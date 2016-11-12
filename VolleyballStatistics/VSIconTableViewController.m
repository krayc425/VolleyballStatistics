//
//  VSIconTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/23.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSIconTableViewController.h"
#import "VSIconTableViewCell.h"
#import "Utilities.h"

@interface VSIconTableViewController ()

@end

@implementation VSIconTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeArr = [Utilities getType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.typeArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strCell = @"VSIconTableViewCell";
    VSIconTableViewCell *cell = (VSIconTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VSIconTableViewCell"
                                              owner:self
                                            options:nil] lastObject];
    }
    
    [cell.imgView setImage:[UIImage imageNamed:self.typeArr[indexPath.row]]];
    [cell.label setText:self.typeArr[indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"图标含义";
    }else{
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
