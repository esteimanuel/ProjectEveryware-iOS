//
//  AuthenticationViewController.m
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "LoginViewController.h"
//#import "MainViewController.h"
#import "PagingViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) RESTClient *restClient;

@end

@implementation LoginViewController

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

- (void)login
{
    // Create dictionary with parameters
    NSMutableDictionary *params = [self createDictionaryWithParameters];
    // Create REST client and send get request
    self.restClient = [[RESTClient alloc] init];
    self.restClient.delegate = self;
    [self.restClient GET:@"http://glassy-api.avans-project.nl/api/account/login?" withParameters:params];
}

- (void)logout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"token"];
    [defaults removeObjectForKey:@"gebruiker_id"];
    [defaults removeObjectForKey:@"account_id"];
    [defaults synchronize];
        
    if ([defaults objectForKey:@"token"] == nil) {
        NSLog(@"User logged out");
    }
}

- (NSMutableDictionary *)createDictionaryWithParameters
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:self.loginView.passwordTextField.text forKey:@"wachtwoord"];
    [params setObject:[self.loginView.emailTextField.text lowercaseString] forKey:@"email"];
    
    return params;
}

- (void)authenticationButtonPressed:(id)sender
{
    [self login];
}

- (void)createView
{
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, 300);
    self.loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    // Set textfield delegates
    self.loginView.passwordTextField.delegate = self;
    self.loginView.emailTextField.delegate = self;
    // Set button targets
    [self.loginView.authenticationButton addTarget:self action:@selector(authenticationButtonPressed:) forControlEvents:UIControlEventTouchDown];
    // Set view gestures
    //[self createGesture];
    // Add loginView to view
    [self.view addSubview:self.loginView];
}

//#pragma mark - Gesture recognizer methods
//
//- (void)createGesture
//{
//    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
//    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
//    [self.loginView addGestureRecognizer:gestureRecognizer];
//}
//
//- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer
//{
//    [self dispose];
//}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController;
        [parent removeLoginView];
    }
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *accountDictionary = (NSDictionary *)[responseDictionary objectForKey:@"account"];
    
    if ([accountDictionary isKindOfClass:[NSDictionary class]]) {
        NSString *token = [accountDictionary objectForKey:@"token"];
        
        if (token != (NSString *)[NSNull null]) {
            [defaults setObject:token forKey:@"token"];
            [defaults setObject:[accountDictionary objectForKey:@"account_id"] forKey:@"account_id"];
            [defaults synchronize];
            
            Account *account = [[Account alloc] init];
            //account.accountId = [accountDictionary objectForKey:@"account_id"];
            account.email = [accountDictionary objectForKey:@"email"];
            account.accountLevel = [accountDictionary objectForKey:@"accountlevel_id"];
            account.image = [accountDictionary objectForKey:@"foto_link"];
            NSMutableDictionary *userDictionary = (NSMutableDictionary *)[accountDictionary objectForKey:@"gebruiker"];
            if (userDictionary != nil) {
                // Save user id to user defaults
                [defaults setObject:[userDictionary objectForKey:@"gebruiker_id"] forKey:@"gebruiker_id"];
                if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
                    PagingViewController* parent = (PagingViewController*)self.parentViewController;
                    [parent setAccountByDictionary:userDictionary];
                }
            }
        } else {
            [self showAuthenticationError];
        }
        
        NSLog(@"User logged in with token: %@", [defaults objectForKey:@"token"]);
        
        [self dispose];
    }
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    [self showAuthenticationError];
}

- (void)showAuthenticationError
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Authentication failed"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
