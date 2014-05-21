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
	self.faqView = [[FaqView alloc]init];
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
    for (id key in responseDictionary) {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    }
        //NSLog(@"key: %@", key);
    
    //NSString *firstQuestion = [responseDictionary objectForKey:@"totalPartPerc"];
//    CGFloat totalPartPerc = [[responseDictionary objectForKey:@"totalPartPerc"] floatValue];
    self.faqView.firstQuestionLabel.text = @" henk";
//    CGFloat totalPaidPerc = [[responseDictionary objectForKey:@"totalPaidPerc"] floatValue];
//    self.progressView.inschrijvenProgress.progress = totalPaidPerc / 100;
//    CGFloat providerSelecPerc = [[responseDictionary objectForKey:@"providerSelecPerc"] floatValue];
//    self.progressView.providerProgress.progress = providerSelecPerc / 100;
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}

@end
