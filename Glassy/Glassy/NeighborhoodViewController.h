//
//  NeighborhoodViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IOS7 ((floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1))
#define IS_LANDSCAPE ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

@interface NeighborhoodViewController : UIViewController

- (void)setNeighborhoodFields:(Action *)action;

@property (nonatomic, strong) UILabel *neighborhoodTitleLabel;
@property (nonatomic, strong) UILabel *participantsNumberLabel;
@property (nonatomic, strong) UILabel *participantsLabel;
@property (nonatomic, strong) UILabel *percentageLabel;

@end
