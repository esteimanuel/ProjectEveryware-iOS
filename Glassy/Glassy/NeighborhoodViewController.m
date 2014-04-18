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
    
    [self createNeighborhoodGUI];
    
}

- (void) createNeighborhoodGUI
{
    // Create frame
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
    
    // Create background image
    UIImage *background = [UIImage imageNamed:@"happy-people.jpg"];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeTop;
    //imageView.clipsToBounds = true;
    [imageView setImage:background];
    
    [self.view addSubview:imageView];
    
    // Create neighborhood title
    UILabel *NeighborhoodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, (self.view.frame.size.height - 210.0) - 10.0, self.view.frame.size.width -10.0, 28.0f)];
    [NeighborhoodTitleLabel setText:@"Martijn's glasvezel buurt"];
    [NeighborhoodTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [NeighborhoodTitleLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:NeighborhoodTitleLabel];
    
    // Create participants number
    UILabel *participantsNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0, (self.view.frame.size.height - 180.0) - 10.0, self.view.frame.size.width -10.0, 50.0f)];
    [participantsNumberLabel setText:@"106"];
    [participantsNumberLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0f]];
    [participantsNumberLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:participantsNumberLabel];
    
    // Create participants label
    UILabel *participantsLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0, (self.view.frame.size.height - 160.0) - 10.0, self.view.frame.size.width -10.0, 25.0f)];
    [participantsLabel setText:@"deelnemers"];
    [participantsLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [participantsLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:participantsLabel];
    
    // Create percentage
    UILabel *percentageLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0, (self.view.frame.size.height - 140.0) - 10.0, self.view.frame.size.width -10.0, 100.0f)];
    [percentageLabel setText:@"22%"];
    [percentageLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:100.0f]];
    [percentageLabel setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:percentageLabel];
    
    // Create facebook share button
    
    // Create action button
    UIButton *actionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //[actionButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setTitle:@"Ik doe ook mee" forState:UIControlStateNormal];
    [actionButton.titleLabel setFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f]];
    [actionButton setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
    actionButton.frame = CGRectMake(5.0, (self.view.frame.size.height - 40.0) - 10.0, self.view.frame.size.width -10.0, 40.0);
    
    [self.view addSubview:actionButton];
    
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
