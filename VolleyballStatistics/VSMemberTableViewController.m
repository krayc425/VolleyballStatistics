//
//  VSMemberTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSMemberTableViewController.h"
#import "VSMemberTableViewCell.h"
#import "AppDelegate.h"
#import "MemberData.h"
#import "MemberManager.h"

@interface VSMemberTableViewController ()

@end

@implementation VSMemberTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.dataArr = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadData{
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[MemberManager loadMembers]];
    [self.tableView reloadData];
}

- (void)addAction:(id)sender{
    NSLog(@"Add Member");
    [self performSegueWithIdentifier:@"addSegue" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"";
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //注册 nib 的方法，来使用.xib 的 cell
    static NSString *CellIdentifier = @"VSMemberTableViewCell";
    UINib *nib = [UINib nibWithNibName:@"VSMemberTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    VSMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MemberData *member = [self.dataArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = member.name;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", member.number];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        VSMemberTableViewCell *cell = (VSMemberTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if([MemberManager deleteMemberWithName:cell.nameLabel.text andNum:[cell.numberLabel.text intValue]]){
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"addSegue"]){
        
    }
}

@end
