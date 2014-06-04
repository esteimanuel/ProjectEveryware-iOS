//
//  ProfileViewController.h
//  Glassy
//
//  Created by Niek Willems on 11/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"
#import "ProfileView.h"

@interface ProfileViewController : UIViewController <UITextFieldDelegate, RestClientDelegate>

@property (nonatomic, strong) ProfileView *profileView;

- (void)createView;
- (void)getProfileData;

@end
