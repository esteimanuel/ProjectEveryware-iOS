//
//  NeighborhoodViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NeighborhoodViewController.h"
#import "PagingViewController.h"

@interface NeighborhoodViewController ()

@end

@implementation NeighborhoodViewController

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

- (void)setNeighborhoodData:(Action *)action
{
    self.neighborhoodView.neighborhoodTitleLabel.text = action.name;
    self.neighborhoodView.participantsNumberLabel.text = [[NSNumber numberWithFloat:action.participants] stringValue];
    self.neighborhoodView.percentageLabel.text = [NSString stringWithFormat:@"%@%s", [[NSNumber numberWithFloat:action.targetPartPerc] stringValue], "%"];
}

- (void)createView;
{
    self.neighborhoodView = [[NeighborhoodView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height)];
    // Set button targets
    //[self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchDown];
    // Set button invisible
    [self.neighborhoodView.actionButton setHidden:YES];
    // Add neighborhoodView to view
    [self.view addSubview:self.neighborhoodView];
}

- (void)setActionButtonStage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // If token object is null, no user is logged on
    if ([defaults objectForKey:@"token"] == nil) {
        //[self.neighborhoodView.actionButton removeTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonLogin:) forControlEvents:UIControlEventTouchDown];
        [self.neighborhoodView.actionButton setTitle:@"Ik doe ook mee!" forState:UIControlStateNormal];
    }
    [self.neighborhoodView.actionButton setHidden:NO];
}

- (void)actionButtonLogin:(UIButton *)button
{
    // Check if MainViewController is parent
    if ([self.parentViewController.parentViewController isKindOfClass:[PagingViewController class]]) {
        // Cast parentViewController to MainViewController
        PagingViewController* parent = (PagingViewController*)self.parentViewController.parentViewController;
        [parent createLoginView];
    }
}

- (void)actionButtonClicked:(UIButton *)button
{
    //    // Check if MainViewController is parent
    //    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
    //        // Cast parentViewController to MainViewController
    //        MainViewController* parent = (MainViewController*)self.parentViewController;
    //        [parent createLoginView];
    //    }
    NSLog(@"actionButtonClicked");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
