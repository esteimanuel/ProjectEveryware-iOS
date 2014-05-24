//
//  NeighborhoodViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NeighborhoodViewController.h"
#import "MainViewController.h"

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
    [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchDown];
}

- (void)actionButtonClicked:(UIButton *)button
{
//    // Check if MainViewController is parent
//    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
//        // Cast parentViewController to MainViewController
//        MainViewController* parent = (MainViewController*)self.parentViewController;
//        [parent createLoginView];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
