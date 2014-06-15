//
//  ParticipantsDetailViewController.m
//  Glassy
//
//  Created by Este Tigele on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsDetailViewController.h"
#import "MainViewController.h"

@interface ParticipantsDetailViewController ()

@end

@implementation ParticipantsDetailViewController

- (id)initWithAccount:(Account *)account
{
    self = [super init];
    if (self) {
        self.account = account;
        [self createView];
        [self createGesture];
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
    [self.view addSubview:self.participantsDetailView];
    
    if (self.account.buddy.email != (NSString*)[NSNull null]) self.participantsDetailView.buddyEmailLabel.text = self.account.buddy.email;
    if (self.account.firstName != (NSString*)[NSNull null]) [self setProfileName];
    if (self.account.buddy.telefoonnummer != (NSString*)[NSNull null]) self.participantsDetailView.buddyPhoneLabel.text = [NSString stringWithFormat:@"%@", self.account.buddy.telefoonnummer];
    [self setProfileImage:self.account.image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfileImage:(NSString *)url
{
    if (url != (NSString *)[NSNull null]) {
        NSURL *imageUrl = [NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        self.participantsDetailView.buddyProfileImage.image = [UIImage imageWithData:imageData];
    } else {
        self.participantsDetailView.buddyProfileImage.image = [UIImage imageNamed:@"ios-nav-default-profile-image.png"];
    }
}

- (void)setProfileName
{
    if (self.account.infix != (NSString *)[NSNull null]) {
        self.participantsDetailView.buddyNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.account.firstName, self.account.infix, self.account.lastName];
    } else {
        self.participantsDetailView.buddyNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.account.firstName, self.account.lastName];
    }
}

#pragma mark - UISwipeGestureRecognizer delegate methods

- (void)createGesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UITapGestureRecognizer *)recognizer
{
    [self dispose];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeParticipantDetailView];
    }
}

@end
