//
//  ParticipantsView.m
//  Glassy
//
//  Created by Este Tigele on 15/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsView.h"
float currentHeight = 0;
float margin = 5;
int numberOfColumns = 6;

@implementation ParticipantsView

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
	float frameWidth = [[UIScreen mainScreen] bounds].size.width;
    
    // Set background to transparent
    self.backgroundColor = [UIColor clearColor];
    
    // Set participants number label
    UILabel *participantsNumber = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, 60, 36.0f)];
    participantsNumber.text = @"106";
    participantsNumber.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f];
    participantsNumber.textColor = [UIColor whiteColor];
    [self addSubview:participantsNumber];
    
    // Set participants text label
    UILabel *participantsText = [[UILabel alloc] initWithFrame:CGRectMake(margin + participantsNumber.frame.size.width, margin * 2, 150, 24.0f)];
    participantsText.text = @"deelnemers";
    participantsText.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    participantsText.textColor = [UIColor whiteColor];
    [self addSubview:participantsText];
    
    // Set participants percentage label
    UILabel *participantsPercentage = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth - margin - 80, 0, 80, 36.0f)];
    participantsPercentage.text = @"22%";
    participantsPercentage.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f];
    participantsPercentage.textAlignment = NSTextAlignmentRight;
    participantsPercentage.textColor = [UIColor whiteColor];
    [self addSubview:participantsPercentage];
    
    currentHeight += participantsNumber.frame.size.height;
    
    // Create separator
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 1)];
    separator.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self addSubview:separator];
	
	currentHeight += separator.frame.size.height;
    
    // Create participants grid
    [self createParticipantsGrid];
    
    // Add participants to participants grid
    //[self addParticipants];
    
    // Add grid to view
    //[self.view addSubview:participantsGrid];
	
	self.frame = CGRectMake(0, 0, frameWidth, currentHeight);
}

- (void)createParticipantsGrid
{
    float frameWidth = [[UIScreen mainScreen] bounds].size.width;
    float gridWidth = frameWidth - margin * 2;
    float cellSize = gridWidth / numberOfColumns;
    
    // Get number of participants
    int participants = 25;
    
    int numberOfCells = participants;
    int remainder = numberOfCells % numberOfColumns;
    int numberOfRows = remainder > 0 ? (numberOfCells - remainder) / numberOfColumns + 1 : numberOfCells / numberOfColumns;
    int numberOfEmptyCells = remainder > 0 ? numberOfColumns - remainder : 0;
    
    for (int row = 0 ; row < numberOfRows ; row++) {
        float xpos = margin;
        for (int col = 0; col < numberOfColumns ; col++) {
            // Add empty cells
            if(numberOfEmptyCells > 0) {
                xpos += numberOfEmptyCells * cellSize;
                col = numberOfEmptyCells;
                numberOfEmptyCells = 0;
            }
			
            [self addSubview:[self createTile:&xpos withCellSize:&cellSize]];
			xpos += cellSize;
        }
        currentHeight += cellSize;
    }
}

- (void)addParticipants
{
    // http://data3.whicdn.com/images/1263185/original.jpg
}


- (UIButton *)createTile:(float *)xpos withCellSize:(float *)cellSize
{
	UIButton *participantButton = [[UIButton alloc]init];
	participantButton.frame = CGRectMake(*xpos, currentHeight, *cellSize, *cellSize);
	participantButton.contentMode = UIViewContentModeScaleAspectFill;
	participantButton.backgroundColor = [UIColor colorWithPatternImage: [self getImage:*cellSize withFrame:participantButton.bounds]];
	return participantButton;
}

- (UIImage *)getImage:(float)size withFrame:(CGRect)frame
{
    // Create background image
    NSArray *urls = @[@"http://data3.whicdn.com/images/1263185/original.jpg", @"http://1.bp.blogspot.com/-KTNcZKXAsUY/ToGvuEV9smI/AAAAAAAAHnU/nAhs3lG4kPA/s640/kc4.jpg"];
    NSString *imageUrl = urls[1];
    UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
	UIGraphicsBeginImageContext(CGSizeMake(size, size));
    [background drawInRect:frame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	return image;
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
