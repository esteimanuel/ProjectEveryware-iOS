//
//  Charity.m
//  Glassy
//
//  Created by Niek Willems on 22/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "Charity.h"

@implementation Charity

- (id)initWithDictionary:(NSMutableDictionary *)fields
{
    self = [super self];
    if (self) {
        self.id = [fields objectForKey:@"id"];
        self.title = [fields objectForKey:@"title"];
        self.description = [fields objectForKey:@"description"];
        self.message = [fields objectForKey:@"message"];
        self.target = [fields objectForKey:@"target"];
    }
    return self;
}

@end
