//
//  MainViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DropDownMenuViewController.h"
//#import "NavigationBarViewController.h"
//#import "SearchViewController.h"
//#import "LoginViewController.h"
//#import "RegisterViewController.h"
//#import "ProfileViewController.h"
#import "RESTClient.h"
#import "ScrollView.h"
#import "Action.h"

// DetailViewControllers
#import "CharityDetailViewController.h"

@interface MainViewController : UIViewController <RestClientDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) Action *action;
@property (nonatomic, strong) NSMutableDictionary *viewControllersDictionary;
// DetailViewControllers
@property (nonatomic, strong) CharityDetailViewController *charityDetailViewController;

@property (strong, nonatomic) UIScrollView *scrollView;

- (void)setNeighborhood;

// DetailViewController methods
- (void)createCharityDetailView;
- (void)removeCharityDetailView;

@end
