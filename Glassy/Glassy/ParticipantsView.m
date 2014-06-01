//
//  ParticipantsView.m
//  Glassy
//
//  Created by Este Tigele on 15/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsView.h"
#import "Account.h"

@implementation ParticipantsView {
	float currentHeight;
	float frameWidth;
	float margin;
	int numberOfColumns;
	NSArray *participants;
    int numberOfParticipants;
	UILabel *participantsNumberLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

- (void)drawView
{
	currentHeight = 0;
	margin = 5;
	frameWidth = [[UIScreen mainScreen] bounds].size.width;
	numberOfColumns = 5;
	numberOfParticipants = 0;
	struct CGColor *shadowColor = [[UIColor blackColor]CGColor];
	CGSize shadowOffset = CGSizeMake(0.0, 0.0);
	float shadowRadius = 3.0f;
	float shadowOpacity = 0.5f;
    
    // Set background to transparent
    self.backgroundColor = [UIColor clearColor];
    
    // Set participants number label
    participantsNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, 60, 36.0f)];
    participantsNumberLabel.text = [NSString stringWithFormat:@"%d", numberOfParticipants];
    participantsNumberLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f];
    participantsNumberLabel.textColor = [UIColor whiteColor];
	participantsNumberLabel.layer.shadowColor = shadowColor;
	participantsNumberLabel.layer.shadowOffset = shadowOffset;
	participantsNumberLabel.layer.shadowRadius = shadowRadius;
	participantsNumberLabel.layer.shadowOpacity = shadowOpacity;
    [self addSubview:participantsNumberLabel];
    
    // Set participants text label
    self.participantsText = [[UILabel alloc] initWithFrame:CGRectMake(margin + participantsNumberLabel.frame.size.width, margin * 2, 150, 24.0f)];
    self.participantsText.text = @"deelnemers";
    self.participantsText.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    self.participantsText.textColor = [UIColor whiteColor];
	self.participantsText.layer.shadowColor = shadowColor;
	self.participantsText.layer.shadowOffset = shadowOffset;
	self.participantsText.layer.shadowRadius = shadowRadius;
	self.participantsText.layer.shadowOpacity = shadowOpacity;
    [self addSubview:self.participantsText];
    
    // Set participants percentage label
//    UILabel *participantsPercentage = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth - margin - 80, 0, 80, 36.0f)];
//    participantsPercentage.text = @"22%";
//    participantsPercentage.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f];
//    participantsPercentage.textAlignment = NSTextAlignmentRight;
//    participantsPercentage.textColor = [UIColor whiteColor];
//    [self addSubview:participantsPercentage];
    
    currentHeight += participantsNumberLabel.frame.size.height;
    
    // Create separator
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 1)];
    separator.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self addSubview:separator];
	
	currentHeight += 2;
	
	self.frame = CGRectMake(0, 0, frameWidth, currentHeight);
}

- (void)createParticipantsGrid
{
    frameWidth = [[UIScreen mainScreen] bounds].size.width;
    float gridWidth = frameWidth - margin * 2;
    float cellSize = gridWidth / numberOfColumns;
    
    int numberOfCells = numberOfParticipants;
    int remainder = numberOfCells % numberOfColumns;
    int numberOfRows = remainder > 0 ? (numberOfCells - remainder) / numberOfColumns + 1 : numberOfCells / numberOfColumns;
    int numberOfEmptyCells = remainder > 0 ? numberOfColumns - remainder : 0;
	int i = 0;
    
    for (int row = 0 ; row < numberOfRows ; row++) {
		// Start drawing from the left
        float xpos = margin;
        for (int col = 0; col < numberOfColumns ; col++) {
            // Add empty cells
            if(numberOfEmptyCells > 0) {
                xpos += numberOfEmptyCells * cellSize;
                col = numberOfEmptyCells;
                numberOfEmptyCells = 0;
            }
			// Add participant tile to grid
            [self addSubview:[self createTile:&xpos withCellSize:&cellSize withParticipant:participants[i]]];
			i++;
			// Start new column
			xpos += cellSize;
        }
		// Start new row
        currentHeight += cellSize;
    }
	// Create participants grid
	self.frame = CGRectMake(0, self.frame.origin.y, frameWidth, currentHeight);
	
	// Add bottom margin
	currentHeight += margin * 4;
}

- (void)addParticipants:(NSArray*)participantsData
{
	participants = participantsData;
    
    // Get number of participants
    numberOfParticipants = [participants count];
	
	// Set participants number
	[self setParticipantsNumber:numberOfParticipants];
	
	// Set participants number label
	participantsNumberLabel.text = [NSString stringWithFormat:@"%d", numberOfParticipants];
	
    // Create participants grid
    [self createParticipantsGrid];
	
	[self setParticipantsLabelPosition:numberOfParticipants];
}


- (UIButton *)createTile:(float *)xpos withCellSize:(float *)cellSize withParticipant:(Account *)participant
{
	UIButton *participantButton = [[UIButton alloc]init];
	participantButton.frame = CGRectMake(*xpos, currentHeight, *cellSize, *cellSize);
	participantButton.contentMode = UIViewContentModeScaleAspectFill;
	participantButton.backgroundColor = [UIColor colorWithPatternImage: [self createImage:*cellSize withFrame:participantButton.bounds withParticipant:participant]];
	if (participant.buddy == 1) {
		participantButton.layer.borderColor = [UIColor greenColor].CGColor;
		participantButton.layer.borderWidth = 2.0f;
	}
	return participantButton;
}

- (UIImage *)createImage:(float)size withFrame:(CGRect)frame withParticipant:(Account *)participant
{
    // Create background image
    UIImage *background = [participant.image length] > 0 ? [self getImage: participant.image] : [UIImage imageNamed:@"userimageplaceholder.png"];
	UIGraphicsBeginImageContext(CGSizeMake(size, size));
    [background drawInRect:frame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	return image;
}

- (void)setParticipantsNumber:(int)number
{
	numberOfParticipants = number;
}

- (void)setParticipantsLabelPosition:(float)numberOfParticipantsForPos
{
	float space = 33;
	int numberOfSpaces = [[[NSNumber numberWithFloat:numberOfParticipantsForPos] stringValue] length];
	NSLog(@"%d",numberOfSpaces);
	self.participantsText.frame = CGRectMake(space * numberOfSpaces, margin * 2, 150, 24.0f);
}

- (UIImage *)getImage:(NSString *)url
{
    UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
	return background;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
