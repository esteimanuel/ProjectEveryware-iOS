//
//  MediaViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MediaViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MediaViewController ()

@end

@implementation MediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self createPlaceholder];
    [self createMediaGui];
}

- (void)createMediaGui
{
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = self.view.frame.size.width;
    
    // Set background to transparent
    self.view.backgroundColor = [UIColor clearColor];
    
    // Set title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    titleLabel.text = @"Buurt video";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];

    currentHeight += titleLabel.frame.size.height + margin;
    
    // Set media view
    UIView *mediaview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, frameWidth * 0.6)];
    mediaview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75];
    mediaview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.75].CGColor;
    mediaview.layer.borderWidth = 1.0;
    [self.view addSubview:mediaview];
    
    // Add web view
    // TODO
    
    // Placeholder - Start
    UIImage *background = [UIImage imageNamed:@"ios-media.png"];
    UIImageView *placeholder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameWidth - margin * 2, frameWidth * 0.6)];
    placeholder.contentMode = UIViewContentModeScaleAspectFit;
    placeholder.image = background;
    [mediaview addSubview:placeholder];
    // Placeholder - End
    
    currentHeight += mediaview.frame.size.height + margin;
    
    // Create frame
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, currentHeight);
}

-(void)createPlaceholder
{
    UIImage *background = [UIImage imageNamed:@"ios-media.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    
    [self.view addSubview:imageView];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, background.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
