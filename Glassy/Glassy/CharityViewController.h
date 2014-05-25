//
//  CharityViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharityView.h"
#import "RESTClient.h"
#import "Charity.h"

@interface CharityViewController : UIViewController <RestClientDelegate>

@property (nonatomic, strong) CharityView *charityView;

@property (nonatomic, strong) Charity *charity;

- (void)createView;

- (void)getCharityData:(int)actionId;

@end
