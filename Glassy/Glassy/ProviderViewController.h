//
//  ProviderViewController.h
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProviderView.h"
#import "RESTClient.h"
#import "Provider.h"

@interface ProviderViewController : UIViewController <RestClientDelegate>

@property (nonatomic, strong) ProviderView *providerView;

@property (nonatomic, strong) NSMutableArray *providerArray;

- (void)createView;
- (void)getProviderData;

@end
