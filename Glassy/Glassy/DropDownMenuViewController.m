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

@property (nonatomic, strong) NSArray *loggedInMenuOptions;
@property (nonatomic, strong) NSArray *loggedOutMenuOptions;

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
    self.loggedInMenuOptions = [[NSArray alloc] initWithObjects:@"Mijn wijk", @"Profiel", @"Instellingen", @"Buddysysteem", @"Uitloggen", nil];
    self.loggedOutMenuOptions = [[NSArray alloc] initWithObjects:@"Aanmelden", @"Registreren", nil];
    self.menuOptionsArray = [[NSMutableArray alloc] init];
    [self setMenuOptionsArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuOptionsArray
{
    if ([self.menuOptionsArray count] > 0) {
        [self.menuOptionsArray removeAllObjects];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    if (token != nil) {
        [self.menuOptionsArray addObjectsFromArray:self.loggedInMenuOptions];
    } else {
        [self.menuOptionsArray addObjectsFromArray:self.loggedOutMenuOptions];
    }
    [self.tableView reloadData];
    // Set frame sizes
    self.view.frame = CGRectMake(0, 85, self.view.frame.size.width, [self.menuOptionsArray count] * 50);
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
        NSString *selected = [self.menuOptionsArray objectAtIndex:indexPath.row];
        if ([selected  isEqual: @"Aanmelden"]) {
            [parent createLoginView];
        } else if ([selected  isEqual: @"Registreren"]) {
            [parent createRegisterView];
        } else if ([selected  isEqual: @"Profiel"]) {
            [parent createProfileView];
        }
        
        // Logout
        else if ([selected  isEqual: @"Uitloggen"]) {
            [parent logout];
        }
    }
}


@end
