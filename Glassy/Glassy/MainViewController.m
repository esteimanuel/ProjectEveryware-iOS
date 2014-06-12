//
//  MainViewController.m
//  Glassy
//
//  Created by Niek Willems on 18/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "MainViewController.h"
#import "NeighborhoodViewController.h"
#import "MediaViewController.h"
#import "MapViewController.h"
#import "CharityViewController.h"
#import "ProgressViewController.h"
#import "ParticipantsViewController.h"
#import "NavigationBarViewController.h"
#import "PagingViewController.h"
#import "LoginViewController.h"
#import "FaqViewController.h"

#import "GPUImage.h"



@interface MainViewController ()
{
	UIImage *backgroundimage;
	UIImage *blurredBackgroundImage;
	int blurred;
	float blurPoint;
	ParticipantsViewController *participantsViewController;
	float contentSizeHeight;
	float participantsViewHeight;
}

@property (nonatomic, strong) RESTClient *restGetNeighborhoodData;
@property (nonatomic, strong) RESTClient *restGetNeighborhoodInfo;
@property (nonatomic, strong) RESTClient *restGetActionData;
@property (nonatomic, strong) RESTClient *restSetActionId;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Init scrollVIew
        self.scrollView = [[UIScrollView alloc] init];
		[self.scrollView setDelegate:self];
		
        [self createScrollViewWithViewControllers];
        [self createScrollViewBackground];
    }
    
    self.neighborhood = [[Neighborhood alloc] init];
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

- (void)getNeighborhoodData:(int)actionId
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/actie/stats?id=%d", actionId];
    // Create REST client and send get request
    self.restGetNeighborhoodData = [[RESTClient alloc] init];
    self.restGetNeighborhoodData.delegate = self;
    [self.restGetNeighborhoodData GET:url withParameters:nil];
}

- (void)getNeighborhoodInfo:(int)neighborhoodId
{
    NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/wijk?id=%d", neighborhoodId];
    // Create REST client and send get request
    self.restGetNeighborhoodInfo = [[RESTClient alloc] init];
    self.restGetNeighborhoodInfo.delegate = self;
    [self.restGetNeighborhoodInfo GET:url withParameters:nil];
}

- (void)getActionData:(int)actionId
{
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/actie?id=%d", actionId];
    // Create REST client and send get request
    self.restGetActionData = [[RESTClient alloc] init];
    self.restGetActionData.delegate = self;
    [self.restGetActionData GET:url withParameters:nil];
}

- (NSMutableDictionary *)createDictionaryWithParameters:(int)actionId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // Objects have to be added in this order
    [params setObject:[NSNumber numberWithInt:actionId] forKey:@"actie_id"];
    [params setObject:[defaults objectForKey:@"token"] forKey:@"_token"];
    
    return params;
}

- (void)setActionId:(int)actionId
{
    // Create dictionary with parameters
    NSMutableDictionary *params = [self createDictionaryWithParameters:actionId];
	NSString *url = [NSString stringWithFormat:@"http://glassy-api.avans-project.nl/api/gebruiker"];
    // Create REST client and send get request
    self.restSetActionId = [[RESTClient alloc] init];
    self.restSetActionId.delegate = self;
    [self.restSetActionId PUT:url withParameters:params];
}


- (void)createScrollViewBackground
{
	blurred = 0;
	blurPoint = [[UIScreen mainScreen] bounds].size.height / 8;
	
	// Set scroll view background
	[self getScrollViewBackgroundData];
}

- (void)getScrollViewBackgroundData
{
	// Get action background image asynchronously
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		UIImage *background = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.action.imageUrl]]];
		
		dispatch_async(dispatch_get_main_queue(),^{
			if (background != nil) {
				[self setScrollViewBackground:background];
			}
		});
		
	});
}

- (void)setScrollViewBackground:(UIImage *)img
{
    // Create background image
    UIImage *background = img;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [background drawInRect:self.view.bounds];
    UIImage *bgimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	backgroundimage = bgimage;
    
	// Create blurred background image
	GPUImageFilter *filter = [[GPUImageGaussianBlurFilter alloc]init];
	UIImage *blurredImage = [filter imageByFilteringImage:[filter imageByFilteringImage: bgimage]];
	blurredBackgroundImage = blurredImage;
	
	// Set background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (blurred == 1 && scrollView.contentOffset.y < blurPoint)
    {
		blurred = 0;
		self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    }
    else if (blurred == 0 && scrollView.contentOffset.y > blurPoint)
    {
		blurred = 1;
		self.view.backgroundColor = [UIColor colorWithPatternImage:blurredBackgroundImage];
    }
}

