//
//  CharityDetailView.m
//  Glassy
//
//  Created by Niek Willems on 13/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityDetailView.h"

@implementation CharityDetailView

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
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = [[UIScreen mainScreen] bounds].size.width;
    
    // Set background to transparent
    //self.view.b = [UICol];
    [self setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    // Set charity view
    self.mediaView = [[UIScrollView alloc]initWithFrame:CGRectMake(margin, margin + currentHeight, frameWidth - margin * 2, [[UIScreen mainScreen] bounds].size.height - 85 - currentHeight - margin * 2)];
    self.mediaView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaView.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaView.layer.borderWidth = 1.0;
    
    // Set title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 24.0f)];
    self.titleLabel.text = @"Goede Doel";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.mediaView addSubview:self.titleLabel];

    currentHeight += self.titleLabel.frame.size.height + margin * 3;
    
    // Set charity text
    self.charityText = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, currentHeight, frameWidth, 48.0f)];
    self.charityText.numberOfLines = 0;
    self.charityText.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.charityText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.charityText.textColor = [UIColor whiteColor];
    [self.mediaView addSubview:self.charityText];
    
    [self addSubview:self.mediaView];
    
    // Create frame
    self.frame = CGRectMake(0, 85, frameWidth, [[UIScreen mainScreen] bounds].size.height - 85);
}

@end
