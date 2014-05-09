//
//  NavigationBarViewController.m
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "MainViewController.h"

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
	// Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 85);
    
    [self createCustomNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfileImage
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([defaults objectForKey:@"foto_link"] != nil) {
        NSURL *imageUrl = [NSURL URLWithString:[defaults objectForKey:@"foto_link"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        self.profileImageView.image = [UIImage imageWithData:imageData];
    } else {
        self.profileImageView.image = [UIImage imageNamed:@"ios-nav-default-profile-image.png"];
    }
}

- (void)setProfileName
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([defaults objectForKey:@"email"] != nil) {
        self.profileNameLabel.text = [defaults objectForKey:@"email"];
    } else {
        self.profileNameLabel.text = @"Anonieme gebruiker";
    }
}

- (void)createCustomNavigationBar
{
    // Create navigation bar view
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 85)];
    self.navigationBarView.backgroundColor = [UIColor whiteColor];
    
    // Create image profile view
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 33, 33)];
    self.profileImageView.layer.cornerRadius = 5.0;
    [self setProfileImage];
    // Create name profile label
    self.profileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 130, 35)];
    self.profileNameLabel.textColor = [UIColor darkGrayColor];
    self.profileNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.profileNameLabel.font = [UIFont boldSystemFontOfSize:13];
    [self setProfileName];
    // Create dropdown button
    UIButton *navigationDropDownButton = [[UIButton alloc] initWithFrame:CGRectMake(205, 30, 25, 35)];
    [navigationDropDownButton setImage:[UIImage imageNamed:@"ios-nav-dropdown-button"] forState:UIControlStateNormal];
    [navigationDropDownButton addTarget:self action:@selector(dropDownButtonClicked:) forControlEvents:UIControlEventTouchDown];
    // Create search button
    UIButton *navigationSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 15, 70, 70)];
    [navigationSearchButton setImage:[UIImage imageNamed:@"ios-nav-search-button"] forState:UIControlStateNormal];
    [navigationSearchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    [self.navigationBarView addSubview:self.profileImageView];
    [self.navigationBarView addSubview:self.profileNameLabel];
    [self.navigationBarView addSubview:navigationDropDownButton];
    [self.navigationBarView addSubview:navigationSearchButton];
    [self.view addSubview:self.navigationBarView];
}

- (void)dropDownButtonClicked:(UIButton *)button
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent createDropDownMenuView];
    }
}

- (void)searchButtonClicked:(UIButton *)button
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeDropDownMenuView];
        [parent createSearchView];
    }
}

@end
