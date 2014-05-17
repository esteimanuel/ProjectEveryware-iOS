//
//  ParticipantsViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipantsView.h"

@interface ParticipantsViewController : UIViewController

@property (nonatomic, strong) ParticipantsView *participantsView;

- (void)createView;
@end
