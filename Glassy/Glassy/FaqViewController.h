//
//  FaqViewController.h
//  Glassy
//
//  Created by Este Tigele on 18/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaqView.h"
#import "RESTClient.h"

@interface FaqViewController : UIViewController <RestClientDelegate>

@property (nonatomic, strong) FaqView *faqView;
@property (nonatomic, strong) NSMutableArray *questionsArray;
@property (nonatomic, strong) NSMutableArray *answersArray;

- (void)createView;

- (void)getFaq;

@end
