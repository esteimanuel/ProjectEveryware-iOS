//
//  MainViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MainViewController.h"
#import "NeighborhoodViewController.h"
#import "MediaViewController.h"
#import "MapViewController.h"
#import "CharityViewController.h"
#import "ProgressViewController.h"
#import "ParticipantsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    [self createCustomNavigationBar];
    [self createScrollViewWithViewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCustomNavigationBar
{
    // Create navigation bar view
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 85)];
    navigationBarView.backgroundColor = [UIColor whiteColor];

    // Create image profile view
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 33, 33)];
    profileImageView.image = [UIImage imageNamed:@"ios-nav-default-profile-image.png"];
    profileImageView.layer.cornerRadius = 5.0;
    // Create name profile label
    UILabel *profileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 130, 35)];
    profileNameLabel.text = @"Anonieme gebruiker";
    profileNameLabel.textColor = [UIColor darkGrayColor];
    profileNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    profileNameLabel.font = [UIFont boldSystemFontOfSize:13];
    // Create dropdown button
    UIButton *navigationDropDownButton = [[UIButton alloc] initWithFrame:CGRectMake(205, 30, 25, 35)];
    [navigationDropDownButton setImage:[UIImage imageNamed:@"ios-nav-dropdown-button"] forState:UIControlStateNormal];
    // Create search button
    UIButton *navigationSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 15, 70, 70)];
    [navigationSearchButton setImage:[UIImage imageNamed:@"ios-nav-search-button"] forState:UIControlStateNormal];
    
    [navigationBarView addSubview:profileImageView];
    [navigationBarView addSubview:profileNameLabel];
    [navigationBarView addSubview:navigationDropDownButton];
    [navigationBarView addSubview:navigationSearchButton];
    [self.view addSubview:navigationBarView];
    
}

- (void)createScrollViewWithViewControllers
{
    // Initialize ViewControllers
    NeighborhoodViewController *neighborhoodViewController = [[NeighborhoodViewController alloc] init];
    MediaViewController *mediaViewController = [[MediaViewController alloc] init];
    MapViewController *mapViewController = [[MapViewController alloc] init];
    CharityViewController *charityViewController = [[CharityViewController alloc] init];
    ProgressViewController *progressViewController = [[ProgressViewController alloc] init];
    ParticipantsViewController *participantsViewController = [[ParticipantsViewController alloc] init];
    
    NSInteger currentHeight = 0;
    // Add ViewControllers to scrollView
    [self.scrollView addSubview:neighborhoodViewController.view];
    neighborhoodViewController.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, neighborhoodViewController.view.frame.size.height);
    [self.scrollView addSubview:mediaViewController.view];
    mediaViewController.view.frame = CGRectMake(0, neighborhoodViewController.view.frame.size.height, self.scrollView.frame.size.width, mediaViewController.view.frame.size.height);
    
    currentHeight = neighborhoodViewController.view.frame.size.height + mediaViewController.view.frame.size.height;
    
    [self.scrollView addSubview:mapViewController.view];
    mapViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, mapViewController.view.frame.size.height);
    
    currentHeight += mapViewController.view.frame.size.height;
    
    [self.scrollView addSubview:charityViewController.view];
    charityViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, charityViewController.view.frame.size.height);
    
    currentHeight += charityViewController.view.frame.size.height;
    
    [self.scrollView addSubview:progressViewController.view];
    progressViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, progressViewController.view.frame.size.height);
    
    currentHeight += progressViewController.view.frame.size.height;
    
    [self.scrollView addSubview:participantsViewController.view];
    participantsViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, participantsViewController.view.frame.size.height);
    
    // Calculate scrollView size
    NSInteger size = currentHeight + participantsViewController.view.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, size);
}

@end
