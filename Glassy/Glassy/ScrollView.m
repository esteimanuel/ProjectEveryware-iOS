//
//  ScrollView.m
//  Glassy
//
//  Created by Este Tigele on 01/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView



- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    NSLog(@"ViewDidScroll: %f, %f", contentOffset.x, contentOffset.y);
}

@end