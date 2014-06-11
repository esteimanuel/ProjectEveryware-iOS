//
//  RegisterView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    CGFloat margin = 15;
    CGFloat currentHeight = margin + 15;
    
    //    self.facebookAuthenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    //    self.facebookAuthenticationButton.backgroundColor = [UIColor lightGrayColor];
    //    self.facebookAuthenticationButton.layer.cornerRadius = 5.0;
    //    self.facebookAuthenticationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    //    [self.facebookAuthenticationButton setTitle:@"Aanmelden via Facebook" forState:UIControlStateNormal];
    //    [self.facebookAuthenticationButton setHidden:YES];
    //
    //    currentHeight = currentHeight + self.facebookAuthenticationButton.frame.size.height + margin;
    
    //    self.orLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, currentHeight, 30, 30)];
    //    self.orLabel.text = @"of";
    //    self.orLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    //    self.orLabel.font = [UIFont italicSystemFontOfSize:11];
    //    self.orLabel.textColor = [UIColor lightGrayColor];
    //    [self.orLabel setHidden:YES];
    //
    //    currentHeight = currentHeight + self.orLabel.frame.size.height + margin;
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.emailTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.emailTextField.layer.borderWidth = 0.5;
    self.emailTextField.layer.cornerRadius = 5.0;
    self.emailTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.emailTextField.placeholder = @"E-mailadres";
    
    currentHeight = currentHeight + self.emailTextField.frame.size.height + margin;
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.passwordTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.passwordTextField.placeholder = @"Wachtwoord";
    self.passwordTextField.secureTextEntry = YES;
    
    currentHeight = currentHeight + self.passwordTextField.frame.size.height + margin;
    
    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 100), self.frame.size.width, 100)];
    registerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    
    //    self.rememberMeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(50, 20, 15, 10)];
    //    self.rememberMeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    //    [self.rememberMeSwitch setHidden:YES];
    //    UILabel *rememberMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 25, 150, 20)];
    //    rememberMeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    //    rememberMeLabel.font = [UIFont boldSystemFontOfSize:13];
    //    rememberMeLabel.text = @"Onthoud mijn gegevens";
    //    rememberMeLabel.textColor = [UIColor darkGrayColor];
    //    [rememberMeLabel setHidden:YES];
    
    self.authenticationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, (registerView.frame.size.height - 70.0), 210, 40)];
    self.authenticationButton.backgroundColor = [UIColor lightGrayColor];
    self.authenticationButton.layer.cornerRadius = 5.0;
    self.authenticationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [self.authenticationButton setTitle:@"Registreren" forState:UIControlStateNormal];
    
    //[registerView addSubview:self.rememberMeSwitch];
    //[registerView addSubview:rememberMeLabel];
    [registerView addSubview:self.authenticationButton];
    
    //[self addSubview:self.facebookAuthenticationButton];
    //[self addSubview:self.orLabel];
    [self addSubview:self.emailTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:registerView];
    // Set background color
    self.backgroundColor = [UIColor whiteColor];
}


@end
