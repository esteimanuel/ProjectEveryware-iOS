//
//  MediaView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MediaView.h"

@implementation MediaView {
	CGFloat currentHeight;
	CGFloat frameWidth;
	CGFloat margin;
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
	// Initialize variables
    currentHeight = 0;
	margin = 5;
    frameWidth = [[UIScreen mainScreen] bounds].size.width;
    
    // Set background to transparent
    self.backgroundColor = [UIColor clearColor];
    
    // Set title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    self.titleLabel.text = @"Buurt video";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set media view
    self.mediaview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, frameWidth * 0.6)];
    self.mediaview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    self.mediaview.layer.borderWidth = 1.0;
    [self addSubview:self.mediaview];
    
    // Add web view
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frameWidth - 2 * margin, self.mediaview.frame.size.height)];
    self.webview.scalesPageToFit = YES;
    
    [self.mediaview addSubview:self.webview];
    
    currentHeight += self.mediaview.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 0, self.frame.size.width, currentHeight);
}

@end
