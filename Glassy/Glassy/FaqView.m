//
//  FaqView.m
//  Glassy
//
//  Created by Este Tigele on 18/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqView.h"

@implementation FaqView {
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
	lineHeight = 24;
	numberOfLines = 3;
	containerHeight = lineHeight * numberOfLines + margin * 4;
	containerWidth = frameWidth - margin * 2;
    
    // Set background to transparent
    self.backgroundColor = [UIColor clearColor];
    
    // Draw header
    [self drawHeader];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
	
    // Draw container
    [self drawContainer];
	
	currentHeight += self.container.frame.size.height + margin;
	
	// Add content
	[self addContent];
	
	currentHeight += margin * 3;
	
	// Create frame
	self.frame = CGRectMake(0, 0, self.frame.size.width, currentHeight);
}

- (void)drawHeader
{
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, lineHeight)];
    self.titleLabel.text = @"Veel gestelde vragen";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
}

- (void)drawContainer
{
	self.container = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, containerWidth, containerHeight)];
    self.container.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.container.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    self.container.layer.borderWidth = 1.0;
    [self addSubview:self.container];
}

- (void)addContent
{
	// Create content
	self.content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];
	self.content.backgroundColor = [UIColor clearColor];
	
	// Create textview
	UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];
	textview.text = [self getFaq];
    textview.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    textview.textColor = [UIColor whiteColor];
	textview.backgroundColor = [UIColor clearColor];
	
	// Add textview to content view
	[self.content addSubview:textview];
	
	// Add content to container
	[self.container addSubview:self.content];
}

- (NSString *)getFaq
{
	NSString *faq = @"- Wat is Glassy?\n- Wat is glasvezel?\n- Waarom zou je glasvezel willen?";
	return faq;
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
