//
//  NeighborhoodView.h
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeighborhoodView : UIView

@property (nonatomic, strong) UILabel *neighborhoodTitleLabel;
@property (nonatomic, strong) UILabel *participantsNumberLabel;
@property (nonatomic, strong) UILabel *participantsLabel;
@property (nonatomic, strong) UILabel *percentageLabel;
@property (nonatomic, strong) UIButton *actionButton;

//- (void)drawView;
- (void)setParticipantsLabelPosition:(float)numberOfParticipants;

@end
