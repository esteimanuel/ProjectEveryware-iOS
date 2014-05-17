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
    NSInteger progressbarSize = 300;
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    NSInteger mediaviewHeight = margin;
    CGFloat frameWidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.backgroundColor = [UIColor clearColor];
    
    // Set title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    self.titleLabel.text = @"Stappen";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
    
    self.mediaview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 170 + margin * 4)];
    self.mediaview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaview.layer.borderWidth = 1.0;
    [self addSubview:self.mediaview];
    
    currentHeight += self.mediaview.frame.size.height + margin * 4;
    
    // Create frame
    self.frame = CGRectMake(0, 0, self.frame.size.width, currentHeight);

    // Set verzamelen
    self.verzamelenLbl = [[UILabel alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, frameWidth, 24.0f)];
    self.verzamelenLbl.text = @"1. Bewoners verzamelen";
    self.verzamelenLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];

    self.verzamelenLbl.textColor = [UIColor whiteColor];
    [self.mediaview addSubview:self.verzamelenLbl];
    
    mediaviewHeight += self.verzamelenLbl.frame.size.height + margin;
    currentHeight += self.verzamelenLbl.frame.size.height + margin;
    
    self.inschrijvenProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, progressbarSize, 24.0f)];
    self.inschrijvenProgress.progress = 0.95f;
    [self.mediaview addSubview:self.inschrijvenProgress];

    mediaviewHeight += self.verzamelenProgress.frame.size.height + margin;
    currentHeight += self.verzamelenProgress.frame.size.height + margin;
    
    // Set inschrijven
    self.inschrijvenLbl = [[UILabel alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, frameWidth, 24.0f)];
    self.inschrijvenLbl.text = @"2. Inschrijven";
    self.inschrijvenLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    self.inschrijvenLbl.textColor = [UIColor whiteColor];
    [self.mediaview addSubview:self.inschrijvenLbl];
    
    mediaviewHeight += self.inschrijvenLbl.frame.size.height + margin;
    currentHeight += self.inschrijvenLbl.frame.size.height + margin;
    
    self.inschrijvenProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, progressbarSize, 24.0f)];
    self.inschrijvenProgress.progress = 0.75f;
    [self.mediaview addSubview:self.inschrijvenProgress];
    
    mediaviewHeight += self.inschrijvenProgress.frame.size.height + margin;
    currentHeight += self.inschrijvenProgress.frame.size.height + margin;
    
    // Set provider kiezen
    self.providerLbl = [[UILabel alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, frameWidth, 24.0f)];
    self.providerLbl.text = @"3. Provider kiezen";
    self.providerLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    self.providerLbl.textColor = [UIColor whiteColor];
    [self.mediaview addSubview:self.providerLbl];
    
    mediaviewHeight += self.providerLbl.frame.size.height + margin;
    currentHeight += self.providerLbl.frame.size.height + margin;
    
    self.providerProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, progressbarSize, 24.0f)];
    self.providerProgress.progress = 0.65f;
    [self.mediaview addSubview:self.providerProgress];
    
    mediaviewHeight += self.providerProgress.frame.size.height + margin;
    currentHeight += self.providerProgress.frame.size.height + margin;
    
    // Set aanleg
    self.aanlegLbl = [[UILabel alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, frameWidth, 24.0f)];
    self.aanlegLbl.text = @"4. Glasvezel aanleggen";
    self.aanlegLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    self.aanlegLbl.textColor = [UIColor whiteColor];
    [self.mediaview addSubview:self.aanlegLbl];
    
    mediaviewHeight += self.aanlegLbl.frame.size.height + margin;
    currentHeight += self.aanlegLbl.frame.size.height + margin;
    
    self.aanlegProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, progressbarSize, 24.0f)];
    self.aanlegProgress.progress = 0.25f;
    [self.mediaview addSubview:self.aanlegProgress];
    
    mediaviewHeight += self.aanlegProgress.frame.size.height + margin;
    currentHeight += self.aanlegProgress.frame.size.height + margin;
    
    // Set overtappen
    self.overstappenLbl = [[UILabel alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, frameWidth, 24.0f)];
    self.overstappenLbl.text = @"5. Overstappen naar glasvezel";
    self.overstappenLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    self.overstappenLbl.textColor = [UIColor whiteColor];
    [self.mediaview addSubview:self.overstappenLbl];
    
    mediaviewHeight += self.overstappenLbl.frame.size.height + margin;
    currentHeight += self.overstappenLbl.frame.size.height + margin;
    
    self.overstappenProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(margin, mediaviewHeight, progressbarSize, 24.0f)];
    self.overstappenProgress.progress = 0.2f;
    [self.mediaview addSubview:self.overstappenProgress];
    
    mediaviewHeight += self.overstappenProgress.frame.size.height + margin;
    currentHeight += self.overstappenProgress.frame.size.height + margin;

}

@end
