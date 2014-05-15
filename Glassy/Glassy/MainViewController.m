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
#import "LoginViewController.h"

#import "Action.h"
#import "GPUImage.h"



@interface MainViewController ()

@property (nonatomic, strong) RESTClient *restClient;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)getAllActions
{
    // Create REST client and send get request
    self.restClient = [[RESTClient alloc] init];
    self.restClient.delegate = self;
    [self.restClient GET:@"http://glassy-api.avans-project.nl/api/actie" withParameters:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getAllActions];
    
    // Set backgroundcolor
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createScrollViewBackground];
    [self createScrollViewWithViewControllers];

    [self createDropDownMenuViewController];
    [self createSearchViewController];
    [self createNavigationBarViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialization view controllers

- (void)createSearchViewController
{
    self.searchViewController = [[SearchViewController alloc] init];
    [self addChildViewController:self.searchViewController];
}

- (void)createDropDownMenuViewController
{
    self.dropDownMenuViewController = [[DropDownMenuViewController alloc] init];
    [self addChildViewController:self.dropDownMenuViewController];
}

- (void)createNavigationBarViewController
{
    self.navigationBarViewController = [[NavigationBarViewController alloc] init];
    [self addChildViewController:self.navigationBarViewController];
    [self.navigationBarViewController createView];
    // Add navigation bar view to subview
    [self.view addSubview:self.navigationBarViewController.navigationBarView];
}

#pragma mark - Child view controller button handlers

- (void)createRegisterView
{
    if (self.registerViewController == nil) {
        self.registerViewController = [[RegisterViewController alloc] init];
    }
    [self.registerViewController createView];
    [self addChildViewController:self.registerViewController];
    [self.view addSubview:self.registerViewController.registerView];
}

- (void)removeRegisterView
{
    [self.registerViewController.registerView removeFromSuperview];
    [self.registerViewController removeFromParentViewController];
    // Reset menu options after login
    [self removeDropDownMenuView];
    [self.dropDownMenuViewController setMenuOptionsArray];
    // Set navigation bar details
    [self.navigationBarViewController setProfileName];
    [self.navigationBarViewController setProfileImage];
}

- (void)createLoginView
{
    if (self.loginViewController == nil) {
        self.loginViewController = [[LoginViewController alloc] init];
    }
    [self.loginViewController createView];
    [self addChildViewController:self.loginViewController];
    [self.view addSubview:self.loginViewController.loginView];
}

- (void)removeLoginView
{
    [self.loginViewController.loginView removeFromSuperview];
    [self.loginViewController removeFromParentViewController];
    // Reset menu options after login
    [self removeDropDownMenuView];
    [self.dropDownMenuViewController setMenuOptionsArray];
    // Set navigation bar details
    [self.navigationBarViewController setProfileName];
    [self.navigationBarViewController setProfileImage];
    
}

- (void)createProfileView
{
    if (self.profileViewController == nil) {
        self.profileViewController = [[ProfileViewController alloc] init];
    }
    [self.profileViewController createView];
    [self addChildViewController:self.profileViewController];
    [self.view addSubview:self.profileViewController.profileView];
}

- (void)removeProfileView
{
    [self.profileViewController.profileView removeFromSuperview];
    [self.profileViewController removeFromParentViewController];
}

- (void)createDropDownMenuView
{
    if ([self.dropDownMenuViewController.view isDescendantOfView:self.view]) {
        [self.dropDownMenuViewController.view removeFromSuperview];
        [self.searchViewController.view removeFromSuperview];
    } else {
        [self.view addSubview:self.dropDownMenuViewController.view];
    }
}

- (void)removeDropDownMenuView
{
    [self.dropDownMenuViewController.view removeFromSuperview];
}

- (void)createSearchView
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
    NSArray *urls = @[@"http://www.wallpaperspictures.net/image/bruce-lee-iconic-figure-wallpaper-for-2560x1920-886-26.jpg", @"http://www.celebs101.com/gallery/Scarlett_Johansson/201825/allthatgossip_Scarlett_Johansson_GoldenGlobe_01.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-1068132.jpg",@"http://storage4.album.bg/52f/adriana_lima_5.jpg_d70f4_29141858.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-707568.jpg",@"http://2014download.com/images/2013/03/jessica-alba-awards-mtv.jpg",@"http://images4.fanpop.com/image/photos/16000000/adriana-victorias-secret-angels-16007539-760-1024.jpg"];
    NSString *imageUrl = urls[6];
    UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [background drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    GPUImageFilter *filter = [[GPUImageGaussianBlurFilter alloc]init];
    UIImage *blurredImage = [filter imageByFilteringImage: image];
    
    UIGraphicsEndImageContext();
    //self.view.contentMode = UIViewContentModeScaleAspectFill;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:blurredImage];
}

- (void)logout
{
    if (self.loginViewController == nil) {
        self.loginViewController = [[LoginViewController alloc] init];
    }
    [self.loginViewController logout];
    // Reset menu options after logout
    [self removeDropDownMenuView];
    [self.dropDownMenuViewController setMenuOptionsArray];
    // Reset navigation bar details
    [self.navigationBarViewController setProfileName];
    [self.navigationBarViewController setProfileImage];
}

#pragma mark - Initialization detail view controllers

- (void)createCharityDetailView
{
    if (self.charityDetailViewController == nil) {
        self.charityDetailViewController = [[CharityDetailViewController alloc] init];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.charityDetailViewController.view cache:YES];
    
    [self addChildViewController:self.charityDetailViewController];
    [self.view addSubview:self.charityDetailViewController.view];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.charityDetailViewController.view cache:YES];
    [UIView commitAnimations];
}

