//
//  Action.h
//  Glassy
//
//  Created by Niek Willems on 01/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *deposit;
@property (nonatomic, strong) NSString *instigatorId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date_start;
@property (nonatomic, strong) NSString *date_end;
@property (nonatomic, strong) NSString *neighborhoodId;
@property (nonatomic, strong) NSString *statusId;

@property (nonatomic) CGFloat participants;
@property (nonatomic) CGFloat houses;
@property (nonatomic) CGFloat target;
@property (nonatomic) CGFloat totalPartPerc;
@property (nonatomic) CGFloat targetPartPerc;
@property (nonatomic) CGFloat paidTargetPerc;
@property (nonatomic) CGFloat providerSelecPerc;

@end
