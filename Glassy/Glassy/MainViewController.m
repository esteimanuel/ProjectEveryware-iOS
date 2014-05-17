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

- (id)init
{
    self = [super init];
    if (self) {
        // Init scrollVIew
        self.scrollView = [[UIScrollView alloc] init];
        
        [self createScrollViewWithViewControllers];
        [self createScrollViewBackground];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
<<<<<<< HEAD
=======

    [self getAllActions];
    
    // Set backgroundcolor
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createScrollViewBackground];
    [self createScrollViewWithViewControllers];

    [self createDropDownMenuViewController];
    [self createSearchViewController];
    [self createNavigationBarViewController];
>>>>>>> FETCH_HEAD
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScrollViewBackground
{
    // Create background image
<<<<<<< HEAD
    NSArray *urls = @[@"http://www.wallpaperspictures.net/image/bruce-lee-iconic-figure-wallpaper-for-2560x1920-886-26.jpg", @"http://www.celebs101.com/gallery/Scarlett_Johansson/201825/allthatgossip_Scarlett_Johansson_GoldenGlobe_01.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-1068132.jpg",@"http://storage4.album.bg/52f/adriana_lima_5.jpg_d70f4_29141858.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-707568.jpg",@"http://2014download.com/images/2013/03/jessica-alba-awards-mtv.jpg"];
    NSString *imageUrl = urls[3];
=======
    NSArray *urls = @[@"http://www.wallpaperspictures.net/image/bruce-lee-iconic-figure-wallpaper-for-2560x1920-886-26.jpg", @"http://www.celebs101.com/gallery/Scarlett_Johansson/201825/allthatgossip_Scarlett_Johansson_GoldenGlobe_01.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-1068132.jpg",@"http://storage4.album.bg/52f/adriana_lima_5.jpg_d70f4_29141858.jpg",@"http://wallpapers.wallbase.cc/rozne/wallpaper-707568.jpg",@"http://2014download.com/images/2013/03/jessica-alba-awards-mtv.jpg",@"http://images4.fanpop.com/image/photos/16000000/adriana-victorias-secret-angels-16007539-760-1024.jpg"];
    NSString *imageUrl = urls[6];
>>>>>>> FETCH_HEAD
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
    [self.viewControllersDictionary setObject:mediaViewController forKey:@"mediaViewController"];
    // TODO: add viewcontrollers
    
    // Add ViewControllers to parent viewcontroller
    [self addChildViewController:neighborhoodViewController];
    [self addChildViewController:mediaViewController];
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
<<<<<<< HEAD
    NSInteger size = currentHeight + participantsViewController.view.frame.size.height;
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
=======
    NSInteger size = currentHeight + participantsViewController.participantsView.frame.size.height;
>>>>>>> FETCH_HEAD
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, size);
    // Add scrollview to view
    [self.view addSubview:self.scrollView];
}

- (void)setNeighborhood
{
    NeighborhoodViewController *neighborhoodViewController = [self.viewControllersDictionary objectForKey:@"neighborhoodViewController"];
    [neighborhoodViewController setNeighborhoodFields:self.action];
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary
{
//    NeighborhoodViewController *neighborhoodViewController = [self.viewControllersDictionary objectForKey:@"neighborhoodViewController"];
//    [neighborhoodViewController setNeighborhoodFields:[self.actionsArray objectAtIndex:0]];
}

- (void)restRequestFailed:(NSString *)failedMessage
{

}

@end
