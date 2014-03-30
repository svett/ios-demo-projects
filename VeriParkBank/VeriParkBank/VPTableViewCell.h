//
//  VPTableViewCell.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/5/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Represents a custom table view cell that embed 3rd UILabel
 */
@interface VPTableViewCell : UITableViewCell

/**
 Returns the right positions text label
 */
@property (nonatomic, strong, readonly) UILabel *secondDetailTextLabel;

@end
