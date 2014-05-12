//
//  NavigationBarView.h
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarView : UIView

@property (nonatomic, strong) UIView *navigationBarView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *profileNameLabel;
@property (nonatomic, strong) UIButton *navigationDropDownButton;
@property (nonatomic, strong) UIButton *navigationSearchButton;

//- (void)drawView;

@end
