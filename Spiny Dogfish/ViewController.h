//
//  ViewController.h
//  Spiny Dogfish
//
//  Created by Max Korenkov on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, copy) NSArray *allItems;
@property (nonatomic, copy) NSArray *searchResults;
@property (nonatomic) Boolean *searching;

@end
