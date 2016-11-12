//
//  VSGameStatisticsTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/18.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameStatisticsTableViewController.h"
#import "VSGameStatisticsTableViewCell.h"
#import "Utilities.h"
#import "GameRecord.h"

@interface VSGameStatisticsTableViewController ()

@end

@implementation VSGameStatisticsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.teamNameLabel.text = self.teamName;
    self.opponentNameLabel.text = self.opponent;
    self.teamScoreLabel.text = @"0";
    self.opponentScoreLabel.text = @"0";
    
    self.itemArr = [[NSMutableArray alloc] initWithArray:[Utilities getType]];
    self.recordArr = [[NSMutableArray alloc] init];
    
    self.teamDataArr = [[NSMutableArray alloc] initWithCapacity:[self.itemArr count]];
    self.opponentDataArr = [[NSMutableArray alloc] initWithCapacity:[self.itemArr count]];
}

- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
    
    [self setFont];
}

- (void)setBarButtonLabel:(int)num{
    self.roundNumLabel.text = [NSString stringWithFormat:@"第 %d 局, 共 %d 局", num, self.roundNum];
}

- (void)loadData{
    [self setBarButtonLabel:self.currentRoundNum];
    self.teamScoreLabel.text = [NSString stringWithFormat:@"%d",[self.teamScore intValue]];
    self.opponentScoreLabel.text = [NSString stringWithFormat:@"%d",[self.opponentScore intValue]];
    
    [self.teamDataArr removeAllObjects];
    [self.opponentDataArr removeAllObjects];
    for (int i = 0; i < [self.itemArr count]; i++) {
        [self.teamDataArr addObject:[NSNumber numberWithInt:0]];
        [self.opponentDataArr addObject:[NSNumber numberWithInt:0]];
    }
    for(GameRecord *record in self.recordArr){
        if([record team] == 0){
            NSNumber *num = [self.teamDataArr objectAtIndex:[record attackType]];
            int n = [num intValue];
            n++;
            [self.teamDataArr replaceObjectAtIndex:[record attackType]
                                        withObject:[NSNumber numberWithInt:n]];
        }else{
            NSNumber *num = [self.opponentDataArr objectAtIndex:[record attackType]];
            int n = [num intValue];
            n++;
            [self.opponentDataArr replaceObjectAtIndex:[record attackType]
                                            withObject:[NSNumber numberWithInt:n]];
        }
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return [self.itemArr count];
            break;
        default:
            return [super tableView:tableView numberOfRowsInSection:section];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"VSGameStatisticsTableViewCell";
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        VSGameStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.itemNameLabel.text = [self.itemArr objectAtIndex:indexPath.row];
        
        cell.teamNumberLabel.text = [NSString stringWithFormat:@"%d",[[self.teamDataArr objectAtIndex:indexPath.row] intValue]];
        cell.opponentNumberLabel.text = [NSString stringWithFormat:@"%d",[[self.opponentDataArr objectAtIndex:indexPath.row] intValue]];
        
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 10;
    }else{
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
}

- (void)setFont{
    [self.roundNumLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
    [self.teamScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:50]];
    [self.opponentScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:50]];
}

@end
