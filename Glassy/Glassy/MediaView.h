//
//  MediaView.h
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *mediaview;
@property (nonatomic, strong) UIWebView* webview;

@end
