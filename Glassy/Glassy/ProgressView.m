//
//  ProgressView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

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
    
    /* --------------- TEMP */
    UIImage *background = [UIImage imageNamed:@"ios-progress.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    
    [self addSubview:imageView];
    //[self createGui];
    self.frame = CGRectMake(0, 0, self.frame.size.width, background.size.height);
   
    /*
    CGFloat margin = 5.0;
    CGFloat stepHeight = 26.0;
    NSInteger currentHeight = 0;
    NSArray *steps = @[@"1. Bewoners verzamelen 22%", @"2. Inschrijven 9%", @"3. Provider selecteren 2%", @"4. Glasvezel aandeel 0%", @"5. Glasvezel aanleggen 0%", @"6. Overstappen naar glasvezel 0%"];
    
    // Initialize container
    UIView *container = [[UIView alloc]init];
    
    // Create Steps
    for (int i = 0; i < steps.count; i++) {
        UILabel *step = [[UILabel alloc]initWithFrame:CGRectMake(margin, currentHeight, self.frame.size.width - margin * 2, stepHeight)];
        step.text = steps[i];
        step.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:stepHeight];
        currentHeight += stepHeight;
        UIProgressView *progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressBar.progress = (float)10.0f;
        [container addSubview:step];
        [container addSubview:progressBar];
    }
    
    // Create container
    container.frame = CGRectMake(margin, stepHeight, self.frame.size.width - 2 * margin, currentHeight);
    container.layer.borderColor = [[UIColor whiteColor]CGColor];
    container.layer.borderWidth = 1.0f;
    
    [self addSubview: container];
    
    // Create title label
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, stepHeight)];
    
    // Create frame
    self.frame = CGRectMake(0, 0, self.frame.size.width, currentHeight + stepHeight);
    
    // Add title label to frame
    [self addSubview:title];
    
    // Add container to frame
    [self addSubview:container];
     */
}

@end
