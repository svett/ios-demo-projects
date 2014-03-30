//
//  GGBook.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/23/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class GGBook
 * @discussion Represents a book object.
 */
@interface GGBook : NSObject

/**
 * A book's id
 */
@property (nonatomic, strong) NSNumber *id;

/**
 * A book's title
 */
@property (nonatomic, strong) NSString *title;

/**
 * A link to book's detail
 */
@property (nonatomic, strong) NSString *link;

@end
