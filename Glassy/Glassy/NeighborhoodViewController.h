//
//  NeighborhoodViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"
#import "NeighborhoodView.h"

@interface NeighborhoodViewController : UIViewController

@property (nonatomic, strong) NeighborhoodView *neighborhoodView;

- (void)setNeighborhoodFields:(Action *)action;

- (void)createView;

@end
