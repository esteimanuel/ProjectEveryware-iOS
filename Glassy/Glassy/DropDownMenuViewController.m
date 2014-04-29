//
//  DropDownMenuViewController.m
//  Glassy
//
//  Created by Niek Willems on 19/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "DropDownMenuViewController.h"
#import "MainViewController.h"

@interface DropDownMenuViewController ()

@end

@implementation DropDownMenuViewController
@synthesize menuOptionsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Disable scrolling
    self.tableView.scrollEnabled = NO;
    
    // Initialize menu options array
    // TODO: check for user token
    NSString *token = nil;
    if (token != nil) {
        self.menuOptionsArray = [[NSArray alloc] initWithObjects:@"Mijn wijk", @"Profiel", @"Instellingen", @"Buddysysteem", nil];
    } else {
        self.menuOptionsArray = [[NSArray alloc] initWithObjects:@"Aanmelden", @"Registreren", nil];
    }
    // Set frame sizes
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, [self.menuOptionsArray count] * 50);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuOptionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure cells
    cell.textLabel.text = [self.menuOptionsArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.parentViewController isKindOfClass:[MainViewController class]]) {
        MainViewController* parent = (MainViewController*)self.parentViewController;
        [parent createAuthenticationViewController];
    }
}


@end
