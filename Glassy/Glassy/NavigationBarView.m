//
//  NavigationBarView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NavigationBarView.h"

@implementation NavigationBarView

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
    // Create navigation bar view
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 85)];
    self.navigationBarView.backgroundColor = [UIColor whiteColor];
    
    // Create image profile view
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 33, 33)];
    self.profileImageView.layer.cornerRadius = 5.0;
    // Create name profile label
    self.profileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 130, 35)];
    self.profileNameLabel.textColor = [UIColor darkGrayColor];
    self.profileNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.profileNameLabel.font = [UIFont boldSystemFontOfSize:13];
    // Create dropdown button
    self.navigationDropDownButton = [[UIButton alloc] initWithFrame:CGRectMake(205, 30, 25, 35)];
    [self.navigationDropDownButton setImage:[UIImage imageNamed:@"ios-nav-dropdown-button"] forState:UIControlStateNormal];
    // Create search button
    self.navigationSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 15, 70, 70)];
    [self.navigationSearchButton setImage:[UIImage imageNamed:@"ios-nav-search-button"] forState:UIControlStateNormal];
    
    [self.navigationBarView addSubview:self.profileImageView];
    [self.navigationBarView addSubview:self.profileNameLabel];
    [self.navigationBarView addSubview:self.navigationDropDownButton];
    [self.navigationBarView addSubview:self.navigationSearchButton];
    [self addSubview:self.navigationBarView];
}

@end
