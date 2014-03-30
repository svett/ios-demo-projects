//
//  GGBookDetailsView.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/24/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGBook;

/**
 * @class GGBookDetailsViewController
 * @discussion A controls that presents a book's details
 */
@interface GGBookDetailsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

/**
 * Intialize the controller with a book
 * @param book A book instance
 */
- (id)initWithBook:(GGBook*)book;

/**
 * A associated table view.
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 * A associated overlay view used to overlap the whole table view.
 */
@property (weak, nonatomic) IBOutlet UIView *overlayView;

/**
 * A associated activity indicator view.
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
