//
//  VPLadingPageViewController.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPBankService.h"

@interface VPLadingPageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, VPBankServiceDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
