//
//  ParticipantsViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsViewController.h"

@interface ParticipantsViewController ()

@end

@implementation ParticipantsViewController {
	NSArray *participants;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)createView
{
	self.participantsView = [[ParticipantsView alloc]init];
}

- (void)retrieveParticipants
{
	// retrieve participants asynchronously
	participants = [[NSArray alloc]initWithObjects:@"Chapter 1",@"Chapter 2",@"Chapter 3",@"Chapter 4",@"Chapter 5",nil];
	
	
	// Add participants to view
	[self.participantsView addParticipants:participants];
}

- (void)createPlaceholderParticipants
{
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
