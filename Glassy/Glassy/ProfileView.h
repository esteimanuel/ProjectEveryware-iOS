//
//  ProfileView.h
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UITextField *firstNameTextField;
@property (nonatomic, strong) UITextField *lastNameTextField;
@property (nonatomic, strong) UITextField *postcodeTextField;
@property (nonatomic, strong) UITextField *houseNumberTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UISwitch *buddySwitch;
@property (nonatomic, strong) UILabel *buddyLabel;

@property (nonatomic, strong) UIView *buddyDetailsView;
@property (nonatomic, strong) UITextField *buddyEmail;
@property (nonatomic, strong) UITextField *buddyPhone;

@end
