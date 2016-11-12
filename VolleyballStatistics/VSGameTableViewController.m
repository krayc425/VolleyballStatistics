//
//  VSGameTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameTableViewController.h"
#import "VSGameInfoTableViewCell.h"
#import "GameManager.h"
#import "Utilities.h"
#import "Game+CoreDataClass.h"
#import "VSGameRecordTabBarViewController.h"

#import "VSGameBrowseTabBarViewController.h"

@interface VSGameTableViewController ()

@end

@implementation VSGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.dataArr = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
//    [self setColor];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [self loadData];
}

- (void)loadData{
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[GameManager loadGames]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addAction:(id)sender{
    NSLog(@"Add Game");
    [self performSegueWithIdentifier:@"addSegue" sender:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strCell = @"VSGameInfoTableViewCell";
    VSGameInfoTableViewCell *cell = (VSGameInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VSGameInfoTableViewCell"
                                              owner:self
                                            options:nil] lastObject];
    }
    Game *game = [self.dataArr objectAtIndex:indexPath.row];
    //设置日期标签
    NSDate *currentDate = game.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    cell.dateLabel.text = [dateFormatter stringFromDate:currentDate];
    //设置队名标签
    cell.teamNameLabel.text = game.teamName;
    cell.opponentLabel.text = game.opponentName;
    //设置比分标签
    cell.teamScoreLabel.text = [NSString stringWithFormat:@"%d",game.teamScore];
    cell.opponentScoreLabel.text = [NSString stringWithFormat:@"%d",game.opponentScore];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"";
        default:
            return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"browseSegue" sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        VSGameInfoTableViewCell *cell = (VSGameInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if([GameManager deleteGameWithName:cell.teamNameLabel.text
                               andOpponent:cell.opponentLabel.text
                               withMyScore:[cell.teamScoreLabel.text intValue]
                          andOpponentScore:[cell.opponentScoreLabel.text intValue]]){
            [self.dataArr removeObjectAtIndex:indexPath.row];
            //删除UITableView中的一行
            [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];
        }else{
            NSLog(@"Delete error");
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"browseSegue"]){
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        Game *game = [self.dataArr objectAtIndex:indexPath.row];
        VSGameBrowseTabBarViewController *vsgrtbvc = (VSGameBrowseTabBarViewController *)[segue destinationViewController];
        
        [vsgrtbvc setTeamName:[game teamName]];
        [vsgrtbvc setOpponent:[game opponentName]];
        [vsgrtbvc setRoundNum:[game teamScore] + [game opponentScore]];
        [vsgrtbvc setCurrentRoundNum:1];
        NSArray *allScoreArr = [NSKeyedUnarchiver unarchiveObjectWithData:[game scoreData]];
        [vsgrtbvc setAllScoreArr:[NSMutableArray arrayWithArray:allScoreArr]];
    }
}

@end
