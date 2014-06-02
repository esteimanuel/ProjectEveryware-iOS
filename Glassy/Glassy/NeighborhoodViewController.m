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
    self.neighborhoodView.neighborhoodTitleLabel.text = @"tetten";
	float numberOfParticipants = action.participants;
    self.neighborhoodView.participantsNumberLabel.text = [[NSNumber numberWithFloat:numberOfParticipants] stringValue];
	[self.neighborhoodView setParticipantsLabelPosition:numberOfParticipants];
    self.neighborhoodView.percentageLabel.text = [NSString stringWithFormat:@"%@%s", [[NSNumber numberWithFloat:action.targetPartPerc] stringValue], "%"];
}

- (void)setNeighborhoodInfo:(Neighborhood *)neighborhood
{
    self.neighborhoodView.neighborhoodTitleLabel.text = @"Bier";
}

- (void)createView;
{
    self.neighborhoodView = [[NeighborhoodView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height)];
    // Add neighborhoodView to view
    [self.view addSubview:self.neighborhoodView];
}

- (void)setActionButtonStage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // If token object is null, no user is logged on
    if ([defaults objectForKey:@"token"] != nil) {
        if ([self.parentViewController.parentViewController isKindOfClass:[PagingViewController class]]) {
            // Cast parentViewController to PaginViewController
            PagingViewController* parent = (PagingViewController*)self.parentViewController.parentViewController;
            if (parent.account.actionId != nil) {
                if ([parent.account.deposit_paid boolValue]) {
                    // TODO: if/else provider gekozen
                    [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                    [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonProvider:) forControlEvents:UIControlEventTouchDown];
                    [self.neighborhoodView.actionButton setTitle:@"Provider Kiezen" forState:UIControlStateNormal];
                } else {
                    [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                    [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonDeposit:) forControlEvents:UIControlEventTouchDown];
                    [self.neighborhoodView.actionButton setTitle:@"Borg betalen" forState:UIControlStateNormal];
                }
            } else {
                [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonJoin:) forControlEvents:UIControlEventTouchDown];
                [self.neighborhoodView.actionButton setTitle:@"Ik doe ook mee!" forState:UIControlStateNormal];
            }
        }
    } else {
        [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonJoin:) forControlEvents:UIControlEventTouchDown];
        [self.neighborhoodView.actionButton setTitle:@"Ik doe ook mee!" forState:UIControlStateNormal];
    }
}

- (void)actionButtonJoin:(UIButton *)button
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([self.parentViewController.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController.parentViewController;
        if ([defaults objectForKey:@"token"] == nil) {
            [parent createLoginView];
        } else {
            MainViewController* main = (MainViewController*)self.parentViewController;
            [main setActionId:[main.action.id intValue]];
        }
    }
}

- (void)actionButtonProvider:(UIButton *)button
{
    if ([self.parentViewController.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController.parentViewController;
        [parent createProviderView];
    }
}

- (void)actionButtonDeposit:(UIButton *)button
{
    if ([self.parentViewController.parentViewController isKindOfClass:[PagingViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController.parentViewController;
        [parent createDepositView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
