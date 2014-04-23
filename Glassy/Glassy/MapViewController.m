//
//  MapViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    
    UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    webview.scalesPageToFit = YES;
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://glassy-web.avans-project.nl"]]];

    [self.view addSubview:webview];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
