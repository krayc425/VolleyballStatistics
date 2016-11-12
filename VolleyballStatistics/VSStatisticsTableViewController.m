//
//  VSStatisticsTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSStatisticsTableViewController.h"
#import "VSStatisticsTableViewCell.h"
#import "MemberManager.h"
#import "GameManager.h"
#import "GameRecord.h"
#import "MemberData.h"
#import "Game+CoreDataClass.h"
#import "Member+CoreDataClass.h"
#import "Utilities.h"

@interface VSStatisticsTableViewController (){
    int scoreOrLose;
    int typeCount;
}

@end

@implementation VSStatisticsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.segmentControl addTarget:self
                            action:@selector(segmentAction:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated{
    scoreOrLose = 0;
    typeCount = (int)[[Utilities getType] count] / 2;
    [self setImage];
    
    [self.segmentControl setSelectedSegmentIndex:0];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setImage{
    for(int j = 0; j < typeCount; j++){
        UIImageView *img = self.stackView.subviews[j];
        [img setImage: [UIImage imageNamed:[Utilities getType][j + typeCount * scoreOrLose]]];
    }
}

- (void)loadData{
    
    self.statisticsArr = [[NSMutableArray alloc] initWithCapacity:[self.memberArr count]];
    for(int i = 0; i < [self.memberArr count]; i++){
        [self.statisticsArr addObject:[[NSMutableArray alloc] init]];
        
        for(int j = 0; j < typeCount; j++){
            [self.statisticsArr[i] addObject:[NSNumber numberWithInt:0]];
        }
        
    }
    
    for(NSArray *sarr in self.allScoreArr){
        for(NSArray *scarr in sarr){
            for(GameRecord *gr in scarr){
                if(gr.team == 0){
                    //直接加
                    int i = -1;
                    for(Member *mem in self.memberArr){
                        if([mem.name isEqualToString:[[gr member] name]] && mem.number == [[gr member] number]){
                            i = (int)[self.memberArr indexOfObject:mem];
                            break;
                        }
                    }
                    if(i != -1){
                        int atype = [gr attackType];
                        if(atype >= typeCount * scoreOrLose && atype < typeCount * (1 + scoreOrLose)){
                            int n = [[self.statisticsArr[i] objectAtIndex:atype - typeCount * scoreOrLose] intValue];
                            n++;
                            [self.statisticsArr[i] replaceObjectAtIndex:atype - typeCount * scoreOrLose withObject:[NSNumber numberWithInt:n]];
                        }
                    }
                }
            }
        }
    }

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return [self.memberArr count];
        default:
            return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        //注册 nib 的方法，来使用.xib 的cell
        static NSString *CellIdentifier = @"VSStatisticsTableViewCell";
        UINib *nib = [UINib nibWithNibName:@"VSStatisticsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        VSStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        Member *member = [self.memberArr objectAtIndex:indexPath.row];
        cell.nameLabel.text = member.name;
        
        for(int j = 0; j < typeCount; j++){
            UILabel *label = [cell.stackView.subviews objectAtIndex:j];
            label.text = [NSString stringWithFormat:@"%d",[[[self.statisticsArr objectAtIndex:indexPath.row] objectAtIndex:j] intValue]];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    switch (indexPath.section) {
//        case 0:
//            switch (indexPath.row) {
//                case 0:
//                    NSLog(@"se");
//                    break;
//                default:
//                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//                    break;
//            }
//            break;
//        default:
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            break;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 10;
    }else{
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
}

#pragma mark - UISegmentControl Delegate

-(void)segmentAction:(UISegmentedControl *)Seg{
    scoreOrLose = (int)Seg.selectedSegmentIndex;
    [self setImage];
    [self loadData];
}

@end
