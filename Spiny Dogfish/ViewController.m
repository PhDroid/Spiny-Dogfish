//
//  ViewController.m
//  Spiny Dogfish
//
//  Created by Max Korenkov on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize searchBar;
@synthesize searchDisplayController;
@synthesize textView;
@synthesize tableView;
@synthesize allItems;
@synthesize searchResults;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;

    //todo: load from SQL databases
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:
                      @"Closure",
                      @"America",
                      @"Voltage",
                      @"Merchant",
                      @"Demo",
                      nil];
    
    self.allItems = items;

    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setSearchDisplayController:nil];
    [self setTextView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    if ([theTableView
         isEqual:self.searchDisplayController.searchResultsTableView]){
        rows = [self.searchResults count];
    }
    else{
        rows = [self.allItems count];
    }
    
    return rows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    /* Configure the cell. */
    if ([theTableView isEqual:self.searchDisplayController.searchResultsTableView]){
        cell.textLabel.text = 
        [self.searchResults objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text =
        [self.allItems objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];

    self.searchResults = [self.allItems filteredArrayUsingPredicate:resultPredicate];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    //[self.searchResults removeAllObjects];// remove all data that belongs to previous search
    if([searchText isEqualToString:@""] || searchText==nil) {
        [self.tableView reloadData];
        return;
    }
    [self filterContentForSearchText:searchText];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar
{
    [self.tableView reloadData];
    [theSearchBar resignFirstResponder];
    theSearchBar.text = @"";
}

#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    theSearchBar.showsCancelButton = YES;

    [self.textView setHidden:TRUE];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar {
    theSearchBar.showsCancelButton = NO;
}

// called when Search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar{
    [self.tableView reloadData];

    [self.textView setHidden:FALSE];
    [self.tableView setHidden:TRUE];
    [self.textView becomeFirstResponder];
}


@end
