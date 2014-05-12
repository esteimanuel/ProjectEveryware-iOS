//
//  MapViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"

@interface MapViewController : UIViewController

@property (nonatomic, strong) MapView *mapView;

- (void)createView;

- (void)loadRequest:(NSString *)url;

@end
