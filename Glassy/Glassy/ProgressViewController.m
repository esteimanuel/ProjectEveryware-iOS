//
//  ProgressViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController

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
    self.progressView = [[ProgressView alloc] init];
    // Add mediaView to view
    [self.view addSubview:self.progressView];
}

- (void)setProgressData:(Action *)action
{
    self.progressView.verzamelenProgress.progress = action.targetPartPerc / 100;
    self.progressView.inschrijvenProgress.progress = action.paidTargetPerc / 100;
    self.progressView.providerProgress.progress = action.providerSelecPerc / 100;
}

//- (void)getProgress:(int)actionId
//{
//    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/actie/stats?id=%d", actionId];
//    // Create REST client and send get request
//    self.restGetProgress = [[RESTClient alloc] init];
//    self.restGetProgress.delegate = self;
//    [self.restGetProgress GET:url withParameters:nil];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - REST client delegate methods
//
//- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
//{
//    CGFloat totalPartPerc = [[responseDictionary objectForKey:@"totalPartPerc"] floatValue];
//    self.progressView.verzamelenProgress.progress = totalPartPerc / 100;
//    CGFloat totalPaidPerc = [[responseDictionary objectForKey:@"totalPaidPerc"] floatValue];
//    self.progressView.inschrijvenProgress.progress = totalPaidPerc / 100;
//    CGFloat providerSelecPerc = [[responseDictionary objectForKey:@"providerSelecPerc"] floatValue];
//    self.progressView.providerProgress.progress = providerSelecPerc / 100;
//}
//
//- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
//{
//
//}

@end
