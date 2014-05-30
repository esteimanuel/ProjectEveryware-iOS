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
}

- (void)setParticipantsData:(int)actionId
{
	// retrieve participants asynchronously
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/actie/users?id=%d",actionId];
	
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
	NSMutableArray *participantsArray = [[NSMutableArray alloc]init];
	for (id key in responseDictionary) {
		NSDictionary *participantsDictionary = (NSDictionary *)key;
		Account *account = [[Account alloc]init];
		account.accountId = [[participantsDictionary objectForKey:@"gebruiker_id"] intValue];
		NSLog(@"account_id: %d",account.accountId);
		account.email = [participantsDictionary objectForKey:@"email"];
		NSLog(@"account_email: %@",account.email);
		account.buddy = [participantsDictionary objectForKey:@"buddy"] != nil ? 1 : 0;
		NSLog(@"account_isBuddy: %d",account.buddy);
		NSDictionary *accountData = [key valueForKey:@"account"];
		NSString *foto_link = [accountData valueForKey:@"foto_link"];
		if ([foto_link isKindOfClass:[NSString class]]) {
			account.image = foto_link;
			NSLog(@"account_image: %@",foto_link);
		}
		
		[participantsArray addObject:account];
	}
	
	// Add participants to view
	[self.participantsView addParticipants:participantsArray];
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
