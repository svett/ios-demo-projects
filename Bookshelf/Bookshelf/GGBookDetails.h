//
//  GGBookDetails.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/23/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "GGBook.h"

/**
 * @class GGBookDetails
 * @discussion Represents a book's details
 */
@interface GGBookDetails : GGBook

/**
 * Represents a book's author
 */
@property (nonatomic, strong) NSString *author;

/**
 * Represents a book's price
 */
@property (nonatomic, strong) NSNumber *price;

/**
 * Represents a image url of the book's cover
 */
@property (nonatomic, strong) NSString *image;

@end
