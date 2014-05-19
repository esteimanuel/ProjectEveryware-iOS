//
//  Account.m
//  Glassy
//
//  Created by Niek Willems on 01/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "Account.h"

@implementation Account

- (id)initWithDictionary:(NSMutableDictionary *)fields
{
    self = [super self];
    if (self) {
        self.email = [fields objectForKey:@"email"];
        self.accountLevel = [fields objectForKey:@"accountlevel_id"];
        self.image = [fields objectForKey:@"foto_link"];
        
        self.deposit_paid = [fields objectForKey:@"borg_betaald"];
        self.houseNumber = [fields objectForKey:@"huisnummer"];
        self.houseNumberAdd = [fields objectForKey:@"huisnummer_toevoeging"];
        self.firstName = [fields objectForKey:@"voornaam"];
        self.lastName = [fields objectForKey:@"achternaam"];
        self.infix = [fields objectForKey:@"tussenvoegsel"];
        self.phoneNumber = [fields objectForKey:@"telefoonnummer"];
        self.dateOfBirth = [fields objectForKey:@"geboortedatum"];
        self.sharedInfo = [fields objectForKey:@"shared_info"];
        self.postcodeId = [fields objectForKey:@"postcode_id"];
        self.actionId = [fields objectForKey:@"actie_id"];
        self.packetId = [fields objectForKey:@"pakket_id"];
    }
    return self;
}

@end
