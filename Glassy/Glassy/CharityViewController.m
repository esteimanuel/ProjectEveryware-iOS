//
//  CharityViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityViewController.h"
#import "MainViewController.h"

@interface CharityViewController ()

@end

@implementation CharityViewController

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
    self.charityView = [[CharityView alloc] init];
    // Set view gestures
    [self createGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    gestureRecognizer.numberOfTouchesRequired = 1;
    [self.charityView addGestureRecognizer:gestureRecognizer];
}

- (void)panHandler:(UITapGestureRecognizer *)recognizer
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent createCharityDetailView];
    }
}


@end
