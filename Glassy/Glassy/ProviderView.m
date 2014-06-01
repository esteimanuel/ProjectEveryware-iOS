//
//  ProviderView.m
//  Glassy
//
//  Created by Niek Willems on 01/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProviderView.h"
#import "Provider.h"

@implementation ProviderView

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
    
    self.providerPickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.providerPickerLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.providerPickerLabel.font = [UIFont boldSystemFontOfSize:13];
    self.providerPickerLabel.text = @"Provider selecteren:";
    self.providerPickerLabel.textColor = [UIColor darkGrayColor];
    
    currentHeight = currentHeight + self.providerPickerLabel.frame.size.height + margin;
    
    self.providerPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.providerPickerView.delegate = self;
    self.providerPickerView.dataSource = self;
    self.providerPickerView.showsSelectionIndicator = YES;

    currentHeight = currentHeight + self.providerPickerView.frame.size.height + margin;
    
    self.providerSaveButton = [[UIButton alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.providerSaveButton.backgroundColor = [UIColor lightGrayColor];
    self.providerSaveButton.layer.cornerRadius = 5.0;
    self.providerSaveButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [self.providerSaveButton setTitle:@"Opslaan" forState:UIControlStateNormal];
    
    [self addSubview:self.providerPickerLabel];
    [self addSubview:self.providerPickerView];
    [self addSubview:self.providerSaveButton];
    // Set background color
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UIPickerView delegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [self.providerArray count];
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Provider *provider = [self.providerArray objectAtIndex:row];

    return provider.name;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

@end
