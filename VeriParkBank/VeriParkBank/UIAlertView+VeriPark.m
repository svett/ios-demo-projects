//
//  UIAlertView+VeriPark.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "UIAlertView+VeriPark.h"

@implementation UIAlertView (VeriPark)

+ (void)showWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    [alertView show];
}

+ (void)showWithError:(NSError *)error
{
    NSLog(@"%@", [error description]);
    NSString *title = NSLocalizedString(@"Error", nil);
    NSString *message = [error localizedDescription];
    NSString *buttonTitle = NSLocalizedString(@"OK", nil);
    [UIAlertView showWithTitle:title message:message buttonTitle:buttonTitle];
}

@end
