//
//  ParticipantsView.h
//  Glassy
//
//  Created by Este Tigele on 15/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParticipantsView : UIView

- (void)addParticipants:(NSArray*)participants;
- (void)setParticipantsNumber:(int)number;
- (void)setParticipantsLabelPosition:(float)numberOfParticipantsForPos;
@property (nonatomic, strong) UILabel *participantsText;


@end
