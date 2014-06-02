//
//  NeighborhoodViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"
#import "Neighborhood.h"
#import "NeighborhoodView.h"

@interface NeighborhoodViewController : UIViewController

@property (nonatomic, strong) NeighborhoodView *neighborhoodView;

- (void)setNeighborhoodData:(Action *)action;
- (void)setNeighborhoodInfo:(Neighborhood *)neighborhood;

- (void)createView;
- (void)setActionButtonStage;

@end
