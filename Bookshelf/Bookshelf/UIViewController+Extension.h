//
//  UIViewController+Extension.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/25/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Extensions of UIViewController
 */
@interface UIViewController (Extension)

/**
 * Setups a label as title of UIViewController's toolbar
 */
- (UILabel*)setupToolbarLabel;

/**
 * Sets the text for label
 */
- (void)setText:(NSString*)text forLabel:(UILabel*)label;

@end
