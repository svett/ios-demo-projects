//
//  GGBookDetailsView.m
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/24/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "GGBookDetailsViewController.h"
#import "GGBooksRepository.h"
#import "GGBookDetails.h"
#import "GGBook.h"
#import "GGTableViewImageCell.h"
#import "UIViewController+Extension.h"

static NSInteger sNumberOfSections = 2;
static NSInteger sHeaderSectionIndex = 0;
static NSInteger sDetailsSectionIndex = 1;
static NSInteger sImageRowIndex = 0;
static NSInteger sTitleRowIndex = 1;
static NSInteger sPriceRowIndex = 0;

@implementation GGBookDetailsViewController
{
    __weak UILabel *_toolbarTitleLabel;
    
    GGBook *_book;
    GGBookDetails *_bookDetails;
    UIImage *_bookImage;
    
    NSNumberFormatter *_currencyFormatter;
}

#pragma mark - Initialization

- (id)initWithBook:(GGBook*)book {
    self = [self init];
    
    if(self) {
        _book = book;
    }
    
    return self;
}

- (id)init {
    return [self initWithNibName:@"GGBookDetailsView" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _currencyFormatter = [[NSNumberFormatter alloc] init];
        [_currencyFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _toolbarTitleLabel = [self setupToolbarLabel];
    self.navigationController.toolbarHidden = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.title = NSLocalizedString(@"Book details", nil);
    [self reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == sHeaderSectionIndex) {
        return 2;
    }
    else if(section == sDetailsSectionIndex) {
        return 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == sHeaderSectionIndex) {
        if(indexPath.row == sImageRowIndex) {
            return 200;
        }
        else if(indexPath.row == sTitleRowIndex) {            
            return 80;
        }
    }
    
    return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if(indexPath.section == sDetailsSectionIndex && indexPath.row == sPriceRowIndex) {        
        cell = [self getCellWithStyle:UITableViewCellStyleValue1];
        cell.detailTextLabel.text = [_currencyFormatter stringFromNumber:_bookDetails.price];
        cell.textLabel.text = NSLocalizedString(@"Price", nil);
    }
    else if(indexPath.section == sHeaderSectionIndex) {
        if(indexPath.row == sImageRowIndex) {
            cell = [self getImageCell];
            cell.imageView.image = _bookImage;
        }
        else if(indexPath.row == sTitleRowIndex) {
            cell = [self getCellWithStyle:UITableViewCellStyleSubtitle];
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = _bookDetails.title;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"by", nil), _bookDetails.author];
        }
    }
    
    if(!cell) {
        cell = [self getCellWithStyle:UITableViewCellStyleSubtitle];
    }
    
    return cell;
}

- (GGTableViewImageCell*)getImageCell {
    static NSString *imageCellIdentifier = @"GGTableViewImageCell";
    GGTableViewImageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
    
    if(cell == nil) {
        cell = [[GGTableViewImageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:imageCellIdentifier];
    }
    
    return cell;
}

- (UITableViewCell*)getCellWithStyle:(UITableViewCellStyle)style {
    NSString *cellIdentifier = [NSString stringWithFormat:@"CellUITableViewCellStyle%i", style];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

#pragma mark - Methods

- (void)reloadData {
    [self.activityIndicator startAnimating];
    [self setText:NSLocalizedString(@"Loading...", nil) forLabel:_toolbarTitleLabel];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        GGBooksRepository *repository = [GGBooksRepository defaultRepository];
        
        __block GGBookDetails *bookDetails = [repository getBookForKey:_book.id];
        __block UIImage *image = [repository getImageFromLink:bookDetails.image];
                
        dispatch_async(dispatch_get_main_queue(), ^{
            _bookDetails = bookDetails;
            _bookImage = image;
            [self.tableView reloadData];
            [self performFadeOutAnimation];
        });
    });
}

- (void)performFadeOutAnimation {
    
    [UIView animateWithDuration:2
                     animations:^{
                         self.overlayView.alpha = 0;
                         _toolbarTitleLabel.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         self.overlayView.hidden = YES;
                         _toolbarTitleLabel.hidden = YES;
                         [self.activityIndicator stopAnimating];
                     }];
}

@end
