//
//  GGWebClient.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/23/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class GGJsonWebClient
 * @discussion Web Client that consumes Json Web Service
 */
@interface GGJSONWebClient : NSObject

/**
 *
 */
- (id)fetchObject:(NSURL*)url ofType:(Class)type;

/**
 *
 */
- (NSArray*)fetchAllObjects:(NSURL*)url ofType:(Class)type;

@end
