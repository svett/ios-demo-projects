//
//  GGViewController.m
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/22/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "GGBooksViewController.h"
#import "GGBook.h"
#import "GGBooksRepository.h"
#import "GGBookDetailsViewController.h"
#import "UIViewController+Extension.h"

@implementation GGBooksViewController
{
    __weak UILabel *_toolbarTitleLabel;

    NSDateFormatter *_dateFormatter;
    
    NSArray *_books;
    NSArray *_filteredBooks;
    
    BOOL _isLoading;
}

#pragma mark - Initialization

- (id)init {
    return [self initWithNibName:@"GGBooksView" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    _isLoading = FALSE;
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"MMM d, HH:mm:ss"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"Search book", nil);
    self.title = NSLocalizedString(@"Books", nil);
    self.clearsSelectionOnViewWillAppear = YES;
    
    _toolbarTitleLabel = [self setupToolbarLabel];
    [self reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView == self.searchDisplayController.searchResultsTableView ? _filteredBooks.count : _books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *sCellIdentifier = @"GGBookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sCellIdentifier];
    }
    
    NSArray *books = tableView == self.searchDisplayController.searchResultsTableView ? _filteredBooks : _books;
    GGBook *book = [books objectAtIndex:indexPath.row];
    cell.textLabel.text = book.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *books = tableView == self.searchDisplayController.searchResultsTableView ? _filteredBooks : _books;
    GGBook *book = [books objectAtIndex:indexPath.row];
    GGBookDetailsViewController *detailsViewController = [[GGBookDetailsViewController alloc] initWithBook: book];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark - Methods

- (void)filterContentForSearchText:(NSString*)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[c] %@",searchText];
    _filteredBooks = [_books filteredArrayUsingPredicate:predicate];
}


- (void)reloadData {
    if(_isLoading) {
        return;
    }

    _isLoading = TRUE;
    [self setText:NSLocalizedString(@"Loading...", nil) forLabel:_toolbarTitleLabel];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        __block NSArray* books = [[GGBooksRepository defaultRepository] getAllBooks];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _books = books;

            [self.tableView reloadData];
            
            NSString *title = NSLocalizedString(@"Last updated on", nil);
            NSString *date = [_dateFormatter stringFromDate:[[NSDate alloc] init]];
            NSString *header = [NSString stringWithFormat:@"%@ %@", title, date];
            
            [self setText:header forLabel:_toolbarTitleLabel];
            
            if(self.refreshControl.refreshing) {
                [self.refreshControl endRefreshing];
            }
            
            _isLoading = FALSE;
        });
    });
}

@end
