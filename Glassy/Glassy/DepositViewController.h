//
//  DepositViewController.h
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DepositView.h"

@interface DepositViewController : UIViewController

@property (nonatomic, strong) DepositView *depositView;

- (void)createView;

@end
