//
//  ProfileViewController.h
//  Glassy
//
//  Created by Niek Willems on 11/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"

@interface ProfileViewController : UIViewController <UITextFieldDelegate, RestClientDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UITextField *firstNameTextField;
@property (nonatomic, strong) UITextField *lastNameTextField;
@property (nonatomic, strong) UITextField *postcodeTextField;
@property (nonatomic, strong) UITextField *houseNumberTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@end
