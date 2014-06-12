//
//  ParticipantsDetailViewController.m
//  Glassy
//
//  Created by Este Tigele on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsDetailViewController.h"

@interface ParticipantsDetailViewController ()

@end

@implementation ParticipantsDetailViewController

- (id)initWithAccount:(Account *)account
{
    self = [super init];
    if (self) {
        self.account = account;
        [self createView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)createView
{
    // Create frame
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 85);
	self.participantsDetailView = [[ParticipantsDetailView alloc] init];
    [self.view addSubview:self.participantsDetailView];
    
    self.participantsDetailView.buddyEmailLabel.text = self.account.email;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
