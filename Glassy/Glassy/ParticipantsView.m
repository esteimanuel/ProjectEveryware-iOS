//
//  ParticipantsView.m
//  Glassy
//
//  Created by Este Tigele on 15/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsView.h"

@implementation ParticipantsView {
	float currentHeight;
	float frameWidth;
	float margin;
	int numberOfColumns;
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
    frameWidth = [[UIScreen mainScreen] bounds].size.width;
    float gridWidth = frameWidth - margin * 2;
    float cellSize = gridWidth / numberOfColumns;
    
    // Get number of participants
    int participants = 26;
    
    int numberOfCells = participants;
    int remainder = numberOfCells % numberOfColumns;
    int numberOfRows = remainder > 0 ? (numberOfCells - remainder) / numberOfColumns + 1 : numberOfCells / numberOfColumns;
    int numberOfEmptyCells = remainder > 0 ? numberOfColumns - remainder : 0;
    
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
            [self addSubview:[self createTile:&xpos withCellSize:&cellSize]];
			// Start new column
			xpos += cellSize;
        }
		// Start new row
        currentHeight += cellSize;
    }
	// Add bottom margin
	currentHeight += margin * 4;
}

- (void)addParticipants
{
    // TODO add participants
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
    UIImage *background = [self getPlaceholderImage]; // TODO get participants image
	UIGraphicsBeginImageContext(CGSizeMake(size, size));
    [background drawInRect:frame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	return image;
}

- (UIImage *)getPlaceholderImage
{
	NSArray *urls = @[@"https://pbs.twimg.com/profile_images/3341129562/a14b1b2d2719b9a8a2e0d643a0c479a4.jpeg", @"http://1.bp.blogspot.com/-KTNcZKXAsUY/ToGvuEV9smI/AAAAAAAAHnU/nAhs3lG4kPA/s640/kc4.jpg",@"http://wallpaperscraft.com/image/kristin_kreuk_brunette_look_model_smile_black_and_white_48248_256x256.jpg?orig=1",@"http://wallpaperscraft.com/image/doutzen_kroes_victorias_secret_angels_blond_hair_eyes_lips_girl_beauty_person_model_nose_finger_hand_31121_256x256.jpg?orig=1",@"http://1.gravatar.com/avatar/45c82fef8276358132876b49cd8282b6?s=128&d=identicon&r=G"];
    NSString *imageUrl = urls[[self getRandomNumberBetween:0 maxNumber:urls.count]];
    UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
	return background;
}

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random() % (max - min);
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
