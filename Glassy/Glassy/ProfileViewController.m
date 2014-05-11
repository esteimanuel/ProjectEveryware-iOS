//
//  ProfileViewController.m
//  Glassy
//
//  Created by Niek Willems on 11/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProfileViewController.h"
#import "MainViewController.h"

@interface ProfileViewController ()

@property (nonatomic, strong) RESTClient *restClient;

@end

@implementation ProfileViewController

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

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createGUI];
    //[self createGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfileImage
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([defaults objectForKey:@"foto_link"] != nil) {
        NSURL *imageUrl = [NSURL URLWithString:[defaults objectForKey:@"foto_link"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        self.profileImageView.image = [UIImage imageWithData:imageData];
    } else {
        self.profileImageView.image = [UIImage imageNamed:@"ios-nav-default-profile-image.png"];
    }
}

- (void)save
{
    // Create dictionary with parameters
    NSMutableDictionary *params = [self createDictionaryWithParameters];
    // Create REST client and send get request
    self.restClient = [[RESTClient alloc] init];
    self.restClient.delegate = self;
    [self.restClient PUT:@"http://glassy-api.avans-project.nl/api/user" withParameters:params];
}

- (NSMutableDictionary *)createDictionaryWithParameters
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:self.passwordTextField.text forKey:@"wachtwoord"];
    [params setObject:[self.emailTextField.text lowercaseString] forKey:@"email"];
    
    return params;
}

- (void)saveButtonPressed:(id)sender
{
    //[self save];
}

- (void)createGUI
{
    CGFloat margin = 15;
    CGFloat currentHeight = margin;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, currentHeight, 100, 100)];
    self.profileImageView.layer.cornerRadius = 5.0;
    [self setProfileImage];
    
    currentHeight = currentHeight + self.profileImageView.frame.size.height + margin;
    
    self.firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.firstNameTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.firstNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.firstNameTextField.layer.borderWidth = 0.5;
    self.firstNameTextField.layer.cornerRadius = 5.0;
    self.firstNameTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.firstNameTextField.placeholder = @"Voornaam";
    self.firstNameTextField.delegate = self;
    
    currentHeight = currentHeight + self.firstNameTextField.frame.size.height + margin;
    
    self.lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.lastNameTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.lastNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lastNameTextField.layer.borderWidth = 0.5;
    self.lastNameTextField.layer.cornerRadius = 5.0;
    self.lastNameTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.lastNameTextField.placeholder = @"Achternaam";
    self.lastNameTextField.delegate = self;
    
    currentHeight = currentHeight + self.lastNameTextField.frame.size.height + margin;
    
    self.postcodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 130, 40)];
    self.postcodeTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.postcodeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.postcodeTextField.layer.borderWidth = 0.5;
    self.postcodeTextField.layer.cornerRadius = 5.0;
    self.postcodeTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.postcodeTextField.placeholder = @"Postcode";
    self.postcodeTextField.delegate = self;
    
    self.houseNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(55 + self.postcodeTextField.frame.size.width + 10, currentHeight, 70, 40)];
    self.houseNumberTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.houseNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.houseNumberTextField.layer.borderWidth = 0.5;
    self.houseNumberTextField.layer.cornerRadius = 5.0;
    self.houseNumberTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.houseNumberTextField.placeholder = @"Huisnr.";
    self.houseNumberTextField.delegate = self;
    
    currentHeight = currentHeight + self.postcodeTextField.frame.size.height + margin;
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.emailTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.emailTextField.layer.borderWidth = 0.5;
    self.emailTextField.layer.cornerRadius = 5.0;
    self.emailTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.emailTextField.placeholder = @"E-mail";
    self.emailTextField.delegate = self;
    self.emailTextField.secureTextEntry = YES;
    
    currentHeight = currentHeight + self.emailTextField.frame.size.height + margin;
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.passwordTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.passwordTextField.placeholder = @"Wachtwoord";
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
    
    currentHeight = currentHeight + self.passwordTextField.frame.size.height + margin;
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    saveButton.backgroundColor = [UIColor lightGrayColor];
    saveButton.layer.cornerRadius = 5.0;
    saveButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [saveButton setTitle:@"Opslaan" forState:UIControlStateNormal];
    
    currentHeight = currentHeight + saveButton.frame.size.height + margin;
    
    // Create scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, currentHeight)];
    // Add all views to scrollview
    [self.scrollView addSubview:self.profileImageView];
    [self.scrollView addSubview:self.firstNameTextField];
    [self.scrollView addSubview:self.lastNameTextField];
    [self.scrollView addSubview:self.postcodeTextField];
    [self.scrollView addSubview:self.houseNumberTextField];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.passwordTextField];
    [self.scrollView addSubview:saveButton];
    // Set content size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, currentHeight);
    self.scrollView.scrollEnabled = YES;
    // Set frame size
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, self.scrollView.frame.size.height);
    // Add scrollview to view
    [self.view addSubview:self.scrollView];
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Gesture recognizer methods

- (void)createGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    [self dispose];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeProfileView];
    }
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *accountDictionary = (NSDictionary *)[responseDictionary objectForKey:@"account"];
    if (accountDictionary != nil) {
        NSString *token = [accountDictionary objectForKey:@"token"];
        NSString *image = [accountDictionary objectForKey:@"foto_link"];
        
        if (token != (NSString *)[NSNull null]) {
            [defaults setObject:token forKey:@"token"];
            [defaults setObject:[accountDictionary objectForKey:@"email"] forKey:@"email"];
            [defaults setObject:[accountDictionary objectForKey:@"account_id"] forKey:@"account_id"];
            if (image != (NSString *)[NSNull null]) [defaults setObject:image forKey:@"foto_link"];
            [defaults synchronize];
        } else {

        }
        
        NSLog(@"User logged in with token: %@", [defaults objectForKey:@"token"]);
        
        [self dispose];
    }
}

- (void)restRequestFailed:(NSString *)failedMessage
{

}

@end
