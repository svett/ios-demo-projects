//
//  VPTableViewCell.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/5/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPTableViewCell.h"

@implementation VPTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _secondDetailTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_secondDetailTextLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_secondDetailTextLabel sizeToFit];
    
    const CGFloat xOffset = 5;
    CGFloat x =  self.contentView.bounds.size.width - _secondDetailTextLabel.bounds.size.width - xOffset;
    CGFloat y = self.textLabel.frame.origin.y;
    
    CGRect frame = _secondDetailTextLabel.frame;
    frame.origin = CGPointMake(x, y);
    _secondDetailTextLabel.frame = frame;
}

@end
