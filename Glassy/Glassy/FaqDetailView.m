//
//  FaqDetailView.m
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqDetailView.h"

CGFloat margin = 5;
CGFloat frameWidth;
CGFloat tempHeight;
CGFloat currentHeight = 0;

@implementation FaqDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self drawView];
    }
    return self;
}

- (void)addAllQuestions
{
    for (int i = 0; i < [self.questionsArray count]; i++) {
		[self addQuestion:self.questionsArray[i] withAnswer:self.answersArray[i]];
		
	}
    self.mediaView.contentSize = CGSizeMake(self.frame.size.width, 880);
    self.mediaView.scrollEnabled = YES;
    [self addSubview:self.mediaView];
}

- (void)drawView
{
	self.questionsArray = [[NSMutableArray alloc] init];
	self.answersArray = [[NSMutableArray alloc]init];
    frameWidth = [[UIScreen mainScreen] bounds].size.width;
    
    // Set background color
    [self setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9]];
    
    
    // Set faq view
    self.mediaView = [[UIScrollView alloc]initWithFrame:CGRectMake(margin, margin + currentHeight, frameWidth - margin * 2, [[UIScreen mainScreen] bounds].size.height - 85 - currentHeight - margin * 2)];
    self.mediaView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    self.mediaView.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaView.layer.borderWidth = 1.0;
	
    // Set title label
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin * 2, frameWidth, 24.0f)];
	self.titleLabel.text = @"Veel gestelde vragen";
	self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
	self.titleLabel.textColor = [UIColor whiteColor];
	[self.mediaView addSubview:self.titleLabel];
	
	currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set faq label
    self.faqLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    self.faqLabel.numberOfLines = 0;
    self.faqLabel.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.faqLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.faqLabel.textColor = [UIColor whiteColor];
    
    [self.mediaView addSubview:self.faqLabel];
    
    //currentHeight += self.mediaView.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 85, self.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 85);
}

- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer
{
    currentHeight += 10.0f;
    
	UILabel *q = [[UILabel alloc] initWithFrame:CGRectMake(margin, currentHeight, frameWidth, 24.0f)];
	q.text = question;
	q.numberOfLines = 0;
	q.preferredMaxLayoutWidth = frameWidth - margin * 4;
	q.font = [UIFont fontWithName:@"HelveticaNeue-Normal" size:20.0f];
	q.textColor = [UIColor whiteColor];
    [q sizeToFit];
	[self.mediaView addSubview:q];
	
	currentHeight += q.frame.size.height;
	
	UILabel *a = [[UILabel alloc] initWithFrame:CGRectMake(margin, currentHeight, frameWidth, 24.0f)];
	a.text = answer;
	a.numberOfLines = 0;
	a.preferredMaxLayoutWidth = frameWidth - margin * 4;
	a.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
	a.textColor = [UIColor whiteColor];
    [a sizeToFit];
	[self.mediaView addSubview:a];
	
	currentHeight += a.frame.size.height;
	
}
@end
