//
//  VPAccountInfo.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/5/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPAccount.h"

/**
 Represent additional information for VPAccount
 */
@interface VPAccountInfo : NSObject

/**
 Gets or sets the account number
 */
@property (nonatomic, strong) NSString *accountNumber;

/**
 Gets or set the account type
 */
@property (nonatomic, assign) VPAccountType accountType;

/**
 Gets or set the currency name
 */
@property (nonatomic, strong) NSString *currencyName;

/**
 Gets or sets the account abalance
 */
@property (nonatomic, assign) double balance;

/**
 Gets or sets the account opening date
 */
@property (nonatomic, strong) NSDate *openedDate;

/**
 Gets or sets the IBAN number
 */
@property (nonatomic, strong) NSString *ibanNumber;

@end
