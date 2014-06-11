//
//  FaqView.h
//  Glassy
//
//  Created by Este Tigele on 18/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaqView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel *firstQuestionLabel;
@property (nonatomic, strong) UILabel *secondQuestionLabel;
@property (nonatomic, strong) UILabel *thirdQuestionLabel;

@end
