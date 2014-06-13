//
//  ProgressDetailView.h
//  Glassy
//
//  Created by Este Tigele on 13/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressDetailView : UIView

// Layout
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UILabel *textview;

// Content
@property (nonatomic, strong) UILabel* verzamelenLabel;
@property (nonatomic, strong) UIProgressView* verzamelenProgress;

@property (nonatomic, strong) UILabel* inschrijvenLabel;
@property (nonatomic, strong) UIProgressView* inschrijvenProgress;

@property (nonatomic, strong) UILabel* providerLabel;
@property (nonatomic, strong) UIProgressView* providerProgress;

@property (nonatomic, strong) UILabel* aanlegLabel;
@property (nonatomic, strong) UIProgressView* aanlegProgress;

@property (nonatomic, strong) UILabel* overstappenLabel;
@property (nonatomic, strong) UIProgressView* overstappenProgress;

@end
