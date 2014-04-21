//
//  MainViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenuViewController.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) DropDownMenuViewController *dropDownMenuViewController;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIView *navigationBarView;

@end
