//
//  FaqViewController.h
//  Glassy
//
//  Created by Este Tigele on 18/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaqView.h"

@interface FaqViewController : UIViewController

@property (nonatomic, strong) FaqView *faqView;

- (void)createView;

@end
