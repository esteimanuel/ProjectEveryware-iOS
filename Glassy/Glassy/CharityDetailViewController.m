//
//  CharityDetailViewController.m
//  Glassy
//
//  Created by Niek Willems on 08/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityDetailViewController.h"
#import "MainViewController.h"

@interface CharityDetailViewController ()

@end

@implementation CharityDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCharity:(Charity *)charity
{
    self = [super init];
    if (self) {
        self.charity = charity;
        
        [self createView];
        [self createGesture];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
    self.charityDetailView = [[CharityDetailView alloc] init];
    [self.view addSubview:self.charityDetailView];
    
    self.charityDetailView.charityText.text = self.charity.message;
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
