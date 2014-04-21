//
//  AuthenticationViewController.m
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

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
    
    [self createAuthenticationView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createAuthenticationView
{    
    // Create facebook button
    UIButton *facebookAuthenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, (self.view.frame.size.height - 450.0), 210, 40)];
    facebookAuthenticationButton.backgroundColor = [UIColor lightGrayColor];
    facebookAuthenticationButton.layer.cornerRadius = 5.0;
    [facebookAuthenticationButton setTitle:@"Registreer via Facebook" forState:UIControlStateNormal];
    
    
    UITextField *emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, (self.view.frame.size.height - 320.0), 210, 40)];
    emailTextField.layer.borderColor = (__bridge CGColorRef)([UIColor lightGrayColor]);
    emailTextField.layer.borderWidth = 1.0;
    emailTextField.placeholder = @"E-mailadres";
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, (self.view.frame.size.height - 270.0), 210, 40)];
    passwordTextField.layer.borderColor = (__bridge CGColorRef)([UIColor lightGrayColor]);
    passwordTextField.layer.borderWidth = 1.0;
    passwordTextField.placeholder = @"Wachtwoord";
    
    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 140), self.view.frame.size.width, 140)];
    registerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    
    UISwitch *rememberMeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(55, 20, 15, 10)];
    UILabel *rememberMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 25, 150, 20)];
    rememberMeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    rememberMeLabel.font = [UIFont boldSystemFontOfSize:13];
    rememberMeLabel.text = @"Onthoud mijn gegevens";
    rememberMeLabel.textColor = [UIColor darkGrayColor];
    
    UIButton *authenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, (registerView.frame.size.height - 70.0), 210, 40)];
    authenticationButton.backgroundColor = [UIColor lightGrayColor];
    authenticationButton.layer.cornerRadius = 5.0;
    [authenticationButton setTitle:@"Registreer" forState:UIControlStateNormal];
    
    [registerView addSubview:rememberMeSwitch];
    [registerView addSubview:rememberMeLabel];
    [registerView addSubview:authenticationButton];

    [self.view addSubview:facebookAuthenticationButton];
    [self.view addSubview:emailTextField];
    [self.view addSubview:passwordTextField];
    [self.view addSubview:registerView];
}

@end
