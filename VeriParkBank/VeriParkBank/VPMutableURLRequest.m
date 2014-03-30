//
//  VPMutableURLRequest.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPMutableURLRequest.h"

@implementation VPMutableURLRequest

- (id)copyWithZone:(NSZone *)zone
{
    VPMutableURLRequest *copy = [super copyWithZone:zone];
    copy.tag = [self tag];
    copy.data = [self.data mutableCopy];
    return copy;
}

@end
