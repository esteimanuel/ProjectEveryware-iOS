//
//  Charity.h
//  Glassy
//
//  Created by Niek Willems on 22/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Charity : NSObject

- (id)initWithDictionary:(NSMutableDictionary *)fields;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *target;

@end
