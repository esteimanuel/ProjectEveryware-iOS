//
//  MediaViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MediaViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MediaViewController ()

@end

@implementation MediaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadRequest:(NSString *)url
{
    [self.mediaView.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)createView
{
    self.mediaView = [[MediaView alloc] init];
    // Add mediaView to view
    [self.view addSubview:self.mediaView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
