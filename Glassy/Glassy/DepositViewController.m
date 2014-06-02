//
//  DepositViewController.m
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "DepositViewController.h"
#import "PagingViewController.h"

@interface DepositViewController ()

@property (nonatomic, strong) RESTClient *restSetDepositPaid;

@end

@implementation DepositViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)createDictionaryWithParameters
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:@"true" forKey:@"borg_betaald"];
    [params setObject:[defaults objectForKey:@"token"] forKey:@"_token"];
    
    return params;
}

- (void)setDepositPaid
{
    // Create dictionary with parameters
    NSMutableDictionary *params = [self createDictionaryWithParameters];
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/gebruiker"];
    // Create REST client and send get request
    self.restSetDepositPaid = [[RESTClient alloc] init];
    self.restSetDepositPaid.delegate = self;
    [self.restSetDepositPaid PUT:url withParameters:params];
}

- (void)createView
{
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, 140);
    self.depositView = [[DepositView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140)];
    // Set button targets
    [self.depositView.depositPayButton addTarget:self action:@selector(payButtonPressed:) forControlEvents:UIControlEventTouchDown];
    // Add providerView to view
    [self.view addSubview:self.depositView];
}

#pragma mark - Button handlers

- (void)payButtonPressed:(id)sender
{
    [self setDepositPaid];
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    NSDictionary *array = responseDictionary[@"model"];
    if ([array isKindOfClass:[NSDictionary class]])
    {
        for (id key in array) {
            if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
                PagingViewController *parent = (PagingViewController*)self.parentViewController;
                parent.account.deposit_paid = [array objectForKey:@"borg_betaald"];
                [parent handleActionButtonStage];
                [self.view removeFromSuperview];
            }
        }
    }
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}

@end
