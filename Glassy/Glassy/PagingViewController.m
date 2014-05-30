//
//  PagingViewController.m
//  Glassy
//
//  Created by Niek Willems on 13/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "PagingViewController.h"

@interface PagingViewController ()

@property (nonatomic, strong) RESTClient *restGetActions;
@property (nonatomic, strong) RESTClient *restGetActionCount;
@property (nonatomic, strong) RESTClient *restGetAccount;

@end

@implementation PagingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create loading view and start animating
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingView.center = self.view.center;
    [self.loadingView startAnimating];
    [self.view addSubview:self.loadingView];
    
    [self getActionCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setAccountByDictionary:(NSMutableDictionary *)fields
{
    self.account = [[Account alloc] initWithDictionary:fields];
}

#pragma mark - REST API calls

- (void)getActionCount
{
    // Create REST client and send get request
    self.restGetActionCount = [[RESTClient alloc] init];
    self.restGetActionCount.delegate = self;
    [self.restGetActionCount GET:@"http://glassy-api.avans-project.nl/api/actie?calc=count" withParameters:nil];
}

- (void)getAllActions
{
    // Create REST client and send get request
    self.restGetActions = [[RESTClient alloc] init];
    self.restGetActions.delegate = self;
    [self.restGetActions GET:@"http://glassy-api.avans-project.nl/api/actie" withParameters:nil];
}

- (void)getAccount:(int)accountId
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/gebruiker?id=%d", accountId];
    // Create REST client and send get request
    self.restGetAccount = [[RESTClient alloc] init];
    self.restGetAccount.delegate = self;
    [self.restGetAccount GET:url withParameters:nil];
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
//    [self addChildViewController:self.registerViewController];
//    [self.view addSubview:self.registerViewController.registerView];
    [self handleActiveViewController:self.registerViewController];
}

- (void)removeRegisterView
{
    // Reset active viewcontroller
    [self handleActiveViewController:nil];
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
    //[self addChildViewController:self.loginViewController];
    //[self.view addSubview:self.loginViewController.view];
    [self handleActiveViewController:self.loginViewController];
}

- (void)removeLoginView
{
    // Reset active viewcontroller
    [self handleActiveViewController:nil];
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
    [self.profileViewController setUserFields];
    [self handleActiveViewController:self.profileViewController];
}

- (void)removeProfileView
{
    [self handleActiveViewController:nil];
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

- (void)handleActiveViewController:(UIViewController *)viewController
{
    if (viewController == nil) {
        [self.activeViewController.view removeFromSuperview];
        [self.activeViewController removeFromParentViewController];
        self.activeViewController = nil;
    } else {
        self.activeViewController = viewController;
        [self addChildViewController:self.activeViewController];
        [self.view addSubview:self.activeViewController.view];
    }
}

#pragma mark - Paging scrollview initialization

- (void)createPagingScrollView
{
    int count = self.mainViewControllers.count;
    float pageX = 0;
    
    self.scrollView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDirectionalLockEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * count,  1)];
	[self.scrollView setBackgroundColor: [UIColor blackColor]];

    
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
    [self.view addSubview:self.scrollView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"PagingViewController touches began");
    NSLog(@"PagingViewController touched %@", self);
    NSLog(@"PagingViewController nextResponder = %@", self.nextResponder);
    //[super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[super touchesMoved:touches withEvent:event];
    [[self nextResponder] touchesMoved:touches withEvent:event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog(@"Touches ended: PagingViewController");
    //[super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    if (client == self.restGetActionCount) {
        self.mainViewControllers = [[NSMutableArray alloc] init];
        // Get number of actions received from REST call, if no actions set count to 1
        NSString *count = [responseDictionary objectForKey:@"result"];
        if ([count intValue] <= 0) count = @"1";
        for (int i = 0; i < [count intValue]; i++) {
            // Initialize new MainViewController
            MainViewController *mainViewController = [[MainViewController alloc] init];
            // Add MainViewController to child view controllers
            //[self addChildViewController:mainViewController];
            //[mainViewController didMoveToParentViewController:self];
            // Add to array
            [self.mainViewControllers addObject:mainViewController];
        }
        [self createPagingScrollView];
        [self createDropDownMenuViewController];
        [self createSearchViewController];
        [self createNavigationBarViewController];
        
        [self getAllActions];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"token"]) {
            NSInteger accountId = [defaults integerForKey:@"gebruiker_id"];
            [self getAccount:accountId];
        }
    } else if (client == self.restGetActions) {
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
        
        for (int i = 0; i < self.actionsArray.count; i++) {
            // Initialize new MainViewController
            MainViewController *mainViewController = [self.mainViewControllers objectAtIndex:i];
            // Add MainViewController to child viewcontrollers
            [self addChildViewController:mainViewController];
            //[mainViewController didMoveToParentViewController:self];
            // Set MainViewController action
            mainViewController.action = self.actionsArray[i];
            // Set MainViewController data, methods have to be called in this order!
            [mainViewController getNeighborhoodData:[mainViewController.action.id intValue]];
            [mainViewController setMapData];
            [mainViewController setMediaData];
            [mainViewController setCharityData];
            [mainViewController setFaqData];
			[mainViewController setParticipants];
        }
    } else if (client == self.restGetAccount) {
        [self setAccountByDictionary:responseDictionary];
        // Stop animating loading view
        [self.loadingView stopAnimating];
    }
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{

}

@end
