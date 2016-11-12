//
//  VSGameRecordTabBarViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/18.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSGameRecordTableViewController;
@class VSGameStatisticsTableViewController;
@class VSStatisticsTableViewController;

@interface VSGameRecordTabBarViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonnull, nonatomic) IBOutlet UINavigationItem *naviItem;

@property (nonnull) VSGameRecordTableViewController *vsGameRecordTableViewController;
@property (nonnull) VSGameStatisticsTableViewController *vsGameStatisticsTableViewController;

@property (nonnull) VSStatisticsTableViewController *vsStatisticsTableViewController;

@property (nonnull, nonatomic) NSString *teamName;
@property (nonnull, nonatomic) NSString *opponent;
@property (nonnull, nonatomic) NSMutableArray *allScoreArr;     //这个 array 需要所有调用此 VC 的人来初始化
@property (nonatomic) int roundNum;
@property (nonatomic) int currentRoundNum;

- (void)setStatisticDataSource;

- (void)setBarButton;

@end
