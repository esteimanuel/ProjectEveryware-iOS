//
//  ProgressViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
#import "RESTClient.h"

@interface ProgressViewController : UIViewController <RestClientDelegate>

@property (nonatomic, strong) ProgressView *progressView;

- (void)createView;

- (void)getProgress:(int)actionId;

@end
