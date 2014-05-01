//
//  NeighborhoodViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "NeighborhoodViewController.h"

@interface NeighborhoodViewController ()

@end

@implementation NeighborhoodViewController

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
    
    [self createGUI];
    
}

- (void)setNeighborhoodFields:(Action *)action
{
    self.neighborhoodTitleLabel.text = action.name;
}

- (void) createGUI
{
    // Create frame
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
    [self.view setBackgroundColor: [UIColor blackColor]];

    // Create background image
    //NSString *imageUrl = @"http://www.celebs101.com/gallery/Scarlett_Johansson/201825/allthatgossip_Scarlett_Johansson_GoldenGlobe_01.jpg";
    NSString *imageUrl = @"http://www.wallpaperspictures.net/image/bruce-lee-iconic-figure-wallpaper-for-2560x1920-886-26.jpg";
    UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 85.0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height -85.0)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = background;
    //imageView.clipsToBounds = NO;
    imageView.alpha = 0.75;
    
    [self.view addSubview:imageView];
    
    // Create neighborhood title
    self.neighborhoodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, (self.view.frame.size.height - 210.0) - 10.0, self.view.frame.size.width -10.0, 28.0f)];
    [self.neighborhoodTitleLabel setText:@"Martijn's glasvezel buurt"];
    [self.neighborhoodTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [self.neighborhoodTitleLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.neighborhoodTitleLabel];
    
    // Create participants number
    self.participantsNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0, (self.view.frame.size.height - 180.0) - 10.0, self.view.frame.size.width -10.0, 50.0f)];
    [self.participantsNumberLabel setText:@"106"];
    [self.participantsNumberLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0f]];
    [self.participantsNumberLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.participantsNumberLabel];
    
    // Create participants label
    self.participantsLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0, (self.view.frame.size.height - 160.0) - 10.0, self.view.frame.size.width -10.0, 25.0f)];
    [self.participantsLabel setText:@"deelnemers"];
    [self.participantsLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [self.participantsLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.participantsLabel];
    
    // Create percentage
    self.percentageLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0, (self.view.frame.size.height - 140.0) - 10.0, self.view.frame.size.width -10.0, 100.0f)];
    [self.percentageLabel setText:@"22%"];
    [self.percentageLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:100.0f]];
    [self.percentageLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.percentageLabel];
    
    // Create facebook share button
    
    // Create action button
    UIButton *actionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //[actionButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setTitle:@"Ik doe ook mee" forState:UIControlStateNormal];
    [actionButton.titleLabel setFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f]];
    [actionButton setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [actionButton.layer setBorderColor:[[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5] CGColor]];
    [actionButton.layer setBorderWidth:1.0f];
    actionButton.frame = CGRectMake(5.0, (self.view.frame.size.height - 40.0) - 10.0, self.view.frame.size.width -10.0, 40.0);
    
    [self.view addSubview:actionButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
