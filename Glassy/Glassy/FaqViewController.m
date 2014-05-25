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
    //for (id key in responseDictionary) {
        //NSArray *array = [responseDictionary allKeys];
        //NSString *json = [NSString stringWithFormat:@"%@", key];
        //NSData *data = [array dataUsingEncoding:NSUTF8StringEncoding];
        
//        for (id obj in array) {
//            NSLog(@"%@", obj);
//        }
    
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        if(!dic) {
//            NSLog(@"%@", error);
//        }
        
//        for (id k in dic) {
//            NSLog(@"key: %@ value:", k);
//        }
    //}
        //NSLog(@"key: %@", key);
    
    self.faqView.firstQuestionLabel.text = @" henk";
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}

@end
