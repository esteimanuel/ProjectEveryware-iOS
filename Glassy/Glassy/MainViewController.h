//
//  MainViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenuViewController.h"
#import "NavigationBarViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) DropDownMenuViewController *dropDownMenuViewController;
@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) NavigationBarViewController *navigationBarViewController;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) RegisterViewController *registerViewController;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)createLoginView;
- (void)removeLoginView;
- (void)createRegisterView;
- (void)createDropDownMenuView;
- (void)removeDropDownMenuView;
- (void)createSearchView;

- (void)logout;

@end
