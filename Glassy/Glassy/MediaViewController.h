//
//  MediaViewController.h
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaView.h"

@interface MediaViewController : UIViewController

@property (nonatomic, strong) MediaView *mediaView;
@property (nonatomic, strong) UIWebView *webView;

- (void)loadRequest:(NSString *)url;

- (void)createView;

@end