#pragma mark - Initialization detail view controllers

- (void)createCharityDetailView:(Charity *)charity
{
    if (self.charityDetailViewController == nil) {
        self.charityDetailViewController = [[CharityDetailViewController alloc] initWithCharity:charity];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.charityDetailViewController.view cache:YES];
    
    [self addChildViewController:self.charityDetailViewController];
    [self.view addSubview:self.charityDetailViewController.view];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.charityDetailViewController.view cache:YES];
    [UIView commitAnimations];
}

- (void)removeCharityDetailView
{
    [self.charityDetailViewController.view removeFromSuperview];
    [self.charityDetailViewController removeFromParentViewController];    
}

- (void)createParticipantDetailView:(Account*)account
{
	if (self.participantsDetailViewController == nil) {
        self.participantsDetailViewController = [[ParticipantsDetailViewController alloc] initWithAccount:account];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.participantsDetailViewController.view cache:YES];
    
    [self addChildViewController:self.participantsDetailViewController];
    [self.view addSubview:self.participantsDetailViewController.view];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.participantsDetailViewController.view cache:YES];
    [UIView commitAnimations];
}

- (void)removeParticipantDetailView
{
    [self.participantsDetailViewController.view removeFromSuperview];
    [self.participantsDetailViewController removeFromParentViewController];
}

- (void)createFaqDetailView
{
    if (self.faqDetailViewController == nil) {
        self.faqDetailViewController = [[FaqDetailViewController alloc] init];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.faqDetailViewController.view cache:YES];
    
    [self addChildViewController:self.faqDetailViewController];
    [self.view addSubview:self.faqDetailViewController.view];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.faqDetailViewController.view cache:YES];
    [UIView commitAnimations];
}

- (void)removeFaqDetailView
{
    [self.faqDetailViewController.view removeFromSuperview];
    [self.faqDetailViewController removeFromParentViewController];
}

#pragma mark - General view

