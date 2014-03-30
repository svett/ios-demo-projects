//
//  UIViewController+Extension.m
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/25/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (UILabel*)setupToolbarLabel {
    
    UIBarButtonItem *flexibaleSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                             target:nil
                                                                                             action:nil];
    UILabel *toolbarTitleLabel = [UILabel new];
    toolbarTitleLabel.textColor = [UIColor whiteColor];
    toolbarTitleLabel.backgroundColor = [UIColor clearColor];
    toolbarTitleLabel.shadowOffset = CGSizeMake(0, -1);
    toolbarTitleLabel.shadowColor = [UIColor grayColor];
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithCustomView:toolbarTitleLabel];
    self.toolbarItems = @[flexibaleSpaceBarButton, titleItem, flexibaleSpaceBarButton];
    return toolbarTitleLabel;
}

- (void)setText:(NSString*)text forLabel:(UILabel*)label {
    label.text = text;
    [label sizeToFit];
}

@end
