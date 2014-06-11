//
//  CharityDetailViewController.h
//  Glassy
//
//  Created by Niek Willems on 08/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charity.h"

@interface CharityDetailViewController : UIViewController

- (id)initWithCharity:(Charity *)charity;

@property (nonatomic, strong) Charity *charity;

@end
