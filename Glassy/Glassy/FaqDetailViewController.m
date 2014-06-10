//
//  FaqDetailViewController.m
//  Glassy
//
//  Created by Niek Willems on 10/06/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "FaqDetailViewController.h"
#import "MainViewController.h"

@interface FaqDetailViewController ()

@property (nonatomic, strong) RESTClient *restGetFaq;

@end

@implementation FaqDetailViewController

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
    [self createView];
    [self createGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFaq
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/faq"];
    // Create REST client and send get request
    self.restGetFaq = [[RESTClient alloc] init];
    self.restGetFaq.delegate = self;
    [self.restGetFaq GET:url withParameters:nil];
}

- (void)createView
{
    //self.faqDetailView = [[FaqDetailView alloc] init];
    //[self.view addSubview:self.faqDetailView];
    
    
    
    CGFloat currentHeight = 0;
    CGFloat margin = 5;
    CGFloat frameWidth = self.view.frame.size.width;
    
    // Set background to transparent
    //self.view.b = [UICol];
    [self.view setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    // Set title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, frameWidth, 24.0f)];
    self.titleLabel.text = @"Frequently Asked Questions";
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    
    currentHeight += self.titleLabel.frame.size.height + margin;
    
    // Set faq view
    self.mediaView = [[UIScrollView alloc]initWithFrame:CGRectMake(margin, currentHeight, frameWidth - margin * 2, [[UIScreen mainScreen] bounds].size.height - 85 - currentHeight - margin)];
    self.mediaView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.mediaView.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5].CGColor;
    self.mediaView.layer.borderWidth = 1.0;
    
    // Set faq label
    self.faqLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2, margin * 2, frameWidth, 48.0f)];
    self.faqLabel.numberOfLines = 0;
    self.faqLabel.preferredMaxLayoutWidth = frameWidth - margin * 4;
    self.faqLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    self.faqLabel.textColor = [UIColor whiteColor];
    
    [self.mediaView addSubview:self.faqLabel];
    [self.view addSubview:self.mediaView];
    
    currentHeight += self.mediaView.frame.size.height + margin * 4;
    
    // Create frame
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 85);
}

#pragma mark - UISwipeGestureRecognizer delegate methods

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
        [parent removeFaqDetailView];
    }
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
	for (id key in responseDictionary)
	{
        [array addObject:[key valueForKey:@"question" ]];
	}
    if ([array count] > 0) {
        for(int i=0; i<[array count]; i++) {
            //if(i == 0) self.faqDetailView.faqLabel.text = array[0];
        }
    }}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    
}


@end
