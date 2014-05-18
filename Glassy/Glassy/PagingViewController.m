//
//  PagingViewController.m
//  Glassy
//
//  Created by Niek Willems on 13/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "PagingViewController.h"

@interface PagingViewController ()

@property (nonatomic, strong) RESTClient *restClient;

@end

@implementation PagingViewController

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
    
    [self getAllActions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)getAllActions
{
    // Create REST client and send get request
    self.restClient = [[RESTClient alloc] init];
    self.restClient.delegate = self;
    [self.restClient GET:@"http://glassy-api.avans-project.nl/api/actie" withParameters:nil];
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

- (void)createPagingScrollView
{
    int count = self.mainViewControllers.count;
    float pageX = 0;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDirectionalLockEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * count,  1)];
	[self.scrollView setBackgroundColor: [UIColor blackColor]];
    [self.view addSubview:self.scrollView];

    
    for (int i = 0; i < count; i++)
    {
        MainViewController *main = self.mainViewControllers[i];
        CGRect pageFrame = (CGRect)
        {
            .origin = CGPointMake(pageX, self.scrollView.bounds.origin.y),
            .size.width = self.view.bounds.size.width,
            .size.height = self.view.bounds.size.height
        };
        // Set frame
        main.view.frame = pageFrame;
        // Add MainViewController to ScrollView
        [self.scrollView addSubview:main.view];
    
        pageX += pageFrame.size.width;  
    }
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary
{
    self.actionsArray = [[NSMutableArray alloc] init];
    self.mainViewControllers = [[NSMutableArray alloc] init];
    
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
    
    for (int i = 0; i < self.actionsArray.count; i++) {
        // Initialize new MainViewController
        MainViewController *mainViewController = [[MainViewController alloc] init];
        // Add MainViewController to child view controllers
        [self addChildViewController:mainViewController];
        [mainViewController didMoveToParentViewController:self];
        // Add to array
        [self.mainViewControllers addObject:mainViewController];
        // Set MainViewController action
        mainViewController.action = self.actionsArray[i];
        [mainViewController setNeighborhood];
        
//        mainViewController.action = self.actionsArray[i];
//        [[mainViewController.viewControllersDictionary objectForKey:@"neighborhoodViewController"]setNeighborhoodFields:[self.actionsArray objectAtIndex:0]];
    }
    
    [self createPagingScrollView];
    // Add subviews
    [self createDropDownMenuViewController];
    [self createSearchViewController];
    [self createNavigationBarViewController];
}

- (void)restRequestFailed:(NSString *)failedMessage
{

}

@end
