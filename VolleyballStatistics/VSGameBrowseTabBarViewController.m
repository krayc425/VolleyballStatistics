
//
//  VSGameBrowseTabBarViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/21.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameBrowseTabBarViewController.h"
#import "VSStatisticsTableViewController.h"
#import "GameRecord.h"
#import "Utilities.h"

static const NSString *title1 = @"记录";
static const NSString *title2 = @"统计";

@interface VSGameBrowseTabBarViewController ()

@end

@implementation VSGameBrowseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.currentRoundNum = 1;
    
    //设置 vsGameBrowseTableViewController
    self.vsGameBrowseTableViewController = (VSGameBrowseTableViewController *)[self.viewControllers objectAtIndex:0];
    [self.vsGameBrowseTableViewController setCurrentRoundNum:self.currentRoundNum];
    [self.vsGameBrowseTableViewController setRoundNum:self.roundNum];
    [self.vsGameBrowseTableViewController setTeamName:self.teamName];
    [self.vsGameBrowseTableViewController setOpponent:self.opponent];
    
    [self.vsGameBrowseTableViewController setAllScoreArr:self.allScoreArr];
    [self.vsGameBrowseTableViewController setScoreArr:[self.allScoreArr objectAtIndex:0]];
    //大比分
    NSMutableArray *teamScoreArr = [[NSMutableArray alloc] initWithCapacity:(self.roundNum)];
    NSMutableArray *opponentScoreArr = [[NSMutableArray alloc] initWithCapacity:(self.roundNum)];
    //
    for (int i = 0; i < self.roundNum; i++){
        NSMutableArray *sarr = self.allScoreArr[i];
        int ts = 0;
        int os = 0;
        for(GameRecord *r in sarr){
            if(r.team == 0){
                if(r.attackType < [[Utilities getType] count] / 2){
                    ts+=1;
                }else{
                    os+=1;
                }
            }else{
                if(r.attackType < [[Utilities getType] count] / 2){
                    os+=1;
                }else{
                    ts+=1;
                }
            }
        }
        [teamScoreArr addObject:[NSNumber numberWithInt:ts]];
        [opponentScoreArr addObject:[NSNumber numberWithInt:os]];
    }
    
    [self.vsGameBrowseTableViewController setTeamScoreArr:teamScoreArr];
    [self.vsGameBrowseTableViewController setOpponentScoreArr:opponentScoreArr];
    
    //设置 VSGameStatisticsTableViewController
    self.vsGameStatisticsTableViewController = (VSGameStatisticsTableViewController *)[self.viewControllers objectAtIndex:1];
    [self.vsGameStatisticsTableViewController setCurrentRoundNum:self.currentRoundNum];
    [self.vsGameStatisticsTableViewController setRoundNum:self.roundNum];
    [self.vsGameStatisticsTableViewController setTeamName:self.teamName];
    [self.vsGameStatisticsTableViewController setOpponent:self.opponent];
    [super setStatisticDataSource];
    
//    //设置 VSStatisticsTableViewController
//    self.vsStatisticsTableViewController = (VSStatisticsTableViewController *)[self.viewControllers objectAtIndex:2];
//    [self.vsStatisticsTableViewController setAllScoreArr:[[NSMutableArray alloc] initWithObjects:self.vsGameRecordTableViewController.allScoreArr, nil]];
//    [self.vsStatisticsTableViewController setMemberArr:(NSMutableArray *)self.vsGameRecordTableViewController.memberArr];

    [self.naviItem setTitle: (NSString *)title1];
    [super setBarButton];
    
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    [[self.tabBar.items objectAtIndex:0] setTitle: (NSString *)title1];
    [[self.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"TAB_V"]];
    [[self.tabBar.items objectAtIndex:1] setTitle: (NSString *)title2];
    [[self.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"TAB_S"]];
}

@end
