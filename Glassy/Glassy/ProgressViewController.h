//
//  ProgressViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
#import "MainViewController.h"

@interface ProgressViewController : UIViewController

@property (nonatomic, strong) ProgressView *progressView;

- (void)createView;

- (void)setProgressData:(Action *)action;

@end
