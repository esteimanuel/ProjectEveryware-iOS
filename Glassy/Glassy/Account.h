//
//  Account.h
//  Glassy
//
//  Created by Niek Willems on 01/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *accountLevel;
@property (nonatomic, strong) NSString *image;
@property (nonatomic) int accountId;

@property (nonatomic) NSInteger *userId;
@property (nonatomic, strong) NSString *deposit_paid;
@property (nonatomic) NSInteger *houseNumber;
@property (nonatomic) NSInteger *houseNumberAdd;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *infix;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *sharedInfo;
@property (nonatomic) NSInteger *actionId;
@end
