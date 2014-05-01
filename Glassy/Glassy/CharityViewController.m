//
//  CharityViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityViewController.h"

@interface CharityViewController ()

@end

@implementation CharityViewController

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
    [self createCharityGui];
}

- (void)createCharityGui
{
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = self.view.frame.size.width;
    
    // Set background to transparent
    self.view.backgroundColor = [UIColor clearColor];
    
    // Set title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    titleLabel.text = @"Goede doel";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    currentHeight += titleLabel.frame.size.height + margin;
    
    // Set charity view
    UIView *mediaview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 48 + margin * 4)];
    mediaview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    mediaview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    mediaview.layer.borderWidth = 1.0;
    [self.view addSubview:mediaview];
    
    // Set charity text
    UILabel *charityText = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    charityText.numberOfLines = 0;
    charityText.preferredMaxLayoutWidth = frameWidth - margin * 4;
    charityText.text = @"Gratis telefoon, tv, internet en wifi \nvoor Basisschool Antonius 3%";
    charityText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    charityText.textColor = [UIColor whiteColor];
    [mediaview addSubview:charityText];
    
    currentHeight += mediaview.frame.size.height + margin * 4;
    
    // Create frame
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, currentHeight);
}

- (void)createPlaceholder
{
    UIImage *background = [UIImage imageNamed:@"ios-charity.png"];
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
