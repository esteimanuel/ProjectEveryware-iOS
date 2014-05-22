//
//  MainViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"
#import "ScrollView.h"
#import "Action.h"
#import "Account.h"

// DetailViewControllers
#import "CharityDetailViewController.h"

@interface MainViewController : UIViewController <RestClientDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) Action *action;
//@property (nonatomic, strong) Account *account;
@property (nonatomic, strong) NSMutableDictionary *viewControllersDictionary;
// DetailViewControllers
@property (nonatomic, strong) CharityDetailViewController *charityDetailViewController;

@property (strong, nonatomic) UIScrollView *scrollView;

- (void)setNeighborhood;
- (void)setProgress;
- (void)setMapData;
- (void)setMediaData;
- (void)setFaqData;

// DetailViewController methods
- (void)createCharityDetailView;
- (void)removeCharityDetailView;

@end
