//
//  AuthenticationViewController.h
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"
#import "LoginView.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, RestClientDelegate>

@property (nonatomic, strong) LoginView *loginView;

- (void)logout;
- (void)createView;

@end
