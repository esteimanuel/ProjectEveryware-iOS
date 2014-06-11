//
//  CharityView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityView.h"

@implementation CharityView {
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
	numberOfLines = 2;
	containerHeight = lineHeight * numberOfLines + margin * 4;
	containerWidth = frameWidth - margin * 2;

    
    // Set background to transparent
    self.backgroundColor = [UIColor clearColor];
    
    // Draw header
    [self drawHeader];
    
    currentHeight += self.header.frame.size.height + margin;
    
	// Draw container
	[self drawContainer];
    
    currentHeight += containerHeight + margin;
	
	// Add content
	[self drawContent];
	
	currentHeight += margin * 3;
    
    // Create frame
    self.frame = CGRectMake(0, 0, frameWidth, currentHeight);
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
    titleLabel.text = @"Goede doel";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
	titleLabel.layer.shadowColor = shadowColor;
	titleLabel.layer.shadowOffset = shadowOffset;
	titleLabel.layer.shadowRadius = shadowRadius;
	titleLabel.layer.shadowOpacity = shadowOpacity;
    [self.header addSubview:titleLabel];
	
	// Add header
	[self addSubview:self.header];
}

- (void)drawContainer
{
	self.container = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, containerWidth, containerHeight)];
    self.container.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.container.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    self.container.layer.borderWidth = 1.0;
    [self addSubview:self.container];
}

- (void)drawContent
{
	// Create contentview
	self.content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];
	self.content.backgroundColor = [UIColor clearColor];
	
	// Create textview
    self.textview = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, containerWidth, containerHeight - margin * 1)];
    self.textview.text = @"";
    self.textview.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.textview.textColor = [UIColor whiteColor];
	self.textview.backgroundColor = [UIColor clearColor];
	self.textview.lineBreakMode = NSLineBreakByTruncatingTail;
	self.textview.numberOfLines = 0;
	
	// Add textview to content view
	[self.content addSubview:self.textview];
	
	// Add content to container
	[self.container addSubview:self.content];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"CharityView touches began");
    NSLog(@"CharityView touched %@", self);
    NSLog(@"CharityView nextResponder = %@", self.nextResponder);
    //[super touchesBegan:touches withEvent:event];
    //[[self nextResponder] touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[super touchesMoved:touches withEvent:event];
    //[[self nextResponder] touchesMoved:touches withEvent:event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog(@"Touches ended: CharityView");
    //[super touchesEnded:touches withEvent:event];
    //[self.nextResponder touchesEnded:touches withEvent:event];
}


@end
