//
//  VSStatisticsTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSStatisticsTableViewController : UITableViewController

@property (nonnull, nonatomic) NSMutableArray *memberArr;
@property (nonnull, nonatomic) NSMutableArray *gameArr;
//这个 arr 里面放的都是一个个 game.scoredata 转出来的数组
@property (nonnull, nonatomic) NSMutableArray *allScoreArr;

@property (nonnull, nonatomic) NSMutableArray *statisticsArr;

@property (nonnull, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonnull, nonatomic) IBOutlet UIStackView *stackView;

- (void)setGameArr:(NSMutableArray * _Nonnull)gameArr;
- (void)setMemberArr:(NSMutableArray * _Nonnull)memberArr;

@end
