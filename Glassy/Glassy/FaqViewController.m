//
//  FaqViewController.m
//  Glassy
//
//  Created by Este Tigele on 18/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqViewController.h"

@interface FaqViewController ()

@property (nonatomic, strong) RESTClient *restGetFaq;

@end

@implementation FaqViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createView
{
	self.faqView = [[FaqView alloc] init];
    // Add mediaView to view
    [self.view addSubview:self.faqView];
}

- (void)getFaq
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/faq"];
    // Create REST client and send get request
    self.restGetFaq = [[RESTClient alloc] init];
    self.restGetFaq.delegate = self;
    [self.restGetFaq GET:url withParameters:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
	NSMutableArray *array = [[NSMutableArray alloc]init];
	for (id key in responseDictionary)
	{
//		NSLog(@"key: %@ value: %@",[key valueForKey:@"question"],[key valueForKey:@"answer"]);
		[array addObject:[key valueForKey:@"question" ]];
	}
    
    self.faqView.firstQuestionLabel.text = array[0];
	NSLog(@"First question: %@",array[0]);
    self.faqView.secondQuestionLabel.text = array[1];
	NSLog(@"Second question: %@",array[1]);
    self.faqView.thirdQuestionLabel.text = array[2];
	NSLog(@"Third question: %@",array[2]);
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}

@end
