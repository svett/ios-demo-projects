//
//  VPAccount.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPAccount.h"

NSString* NSStringFromVPAccountType(VPAccountType type)
{
    NSString *accountType = @"None";
    
    switch (type) {
        case VPAccountTypeCurrentAccount:
            accountType = NSLocalizedString(@"Current Account", nil);
            break;
        case VPAccountTypeSavingAccount:
            accountType = NSLocalizedString(@"Saving Account", nil);
            break;
        case VPAccountTypeTransactionAccount:
            accountType = NSLocalizedString(@"Transaction Account", nil);
            break;
        default:
            break;
    }
    
    return accountType;
}

@implementation VPAccount

@end