- (void)removeCharityDetailView
{
    [self.charityDetailViewController.view removeFromSuperview];
    [self.charityDetailViewController removeFromParentViewController];    
}

#pragma mark - General view

- (void)createScrollViewWithViewControllers
{
    // Initiablize ViewControllers dictionary
    self.viewControllersDictionary = [[NSMutableDictionary alloc] init];
    // Initialize ViewControllers
    NeighborhoodViewController *neighborhoodViewController = [[NeighborhoodViewController alloc] init];
    [neighborhoodViewController createView];
    MediaViewController *mediaViewController = [[MediaViewController alloc] init];
    [mediaViewController createView];
    MapViewController *mapViewController = [[MapViewController alloc] init];
    [mapViewController createView];
    CharityViewController *charityViewController = [[CharityViewController alloc] init];
    [charityViewController createView];
    ProgressViewController *progressViewController = [[ProgressViewController alloc] init];
    [progressViewController createView];
    ParticipantsViewController *participantsViewController = [[ParticipantsViewController alloc] init];
	[participantsViewController createView];
    // Add ViewControllers to dictionary
    [self.viewControllersDictionary setObject:neighborhoodViewController forKey:@"neighborhoodViewController"];
    // TODO: add viewcontrollers
    
    // Add ViewControllers to parent viewcontroller
    [self addChildViewController:neighborhoodViewController];
    [self addChildViewController:charityViewController];
    
    
    // Set background to clear
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    NSInteger currentHeight = 0;
    // Add ViewControllers to scrollView
    [self.scrollView addSubview:neighborhoodViewController.neighborhoodView];
    neighborhoodViewController.neighborhoodView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, neighborhoodViewController.neighborhoodView.frame.size.height);
    [self.scrollView addSubview:mediaViewController.mediaView];
    mediaViewController.mediaView.frame = CGRectMake(0, neighborhoodViewController.neighborhoodView.frame.size.height, self.scrollView.frame.size.width, mediaViewController.mediaView.frame.size.height);
    
    currentHeight = neighborhoodViewController.neighborhoodView.frame.size.height + mediaViewController.mediaView.frame.size.height;
    
    [self.scrollView addSubview:mapViewController.mapView];
    mapViewController.mapView.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, mapViewController.mapView.frame.size.height);
    
    currentHeight += mapViewController.mapView.frame.size.height;
    
    [self.scrollView addSubview:charityViewController.charityView];
    charityViewController.charityView.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, charityViewController.charityView.frame.size.height);
    
    currentHeight += charityViewController.charityView.frame.size.height;
    
    [self.scrollView addSubview:progressViewController.progressView];
    progressViewController.progressView.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, progressViewController.progressView.frame.size.height);
    
    currentHeight += progressViewController.progressView.frame.size.height;
    
    [self.scrollView addSubview:participantsViewController.participantsView];
    participantsViewController.participantsView.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, participantsViewController.participantsView.frame.size.height);
    
    // Calculate scrollView size
    NSInteger size = currentHeight + participantsViewController.participantsView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, size);
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary
{
    self.actionsArray = [[NSMutableArray alloc] init];
    
    for (id key in responseDictionary) {
        NSDictionary *actionDictionary = (NSDictionary *)key;
        
        Action *action = [[Action alloc] init];
        action.name = [actionDictionary objectForKey:@"naam"];
        action.instigatorId = [actionDictionary objectForKey:@"initiatiefnemer_id"];
        action.neighborhoodId = [actionDictionary objectForKey:@"wijk_id"];
        action.date_end = [actionDictionary objectForKey:@"eind_datum"];
        action.date_start = [actionDictionary objectForKey:@"start_datum"];
        action.deposit = [actionDictionary objectForKey:@"borg"];
        action.id = [actionDictionary objectForKey:@"actie_id"];
        action.statusId = [actionDictionary objectForKey:@"status_id"];
        [self.actionsArray addObject:action];
    }
    
    NeighborhoodViewController *neighborhoodViewController = [self.viewControllersDictionary objectForKey:@"neighborhoodViewController"];
    [neighborhoodViewController setNeighborhoodFields:[self.actionsArray objectAtIndex:0]];
}

- (void)restRequestFailed:(NSString *)failedMessage
{

}

@end
