//
//  FaqDetailViewController.h
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"
#import "FaqDetailView.h"

@interface FaqDetailViewController : UIViewController <RestClientDelegate>

//@property (nonatomic, strong) FaqDetailView *faqDetailView;

@property (nonatomic, strong) UILabel *faqLabel;
@property (nonatomic, strong) UIScrollView *mediaView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
