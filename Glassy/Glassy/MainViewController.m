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
    
	// Init custom navigation bar view
    //NavigationBarViewController *navigationBarViewController = [[NavigationBarViewController alloc] init];
    //[self.view addSubview:navigationBarViewController.view];
    //[self createCustomNavigationBar];
    [self createScrollViewBackground];
    [self createScrollViewWithViewControllers];

    [self createDropDownMenuViewController];
    [self createSearchViewController];
    [self createNavigationBarViewController];
    [self createScrollViewWithViewControllers];
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
    // Add navigation bar view to subview
    [self.view addSubview:self.navigationBarViewController.view];
}

#pragma mark - Child view controller button handlers

- (void)createRegisterView
{
    if (self.registerViewController == nil) {
        self.registerViewController = [[RegisterViewController alloc] init];
    }
    [self addChildViewController:self.registerViewController];
    [self.view addSubview:self.registerViewController.view];
}

- (void)createLoginView
{
    if (self.loginViewController == nil) {
        self.loginViewController = [[LoginViewController alloc] init];
    }
    [self addChildViewController:self.loginViewController];
    [self.view addSubview:self.loginViewController.view];
}

- (void)removeLoginView
{
    [self.loginViewController.view removeFromSuperview];
    [self.loginViewController removeFromParentViewController];
    // Reset menu options after login
    [self removeDropDownMenuView];
    [self.dropDownMenuViewController setMenuOptionsArray];
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
    NSArray *urls = @[@"http://www.wallpaperspictures.net/image/bruce-lee-iconic-figure-wallpaper-for-2560x1920-886-26.jpg", @"http://www.celebs101.com/gallery/Scarlett_Johansson/201825/allthatgossip_Scarlett_Johansson_GoldenGlobe_01.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-1068132.jpg",@"http://storage4.album.bg/52f/adriana_lima_5.jpg_d70f4_29141858.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-707568.jpg",@"http://2014download.com/images/2013/03/jessica-alba-awards-mtv.jpg"];
    NSString *imageUrl = urls[1];
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
}

#pragma mark - General view

- (void)createScrollViewWithViewControllers
{
    // Initiablize ViewControllers dictionary
    self.viewControllersDictionary = [[NSMutableDictionary alloc] init];
    // Initialize ViewControllers
    NeighborhoodViewController *neighborhoodViewController = [[NeighborhoodViewController alloc] init];
    MediaViewController *mediaViewController = [[MediaViewController alloc] init];
    MapViewController *mapViewController = [[MapViewController alloc] init];
    CharityViewController *charityViewController = [[CharityViewController alloc] init];
    ProgressViewController *progressViewController = [[ProgressViewController alloc] init];
    ParticipantsViewController *participantsViewController = [[ParticipantsViewController alloc] init];
    // Add ViewControllers to dictionary
    [self.viewControllersDictionary setObject:neighborhoodViewController forKey:@"neighborhoodViewController"];
    // TODO: add viewcontrollers
    
    
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
