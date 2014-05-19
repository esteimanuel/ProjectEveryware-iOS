//
//  ProfileView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProfileView.h"

@implementation ProfileView

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
    CGFloat currentHeight = margin;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, currentHeight, 100, 100)];
    self.profileImageView.layer.cornerRadius = 5.0;
    
    currentHeight = currentHeight + self.profileImageView.frame.size.height + margin;
    
    self.firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.firstNameTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.firstNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.firstNameTextField.layer.borderWidth = 0.5;
    self.firstNameTextField.layer.cornerRadius = 5.0;
    self.firstNameTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.firstNameTextField.placeholder = @"Voornaam";
 
    currentHeight = currentHeight + self.firstNameTextField.frame.size.height + margin;
    
    self.lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.lastNameTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.lastNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lastNameTextField.layer.borderWidth = 0.5;
    self.lastNameTextField.layer.cornerRadius = 5.0;
    self.lastNameTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.lastNameTextField.placeholder = @"Achternaam";
    
    currentHeight = currentHeight + self.lastNameTextField.frame.size.height + margin;
    
    self.postcodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 130, 40)];
    self.postcodeTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.postcodeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.postcodeTextField.layer.borderWidth = 0.5;
    self.postcodeTextField.layer.cornerRadius = 5.0;
    self.postcodeTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.postcodeTextField.placeholder = @"Postcode";
    
    self.houseNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(55 + self.postcodeTextField.frame.size.width + 10, currentHeight, 70, 40)];
    self.houseNumberTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.houseNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.houseNumberTextField.layer.borderWidth = 0.5;
    self.houseNumberTextField.layer.cornerRadius = 5.0;
    self.houseNumberTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.houseNumberTextField.placeholder = @"Huisnr.";

    currentHeight = currentHeight + self.postcodeTextField.frame.size.height + margin;
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.emailTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.emailTextField.layer.borderWidth = 0.5;
    self.emailTextField.layer.cornerRadius = 5.0;
    self.emailTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.emailTextField.placeholder = @"E-mail";

    self.emailTextField.secureTextEntry = YES;
    
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
    
    self.buddySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(50, currentHeight - 5, 15, 10)];
    self.buddySwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.buddySwitch.on = YES;
    self.buddyLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, currentHeight, 150, 20)];
    self.buddyLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyLabel.font = [UIFont boldSystemFontOfSize:13];
    self.buddyLabel.text = @"Ik ben een buddy";
    self.buddyLabel.textColor = [UIColor darkGrayColor];
    
    currentHeight = currentHeight + self.buddyLabel.frame.size.height + margin;
    
    currentHeight = [self drawBuddyView:currentHeight withMargin:margin];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.saveButton.backgroundColor = [UIColor lightGrayColor];
    self.saveButton.layer.cornerRadius = 5.0;
    self.saveButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [self.saveButton setTitle:@"Opslaan" forState:UIControlStateNormal];
    
    currentHeight = currentHeight + self.saveButton.frame.size.height + margin;
    
    // Set frame size
    self.frame = CGRectMake(0, 85, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    // Create scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    // Add all views to scrollview
    [self.scrollView addSubview:self.profileImageView];
    [self.scrollView addSubview:self.firstNameTextField];
    [self.scrollView addSubview:self.lastNameTextField];
    [self.scrollView addSubview:self.postcodeTextField];
    [self.scrollView addSubview:self.houseNumberTextField];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.passwordTextField];
    [self.scrollView addSubview:self.saveButton];
    
    [self.scrollView addSubview:self.buddySwitch];
    [self.scrollView addSubview:self.buddyLabel];
    [self.scrollView addSubview:self.buddyDetailsView];
    // Set content size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 880);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    // Add scrollview to view
    [self addSubview:self.scrollView];
}

- (int)drawBuddyView:(int)currentHeight withMargin:(int)margin
{
    int buttonHeight = 40;
    
    self.buddyDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, self.frame.size.width, buttonHeight * 2 + margin)];
    
    self.buddyPhone = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, 210, 40)];
    self.buddyPhone.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.buddyPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buddyPhone.layer.borderWidth = 0.5;
    self.buddyPhone.layer.cornerRadius = 5.0;
    self.buddyPhone.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyPhone.placeholder = @"Alternatief telefoonnummer";
    
    self.buddyEmail = [[UITextField alloc] initWithFrame:CGRectMake(55, self.buddyPhone.frame.size.height + margin, 210, 40)];
    self.buddyEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.buddyEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buddyEmail.layer.borderWidth = 0.5;
    self.buddyEmail.layer.cornerRadius = 5.0;
    self.buddyEmail.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyEmail.placeholder = @"Alternatief e-mailadres";
    
    [self.buddyDetailsView addSubview:self.buddyPhone];
    [self.buddyDetailsView addSubview:self.buddyEmail];
    
    currentHeight = currentHeight + self.buddyDetailsView.frame.size.height + margin;
    return currentHeight;
}

@end