//
//  VPAccount.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Defines the account types
 */
typedef enum VPAccountType {
    /**
     Current account
     */
    VPAccountTypeCurrentAccount = 1,
    /**
     Saving account
     */
    VPAccountTypeSavingAccount = 2,
    /**
     Transaction account
     */
    VPAccountTypeTransactionAccount = 3,
} VPAccountType;

/**
 Returns a text representation of VPAccountType
 @param type The type
 */
NSString* NSStringFromVPAccountType(VPAccountType type);

/**
 Represents a single bank account
 */
@interface VPAccount : NSObject

/**
 Gets or sets the account number
 */
@property (nonatomic, strong) NSString *number;

/**
 Gets or sets the branch code
 */
@property (nonatomic, strong) NSString *branchCode;

/**
 Gets or sets the branch name
 */
@property (nonatomic, strong) NSString *branchName;

/**
 Gets or sets the available balance
 */
@property (nonatomic, assign) double availableBalance;

/**
 Gets or sets the balance
 */
@property (nonatomic, assign) double balance;

/**
 Gets or sets the currency name
 */
@property (nonatomic, strong) NSString *currencyName;

/**
 Gets or sets the account type
 */
@property (nonatomic, assign) VPAccountType type;

@end
