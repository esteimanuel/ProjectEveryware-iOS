//
//  NavigationBarViewController.m
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "PagingViewController.h"
#import "NullCheck.h"

@interface NavigationBarViewController ()

@end

@implementation NavigationBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfileImage
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController;
        if ([NullCheck isNotNilOrEmpty:parent.account.image]) {
            NSURL *imageUrl = [NSURL URLWithString:parent.account.image];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            self.navigationBarView.profileImageView.image = [UIImage imageWithData:imageData];
        } else {
            self.navigationBarView.profileImageView.image = [UIImage imageNamed:@"ios-nav-default-profile-image.png"];
        }
    }
}

- (void)setProfileName
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController;
        if ([NullCheck isNotNilOrEmpty:parent.account.firstName]) {
            NSString *msg = [NSString stringWithFormat:@"Hallo, %@", parent.account.firstName];
            self.navigationBarView.profileNameLabel.text = msg;
        } else {
            self.navigationBarView.profileNameLabel.text = @"Anonieme gebruiker";
        }
    }
}

- (BOOL)isNotNilOrEmpty:(NSString *)string
{
    if (string != nil) {
        if (![string isKindOfClass:[NSNull class]]) {
            if ([string length] > 0) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    } else {
        return false;
    }
}

- (void)createView
{
    self.navigationBarView = [[NavigationBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 85)];
    // Create gesture
    [self createGesture];
    // Set profile info
    [self setProfileName];
    [self setProfileImage];
    // Set button targets
    [self.navigationBarView.navigationDropDownButton addTarget:self action:@selector(dropDownButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.navigationBarView.navigationSearchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchDown];
}

- (void)dropDownButtonClicked:(UIButton *)button
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController;
        if (parent.activeViewController != nil) {
            [parent handleActiveViewController:nil];
            [parent removeDropDownMenuView];
        } else {
            [parent createDropDownMenuView];
        }
    }
}

- (void)searchButtonClicked:(UIButton *)button
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController;
        [parent removeDropDownMenuView];
        [parent createSearchView];
    }
}

#pragma mark - PAN gesture methods

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    gestureRecognizer.numberOfTouchesRequired = 1;
    [self.navigationBarView addGestureRecognizer:gestureRecognizer];
}

- (void)panHandler:(UITapGestureRecognizer *)recognizer
{
    [self dropDownButtonClicked:nil];
}

@end
