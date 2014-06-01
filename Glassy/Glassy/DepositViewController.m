//
//  DepositViewController.m
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "DepositViewController.h"

@interface DepositViewController ()

@end

@implementation DepositViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, 140);
    self.depositView = [[DepositView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140)];
    // Set button targets
    [self.depositView.depositPayButton addTarget:self action:@selector(payButtonPressed:) forControlEvents:UIControlEventTouchDown];
    // Add providerView to view
    [self.view addSubview:self.depositView];
}

#pragma mark - Button handlers

- (void)payButtonPressed:(id)sender
{
    
}

@end
