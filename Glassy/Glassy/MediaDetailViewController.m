//
//  MediaDetailViewController.m
//  Glassy
//
//  Created by Este Tigele on 14/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MediaDetailViewController.h"
#import "MainViewController.h"

@interface MediaDetailViewController ()

@end

@implementation MediaDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
	[self createGesture];
}

- (void)createView
{
    [self.view addSubview:[[MediaDetailView alloc] init]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISwipeGestureRecognizer delegate methods

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UITapGestureRecognizer *)recognizer
{
    [self dispose];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeCharityDetailView];
    }
}

@end
