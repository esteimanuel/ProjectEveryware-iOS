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
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/postcode?id=%d", postcodeId];
    // Create REST client and send get request
    self.restGetPostcode = [[RESTClient alloc] init];
    self.restGetPostcode.delegate = self;
    [self.restGetPostcode GET:url withParameters:nil];
}

- (void)setProfileImage:(PagingViewController *)parent
{
    if (parent.account.image != (NSString *)[NSNull null]) {
        NSURL *imageUrl = [NSURL URLWithString:parent.account.image];
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
            if (parent.account.email != (NSString *)[NSNull null]) self.profileView.emailTextField.text = parent.account.email;
            //if (parent.account.email != (NSString *)[NSNull null]) self.profileView.passwordTextField.text = @"wachtwoord";
            if (parent.account.firstName != (NSString *)[NSNull null]) self.profileView.firstNameTextField.text = parent.account.firstName;
            if (parent.account.lastName != (NSString *)[NSNull null]) self.profileView.lastNameTextField.text = parent.account.lastName;
            if (parent.account.postcode != (NSString *)[NSNull null]) self.profileView.postcodeTextField.text = parent.account.postcode;
            //if (parent.account.houseNumber != (NSString *)[NSNull null]) self.profileView.houseNumberTextField.text = parent.account.houseNumber;
        }
        [self setProfileImage:parent];
        [parent refreshNavigationBarView];
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
            NSDictionary *array = responseDictionary[@"model"];
            if ([array isKindOfClass:[NSDictionary class]])
            {
                for (id key in array) {
                    parent.account.firstName = [array objectForKey:@"voornaam"];
                    parent.account.lastName = [array objectForKey:@"achternaam"];
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
