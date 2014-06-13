//
//  ParticipantsDetailView.m
//  Glassy
//
//  Created by Este Tigele on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsDetailView.h"

@implementation ParticipantsDetailView

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
    CGFloat frameWidth = self.frame.size.width;
    
    // Set background to transparent
    //self.view.b = [UICol];
    [self setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    // Set title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    self.titleLabel.text = @"Profiel";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set buddy view
    self.mediaView = [[UIScrollView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, [[UIScreen mainScreen] bounds].size.height - 85 - currentHeight - margin)];
    self.mediaView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaView.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaView.layer.borderWidth = 1.0;
    
    self.buddyProfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    self.buddyProfileImage.layer.cornerRadius = 5.0;
    
    self.buddyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, margin * 2, frameWidth, 12)];
    self.buddyNameLabel.numberOfLines = 0;
    self.buddyNameLabel.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.buddyNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.buddyNameLabel.textColor = [UIColor whiteColor];
    
    currentHeight += self.buddyNameLabel.frame.size.height + margin;
    
    self.buddyEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, currentHeight, frameWidth, 12)];
    self.buddyEmailLabel.numberOfLines = 0;
    self.buddyEmailLabel.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.buddyEmailLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.buddyEmailLabel.textColor = [UIColor whiteColor];
    
    currentHeight += self.buddyEmailLabel.frame.size.height + margin;
    
    self.buddyPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, currentHeight, frameWidth, 12)];
    self.buddyPhoneLabel.numberOfLines = 0;
    self.buddyPhoneLabel.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.buddyPhoneLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.buddyPhoneLabel.textColor = [UIColor whiteColor];
    
    [self.mediaView addSubview:self.buddyProfileImage];
    [self.mediaView addSubview:self.buddyNameLabel];
    [self.mediaView addSubview:self.buddyEmailLabel];
    [self.mediaView addSubview:self.buddyPhoneLabel];
    
    [self addSubview:self.mediaView];
    
    currentHeight += self.mediaView.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 85, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 85);
}



@end
