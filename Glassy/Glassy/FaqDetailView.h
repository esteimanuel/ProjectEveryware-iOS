//
//  FaqDetailView.h
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaqDetailView : UIView

@property (nonatomic, strong) UILabel *faqLabel;
@property (nonatomic, strong) UIScrollView *mediaView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;

- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer;

@property (nonatomic, strong) NSMutableArray *questionsArray;
@property (nonatomic, strong) NSMutableArray *answersArray;
- (void)drawView;

@end
