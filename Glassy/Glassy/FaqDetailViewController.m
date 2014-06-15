//
//  FaqDetailViewController.m
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqDetailViewController.h"
#import "MainViewController.h"

@interface FaqDetailViewController ()

@end

@implementation FaqDetailViewController

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
    FaqDetailView *faq = [[FaqDetailView alloc] init];
	faq.answersArray = self.answersArray;
	faq.questionsArray = self.questionsArray;
    [faq addAllQuestions];
    [self.view addSubview:faq];
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
        [parent removeFaqDetailView];
    }
}



@end
