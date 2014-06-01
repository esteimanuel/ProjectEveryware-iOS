//
//  ProviderViewController.m
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProviderViewController.h"

@interface ProviderViewController ()

@property (nonatomic, strong) RESTClient *restGetProviders;

@end

@implementation ProviderViewController

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

- (void)getProviderData
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/provider"];
    // Create REST client and send get request
    self.restGetProviders = [[RESTClient alloc] init];
    self.restGetProviders.delegate = self;
    [self.restGetProviders GET:url withParameters:nil];
}

- (void)createView
{
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, 330);
    self.providerView = [[ProviderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 330)];
    // Set button targets
    [self.providerView.providerSaveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchDown];
    // Add providerView to view
    [self.view addSubview:self.providerView];
}

#pragma mark - Button handlers

- (void)saveButtonPressed:(id)sender
{

}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
	self.providerArray = [[NSMutableArray alloc] init];
	for (id key in responseDictionary)
	{
        Provider *provider = [[Provider alloc] init];
        provider.name = [key valueForKey:@"naam"];
        provider.providerId = [[key valueForKey:@"provider_id"] intValue];
        provider.url = [key valueForKey:@"website_url"];
		[self.providerArray addObject:provider];
	}
    self.providerView.providerArray = self.providerArray;
    [self.providerView.providerPickerView reloadAllComponents];
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{

}

@end
