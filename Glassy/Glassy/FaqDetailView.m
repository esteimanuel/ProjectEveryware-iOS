//
//  FaqDetailView.m
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqDetailView.h"

@implementation FaqDetailView

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
    [self setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    
    // Set faq view
    self.mediaView = [[UIScrollView alloc]initWithFrame:CGRectMake(margin, margin + currentHeight, frameWidth - margin * 2, [[UIScreen mainScreen] bounds].size.height - 85 - currentHeight - margin * 2)];
    self.mediaView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaView.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaView.layer.borderWidth = 1.0;
	
    // Set title label
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin * 2, frameWidth, 24.0f)];
	self.titleLabel.text = @"Veel gestelde vragen";
	self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
	self.titleLabel.textColor = [UIColor whiteColor];
	[self.mediaView addSubview:self.titleLabel];
	
	self.closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
	self.closeButton.frame = CGRectMake(frameWidth - (32.0f + margin * 3), margin, 32.0f, 32.0f);
	[self.closeButton setTitle:@"X" forState:UIControlStateNormal];
	self.closeButton.layer.backgroundColor = [UIColor purpleColor].CGColor;
	
	[self.mediaView addSubview:self.closeButton];
	
	currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set faq label
    self.faqLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    self.faqLabel.numberOfLines = 0;
    self.faqLabel.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.faqLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.faqLabel.textColor = [UIColor whiteColor];
    
    [self.mediaView addSubview:self.faqLabel];
    [self addSubview:self.mediaView];
    
    currentHeight += self.mediaView.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 85, self.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 85);
}
@end
