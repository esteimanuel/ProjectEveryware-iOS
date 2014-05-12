//
//  RegisterViewController.h
//  Glassy
//
//  Created by Niek Willems on 29/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"
#import "RegisterView.h"

@interface RegisterViewController : UIViewController <UITextFieldDelegate, RestClientDelegate>

@property (nonatomic, strong) RegisterView *registerView;

- (void)createView;

@end
