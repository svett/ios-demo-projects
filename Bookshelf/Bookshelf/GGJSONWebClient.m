//
//  GGWebClient.m
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/23/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "GGJSONWebClient.h"

@implementation GGJSONWebClient

- (id)fetchObject:(NSURL*)url ofType:(Class)type {
    NSString *json = [self stringWithURL:url];
    NSDictionary *dictionary = [self JSONObjectFromNSString:json withOptions:NSJSONReadingMutableLeaves];
    
    NSObject *jsonObject = [[type alloc] init];
    [jsonObject setValuesForKeysWithDictionary:dictionary];
    return jsonObject;
}

- (NSArray*)fetchAllObjects:(NSURL*)url ofType:(Class)type {
    NSString *json = [self stringWithURL:url];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *items = [self JSONObjectFromNSString:json withOptions:NSJSONReadingMutableContainers];
    
    for(NSDictionary *dictionary in items) {
        NSObject *jsonObject = [[type alloc] init];
        [jsonObject setValuesForKeysWithDictionary:dictionary];
        [result addObject:jsonObject];
    }
    
    return [result copy];
}

- (id)JSONObjectFromNSString:(NSString*)json withOptions:(NSJSONReadingOptions)options {
    NSError *error = nil;
    NSData *data = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:options error:&error];
}

- (NSString*)stringWithURL:(NSURL*)url {
    NSError *error = nil;
    NSString *json = [NSString stringWithContentsOfURL:url
                                              encoding:NSASCIIStringEncoding
                                                 error:&error];
    
    return json;
}

@end
