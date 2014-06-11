//
//  SearchViewController.m
//  Glassy
//
//  Created by Niek Willems on 21/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftMargin = 80;
        self.labelHeight = 0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set frame sizes
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, 100);
    
    [self createSearchView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSearchView
{
    float currentHeight = 0;
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, self.view.frame.size.width, 100)];
    self.searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-search.png"]];
    
    currentHeight += self.searchView.frame.size.height;
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 40, 150, 25)];
    self.searchTextField.textColor = [UIColor whiteColor];
    [self.searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.searchTextField.placeholder = @"Zoek wijken";
    [self.searchTextField addTarget:self action:@selector(searchHandle) forControlEvents:UIControlEventEditingChanged];
    
    self.resultView = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, self.searchView.frame.size.width, 500)];
    self.resultView.backgroundColor = [UIColor whiteColor];
    [self.resultView setBackgroundColor:[UIColor whiteColor]];
    
    [self.searchView addSubview:self.resultView];

    [self.searchView addSubview:self.searchTextField];
    
    [self.view addSubview:self.searchView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

-(void)searchHandle
{
    [self getNeighborhoodData:self.searchTextField.text];
}

-(void)getNeighborhoodData:(NSString*)searchText
{
    NSString *url = [NSString stringWithFormat:[@"http://glassy-api.avans-project.nl/api/wijk/search?sq=" stringByAppendingString:searchText]];
    // Create REST client and send get request
    self.restGetNeighborhood = [[RESTClient alloc] init];
    self.restGetNeighborhood.delegate = self;
    [self.restGetNeighborhood GET:url withParameters:nil];
}

-(void)setNeighborhoodData
{
    
}

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client
{
    if(client == self.restGetNeighborhood) {
        if([responseDictionary count] > 0) {
            [self clearResult];
            
            for(id key in responseDictionary) {
                NSDictionary *neighborhoodDict = (NSDictionary *)key;
                NSString* neighborhoodName = [neighborhoodDict objectForKey:@"wijk_naam"];
                NSLog(neighborhoodName);
                
                UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.labelHeight, self.searchView.frame.size.width, 25)];
                [lbl setBackgroundColor:[UIColor whiteColor]];
                
                [lbl setText:neighborhoodName];
                [self.resultView addSubview:lbl];
                
                self.labelHeight += lbl.frame.size.height;
            }
        }else [self noResult];
    }
}

- (void) clearResult
{
    NSArray *viewsToRemove = [self.resultView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    self.labelHeight = 0;
}

- (void) noResult
{
    [self clearResult];
    
    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, 0, self.searchView.frame.size.width, 25)];
    [lbl setBackgroundColor:[UIColor whiteColor]];
    
    [lbl setText:@"Geen wijken gevonden"];
    [self.resultView addSubview:lbl];
}


@end
