//
//  ProviderView.h
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UILabel *providerPickerLabel;
@property (nonatomic, strong) UIPickerView *providerPickerView;
@property (nonatomic, strong) UIButton *providerSaveButton;
@property (nonatomic, strong) NSArray *providerArray;
@property (nonatomic) int currentRow;

@end
