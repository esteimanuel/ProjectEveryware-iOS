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
@property (nonatomic) NSInteger *id;

@end
