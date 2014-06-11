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
        // Initialization code
		[self createView];
    }
    return self;
}

- (void)createView
{
	NSLog(@"ParticipantsDetailView created");
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
