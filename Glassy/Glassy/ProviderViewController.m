//
//  ProviderViewController.m
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProviderViewController.h"
#import "PagingViewController.h"

@interface ProviderViewController ()

@property (nonatomic, strong) RESTClient *restGetProviders;
@property (nonatomic, strong) RESTClient *restSetProviderId;

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

- (NSMutableDictionary *)createDictionaryWithParameters:(int)providerId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:[NSNumber numberWithInt:providerId] forKey:@"provider_id"];
    [params setObject:[defaults objectForKey:@"token"] forKey:@"_token"];
    
    return params;
}

- (void)setProviderId:(int)providerId
{
    // Create dictionary with parameters
    NSMutableDictionary *params = [self createDictionaryWithParameters:providerId];
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/gebruiker"];
    // Create REST client and send get request
    self.restSetProviderId = [[RESTClient alloc] init];
    self.restSetProviderId.delegate = self;
    [self.restSetProviderId PUT:url withParameters:params];
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
    Provider *provider = [self.providerView.providerArray objectAtIndex:self.providerView.currentRow];
    [self setProviderId:provider.providerId];
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    if (client == self.restGetProviders) {
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
    } else if (client == self.restSetProviderId) {
        NSDictionary *array = responseDictionary[@"model"];
		if ([array isKindOfClass:[NSDictionary class]])
		{
            for (id key in array) {
                if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
                    PagingViewController *parent = (PagingViewController*)self.parentViewController;
                    parent.account.providerId = [array objectForKey:@"provider_id"];
                    [parent handleActionButtonStage];
                    [self.view removeFromSuperview];
                }
            }
        }
    }
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{

}

@end
