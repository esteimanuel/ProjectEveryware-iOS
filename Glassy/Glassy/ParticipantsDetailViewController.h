//
//  ParticipantsDetailViewController.h
//  Glassy
//
//  Created by Este Tigele on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipantsDetailView.h"
#import "Account.h"

@interface ParticipantsDetailViewController : UIViewController

@property (nonatomic, strong) ParticipantsDetailView *participantsDetailView;

@property (nonatomic, strong) Account *account;

- (void)createView;

@end
