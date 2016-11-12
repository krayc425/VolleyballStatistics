//
//  VSGameTableViewCell.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameTableViewCell.h"
#import "Utilities.h"

@interface VSGameTableViewCell ()

@end

@implementation VSGameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFont{
    [self.teamScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
    [self.teamMemberLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
    [self.opponentScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
    [self.opponentNumberText setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
}

@end
