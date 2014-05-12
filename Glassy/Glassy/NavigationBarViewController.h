//
//  NavigationBarViewController.h
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBarView.h"

@interface NavigationBarViewController : UIViewController

@property (nonatomic, strong) NavigationBarView *navigationBarView;

- (void)setProfileName;
- (void)setProfileImage;

- (void)createView;

@end
