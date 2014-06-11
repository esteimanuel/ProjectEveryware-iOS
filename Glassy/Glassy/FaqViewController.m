//
//  FaqViewController.m
//  Glassy
//
//  Created by Este Tigele on 18/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqViewController.h"
#import "MainViewController.h"

@interface FaqViewController ()

@property (nonatomic, strong) RESTClient *restGetFaq;

@end

@implementation FaqViewController

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
	self.faqView = [[FaqView alloc] init];
    // Set view gestures
    [self createGesture];
    // Add mediaView to view
    [self.view addSubview:self.faqView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFaq
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/faq"];
    // Create REST client and send get request
    self.restGetFaq = [[RESTClient alloc] init];
    self.restGetFaq.delegate = self;
    [self.restGetFaq GET:url withParameters:nil];
}

#pragma mark - PAN gesture methods

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    gestureRecognizer.numberOfTouchesRequired = 1;
    [self.faqView addGestureRecognizer:gestureRecognizer];
}

- (void)panHandler:(UITapGestureRecognizer *)recognizer
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent createFaqDetailView];
    }
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
	NSMutableArray *array = [[NSMutableArray alloc]init];
	for (id key in responseDictionary)
	{
        [array addObject:[key valueForKey:@"question" ]];
	}
    if ([array count] > 0) {
        for(int i=0; i<[array count]; i++) {
            if(i == 0) self.faqView.firstQuestionLabel.text = array[0];
            if(i == 1) self.faqView.secondQuestionLabel.text = array[1];
            if(i == 2) self.faqView.thirdQuestionLabel.text = array[2];
        }
    }
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}

@end
