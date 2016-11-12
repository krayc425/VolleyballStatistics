//
//  VSGameRecordTabBarViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/18.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameRecordTabBarViewController.h"
#import "VSGameRecordTableViewController.h"
#import "VSGameStatisticsTableViewController.h"
#import "VSStatisticsTableViewController.h"
#import "Utilities.h"
#import "GameRecord.h"
#import "Game+CoreDataClass.h"

static const NSString *title1 = @"记录";
static const NSString *title2 = @"技术统计";
static const NSString *title3 = @"队员统计";

@interface VSGameRecordTabBarViewController ()

@end

@implementation VSGameRecordTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.currentRoundNum = 1;
    
    //设置 VSGameRecordTableViewController
    self.vsGameRecordTableViewController = (VSGameRecordTableViewController *)[self.viewControllers objectAtIndex:0];
    [self.vsGameRecordTableViewController setCurrentRoundNum:self.currentRoundNum];
    [self.vsGameRecordTableViewController setRoundNum:self.roundNum];
    [self.vsGameRecordTableViewController setTeamName:self.teamName];
    [self.vsGameRecordTableViewController setOpponent:self.opponent];
    
    [self.vsGameRecordTableViewController setAllScoreArr:self.allScoreArr];
    [self.vsGameRecordTableViewController setScoreArr:[self.allScoreArr objectAtIndex:0]];
    //大比分
    NSMutableArray *teamScoreArr = [[NSMutableArray alloc] initWithCapacity:(self.roundNum)];
    NSMutableArray *opponentScoreArr = [[NSMutableArray alloc] initWithCapacity:(self.roundNum)];
    //
    for (int i = 0; i < self.roundNum; i++) {
        [teamScoreArr addObject:[NSNumber numberWithInt:0]];
        [opponentScoreArr addObject:[NSNumber numberWithInt:0]];
    }
    
    [self.vsGameRecordTableViewController setTeamScoreArr:teamScoreArr];
    [self.vsGameRecordTableViewController setOpponentScoreArr:opponentScoreArr];
    
    //设置 VSGameStatisticsTableViewController
    self.vsGameStatisticsTableViewController = (VSGameStatisticsTableViewController *)[self.viewControllers objectAtIndex:1];
    [self.vsGameStatisticsTableViewController setCurrentRoundNum:self.currentRoundNum];
    [self.vsGameStatisticsTableViewController setRoundNum:self.roundNum];
    [self.vsGameStatisticsTableViewController setTeamName:self.teamName];
    [self.vsGameStatisticsTableViewController setOpponent:self.opponent];
    [self setStatisticDataSource];
    
    //设置 VSStatisticsTableViewController
    self.vsStatisticsTableViewController = (VSStatisticsTableViewController *)[self.viewControllers objectAtIndex:2];
    
    //
    [self.naviItem setTitle: (NSString *)title1];
    [self setBarButton];
    
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    [[self.tabBar.items objectAtIndex:0] setTitle: (NSString *)title1];
    [[self.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"TAB_V"]];
    [[self.tabBar.items objectAtIndex:1] setTitle: (NSString *)title2];
    [[self.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"TAB_S"]];
    [[self.tabBar.items objectAtIndex:2] setTitle: (NSString *)title3];
    [[self.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"TAB_M"]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self setColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
- (void)viewWillDisappear:(BOOL)animated{
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"您真的要返回吗"
                                        message:@"您将丢失当前记录的比赛进度"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
 */

- (void)setStatisticDataSource{
    [self.vsGameStatisticsTableViewController setCurrentRoundNum:self.currentRoundNum];
    [self.vsGameStatisticsTableViewController setRoundNum:self.roundNum];
    [self.vsGameStatisticsTableViewController setRecordArr:
     [self.vsGameRecordTableViewController.allScoreArr objectAtIndex:self.currentRoundNum-1]
     ];
    [self.vsGameStatisticsTableViewController setTeamScore:[self.vsGameRecordTableViewController.teamScoreArr objectAtIndex:self.currentRoundNum-1]];
    [self.vsGameStatisticsTableViewController setOpponentScore:[self.vsGameRecordTableViewController.opponentScoreArr objectAtIndex:self.currentRoundNum-1]];
    [self.vsGameStatisticsTableViewController loadData];
}

- (void)setStatisticDetail{
    [self.vsStatisticsTableViewController setAllScoreArr:[[NSMutableArray alloc] initWithObjects:self.vsGameRecordTableViewController.allScoreArr, nil]];
}

- (void)setBarButton{
    
    self.currentRoundNum = self.vsGameRecordTableViewController.currentRoundNum;
    self.roundNum = self.vsGameRecordTableViewController.roundNum;

    UIBarButtonItem *R1;
    UIBarButtonItem *R2;
    if(self.currentRoundNum == 1){
        R1 = [[UIBarButtonItem alloc] initWithTitle:@"　　　"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(prevRoundAction:)];
        R2 = [[UIBarButtonItem alloc] initWithTitle:@"下一局"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(nextRoundAction:)];
    }else if(self.currentRoundNum == self.roundNum){
        R1 = [[UIBarButtonItem alloc] initWithTitle:@"上一局"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(prevRoundAction:)];
        R2 = [[UIBarButtonItem alloc] initWithTitle:@"　结束"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(nextRoundAction:)];
    }else{
        R1 = [[UIBarButtonItem alloc] initWithTitle:@"上一局"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(prevRoundAction:)];
        R2 = [[UIBarButtonItem alloc] initWithTitle:@"下一局"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(nextRoundAction:)];
    }
    
    self.naviItem.rightBarButtonItems = [NSArray arrayWithObjects:R2,R1,nil];
}

- (void)prevRoundAction:(id)sender{
    if(self.currentRoundNum == 1){
        
    }else{
//        self.currentRoundNum--;
        self.vsGameRecordTableViewController.currentRoundNum--;
        [self.vsGameRecordTableViewController refreshScoreLabel];
    }
    [self.vsGameRecordTableViewController setBarButtonLabel:self.vsGameRecordTableViewController.currentRoundNum];
    self.vsGameRecordTableViewController.scoreArr = [self.vsGameRecordTableViewController.allScoreArr objectAtIndex:self.vsGameRecordTableViewController.currentRoundNum-1];
    [self.vsGameRecordTableViewController.customTableView reloadData];
    
    [self setBarButton];
    [self setStatisticDataSource];
    
    self.vsGameRecordTableViewController.tmpGameRecord = [[GameRecord alloc] initWithMember:nil
                                                                                     inTeam:-1
                                                                                    andType:-1
                                                                                 andMyScore:0
                                                                           andOpponentScore:0];

}

- (void)nextRoundAction:(id)sender{
    if(self.currentRoundNum == self.roundNum){
        //FINISH GAME
        NSLog(@"Finish Game");
        [self.vsGameRecordTableViewController finishGame];
    }else{
//        self.currentRoundNum++;
        self.vsGameRecordTableViewController.currentRoundNum++;
        [self.vsGameRecordTableViewController refreshScoreLabel];
    }
    [self.vsGameRecordTableViewController setBarButtonLabel:self.vsGameRecordTableViewController.currentRoundNum];
    self.vsGameRecordTableViewController.scoreArr = [self.vsGameRecordTableViewController.allScoreArr objectAtIndex:self.vsGameRecordTableViewController.currentRoundNum-1];
    [self.vsGameRecordTableViewController.customTableView reloadData];
    
    [self setBarButton];
    [self setStatisticDataSource];
    
    self.vsGameRecordTableViewController.tmpGameRecord = [[GameRecord alloc] initWithMember:nil
                                                                                    inTeam:-1
                                                                                   andType:-1
                                                                                andMyScore:0
                                                                          andOpponentScore:0];
    
}

#pragma mark - UITabBarController Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    switch (self.selectedIndex) {
        case 0:
        {
            [self.naviItem setTitle: (NSString *)title1];
        }
            break;
        case 1:
        {
            [self.naviItem setTitle: (NSString *)title2];
            [self setStatisticDataSource];
        }
            break;
        case 2:
        {
            [self.naviItem setTitle: (NSString *)title3];
            [self setStatisticDetail];
        }
        default:
            break;
    }
}

- (void)setColor{
    UIColor *color = [Utilities getColor];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = color;
}

@end
