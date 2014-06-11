//
//  CharityDetailViewController.m
//  Glassy
//
//  Created by Niek Willems on 08/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CharityDetailViewController.h"
#import "MainViewController.h"

@interface CharityDetailViewController ()

@end

@implementation CharityDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCharity:(Charity *)charity
{
    self = [super init];
    if (self) {
        self.charity = charity;
        
        [self createCharityGui];
        [self createGesture];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCharityGui
{
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = self.view.frame.size.width;
    
    // Set background to transparent
    //self.view.b = [UICol];
    [self.view setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    // Set title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    titleLabel.text = self.charity.title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    currentHeight += titleLabel.frame.size.height + margin;
    
    // Set charity view
    UIView *mediaview = [[UIView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, [[UIScreen mainScreen] bounds].size.height - 85 - currentHeight - margin)];
    mediaview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    mediaview.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    mediaview.layer.borderWidth = 1.0;
    [self.view addSubview:mediaview];
    
    // Set charity text
    UILabel *charityText = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    charityText.numberOfLines = 0;
    charityText.preferredMaxLayoutWidth = frameWidth - margin * 4;
    charityText.text = self.charity.message;
    charityText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    charityText.textColor = [UIColor whiteColor];
    [mediaview addSubview:charityText];
    
    currentHeight += mediaview.frame.size.height + margin * 4;
    
    // Create frame
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 85);
}

- (void)createGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    [self dispose];
}

- (void)dispose
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent removeCharityDetailView];
    }
}


@end
