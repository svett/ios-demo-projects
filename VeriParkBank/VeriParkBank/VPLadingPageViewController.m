//
//  VPLadingPageViewController.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPLadingPageViewController.h"
#import "VPAccount.h"
#import "VPAccountDetailsViewController.h"
#import "VPUserToken.h"
#import "VPTableViewCell.h"
#import "UIAlertView+VeriPark.h"

@implementation VPLadingPageViewController
{
    NSArray *_accounts;
}

#pragma mark - Initialization

- (id)init
{
    return [self initWithNibName:@"VPLadingPageView" bundle:[NSBundle mainBundle]];
}

#pragma mark - Events

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = NSLocalizedString(@"VeriParkBank", nil);
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationItem.hidesBackButton = YES;
    
    VPUserToken *userToken = [VPUserToken currentUserToken];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", userToken.firstName, userToken.sureName];
    NSString *welcome = NSLocalizedString(@"Welcome", nil);
    NSString *welcomeMessage = [NSString stringWithFormat:@"%@, %@", welcome, fullName];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:welcomeMessage];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(9, fullName.length)];
    
    self.welcomeLabel.attributedText = attributedText;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *currentTime = NSLocalizedString(@"Current time", nil);
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%@: %@", currentTime, [dateFormatter stringFromDate:[NSDate date]]];
    
    NSString *logOutTitle = NSLocalizedString(@"Logout", nil);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:logOutTitle
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(logout:)];
    [self.activityIndicator setCenter:self.view.center];
    [self.activityIndicator startAnimating];

    VPBankService *service = [[VPBankService alloc] init];
    service.delegate = self;
    [service accountsForUserToken:[VPUserToken currentUserToken]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender
{
    [VPUserToken setCurrentUserToken:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - VPBankServiceDelegate

- (void)bankService:(VPBankService *)service fetchedAccounts:(NSArray *)accounts forToken:(VPUserToken *)token
{
    _accounts = accounts;
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

- (void)bankService:(VPBankService *)service didFailWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    [UIAlertView showWithError:error];
}

#pragma mark - UITableViewDataSource

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = NSLocalizedString(@"Accounts", nil);
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accounts.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sTableCellIdentifier = @"TableCellIdentifier";
    VPTableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:sTableCellIdentifier];
    
    if(!tableViewCell) {
        tableViewCell = [[VPTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sTableCellIdentifier];
    }
    
    VPAccount *account = [_accounts objectAtIndex:indexPath.row];
    tableViewCell.textLabel.text = account.number;
    tableViewCell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    
    NSString *accountType = NSStringFromVPAccountType(account.type);
    tableViewCell.detailTextLabel.text = accountType;
    tableViewCell.secondDetailTextLabel.text = [NSString stringWithFormat:@"%.2f %@", account.availableBalance, account.currencyName];
    tableViewCell.secondDetailTextLabel.font = [UIFont systemFontOfSize:15];
    
    return tableViewCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VPAccount *account = [_accounts objectAtIndex:indexPath.row];
    VPAccountDetailsViewController *detailsViewController = [[VPAccountDetailsViewController alloc] initWithAccount:account];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

@end
