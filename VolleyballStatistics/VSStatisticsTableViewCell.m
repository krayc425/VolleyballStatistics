//
//  VSStatisticsTableViewCell.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSStatisticsTableViewCell.h"
#import "Utilities.h"

@implementation VSStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFont{
    for(UILabel *label in self.stackView.subviews){
        [label setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
    }
}

@end
