//
//  VPAccountDetailsViewController.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPBankService.h"

@class VPAccount;

@interface VPAccountDetailsViewController : UIViewController<UITableViewDataSource, VPBankServiceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

/**
 Initializes the VPAccountDetailsViewController with account
 @param account The account
 */
- (id)initWithAccount:(VPAccount*)account;

@end
