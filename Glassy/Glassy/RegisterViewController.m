//
//  RegisterViewController.m
//  Glassy
//
//  Created by Niek Willems on 29/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "RegisterViewController.h"
#import "PagingViewController.h"
#import "RESTClient.h"

@interface RegisterViewController ()

@property (nonatomic, strong) RESTClient *restClient;

@end

@implementation RegisterViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)register
{
    // Create dictionary with parameters
    NSMutableDictionary *params = [self createDictionaryWithParameters];
    // Create REST client and send get request
    self.restClient = [[RESTClient alloc] init];
    self.restClient.delegate = self;
    [self.restClient POST:@"http://glassy-api.avans-project.nl/api/account/register" withParameters:params];
}

- (NSMutableDictionary *)createDictionaryWithParameters
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setObject:[self.registerView.emailTextField.text lowercaseString] forKey:@"email"];
    [params setObject:self.registerView.passwordTextField.text forKey:@"wachtwoord"];
    
    return params;
}

- (void)registerButtonPressed:(id)sender
{
    [self register];
}

- (void)createView
{
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, 300);
    self.registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    // Set textfield delegates
    self.registerView.passwordTextField.delegate = self;
    self.registerView.emailTextField.delegate = self;
    // Set button targets
    [self.registerView.authenticationButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchDown];
    // Set view gestures
    //[self createGesture];
    // Add loginView to view
    [self.view addSubview:self.registerView];
}

//#pragma mark - Gesture recognizer methods
//
//- (void)createGesture
//{
//    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
//    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
//    [self.registerView addGestureRecognizer:gestureRecognizer];
//}
//
//- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer
//{
//    [self dispose];
//}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController *parent = (PagingViewController*)self.parentViewController;
        [parent removeRegisterView];
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
                                                        message:@"Registration failed"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
