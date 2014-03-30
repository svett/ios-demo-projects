//
//  VPAccountDetailsViewController.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPAccountDetailsViewController.h"
#import "VPAccount.h"
#import "VPBankService.h"
#import "VPUserToken.h"
#import "UIAlertView+VeriPark.h"
#import "VPAccountInfo.h"

const NSInteger kNumberOfPresentedProperties = 5;
const NSInteger kAccountNumberRow = 0;
const NSInteger kAccountTypeRow = 1;
const NSInteger kAccountBalanceRow = 2;
const NSInteger kAccountOpenedDateRow = 3;
const NSInteger kAccountIBANRow = 4;

@implementation VPAccountDetailsViewController
{
    VPAccount *_account;
    VPAccountInfo *_info;
}

#pragma mark - Initialization

- (id)initWithAccount:(VPAccount*)account
{
    self = [self init];
    
    if(self) {
        _account = account;
    }
    
    return self;
}

- (id)init
{
    return [self initWithNibName:@"VPAccountDetailsView" bundle:[NSBundle mainBundle]];
}

#pragma mark - Events

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Details", nil);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    [self.activityIndicator setCenter:self.view.center];
    [self.activityIndicator startAnimating];
    
    VPBankService *service = [[VPBankService alloc] init];
    service.delegate = self;
    [service infoForAccount:_account token:[VPUserToken currentUserToken]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _info ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfPresentedProperties;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *accountInformation = NSLocalizedString(@"Information", nil);
    return  accountInformation;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sTableCellIdentifier = @"AccountTableCellIdentifier";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:sTableCellIdentifier];
    
    if(!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:sTableCellIdentifier];
    }
    
    tableViewCell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    switch (indexPath.row) {
        case kAccountNumberRow:
        {
            tableViewCell.textLabel.text = NSLocalizedString(@"Number", nil);
            tableViewCell.detailTextLabel.text = _info.accountNumber;
        }
            break;
        case kAccountTypeRow:
        {
            NSString *accountType = NSStringFromVPAccountType(_info.accountType);
            tableViewCell.textLabel.text = NSLocalizedString(@"Type", nil);
            tableViewCell.detailTextLabel.text = accountType;
        }
            break;
        case kAccountBalanceRow:
        {
            tableViewCell.textLabel.text = NSLocalizedString(@"Balance", nil);
            tableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f %@", _info.balance, _info.currencyName];
        }
            break;
        case kAccountOpenedDateRow:
        {
            tableViewCell.textLabel.text = NSLocalizedString(@"Opened Date", nil);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            tableViewCell.detailTextLabel.text = [dateFormatter stringFromDate:_info.openedDate];
        }
            break;
        case kAccountIBANRow:
        {
            tableViewCell.textLabel.text = NSLocalizedString(@"IBAN", nil);
            tableViewCell.detailTextLabel.text = _info.ibanNumber;
        }
            break;
        default:
            break;
    }
   
   return tableViewCell;
}

#pragma mark - VPBankServiceDelegate

- (void)bankService:(VPBankService *)service fetchedInfo:(VPAccountInfo *)info forAccount:(VPAccount *)account
{
    [self.activityIndicator stopAnimating];
    _info = info;
    [self.tableView reloadData];
}

- (void)bankService:(VPBankService *)service didFailWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    [UIAlertView showWithError:error];
}

@end
