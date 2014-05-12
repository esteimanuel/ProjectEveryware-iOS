//
//  CharityView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityView.h"

@implementation CharityView

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
    self.backgroundColor = [UIColor clearColor];
    
    // Set title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    self.titleLabel.text = @"Goede doel";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set charity view
    self.mediaview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 48 + margin * 4)];
    self.mediaview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaview.layer.borderWidth = 1.0;
    [self addSubview:self.mediaview];
    
    // Set charity text
    self.charityText = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    self.charityText.numberOfLines = 0;
    self.charityText.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.charityText.text = @"Gratis telefoon, tv, internet en wifi \nvoor Basisschool Antonius 3%";
    self.charityText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.charityText.textColor = [UIColor whiteColor];
    [self.mediaview addSubview:self.charityText];
    
    currentHeight += self.mediaview.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 0, self.frame.size.width, currentHeight);
}

@end
