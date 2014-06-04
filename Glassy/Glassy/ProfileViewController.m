//
//  ProfileViewController.m
//  Glassy
//
//  Created by Niek Willems on 11/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProfileViewController.h"
#import "PagingViewController.h"

@interface ProfileViewController ()

@property (nonatomic, strong) RESTClient *restGetPostcode;
@property (nonatomic, strong) RESTClient *restPutUser;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getProfileData
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController *parent = (PagingViewController*)self.parentViewController;
        
        if (parent.account.postcodeId != (NSString*)[NSNull null]) [self getPostcodeData:[parent.account.postcodeId intValue]];
        
        [self setUserFields];
    }
}

- (NSMutableDictionary *)createDictionaryForUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:self.profileView.firstNameTextField.text forKey:@"voornaam"];
    [params setObject:[self.profileView.lastNameTextField.text lowercaseString] forKey:@"achternaam"];
    [params setObject:[self.profileView.houseNumberTextField.text lowercaseString] forKey:@"huisnummer"];
    [params setObject:[defaults objectForKey:@"token"] forKey:@"_token"];

    return params;
}

//- (NSMutableDictionary *)createDictionaryForPostcode
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    // Objects have to be added in this order
//    [params setObject:@"true" forKey:@"borg_betaald"];
//    [params setObject:[defaults objectForKey:@"token"] forKey:@"_token"];
//    
//    return params;
//}

- (void)putUserData
{
    NSMutableDictionary *params = [self createDictionaryForUser];
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/gebruiker"];
    // Create REST client and send get request
    self.restPutUser = [[RESTClient alloc] init];
    self.restPutUser.delegate = self;
    [self.restPutUser PUT:url withParameters:params];
}

- (void)getPostcodeData:(int)postcodeId
{
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/postcode?%d", postcodeId];
    // Create REST client and send get request
    self.restGetPostcode = [[RESTClient alloc] init];
    self.restGetPostcode.delegate = self;
    [self.restGetPostcode PUT:url withParameters:nil];
}

- (void)setProfileImage
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([defaults objectForKey:@"foto_link"] != nil) {
        NSURL *imageUrl = [NSURL URLWithString:[defaults objectForKey:@"foto_link"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        self.profileView.profileImageView.image = [UIImage imageWithData:imageData];
    } else {
        self.profileView.profileImageView.image = [UIImage imageNamed:@"ios-nav-default-profile-image.png"];
    }
}

- (void)setUserFields
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController;
        if (parent.account != nil) {
            self.profileView.emailTextField.text = parent.account.email;
            self.profileView.passwordTextField.text = @"wachtwoord";
            self.profileView.firstNameTextField.text = parent.account.firstName;
            self.profileView.lastNameTextField.text = parent.account.lastName;
            //self.profileView.postcodeTextField.text = parent.account.postcode;
            //self.profileView.houseNumberTextField.text = parent.account.houseNumber;
        }
    }
}

- (void)save
{
    [self putUserData];
}

- (void)saveButtonPressed:(id)sender
{
    [self save];
}

- (void)toggleBuddyDetails:(id)sender
{
    
}

- (void)createView
{
    self.view.frame = CGRectMake(0, 85, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 85);
    self.profileView = [[ProfileView alloc] init];
    // Set delegates
    self.profileView.firstNameTextField.delegate = self;
    self.profileView.lastNameTextField.delegate = self;
    self.profileView.postcodeTextField.delegate = self;
    self.profileView.houseNumberTextField.delegate = self;
    self.profileView.emailTextField.delegate = self;
    self.profileView.passwordTextField.delegate = self;
    // Set button action
    [self.profileView.saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [self.profileView.buddySwitch addTarget:self action:@selector(toggleBuddyDetails:) forControlEvents:UIControlEventTouchDown];
    // Set profile image
    [self setProfileImage];
    // Create gestures
    //[self createGesture];
    [self.view addSubview:self.profileView];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController *parent = (PagingViewController*)self.parentViewController;
        [parent removeProfileView];
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
    if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController *parent = (PagingViewController*)self.parentViewController;
        if (client == self.restGetPostcode) {
            parent.account.postcode = [responseDictionary objectForKey:@"postcode"];
        } else if (client == self.restPutUser) {
            NSLog(@"modelstart");
            NSDictionary *array = responseDictionary[@"model"];
            if ([array isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"forstart");
                for (id key in array) {
                    NSLog(@"voornaam");
                    parent.account.firstName = [array objectForKey:@"voornaam"];
                    NSLog(@"achternaam");
                    parent.account.lastName = [array objectForKey:@"achternaam"];
                    NSLog(@"huisnummer");
                    parent.account.houseNumber = [array objectForKey:@"huisnummmer"];
                }
            }
        }
    }
    [self setUserFields];
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{

}

@end
