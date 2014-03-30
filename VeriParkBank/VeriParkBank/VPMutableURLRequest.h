//
//  VPMutableURLRequest.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Represent a mutable request class that contains meta information
 */
@interface VPMutableURLRequest : NSMutableURLRequest

/**
 Gets or sets an aggregated data from request's response
 */
@property (nonatomic, strong) NSMutableData *data;

/**
 Gets or sets an associated tag
 */
@property (nonatomic, strong) id tag;

@end
