//
//  NullCheck.m
//  Glassy
//
//  Created by Niek Willems on 13/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NullCheck.h"

@implementation NullCheck

+ (BOOL)isNotNilOrEmpty:(NSString *)string
{
    if (string != nil) {
        if (![string isKindOfClass:[NSNull class]]) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

@end
