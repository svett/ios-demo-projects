//
//  VPToken.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Represent a authenticated VeriPark Bank User
 */
@interface VPUserToken : NSObject

/**
 Returns the currently authenticated user's token
 */
+ (VPUserToken*)currentUserToken;

/**
 Sets the current token of authenticated user
 @param token The token
 */
+ (void)setCurrentUserToken:(VPUserToken*)token;

/**
 Gets or sets the user name
 */
@property (nonatomic, strong) NSString *userName;

/**
 Gets or sets whether the token is verified.
 */
@property (nonatomic, assign, getter = isVerified) BOOL verified;

/**
 Gets or sets the token id
 */
@property (nonatomic, strong) NSString *tokenId;

/**
 Gets or sets the first name
 */
@property (nonatomic, strong) NSString *firstName;

/**
 Gets or sets the user surename
 */
@property (nonatomic, strong) NSString *sureName;

@end