- (void)createScrollViewWithViewControllers
{
    // Initiablize ViewControllers dictionary
    self.viewControllersDictionary = [[NSMutableDictionary alloc] init];
    // Initialize ViewControllers
    NeighborhoodViewController *neighborhoodViewController = [[NeighborhoodViewController alloc] init];
    [neighborhoodViewController createView];
    MediaViewController *mediaViewController = [[MediaViewController alloc] init];
    [mediaViewController createView];
    MapViewController *mapViewController = [[MapViewController alloc] init];
    [mapViewController createView];
    CharityViewController *charityViewController = [[CharityViewController alloc] init];
    [charityViewController createView];
    ProgressViewController *progressViewController = [[ProgressViewController alloc] init];
    [progressViewController createView];
    participantsViewController = [[ParticipantsViewController alloc] init];
	[participantsViewController createView];
	FaqViewController *faqViewController = [[FaqViewController alloc]init];
	[faqViewController createView];
    // Add ViewControllers to dictionary
    [self.viewControllersDictionary setObject:neighborhoodViewController forKey:@"neighborhoodViewController"];
    [self.viewControllersDictionary setObject:mediaViewController forKey:@"mediaViewController"];
    [self.viewControllersDictionary setObject:progressViewController forKey:@"progressViewController"];
    [self.viewControllersDictionary setObject:mapViewController forKey:@"mapViewController"];
    [self.viewControllersDictionary setObject:faqViewController forKey:@"faqViewController"];
    [self.viewControllersDictionary setObject:participantsViewController forKey:@"participantsViewController"];
    [self.viewControllersDictionary setObject:charityViewController forKey:@"charityViewController"];
    // TODO: add viewcontrollers
    
    // Add ViewControllers to parent viewcontroller
    [self addChildViewController:neighborhoodViewController];
    [self addChildViewController:faqViewController];
    [faqViewController didMoveToParentViewController:self];
    [self addChildViewController:mediaViewController];
    [self addChildViewController:mapViewController];
    [self addChildViewController:charityViewController];
    [self addChildViewController:progressViewController];
    [self addChildViewController:participantsViewController];
    [self addChildViewController:faqViewController];
    
    // Set background to clear
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    float currentHeight = 0;
    // Add ViewControllers to scrollView
    [self.scrollView addSubview:neighborhoodViewController.view];
    neighborhoodViewController.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, neighborhoodViewController.neighborhoodView.frame.size.height);
	
	currentHeight += neighborhoodViewController.neighborhoodView.frame.size.height;
	
    [self.scrollView addSubview:mediaViewController.view];
    mediaViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, mediaViewController.mediaView.frame.size.height);
	
	// Add button overlay
	UIButton *mediaButton = [[UIButton alloc]initWithFrame:CGRectMake(0, currentHeight, 500, mediaViewController.view.frame.size.height)];
	[mediaButton addTarget:self action:@selector(openMediaDetailView) forControlEvents:UIControlEventTouchUpInside];
	mediaButton.backgroundColor = [UIColor clearColor];
	[self.scrollView addSubview:mediaButton];
    
    currentHeight += mediaViewController.mediaView.frame.size.height;
    
    [self.scrollView addSubview:mapViewController.view];
    mapViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, mapViewController.mapView.frame.size.height);
	
	// Add button overlay
	UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(0, currentHeight, 500, mapViewController.view.frame.size.height)];
	[mapButton addTarget:self action:@selector(openMapDetailView) forControlEvents:UIControlEventTouchUpInside];
	mapButton.backgroundColor = [UIColor clearColor];
	[self.scrollView addSubview:mapButton];
    
    currentHeight += mapViewController.mapView.frame.size.height;
    
    [self.scrollView addSubview:charityViewController.view];
    charityViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, charityViewController.charityView.frame.size.height);
    
    currentHeight += charityViewController.charityView.frame.size.height;
    
    [self.scrollView addSubview:progressViewController.view];
    progressViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, progressViewController.progressView.frame.size.height);
	
	// Add button overlay
	UIButton *progressButton = [[UIButton alloc]initWithFrame:CGRectMake(0, currentHeight, 500, progressViewController.view.frame.size.height)];
	[progressButton addTarget:self action:@selector(openProgressDetailView) forControlEvents:UIControlEventTouchUpInside];
	progressButton.backgroundColor = [UIColor clearColor];
	[self.scrollView addSubview:progressButton];
    
    currentHeight += progressViewController.progressView.frame.size.height;
	
	[self.scrollView addSubview:faqViewController.view];
	faqViewController.view.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, faqViewController.faqView.frame.size.height);
	
	// Add button overlay
	UIButton *faqButton = [[UIButton alloc]initWithFrame:CGRectMake(0, currentHeight, 500, faqViewController.view.frame.size.height)];
	[faqButton addTarget:self action:@selector(createFaqDetailView) forControlEvents:UIControlEventTouchUpInside];
	faqButton.backgroundColor = [UIColor clearColor];
	[self.scrollView addSubview:faqButton];
	
	currentHeight += faqViewController.faqView.frame.size.height;
    
    [self.scrollView addSubview:participantsViewController.participantsView];
    participantsViewController.participantsView.frame = CGRectMake(0, currentHeight, self.scrollView.frame.size.width, participantsViewController.participantsView.frame.size.height);
	participantsViewHeight = participantsViewController.participantsView.frame.size.height;
    currentHeight += participantsViewController.participantsView.frame.size.height;
    
    // Set frame size
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	
	contentSizeHeight = currentHeight;
	// Calculate scrollView content size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, currentHeight);
	
    // Add scrollview to view
    [self.view addSubview:self.scrollView];
	[self onParticipantsLoaded];
}

- (void)openProgressDetailView
{
	NSLog(@"openProgressDetailView called!");
}

- (void)openFaqDetailView
{
	NSLog(@"openFaqDetailView called!");
}

- (void)openMediaDetailView
{
	NSLog(@"openMediaDetailView called!");
}

- (void)openMapDetailView
{
	NSLog(@"openMapDetailView called!");
}

- (void)onParticipantsLoaded
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		if (participantsViewController.participantsView.frame.size.height > participantsViewHeight) {
			dispatch_async(dispatch_get_main_queue(), ^{
				float margin = 5;
				contentSizeHeight += participantsViewController.participantsView.frame.size.height - participantsViewHeight + margin * 4;
				self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, contentSizeHeight);
			});
		} else {
			usleep(1000000);
			[self onParticipantsLoaded];
		}
		
	});
}

#pragma mark - Widget ViewController set methods

- (void)setNeighborhoodData
{
    self.neighborhoodViewController = [self.viewControllersDictionary objectForKey:@"neighborhoodViewController"];
    [self.neighborhoodViewController setNeighborhoodData:self.action];
}

- (void)setNeighborhoodInfo
{
    self.neighborhoodViewController = [self.viewControllersDictionary objectForKey:@"neighborhoodViewController"];
    [self.neighborhoodViewController setNeighborhoodInfo:self.neighborhood];
}

- (void)setNeighborhoodActionButtonStage
{
    NeighborhoodViewController *neighborhoodViewController = [self.viewControllersDictionary objectForKey:@"neighborhoodViewController"];
    [neighborhoodViewController setActionButtonStage];
}

