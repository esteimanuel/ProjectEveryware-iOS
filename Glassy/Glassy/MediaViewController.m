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
	// Do any additional setup after loading the view.
    //[self createPlaceholder];
    //[self createMediaGui];
}

- (void)loadRequest:(NSString *)url
{
    [self.mediaView.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)createView
{
    self.mediaView = [[MediaView alloc] init];
    // Load request
    [self loadRequest:@"http://www.youtube.com/embed/vIu85WQTPRc"];
}

-(void)createPlaceholder
{
    UIImage *background = [UIImage imageNamed:@"ios-media.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    
    [self.view addSubview:imageView];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, background.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
