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
#import "CustomScrollView.h"

// DetailViewControllers
#import "CharityDetailViewController.h"

@interface MainViewController : UIViewController <RestClientDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) Action *action;
//@property (nonatomic, strong) Account *account;
@property (nonatomic, strong) NSMutableDictionary *viewControllersDictionary;
// DetailViewControllers
@property (nonatomic, strong) CharityDetailViewController *charityDetailViewController;

@property (strong, nonatomic) CustomScrollView *scrollView;

- (void)getNeighborhoodData:(int)actionId;
- (void)getActionData:(int)actionId;
- (void)setActionId:(int)actionId;

- (void)setNeighborhoodData;
- (void)setNeighborhoodActionButtonStage;
- (void)setProgressData;
- (void)setMapData;
- (void)setMediaData;
- (void)setCharityData;
- (void)setFaqData;
- (void)setParticipantsData;

// DetailViewController methods
- (void)createCharityDetailView;
- (void)removeCharityDetailView;

@end