- (void)setProgressData
{
    ProgressViewController *progressViewController = [self.viewControllersDictionary objectForKey:@"progressViewController"];
    [progressViewController setProgressData:self.action];
}

- (void)setParticipantsData
{
	participantsViewController = [self.viewControllersDictionary objectForKey:@"participantsViewController"];
	[participantsViewController setParticipantsData:[self.action.id intValue]];
}

- (void)setMapData
{
    MapViewController *mapViewController = [self.viewControllersDictionary objectForKey:@"mapViewController"];
    NSString *url = [NSString stringWithFormat:@"http://glassy-web.avans-project.nl/?wijk=%d", [self.action.neighborhoodId intValue]];
    [mapViewController loadRequest:url];
}

- (void)setMediaData
{
    MediaViewController *mediaViewController = [self.viewControllersDictionary objectForKey:@"mediaViewController"];
    [mediaViewController loadRequest:self.action.movieUrl];
}

- (void)setCharityData
{
    CharityViewController *charityViewController = [self.viewControllersDictionary objectForKey:@"charityViewController"];
    [charityViewController getCharityData:[self.action.id intValue]];
}

- (void)setFaqData
{
    FaqViewController *faqViewController = [self.viewControllersDictionary objectForKey:@"faqViewController"];
    [faqViewController getFaq];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"MainViewController touches began");
//    NSLog(@"MainViewController touched %@", self);
//    NSLog(@"MainViewController nextResponder = %@", [super class]);
//    //[super touchesBegan:touches withEvent:event];
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //[super touchesMoved:touches withEvent:event];
//    [super touchesMoved:touches withEvent:event];
//}
//
//-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
//{
//    NSLog(@"Touches ended: MainViewController");
//    //[super touchesEnded:touches withEvent:event];
//    [super touchesEnded:touches withEvent:event];
//}

- (void)showJoinedAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Welkom"
                                                        message:@"Je doet nu mee aan deze actie!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - REST client delegate methods

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
	if (client == self.restGetNeighborhoodData) {
		self.action.participants = [[responseDictionary objectForKey:@"participants"] floatValue];
		self.action.houses = [[responseDictionary objectForKey:@"houses"] floatValue];
		self.action.totalPartPerc = [[responseDictionary objectForKey:@"totalPartPerc"] floatValue];
		self.action.targetPartPerc = [[responseDictionary objectForKey:@"targetPartPerc"] floatValue];
		self.action.paidTargetPerc = [[responseDictionary objectForKey:@"paidTargetPerc"] floatValue];
		self.action.providerSelecPerc = [[responseDictionary objectForKey:@"providerSelecPerc"] floatValue];
		
        [self setNeighborhoodData];
        [self setNeighborhoodActionButtonStage];
		[self setProgressData];
	}
	else if (client == self.restGetActionData) {
		NSArray *array = responseDictionary [@"media"];
		if ([array isKindOfClass:[NSArray class]])
		{
			for (int i = 0 ; i < [array count] ; i++)
			{
				if ([[array[i] valueForKey:@"type"] isEqualToString:@"image"])
				{
					self.action.imageUrl = [array[i] valueForKey:@"url"];
					//NSLog(@"%@",self.action.imageUrl);
				} else if ([[array[i] valueForKey:@"type"] isEqualToString:@"video"])
				{
					self.action.movieUrl = [array[i] valueForKey:@"url"];
					//NSLog(@"%@",self.action.movieUrl);
				}
			}
		}
		[self getScrollViewBackgroundData];
		[self setMediaData];
	}
    else if (client == self.restSetActionId) {
        NSDictionary *array = responseDictionary[@"model"];
		if ([array isKindOfClass:[NSDictionary class]])
		{
            for (id key in array) {
                if ([self.parentViewController isKindOfClass:[PagingViewController class]]) {
                    PagingViewController *parent = (PagingViewController*)self.parentViewController;
                    parent.account.actionId = [array objectForKey:@"actie_id"];
                    [parent handleActionButtonStage];
                    [self getNeighborhoodData:[self.action.id intValue]];
                }
            }
        }
        [self showJoinedAlertView];
    }else if (client == self.restGetNeighborhoodInfo) {
        self.neighborhood.neighborhoodId = [NSString stringWithFormat:@"%@", [responseDictionary valueForKey:@"wijk_id" ]];
        self.neighborhood.name = [NSString stringWithFormat:@"%@", [responseDictionary valueForKey:@"wijk_naam" ]];
        
        [self setNeighborhoodInfo];
    }
}

- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client
{
    NSLog(@"Request failed");
}

@end
