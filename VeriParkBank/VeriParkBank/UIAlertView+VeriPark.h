//
//  UIAlertView+VeriPark.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (VeriPark)

/**
 Shows the UIAlertView
 @param title The title
 @param message The message
 @param buttonTitle The button title
 */
+ (void)showWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle;

/**
 Shows the UIAlertView for error
 @param error The Error
 */
+ (void)showWithError:(NSError*)error;
@end
