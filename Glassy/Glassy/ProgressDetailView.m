//
//  ProgressDetailView.m
//  Glassy
//
//  Created by Este Tigele on 13/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProgressDetailView.h"

@implementation ProgressDetailView {
	float currentHeight;
	float frameWidth;
	float margin;
	float containerHeight;
	float containerWidth;
	float lineHeight;
	float numberOfLines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self drawView];
    }
    return self;
}

- (void)drawView
{
	// Initialize variables
    margin = 5;
    currentHeight = 85.0f + margin;
    frameWidth = [[UIScreen mainScreen] bounds].size.width;
	lineHeight = 24;
	numberOfLines = 2;
	containerHeight = [[UIScreen mainScreen] bounds].size.height - 85.0f;
	containerWidth = frameWidth - margin * 2;
	
    
    // Set background to transparent
    self.backgroundColor = [UIColor clearColor];
    
	// Draw container
	[self drawContainer];
    
    // Draw header
    [self drawHeader];
    
    currentHeight += self.header.frame.size.height + margin;
	
	// Add content
	[self drawContent];
	
	currentHeight += margin * 3;
    
    // Create frame
    self.frame = CGRectMake(0, 0, frameWidth, currentHeight);
	
}

- (void)drawContainer
{
	self.container = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, containerWidth, containerHeight - margin * 2)];
    self.container.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    self.container.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    self.container.layer.borderWidth = 1.0;
    [self addSubview:self.container];
}

- (void)drawHeader
{
	struct CGColor *shadowColor = [[UIColor blackColor]CGColor];
	CGSize shadowOffset = CGSizeMake(0.0, 0.0);
	float shadowRadius = 3.0f;
	float shadowOpacity = 0.5f;
	
	// Create header
	self.header = [[UIView alloc]initWithFrame:CGRectMake(margin, 0, frameWidth, lineHeight)];
	self.header.backgroundColor = [UIColor clearColor];
	
    // Set title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.header.bounds];
    titleLabel.text = @"Stappen";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
	titleLabel.layer.shadowColor = shadowColor;
	titleLabel.layer.shadowOffset = shadowOffset;
	titleLabel.layer.shadowRadius = shadowRadius;
	titleLabel.layer.shadowOpacity = shadowOpacity;
    [self.header addSubview:titleLabel];
	
	// Add header
	[self.container addSubview:self.header];
}

- (void)drawContent
{
	float contentHeight = self.header.frame.size.height + margin;
	
	// Create content
	self.content = [[UIView alloc]init];
	
	// Set verzamelen
    self.verzamelenLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth, 24.0f)];
    self.verzamelenLabel.text = @"1. Bewoners verzamelen";
    self.verzamelenLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	
    self.verzamelenLabel.textColor = [UIColor whiteColor];
    [self.content addSubview:self.verzamelenLabel];
	
	contentHeight += self.verzamelenLabel.frame.size.height + margin;
    
    self.verzamelenProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth - margin * 4, 24.0f)];
    self.verzamelenProgress.progress = 0;
    [self.content addSubview:self.verzamelenProgress];
	
	contentHeight += self.verzamelenProgress.frame.size.height + margin;
	
	// Set inschrijven
    self.inschrijvenLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth, 24.0f)];
    self.inschrijvenLabel.text = @"2. Inschrijven";
    self.inschrijvenLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	
    self.inschrijvenLabel.textColor = [UIColor whiteColor];
    [self.content addSubview:self.inschrijvenLabel];
	
	contentHeight += self.inschrijvenLabel.frame.size.height + margin;
    
    self.inschrijvenProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth - margin * 4, 24.0f)];
    self.inschrijvenProgress.progress = 0;
    [self.content addSubview:self.inschrijvenProgress];
	
	contentHeight += self.inschrijvenProgress.frame.size.height + margin;
	
	// Set provider kiezer
    self.providerLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth, 24.0f)];
    self.providerLabel.text = @"3. Provider kiezen";
    self.providerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	
    self.providerLabel.textColor = [UIColor whiteColor];
    [self.content addSubview:self.providerLabel];
	
	contentHeight += self.providerLabel.frame.size.height + margin;
    
    self.providerProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth - margin * 4, 24.0f)];
    self.providerProgress.progress = 0;
    [self.content addSubview:self.providerProgress];
	
	contentHeight += self.providerProgress.frame.size.height + margin;
	
	// Set aanleg
    self.aanlegLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth, 24.0f)];
    self.aanlegLabel.text = @"4. Glasvezel aanleggen";
    self.aanlegLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	
    self.aanlegLabel.textColor = [UIColor whiteColor];
    [self.content addSubview:self.aanlegLabel];
	
	contentHeight += self.aanlegLabel.frame.size.height + margin;
    
    self.aanlegProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth - margin * 4, 24.0f)];
    self.aanlegProgress.progress = 0;
    [self.content addSubview:self.aanlegProgress];
	
	contentHeight += self.aanlegProgress.frame.size.height + margin;
	
	// Set overstappen
    self.overstappenLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth, 24.0f)];
    self.overstappenLabel.text = @"5. Overstappen naar glasvezel";
    self.overstappenLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	
    self.overstappenLabel.textColor = [UIColor whiteColor];
    [self.content addSubview:self.overstappenLabel];
	
	contentHeight += self.overstappenLabel.frame.size.height + margin;
    
    self.overstappenProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, contentHeight, frameWidth - margin * 4, 24.0f)];
    self.overstappenProgress.progress = 0;
    [self.content addSubview:self.overstappenProgress];
	
	contentHeight += self.overstappenProgress.frame.size.height + margin;
	
	
	[self.container addSubview:self.content];
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
