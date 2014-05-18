//
//  PagingViewController.h
//  Glassy
//
//  Created by Niek Willems on 13/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenuViewController.h"
#import "NavigationBarViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ProfileViewController.h"
#import "MainViewController.h"
#import "RESTClient.h"
#import "Action.h"

@interface PagingViewController : UIViewController <RestClientDelegate>

@property (nonatomic, strong) Account *account;

@property (nonatomic, strong) NSMutableArray *actionsArray;
@property (nonatomic, strong) NSMutableArray *mainViewControllers;

@property (strong, nonatomic) UIScrollView *scrollView;

// ViewControllers
@property (nonatomic, strong) DropDownMenuViewController *dropDownMenuViewController;
@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) NavigationBarViewController *navigationBarViewController;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) RegisterViewController *registerViewController;
@property (nonatomic, strong) ProfileViewController *profileViewController;

- (void)setAccountFields:(NSDictionary *)fields;

- (void)createLoginView;
- (void)removeLoginView;
- (void)createRegisterView;
- (void)removeRegisterView;
- (void)createProfileView;
- (void)removeProfileView;
- (void)createDropDownMenuView;
- (void)removeDropDownMenuView;
- (void)createSearchView;

- (void)logout;

@end
