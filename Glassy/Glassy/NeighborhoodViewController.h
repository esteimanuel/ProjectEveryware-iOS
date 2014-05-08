//
//  NeighborhoodViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"

@interface NeighborhoodViewController : UIViewController

- (void)setNeighborhoodFields:(Action *)action;

@property (nonatomic, strong) UILabel *neighborhoodTitleLabel;
@property (nonatomic, strong) UILabel *participantsNumberLabel;
@property (nonatomic, strong) UILabel *participantsLabel;
@property (nonatomic, strong) UILabel *percentageLabel;

@property (nonatomic, strong) UIButton *actionButton;

@end
