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
    [self createMapGui];
}

- (void)createMapGui
{
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = self.view.frame.size.width;
    
    // Set background to transparent
    self.view.backgroundColor = [UIColor clearColor];
    
    // Set title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    titleLabel.text = @"Buurt kaart";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    currentHeight += titleLabel.frame.size.height + margin;
    
    // Set map view
    UIView *mapview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 250)];
    mapview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75];
    mapview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    mapview.layer.borderWidth = 1.0;
    [self.view addSubview:mapview];
    
    // Add web view
    UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frameWidth - 2 * margin, 250)];
    webview.scalesPageToFit = YES;
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://glassy-web.avans-project.nl"]]];
    
    [mapview addSubview:webview];
    
    currentHeight += mapview.frame.size.height + margin * 4;
    
    // Create frame
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, currentHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
