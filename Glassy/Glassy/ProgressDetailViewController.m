//
//  ProgressDetailViewController.m
//  Glassy
//
//  Created by Este Tigele on 13/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProgressDetailViewController.h"
#import "MainViewController.h"

@interface ProgressDetailViewController ()

@end

@implementation ProgressDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createView];
	[self createGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
	self.progressDetailView = [[ProgressDetailView alloc] init];
	self.view = self.progressDetailView;
}

#pragma mark - UISwipeGestureRecognizer delegate methods

- (void)createGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    [self dispose];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeProgressDetailView];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
