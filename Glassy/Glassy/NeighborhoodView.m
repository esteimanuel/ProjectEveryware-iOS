//
//  NeighborhoodView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NeighborhoodView.h"

@implementation NeighborhoodView

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
	struct CGColor *shadowColor = [[UIColor blackColor]CGColor];
	CGSize shadowOffset = CGSizeMake(0.0, 0.0);
	float shadowRadius = 3.0f;
	float shadowOpacity = 0.5f;
	
    self.backgroundColor = [UIColor clearColor];
    
    // Create neighborhood title
    self.neighborhoodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, (self.frame.size.height - 210.0) - 10.0, self.frame.size.width -10.0, 28.0f)];
    //	[self.neighborhoodTitleLabel setText:@"Martijn's glasvezel buurt"];
    [self.neighborhoodTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [self.neighborhoodTitleLabel setTextColor:[UIColor whiteColor]];
	self.neighborhoodTitleLabel.layer.shadowColor = shadowColor;
	self.neighborhoodTitleLabel.layer.shadowOffset = shadowOffset;
	self.neighborhoodTitleLabel.layer.shadowRadius = shadowRadius;
	self.neighborhoodTitleLabel.layer.shadowOpacity = shadowOpacity;
	
    [self addSubview:self.neighborhoodTitleLabel];
    
    // Create participants number
    self.participantsNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0, (self.frame.size.height - 180.0) - 10.0, self.frame.size.width -10.0, 50.0f)];
    [self.participantsNumberLabel setText:@"0"];
    [self.participantsNumberLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0f]];
    [self.participantsNumberLabel setTextColor:[UIColor whiteColor]];
	self.participantsNumberLabel.layer.shadowColor = shadowColor;
	self.participantsNumberLabel.layer.shadowOffset = shadowOffset;
	self.participantsNumberLabel.layer.shadowRadius = shadowRadius;
	self.participantsNumberLabel.layer.shadowOpacity = shadowOpacity;
    
    [self addSubview:self.participantsNumberLabel];
    
    // Create participants label
    self.participantsLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0, (self.frame.size.height - 160.0) - 10.0, self.frame.size.width -10.0, 25.0f)];
    [self.participantsLabel setText:@"deelnemers"];
    [self.participantsLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [self.participantsLabel setTextColor:[UIColor whiteColor]];
	self.participantsLabel.layer.shadowColor = shadowColor;
	self.participantsLabel.layer.shadowOffset = shadowOffset;
	self.participantsLabel.layer.shadowRadius = shadowRadius;
	self.participantsLabel.layer.shadowOpacity = shadowOpacity;
    
    [self addSubview:self.participantsLabel];
    
    // Create percentage
    self.percentageLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0, (self.frame.size.height - 140.0) - 10.0, self.frame.size.width -10.0, 100.0f)];
    [self.percentageLabel setText:@"0%"];
    [self.percentageLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:100.0f]];
    [self.percentageLabel setTextColor:[UIColor whiteColor]];
	self.percentageLabel.layer.shadowColor = shadowColor;
	self.percentageLabel.layer.shadowOffset = shadowOffset;
	self.percentageLabel.layer.shadowRadius = shadowRadius;
	self.percentageLabel.layer.shadowOpacity = shadowOpacity;
    
    [self addSubview:self.percentageLabel];
    
    // Create facebook share button
    
    // Create action button
    self.actionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //[actionButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton setTitle:@"Ik doe ook mee!" forState:UIControlStateNormal];
    [self.actionButton.titleLabel setFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f]];
    [self.actionButton setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [self.actionButton.layer setBorderColor:[[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5] CGColor]];
    [self.actionButton.layer setBorderWidth:1.0f];
    //[self.actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchDown];
    self.actionButton.frame = CGRectMake(5.0, (self.frame.size.height - 40.0) - 10.0, self.frame.size.width -10.0, 40.0);
    
    [self addSubview:self.actionButton];
}

- (void)setParticipantsLabelPosition:(float)numberOfParticipants
{
	float space = 33;
	int numberOfSpaces = [[[NSNumber numberWithFloat:numberOfParticipants] stringValue] length];
	NSLog(@"%d",numberOfSpaces);
	self.participantsLabel.frame = CGRectMake(space * numberOfSpaces, (self.frame.size.height - 160.0) - 10.0, self.frame.size.width -10.0, 25.0f);
}

- (void)hideLabels
{
	self.percentageLabel.textColor = [UIColor clearColor];
	self.participantsLabel.textColor = [UIColor clearColor];
	self.participantsNumberLabel.textColor = [UIColor clearColor];
}

- (void)showLabels
{
	self.percentageLabel.textColor = [UIColor whiteColor];
	self.participantsLabel.textColor = [UIColor whiteColor];
	self.participantsNumberLabel.textColor = [UIColor whiteColor];
}

@end
