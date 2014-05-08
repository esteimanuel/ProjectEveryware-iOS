//
//  ParticipantsViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ParticipantsViewController.h"

@interface ParticipantsViewController ()

@end

@implementation ParticipantsViewController

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
    [self createParticipantsGui];
}

- (void)createParticipantsGui
{
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = self.view.frame.size.width;
    
    // Set background to transparent
    self.view.backgroundColor = [UIColor clearColor];
    
    // Set participants number label
    UILabel *participantsNumber = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, 60, 36.0f)];
    participantsNumber.text = @"106";
    participantsNumber.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f];
    participantsNumber.textColor = [UIColor whiteColor];
    [self.view addSubview:participantsNumber];
    
    // Set participants text label
    UILabel *participantsText = [[UILabel alloc] initWithFrame:CGRectMake(margin + participantsNumber.frame.size.width, margin * 2, 150, 24.0f)];
    participantsText.text = @"deelnemers";
    participantsText.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    participantsText.textColor = [UIColor whiteColor];
    [self.view addSubview:participantsText];
    
    // Set participants percentage label
    UILabel *participantsPercentage = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth - margin - 80, 0, 80, 36.0f)];
    participantsPercentage.text = @"22%";
    participantsPercentage.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f];
    participantsPercentage.textAlignment = NSTextAlignmentRight;
    participantsPercentage.textColor = [UIColor whiteColor];
    [self.view addSubview:participantsPercentage];
    
    currentHeight += participantsNumber.frame.size.height;
    
    // Create separator
    UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, 1)];
    separator.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:separator];
    
    // Create participants grid
    //UICollectionView *participantsGrid = [[UICollectionView alloc]init];
    
    // Add participants to participants grid
    [self addParticipants];
    
    // Add grid to view
    //[self.view addSubview:participantsGrid];
}

- (void)addParticipants
{
    
}

-(void)createPlaceholder
{
    UIImage *background = [UIImage imageNamed:@"ios-participants.png"];
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
