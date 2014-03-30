//
//  VPToken.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPUserToken.h"

@implementation VPUserToken

static VPUserToken* sCurrentToken;

+ (VPUserToken*)currentUserToken
{
    return sCurrentToken;
}

+ (void)setCurrentUserToken:(VPUserToken *)token
{
    sCurrentToken = token;
}

@end
