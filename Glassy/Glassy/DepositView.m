//
//  DepositView.m
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "DepositView.h"

@implementation DepositView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    CGFloat margin = 15;
    CGFloat currentHeight = margin;
    
    self.depositAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.depositAmountLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.depositAmountLabel.font = [UIFont boldSystemFontOfSize:13];
    self.depositAmountLabel.text = @"Borg totaal: 10,00 euro";
    self.depositAmountLabel.textColor = [UIColor darkGrayColor];
    
    currentHeight = currentHeight + self.depositAmountLabel.frame.size.height + margin;
    
    self.depositPayButton = [[UIButton alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.depositPayButton.backgroundColor = [UIColor lightGrayColor];
    self.depositPayButton.layer.cornerRadius = 5.0;
    self.depositPayButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [self.depositPayButton setTitle:@"Betalen" forState:UIControlStateNormal];
    
    [self addSubview:self.depositAmountLabel];
    [self addSubview:self.depositPayButton];
    // Set background color
    self.backgroundColor = [UIColor whiteColor];
}

@end
