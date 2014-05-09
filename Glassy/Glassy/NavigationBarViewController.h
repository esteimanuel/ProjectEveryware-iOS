//
//  NavigationBarViewController.h
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarViewController : UIViewController

@property (nonatomic, strong) UIView *navigationBarView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *profileNameLabel;

- (void)setProfileName;
- (void)setProfileImage;

@end
