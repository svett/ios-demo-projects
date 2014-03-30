//
//  GGBooksRepository.m
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/23/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "GGBooksRepository.h"
#import "GGBook.h"
#import "GGBookDetails.h"
#import "GGJSONWebClient.h"

static NSString *sBooksURL = @"http://assignment.golgek.mobi/api/v10/items";

@implementation GGBooksRepository
{
    GGJSONWebClient *_webClient;
    NSArray *_allBooks;
    NSCache *_bookDetails;
    NSCache *_bookImages;
}

+ (GGBooksRepository*)defaultRepository {
    static GGBooksRepository* _defaultRepository = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _defaultRepository = [[GGBooksRepository alloc] init];
    });
    
    return _defaultRepository;
}

#pragma mark - Initialization

- (id)init {
    self = [super init];
    
    if(self) {
        _allBooks = nil;
        _bookImages = [[NSCache alloc] init];
        _bookDetails = [[NSCache alloc] init];
        _webClient = [[GGJSONWebClient alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanRepository:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    _bookImages = nil;
    _allBooks = nil;
    _bookDetails = nil;
    _webClient = nil;
    [[NSNotificationCenter defaultCenter] removeObject:self];
}

#pragma mark - Methods

- (void)cleanRepository:(NSNotification*)notification {
    _allBooks = nil;
}

- (NSArray*)getAllBooks {
    if(!_allBooks) {
        NSURL *url = [NSURL URLWithString:sBooksURL];
        _allBooks = [_webClient fetchAllObjects:url ofType:[GGBook class]];
    }
    return _allBooks;
}

- (GGBookDetails*)getBookForKey:(NSNumber*)bookId {
    GGBookDetails *details = [_bookDetails objectForKey:bookId];
    
    if(!details) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", sBooksURL, bookId]];
        details = [_webClient fetchObject:url ofType:[GGBookDetails class]];
        [_bookDetails setObject:details forKey:bookId];
    }
    
    return details;
}

- (UIImage*)getImageFromLink:(NSString*)link {
    UIImage *image = [_bookImages objectForKey:link];
    
    if(!image) {
        NSString *fileName = [link stringByReplacingOccurrencesOfString:@"//" withString:@"_"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            image = [UIImage imageWithContentsOfFile:path];
            [_bookImages setObject:image forKey:link];
        }
        else {
            NSError *error = nil;
            NSURL *url = [NSURL URLWithString:link];
            NSData *imageData = [NSData dataWithContentsOfURL:url options:0 error:&error];
            
            if(!error && imageData && [imageData length] > 0) {
                [imageData writeToFile:path options:0 error:&error];
                image = [UIImage imageWithData:imageData];
                [_bookImages setObject:image forKey:link];
            }
        }
    }
    
    return image;
}

@end
