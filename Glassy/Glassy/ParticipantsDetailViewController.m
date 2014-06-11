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
	self.participantsDetailView = [[ParticipantsDetailView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
