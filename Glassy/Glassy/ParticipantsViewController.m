//
//  ParticipantsViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsViewController.h"
#import "Account.h"

@interface ParticipantsViewController ()

@property (nonatomic, strong) RESTClient *restGetParticipants;
@property NSMutableArray *participants;

@end

@implementation ParticipantsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)createView
{
	self.participantsView = [[ParticipantsView alloc] init];
	[self getParticipants];
}

- (void)getParticipants
{
	// retrieve participants asynchronously
	//self.participants = [[NSArray alloc]initWithObjects:@"Chapter 1",@"Chapter 2",@"Chapter 3",@"Chapter 4",@"Chapter 5",nil];
	
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/actie/users?id=%d",1];
	
	// Create REST client and send get request
	self.restGetParticipants = [[RESTClient alloc] init];
	self.restGetParticipants.delegate = self;
	[self.restGetParticipants GET:url withParameters:nil];
}

- (void)setParticipantsNumber:(int)number
{
	[self.participantsView setParticipantsNumber:number];
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
	if (client == self.restGetParticipants) {
		for (id key in responseDictionary) {
			NSMutableDictionary *participantsDictionary = (NSMutableDictionary *)key;
			
			Account *account = [[Account alloc]initWithDictionary:participantsDictionary];
			[self.participants addObject:account];
			
		}
		
		// Add participants to view
		[self.participantsView addParticipants:self.participants];
	}
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
