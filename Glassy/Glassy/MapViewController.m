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
    //[self createMapGui];
}

- (void)loadRequest:(NSString *)url
{
    [self.mapView.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)createView
{
    self.mapView = [[MapView alloc] init];
    // Load request
    [self loadRequest:@"http://glassy-web.avans-project.nl/?wijk=2"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
