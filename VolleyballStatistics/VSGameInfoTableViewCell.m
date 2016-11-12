//
//  VSGameInfoTableViewCell.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameInfoTableViewCell.h"
#import "Utilities.h"

@implementation VSGameInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFont{
    [self.teamScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:35]];
    [self.opponentScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:35]];
}

@end
