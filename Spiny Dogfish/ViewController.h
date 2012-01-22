//
//  ViewController.h
//  Spiny Dogfish
//
//  Created by Max Korenkov on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textView;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, copy) NSArray *allItems;
@property (nonatomic, copy) NSArray *searchResults;
@property (nonatomic) Boolean *searching;

@end
