//
//  VSGameInfoTableViewCell.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

//首页展示比赛信息的 cell
@interface VSGameInfoTableViewCell : UITableViewCell

@property (nonnull, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *opponentLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *teamScoreLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *opponentScoreLabel;

@end
