//
//  VSGameStatisticsTableViewCell.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/18.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSGameStatisticsTableViewCell : UITableViewCell

@property (nonnull, nonatomic) IBOutlet UILabel *teamNumberLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *opponentNumberLabel;

@end
