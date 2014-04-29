//
//  AuthenticationViewController.m
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "LoginViewController.h"
#import "RESTClient.h"

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
    
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 85);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createLoginView];
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

- (NSMutableDictionary *)createDictionaryWithParameters
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:self.passwordTextField.text forKey:@"wachtwoord"];
    [params setObject:self.emailTextField.text forKey:@"email"];
    
    return params;
}

- (void)authenticationButtonPressed:(id)sender
{
    [self login];
}

- (void)createLoginView
{    
    // Create facebook button
    UIButton *facebookAuthenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, (self.view.frame.size.height - 450.0), 210, 40)];
    facebookAuthenticationButton.backgroundColor = [UIColor lightGrayColor];
    facebookAuthenticationButton.layer.cornerRadius = 5.0;
    facebookAuthenticationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [facebookAuthenticationButton setTitle:@"Aanmelden via Facebook" forState:UIControlStateNormal];
    
    UILabel *orLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, (self.view.frame.size.height - 380), 30, 30)];
    orLabel.text = @"of";
    orLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    orLabel.font = [UIFont italicSystemFontOfSize:11];
    orLabel.textColor = [UIColor lightGrayColor];
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, (self.view.frame.size.height - 320.0), 210, 40)];
    self.emailTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.emailTextField.layer.borderWidth = 0.5;
    self.emailTextField.layer.cornerRadius = 5.0;
    self.emailTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.emailTextField.placeholder = @"E-mailadres";
    self.emailTextField.delegate = self;
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, (self.view.frame.size.height - 270.0), 210, 40)];
    self.passwordTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.passwordTextField.placeholder = @"Wachtwoord";
    self.passwordTextField.delegate = self;
    
    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 140), self.view.frame.size.width, 140)];
    registerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    
    UISwitch *rememberMeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(50, 20, 15, 10)];
    rememberMeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    UILabel *rememberMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 25, 150, 20)];
    rememberMeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    rememberMeLabel.font = [UIFont boldSystemFontOfSize:13];
    rememberMeLabel.text = @"Onthoud mijn gegevens";
    rememberMeLabel.textColor = [UIColor darkGrayColor];
    
    UIButton *authenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, (registerView.frame.size.height - 70.0), 210, 40)];
    authenticationButton.backgroundColor = [UIColor lightGrayColor];
    authenticationButton.layer.cornerRadius = 5.0;
    authenticationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [authenticationButton addTarget:self action:@selector(authenticationButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [authenticationButton setTitle:@"Inloggen" forState:UIControlStateNormal];
    
    [registerView addSubview:rememberMeSwitch];
    [registerView addSubview:rememberMeLabel];
    [registerView addSubview:authenticationButton];

    [self.view addSubview:facebookAuthenticationButton];
    [self.view addSubview:orLabel];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:registerView];
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary
{
    NSString *token = [responseDictionary objectForKey:@"token"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (token != nil) {
        [defaults setObject:token forKey:@"token"];
        [defaults synchronize];
    }
    
    NSLog(@"User logged in with token: %@", [defaults objectForKey:@"token"]);
}

- (void)restRequestFailed:(NSString *)failedMessage
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Authentication failed"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
