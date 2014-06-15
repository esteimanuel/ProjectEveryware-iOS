//
//  FaqDetailViewController.m
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqDetailViewController.h"
#import "MainViewController.h"

@interface FaqDetailViewController ()

@property (nonatomic, strong) RESTClient *restGetFaq;

@end

@implementation FaqDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self createGesture];
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

- (void)createView
{
    self.faqDetailView = [[FaqDetailView alloc] init];
    [self.view addSubview:self.faqDetailView];
    
}

#pragma mark - UISwipeGestureRecognizer delegate methods

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UITapGestureRecognizer *)recognizer
{
    [self dispose];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeFaqDetailView];
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
            //if(i == 0) self.faqDetailView.faqLabel.text = array[0];
        }
    }}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}


@end
