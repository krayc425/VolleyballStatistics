//
//  VSGameStatisticsTableViewCell.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/18.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameStatisticsTableViewCell.h"
#import "Utilities.h"

@implementation VSGameStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFont{
    [self.teamNumberLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:25]];
    [self.opponentNumberLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:25]];
}

@end
