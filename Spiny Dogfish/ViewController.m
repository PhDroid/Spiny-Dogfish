//
//  ViewController.m
//  Spiny Dogfish
//
//  Created by Max Korenkov on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Eng2RuHTMLParser.h"
#import "Eng2RuNotFoundException.h"

@implementation ViewController
@synthesize searchBar;
@synthesize searchDisplayController;
@synthesize textView;
@synthesize tableView;
@synthesize allItems;
@synthesize searchResults;
@synthesize searching;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.searching = FALSE;
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
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar {
    theSearchBar.showsCancelButton = NO;
}

// called when Search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    //sending request to lingvo
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //todo:to lower case
    NSString *url = [[NSString alloc] initWithFormat:@"http://eng2.ru/%@", self.searchBar.text];
    NSLog(@"URL: %@", url);
    [request setURL:[NSURL URLWithString: url]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"SpinyDogfish/1.0" forHTTPHeaderField:@"User-Agent"];
    [request addValue:@"text/plain, text/html" forHTTPHeaderField:@"Accept"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:TRUE]; // release later

    //end of request


    /*
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:
                          @"Hello World!",
                          nil];
    self.searchResults = items;
    [self.searchDisplayController.searchResultsTableView reloadData];
    [self.tableView reloadData];
    */
    //[self.textView setHidden:FALSE];
    //[self.tableView setHidden:TRUE];
    //[self.textView becomeFirstResponder];
}

-(void)dataCardNotFound {
    //todo:Handle the error properly
    NSLog( @"word not found" );
}
-(void)dataCardParsed:(NSMutableString *)result {
    NSLog( @"Result text: %@", result );
}

NSMutableData *_data;
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
    NSLog( @"From didReceiveResponse" );
    _data = [[NSMutableData alloc] init]; // _data being an ivar
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    NSLog( @"From didReceiveData" );
    [_data appendData:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    //todo:Handle the error properly
    NSLog( @"Error: %@", error.description);
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection {
    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parse:_data];
        [self dataCardParsed:result];
    } @catch (Eng2RuNotFoundException *e) {
        [self dataCardNotFound];
    }
}

@end
