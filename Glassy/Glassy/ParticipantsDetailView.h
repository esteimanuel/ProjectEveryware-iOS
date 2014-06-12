//
//  ParticipantsDetailView.h
//  Glassy
//
//  Created by Este Tigele on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParticipantsDetailView : UIView

@property (nonatomic, strong) UIScrollView *mediaView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *buddyNameLabel;
@property (nonatomic, strong) UILabel *buddyEmailLabel;
@property (nonatomic, strong) UILabel *buddyPhoneLabel;
@property (nonatomic, strong) UIImageView *buddyProfileImage;

@end
