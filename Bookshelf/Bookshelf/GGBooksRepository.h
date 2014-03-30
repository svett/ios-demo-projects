//
//  GGBooksRepository.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/23/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GGBook;
@class GGBookDetails;

/**
 * @class GGBooksRepository
 * @discussion Represents a repository class of books
 */
@interface GGBooksRepository : NSObject

+ (GGBooksRepository*)defaultRepository;

/**
 * Returns all books
 */
- (NSArray*)getAllBooks;

/**
 * Returns a book by its id
 */
- (GGBookDetails*)getBookForKey:(NSNumber*)bookKey;

/**
 * Returns a book's cover image
 */
- (UIImage*)getImageFromLink:(NSString*)link;

@end
