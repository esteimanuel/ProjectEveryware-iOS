//
//  RegisterView.h
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView

@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UILabel *orLabel;
@property (nonatomic, strong) UIButton *facebookAuthenticationButton;
@property (nonatomic, strong) UISwitch *rememberMeSwitch;
@property (nonatomic, strong) UIButton *authenticationButton;

//- (void)drawView;

@end
