//
//  MapView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MapView.h"

@implementation MapView

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
    self.titleLabel.text = @"Buurt kaart";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set map view
    self.mapview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 250)];
    self.mapview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75];
    self.mapview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    self.mapview.layer.borderWidth = 1.0;
    
    // no scroll
    self.mapview.userInteractionEnabled = false;
    
    [self addSubview:self.mapview];
    
    // Add web view
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frameWidth - 2 * margin, 250)];
    self.webview.scalesPageToFit = YES;
    
    [self.mapview addSubview:self.webview];
    
    currentHeight += self.mapview.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 0, self.frame.size.width, currentHeight);
}

@end
