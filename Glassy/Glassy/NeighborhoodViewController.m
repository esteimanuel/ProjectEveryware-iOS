//
//  NeighborhoodViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NeighborhoodViewController.h"
#import "PagingViewController.h"
#import "Account.h"

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
    //self.neighborhoodView.neighborhoodTitleLabel.text = @"tetten";
	float numberOfParticipants = action.participants;
    self.neighborhoodView.participantsNumberLabel.text = [[NSNumber numberWithFloat:numberOfParticipants] stringValue];
	[self.neighborhoodView setParticipantsLabelPosition:numberOfParticipants];
    self.neighborhoodView.percentageLabel.text = [NSString stringWithFormat:@"%@%s", [[NSNumber numberWithFloat:action.targetPartPerc] stringValue], "%"];
}

- (void)setNeighborhoodInfo:(Neighborhood *)neighborhood
{
    if ([self.parentViewController.parentViewController isKindOfClass:[PagingViewController class]] && [self.parentViewController isKindOfClass:[MainViewController class]]) {
        PagingViewController* parent = (PagingViewController*)self.parentViewController.parentViewController;
        MainViewController* parentMainView = (MainViewController*)self.parentViewController;
                
        self.neighborhoodView.neighborhoodTitleLabel.text = (parent.account.actionId == parentMainView.action.id) ? @"Mijn wijk" : neighborhood.name;
    }
    
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
            if (parent.account.actionId != (NSString *)[NSNull null]) {
                NSString *paid = parent.account.deposit_paid;
                if (paid != (NSString *)[NSNull null] && [paid boolValue]) {
                    if (parent.account.providerId != (NSString *)[NSNull null]) {
                        [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                        [self.neighborhoodView.actionButton setTitle:@"Alle stappen voltooid" forState:UIControlStateNormal];
                        [self.neighborhoodView.actionButton setEnabled:NO];
                    } else {
                        [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                        [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonProvider:) forControlEvents:UIControlEventTouchDown];
                        [self.neighborhoodView.actionButton setTitle:@"Provider Kiezen" forState:UIControlStateNormal];
                    }
                } else {
                    [self.neighborhoodView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                    [self.neighborhoodView.actionButton addTarget:self action:@selector(actionButtonDeposit:) forControlEvents:UIControlEventTouchDown];
                    [self.neighborhoodView.actionButton setTitle:@"Inschrijven" forState:UIControlStateNormal];
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
