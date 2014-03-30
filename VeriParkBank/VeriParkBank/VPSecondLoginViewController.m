//
//  VPSecondLoginViewController.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPSecondLoginViewController.h"
#import "VPLadingPageViewController.h"
#import "VPUserToken.h"
#import "UIAlertView+VeriPark.h"

@implementation VPSecondLoginViewController

#pragma mark - Initialization

- (id)init
{
    return [self initWithNibName:@"VPSecondLoginView" bundle:[NSBundle mainBundle]];
}


#pragma mark - Events

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = NSLocalizedString(@"Authorization", nil);
    self.navigationItem.hidesBackButton = YES;
    self.verificationTextField.secureTextEntry = YES;
    self.verificationTextField.returnKeyType = UIReturnKeyDone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verify:(id)sender {
    [sender becomeFirstResponder];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *password = self.verificationTextField.text;
    
    VPBankService *service = [[VPBankService alloc] init];
    service.delegate = self;
    
    [service veriftyToken:[VPUserToken currentUserToken] password:password];
}

#pragma mark - VPBankServiceDelegate

- (void)bankService:(VPBankService *)service didVerifyToken:(VPUserToken *)token
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self.verificationTextField endEditing:YES];
    
    VPLadingPageViewController *landingPageController = [[VPLadingPageViewController alloc] init];
    [self.navigationController pushViewController:landingPageController animated:YES];
    
    self.verificationTextField.text = @"";
}

- (void)bankService:(VPBankService *)service didFailWithTokenVerification:(VPUserToken *)token
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *title = NSLocalizedString(@"Unathenticated", nil);
    NSString *message = [NSString stringWithFormat: NSLocalizedString(@"Verification fails for username: %@", nil), token.userName];
    NSString *buttonTitle = NSLocalizedString(@"OK", nil);
    [UIAlertView showWithTitle:title message:message buttonTitle:buttonTitle];
}

- (void)bankService:(VPBankService *)service didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [UIAlertView showWithError:error];
}

@end
