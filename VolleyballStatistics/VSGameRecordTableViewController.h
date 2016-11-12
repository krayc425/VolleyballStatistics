//
//  VSGameRecordTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/13.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameRecord;

@interface VSGameRecordTableViewController : UITableViewController <UITextFieldDelegate>

enum CHOOSE_POSITION{
    TEAM_LABEL,
    TEAM_IMG,
    OPPONENT_IMG,
};

enum TEAM_TYPE{
    NO_TEAM = -1,
    MY_TEAM,
    OPPONENT_TEAM,
};
typedef enum CHOOSE_POSITION CHOOSE_POSITION;

enum TYPE{
    FAQIU,
    LANWANG,
    KOUQIU,
    FAQIU_FAIL,
    LANWANG_FAIL,
    KOUQIU_FAIL,
};
typedef enum TYPE TYPE;


enum VIEW_TYPE{
    RECORD,
    BROWSE,
};
typedef enum VIEW_TYPE VIEW_TYPE;

@property (nonnull,nonatomic,strong) UIView *containerView;
//这个 customTableView 和 UITableViewController 自带的 tableView 不同！
@property (nonnull,nonatomic,strong) UITableView *customTableView;

@property (nonatomic, nonnull) IBOutlet UILabel *opponentLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *teamLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *teamScoreLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *opponentScoreLabel;
@property (nonatomic, nonnull) IBOutlet UILabel *roundNumLabel;

@property (nonatomic, nonnull) IBOutlet UIBarButtonItem *prevRoundItem;
@property (nonatomic, nonnull) IBOutlet UIBarButtonItem *nextRoundItem;
@property (nonnull, nonatomic) NSArray *memberArr;
@property (nonnull, nonatomic) NSString *teamName;
@property (nonnull, nonatomic) NSString *opponent;
@property (nonatomic) int roundNum;
@property (nonatomic) int currentRoundNum;

@property (nonnull, nonatomic) NSIndexPath *tmpIndexPath;
@property (nonnull, nonatomic) GameRecord *tmpGameRecord;

//记录所有 GameRecord 的数组
@property (nonnull, nonatomic) NSMutableArray *allScoreArr;
@property (nonnull, nonatomic) NSMutableArray *scoreArr;

//记录大比分的数组
@property (nonnull, nonatomic) NSMutableArray *teamScoreArr;
@property (nonnull, nonatomic) NSMutableArray *opponentScoreArr;

- (void)refreshScoreLabel;
- (void)setBarButtonLabel:(int)num;
- (void)finishGame;

@end
