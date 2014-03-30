//
//  VPBankService.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VPUserToken;
@class VPAccount;
@class VPAccountInfo;
@class VPBankService;

/**
 Represents a VeriPark Bank Service delegate
 */
@protocol VPBankServiceDelegate <NSObject>

@optional

/**
 Occurs when the username authentication fails
 @param service The service
 @param username The username
 */
- (void)bankService:(VPBankService*)service didFailWithUserAuthentication:(NSString*)username;

/**
 Occurs when the user is authenticated.
 @param service The service
 @param token The username token
 */
- (void)bankService:(VPBankService*)service didAuthenticateToken:(VPUserToken*)token;

/**
 Occurs when token is verified
 @param service The service
 @param token The token
 */
- (void)bankService:(VPBankService *)service didVerifyToken:(VPUserToken*)token;

/**
 Occurs when token verification fails
 @param service The service
 @param token The token
 */
- (void)bankService:(VPBankService *)service didFailWithTokenVerification:(VPUserToken*)token;

/**
 Occurs when the service fail
 @param service The service
 @param error The error
 */
- (void)bankService:(VPBankService *)service didFailWithError:(NSError*)error;

/**
 Occurs when the accounts for user token are fetched.
 @param service The service
 @param accounts The fetched accounts
 @param token The user token
 */
- (void)bankService:(VPBankService *)service fetchedAccounts:(NSArray*)accounts forToken:(VPUserToken*)token;


/**
 Occurse when the account info is fetched
 @param service The service
 @param info The feteched account info
 @param account The account
 */
- (void)bankService:(VPBankService *)service fetchedInfo:(VPAccountInfo*)info forAccount:(VPAccount*)account;

@end

/**
 Represents an entry point to VeriPark Bank Soap Service
 */
@interface VPBankService : NSObject<NSURLConnectionDataDelegate>

/**
 Gets or sets the service delegate
 */
@property (nonatomic, assign) id<VPBankServiceDelegate> delegate;

/**
 Authenticate a bank customer
 @param username The username
 @parama password The password
 */
- (void)authenticateWithUsername:(NSString*)username password:(NSString*)password;

/**
 Verifies the token for second time
 @param token The token
 @param password The second password
 */
- (void)veriftyToken:(VPUserToken*)token password:(NSString*)password;

/**
 Gets the accounts for concrete user token
 @param token The token
 */
- (void)accountsForUserToken:(VPUserToken*)token;

/**
 Gets additional information for the specified account
 @param account The account
 @param token The token
 */
- (void)infoForAccount:(VPAccount*)account token:(VPUserToken*)token;

@end
