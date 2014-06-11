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
#import "Neighborhood.h"
#import "Account.h"
#import "Charity.h"
#import "CustomScrollView.h"

// DetailViewControllers
#import "CharityDetailViewController.h"
#import "FaqDetailViewController.h"
#import "NeighborhoodViewController.h"

@interface MainViewController : UIViewController <RestClientDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) Action *action;
@property (nonatomic, strong) Neighborhood *neighborhood;
@property (nonatomic, strong) NSMutableDictionary *viewControllersDictionary;
// DetailViewControllers
@property (nonatomic, strong) CharityDetailViewController *charityDetailViewController;
@property (nonatomic, strong) FaqDetailViewController *faqDetailViewController;
@property (nonatomic, strong) NeighborhoodViewController* neighborhoodViewController;

@property (strong, nonatomic) UIScrollView *scrollView;

- (void)getNeighborhoodData:(int)actionId;
- (void)getNeighborhoodInfo:(int)neighborhoodId;
- (void)getActionData:(int)actionId;
- (void)setActionId:(int)actionId;

- (void)setNeighborhoodData;
- (void)setNeighborhoodInfo;
- (void)setNeighborhoodActionButtonStage;
- (void)setProgressData;
- (void)setMapData;
- (void)setMediaData;
- (void)setCharityData;
- (void)setFaqData;
- (void)setParticipantsData;

// DetailViewController methods
- (void)createCharityDetailView:(Charity *)charity;
- (void)removeCharityDetailView;
- (void)createFaqDetailView;
- (void)removeFaqDetailView;

@end
