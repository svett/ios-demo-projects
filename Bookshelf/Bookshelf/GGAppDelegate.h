//
//  GGAppDelegate.h
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/22/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGBooksViewController;

@interface GGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GGBooksViewController *viewController;

@end
