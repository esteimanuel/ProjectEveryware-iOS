//
//  CharityViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharityView.h"

@interface CharityViewController : UIViewController

@property (nonatomic, strong) CharityView *charityView;

- (void)createView;

@end
