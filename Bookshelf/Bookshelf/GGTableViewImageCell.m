//
//  GGTableViewImageCell.m
//  Bookshelf
//
//  Created by Svetlin Ralchev on 7/25/13.
//  Copyright (c) 2013 Svetlin Ralchev. All rights reserved.
//

#import "GGTableViewImageCell.h"

@implementation GGTableViewImageCell

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentBounds = self.contentView.bounds;
    self.imageView.center = CGPointMake(contentBounds.size.width / 2.,contentBounds.size.height / 2.);
}

@end
