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
    for (id key in responseDictionary) {
        NSString *json = [NSString stringWithFormat:@"%@", key];
        NSString *fixed = [self fixJSON:json];
        NSData *data = [fixed dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(!dic) {
            NSLog(@"%@", error);
        }
    }
//        for (id obj in array) {
//            NSLog(@"%@", obj);
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

- (NSString *)fixJSON:(NSString *)json {
    json = [json stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    json = [json stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    json = [json stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
    int lastChar = [json length]-1;
    json = [json stringByReplacingCharactersInRange:NSMakeRange(lastChar,1) withString:@""];
    json = [json stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return  json;
}

@end
