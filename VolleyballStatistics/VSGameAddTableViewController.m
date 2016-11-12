//
//  VSGameAddTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameAddTableViewController.h"
#import "MemberManager.h"
#import "VSStatisticsTableViewCell.h"
#import "VSStatisticsTableViewController.h"
#import "VSMemberTableViewCell.h"
#import "MemberData.h"
#import "VSGameRecordTableViewController.h"
#import "VSGameRecordTabBarViewController.h"

@interface VSGameAddTableViewController ()

@end

@implementation VSGameAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedMemberArr = [[NSMutableArray alloc] init];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.dateLabel.text = dateString;
    
    self.teamNameText.delegate = self;
    self.opponentText.delegate = self;
    self.roundNumText.delegate = self;
    
    [self clearText];
}

- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideKeyboard{
    [self.teamNameText resignFirstResponder];
    [self.opponentText resignFirstResponder];
    [self.roundNumText resignFirstResponder];
}

- (void)loadData{
    self.memberArr = [[NSMutableArray alloc] init];
    NSArray *tm = [MemberManager loadMembers];
    for(Member *M in tm){
        [self.memberArr addObject:[[MemberData alloc] initWithName:M.name andNumber:M.number]];
    }
    
    [self.tableView reloadData];
}

- (void)clearText{
    NSString *tn = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"teamName"];
    if([tn isEqualToString:@""]){
        self.teamNameText.placeholder = @"键入我方队名";
    }else{
        self.teamNameText.text = tn;
    }
    self.opponentText.placeholder = @"键入对方队名";
    self.roundNumText.text = @"3";
}

- (IBAction)startGameAction:(id)sender{
    NSLog(@"Start Game");
    if([self.selectedMemberArr count] == 0){
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"您未选中任何队员"
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去选择"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if([self.teamNameText.text isEqualToString:@""]){
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"您未填写我方队名"
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去填写"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self.teamNameText becomeFirstResponder];
                                                         }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if([self.opponentText.text isEqualToString:@""]){
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"您未填写对方队名"
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去填写"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self.opponentText becomeFirstResponder];
                                                         }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"okSegue" sender:nil];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"okSegue"]){
        VSGameRecordTabBarViewController *vsgrtbvc = (VSGameRecordTabBarViewController *)[segue destinationViewController];
        
        vsgrtbvc.opponent = self.opponentText.text;
        vsgrtbvc.teamName = self.teamNameText.text;
        vsgrtbvc.roundNum = [self.roundNumText.text intValue];
        
        NSMutableArray *allScoreArr = [[NSMutableArray alloc] initWithCapacity:[self.roundNumText.text intValue]];
        for (int i = 0; i < [self.roundNumText.text intValue]; i++) {
            [allScoreArr addObject:[[NSMutableArray alloc] initWithCapacity:1]];
        }
        [vsgrtbvc setAllScoreArr: allScoreArr];
        
        //设置 memberArr
        VSGameRecordTableViewController *vsgrtvc = [[vsgrtbvc viewControllers] objectAtIndex:0];
        vsgrtvc.memberArr = [self.selectedMemberArr copy];
        
        VSStatisticsTableViewController *vsstvc = [[vsgrtbvc viewControllers] objectAtIndex:2];
        [vsstvc setMemberArr:[self.selectedMemberArr copy]];
    }
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
            return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            switch (indexPath.row) {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    break;
                default:
                    break;
            }
            break;
        case 1:
            if([self.selectedMemberArr containsObject:[self.memberArr objectAtIndex:indexPath.row]]){
                [self.selectedMemberArr removeObject:[self.memberArr objectAtIndex:indexPath.row]];
            }else{
                [self.selectedMemberArr addObject:[self.memberArr objectAtIndex:indexPath.row]];
            }
            [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"VSMemberTableViewCell";
        UINib *nib = [UINib nibWithNibName:@"VSMemberTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        VSMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //设置名字标签
        MemberData *member = [self.memberArr objectAtIndex:indexPath.row];
        cell.nameLabel.text = member.name;
        cell.numberLabel.text = [NSString stringWithFormat:@"%d", member.number];
        //设置可以选中
        if ([self.selectedMemberArr containsObject:member]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL flag = NO;
    if(textField == self.teamNameText){
        [self.opponentText becomeFirstResponder];
    }else if(textField == self.opponentText){
        [self.roundNumText becomeFirstResponder];
    }else{
        [self.roundNumText resignFirstResponder];
        flag = YES;
    }
    return flag;
}


@end
