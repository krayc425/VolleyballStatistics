//
//  VSGameBrowseTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/21.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameBrowseTableViewController.h"
#import "VSGameTableViewCell.h"
#import "Utilities.h"
#import "MemberData.h"
#import "MemberOpponent.h"
#import "GameRecord.h"

//#import "GameManager.h"

@interface VSGameBrowseTableViewController ()

@end

@implementation VSGameBrowseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)finishGame{
    self.navigationController.toolbarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return [self.scoreArr count];
        default:
            return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"VSGameTableViewCell";
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        VSGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        [cell.teamTypeImageView setTintColor:[Utilities getColor]];
        [cell.opponentTypeImageView setTintColor:[UIColor redColor]];
        
        if(indexPath.row < [self.scoreArr count]){
            
            cell.teamScoreLabel.text = [NSString stringWithFormat:@"%d",[[self.scoreArr objectAtIndex:indexPath.row] teamScore]];
            cell.opponentScoreLabel.text = [NSString stringWithFormat:@"%d",[[self.scoreArr objectAtIndex:indexPath.row] opponentScore]];
            
            cell.addButton.hidden = YES;
            
            int i = [[self.scoreArr objectAtIndex:indexPath.row] attackType];
            
            if([[self.scoreArr objectAtIndex:indexPath.row] team] == 0){
                [cell.teamTypeImageView setImage:[UIImage imageNamed:[Utilities getType][i]]];
                [cell.opponentTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
            }else{
                [cell.opponentTypeImageView setImage:[UIImage imageNamed:[Utilities getType][i]]];
                [cell.teamTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
            }
            
            if([[self.scoreArr objectAtIndex:indexPath.row] team] == 1){
                
                //opponent 的号码
                
                cell.opponentNumberText.text = [NSString stringWithFormat:@"%d",[[[self.scoreArr objectAtIndex:indexPath.row] member] number]];
                cell.opponentNumberText.userInteractionEnabled = NO;
                cell.teamMemberLabel.text = @"";
                
            }else{
                
                //我方队员的姓名
                
                cell.teamMemberLabel.text = [NSString stringWithFormat:@"%@",[[[self.scoreArr objectAtIndex:indexPath.row] member] name]];
                cell.opponentNumberText.text = @"";
            }
        }
        
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

@end
