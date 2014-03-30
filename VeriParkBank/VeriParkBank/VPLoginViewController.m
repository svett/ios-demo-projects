//
//  VPLoginViewController.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPLoginViewController.h"
#import "VPSecondLoginViewController.h"
#import "VPUserToken.h"
#import "UIAlertView+VeriPark.h"

@implementation VPLoginViewController

#pragma mark - Initialization

- (id)init
{
    return [self initWithNibName:@"VPLoginView" bundle:[NSBundle mainBundle]];
}

#pragma mark - Events

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = NSLocalizedString(@"Authentication", nil);
    self.passwordTextField.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [self.userNameTextField endEditing:YES];
    [self.passwordTextField endEditing:YES];
    
    NSString *username = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    VPBankService *service = [[VPBankService alloc] init];
    service.delegate = self;
    [service authenticateWithUsername:username password:password];
}

#pragma mark - VPBankServiceDelegate

- (void)bankService:(VPBankService *)service didAuthenticateToken:(VPUserToken *)token
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [VPUserToken setCurrentUserToken:token];
    VPSecondLoginViewController *secondLoginViewController = [[VPSecondLoginViewController alloc] init];
    [self.navigationController pushViewController:secondLoginViewController animated:YES];
    
    self.userNameTextField.text = @"";
    self.passwordTextField.text = @"";
}

- (void)bankService:(VPBankService *)service didFailWithUserAuthentication:(NSString *)username
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *title = NSLocalizedString(@"Unathenticated", nil);
    NSString *message = [NSString stringWithFormat: NSLocalizedString(@"Login fails for username: %@", nil), username];
    NSString *buttonTitle = NSLocalizedString(@"OK", nil);
    [UIAlertView showWithTitle:title message:message buttonTitle:buttonTitle];
}

- (void)bankService:(VPBankService *)service didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [UIAlertView showWithError:error];
}

@end
