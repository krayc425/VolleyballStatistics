//
//  VSGameStatisticsTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/18.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSGameStatisticsTableViewController : UITableViewController

@property (nonnull, nonatomic) NSString *teamName;
@property (nonnull, nonatomic) NSString *opponent;
@property (nonnull, nonatomic) NSNumber *teamScore;
@property (nonnull, nonatomic) NSNumber *opponentScore;
@property (nonatomic) int roundNum;
@property (nonatomic) int currentRoundNum;
@property (nonnull, nonatomic) NSMutableArray *itemArr;
@property (nonnull, nonatomic) NSMutableArray *recordArr;   //这里只是单独的一局的数据
@property (nonnull, nonatomic) NSMutableArray *teamDataArr;
@property (nonnull, nonatomic) NSMutableArray *opponentDataArr;

@property (nonatomic, nonnull) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *opponentNameLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *teamScoreLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *opponentScoreLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *roundNumLabel;

- (void)loadData;

@end
