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
        // Custom initialization
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
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-search.png"]];
    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 36, 150, 25)];
    searchTextField.placeholder = @"Zoek wijken";
    
    
    // TODO: Create table view
    
    
    [searchView addSubview:searchTextField];
    
    [self.view addSubview:searchView];
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


@end
