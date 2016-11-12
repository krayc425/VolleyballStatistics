//
//  VSMemberTableViewCell.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSMemberTableViewCell.h"
#import "Utilities.h"

@implementation VSMemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFont{
    [self.numberLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
}

@end
