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
#import "NavigationBarViewController.h"

/* Test */
#import "AuthenticationViewController.h"

#import "GPUImage.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    GPUImageView *_blurView;
    GPUImageiOSBlurFilter *blurFilter;
}

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
    // Set backgroundcolor
    self.view.backgroundColor = [UIColor blackColor];
    
	// Init custom navigation bar view
    //NavigationBarViewController *navigationBarViewController = [[NavigationBarViewController alloc] init];
    //[self.view addSubview:navigationBarViewController.view];
    [self createCustomNavigationBar];
    [self createScrollViewBackground];
    [self createScrollViewWithViewControllers];
    [self createDropDownMenuViewController];
    [self createSearchViewController];
    
    
    /* Test */
    //AuthenticationViewController *auth = [[AuthenticationViewController alloc] init];
    //[self.view addSubview:auth.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSearchViewController
{
    self.searchViewController = [[SearchViewController alloc] init];
}

- (void)createDropDownMenuViewController
{
    // Create custom dropdown menu view
    self.dropDownMenuViewController = [[DropDownMenuViewController alloc] init];
}

- (void)createCustomNavigationBar
{
    // Create navigation bar view
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 85)];
    self.navigationBarView.backgroundColor = [UIColor whiteColor];
    
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
    [navigationDropDownButton addTarget:self action:@selector(dropDownButtonClicked:) forControlEvents:UIControlEventTouchDown];
    // Create search button
    UIButton *navigationSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 15, 70, 70)];
    [navigationSearchButton setImage:[UIImage imageNamed:@"ios-nav-search-button"] forState:UIControlStateNormal];
    [navigationSearchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    [self.navigationBarView addSubview:profileImageView];
    [self.navigationBarView addSubview:profileNameLabel];
    [self.navigationBarView addSubview:navigationDropDownButton];
    [self.navigationBarView addSubview:navigationSearchButton];
    [self.view addSubview:self.navigationBarView];
}

- (void)dropDownButtonClicked:(UIButton *)button
{
    if ([self.dropDownMenuViewController.view isDescendantOfView:self.view]) {
        [self.dropDownMenuViewController.view removeFromSuperview];
        [self.searchViewController.view removeFromSuperview];
    } else {
        [self.view addSubview:self.dropDownMenuViewController.view];
    }
}

- (void)searchButtonClicked:(UIButton *)button
{
    if ([self.searchViewController.view isDescendantOfView:self.view]) {
        [self.searchViewController.view removeFromSuperview];
        [self.dropDownMenuViewController.view removeFromSuperview];
    } else {
        [self.view addSubview:self.searchViewController.view];
    }
}

- (void)createScrollViewBackground
{
    // Create background image
    //NSString *imageUrl = @"http://www.celebs101.com/gallery/Scarlett_Johansson/201825/allthatgossip_Scarlett_Johansson_GoldenGlobe_01.jpg";
    NSString *imageUrl = @"http://www.wallpaperspictures.net/image/bruce-lee-iconic-figure-wallpaper-for-2560x1920-886-26.jpg";
    UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [background drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    GPUImageFilter *filter = [[GPUImageGaussianBlurFilter alloc]init];
    UIImage *blurredImage = [filter imageByFilteringImage: image];
    
    UIGraphicsEndImageContext();
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:blurredImage];
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
    
    // Set background to clear
    self.scrollView.backgroundColor = [UIColor clearColor];
    
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
