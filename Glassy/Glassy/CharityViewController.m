//
//  CharityViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityViewController.h"
#import "MainViewController.h"

@interface CharityViewController ()

@property (nonatomic, strong) RESTClient *restGetCharity;

@end

@implementation CharityViewController

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

- (void)createView
{
    self.charityView = [[CharityView alloc] init];
    // Set view gestures
    [self createGesture];
    // Add chairtyView to view
    [self.view addSubview:self.charityView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCharityData:(int)actionId
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/goededoel?id=%d", actionId];
    // Create REST client and send get request
    self.restGetCharity = [[RESTClient alloc] init];
    self.restGetCharity.delegate = self;
    [self.restGetCharity GET:url withParameters:nil];
}

- (void)setCharityByDictionary:(NSMutableDictionary *)fields
{
    self.charity = [[Charity alloc] initWithDictionary:fields];
}

#pragma mark - PAN gesture methods

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    gestureRecognizer.numberOfTouchesRequired = 1;
    [self.charityView addGestureRecognizer:gestureRecognizer];
}

- (void)panHandler:(UITapGestureRecognizer *)recognizer
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent createCharityDetailView:self.charity];
    }
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    [self setCharityByDictionary:responseDictionary];
    
    self.charityView.textview.text = self.charity.description;
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}


@end
