//
//  VSGameRecordTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/13.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameRecordTableViewController.h"
#import "VSGameTableViewCell.h"
#import "MemberData.h"
#import "MLKMenuPopover.h"
#import "GameManager.h"
#import "GameRecord.h"
#import "MemberOpponent.h"
#import "Utilities.h"

#define TYPE_ARR [Utilities getType]
#define FONT_NAME [Utilities getFontName]

@interface VSGameRecordTableViewController () <MLKMenuPopoverDelegate>

@property (nonatomic,strong) MLKMenuPopover *_Nonnull menuPopover;
@property (nonatomic) CHOOSE_POSITION chooseItem;

@end

@implementation VSGameRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.allScoreArr = [[NSMutableArray alloc] initWithCapacity:self.roundNum];
//    for (int i = 0; i < self.roundNum; i++) {
//        [self.allScoreArr addObject:[[NSMutableArray alloc] initWithCapacity:1]];
//    }
//    self.scoreArr = [self.allScoreArr objectAtIndex:0];
//    
//    //大比分
//    self.teamScoreArr = [[NSMutableArray alloc] initWithCapacity:(self.roundNum)];
//    self.opponentScoreArr = [[NSMutableArray alloc] initWithCapacity:(self.roundNum)];
//    for (int i = 0; i < self.roundNum; i++) {
//        [self.teamScoreArr addObject:[NSNumber numberWithInt:0]];
//        [self.opponentScoreArr addObject:[NSNumber numberWithInt:0]];
//    }
    
    self.customTableView = (UITableView *)self.view;
    self.containerView = [[UIView alloc] initWithFrame:self.view.frame];
    self.customTableView.frame = self.customTableView.bounds;
    self.view = self.containerView;
    [self.containerView addSubview:self.customTableView];
    
    self.teamLabel.text = self.teamName;
    self.opponentLabel.text = self.opponent;
    
    self.teamScoreLabel.text = [NSString stringWithFormat:@"%d",[self.teamScoreArr[0] intValue]];
    self.opponentScoreLabel.text = [NSString stringWithFormat:@"%d",[self.opponentScoreArr[0] intValue]];

    
    //添加手势，点击屏幕其他区域关闭键盘的操作
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                              action:@selector(hideKeyboard)];
//    gesture.numberOfTapsRequired = 1;
//    [self.containerView addGestureRecognizer:gesture];
    
    self.tmpGameRecord = [[GameRecord alloc] initWithMember:nil
                                                     inTeam:-1
                                                    andType:-1
                                                 andMyScore:0
                                           andOpponentScore:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setBarButtonLabel:self.currentRoundNum];
    
    [self setFont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideKeyboard{
    VSGameTableViewCell *cell = (VSGameTableViewCell *)[self.tableView cellForRowAtIndexPath:self.tmpIndexPath];
    [cell.opponentNumberText resignFirstResponder];
}

- (void)doneAction{
    
//    NSLog(@"DONE");
    
    switch (self.tmpGameRecord.team) {
        case -1:
            return;
        case 0:
            if(self.tmpGameRecord.member == nil || self.tmpGameRecord.attackType == -1){
                return;
            }
        case 1:
            if(self.tmpGameRecord.attackType == -1){
                return;
            }else{
//                self.tmpGameRecord setMember:[[MemberData alloc] initWithName:@"" andNumber:
            }
        default:
        {
            //当前的 GR 加入数组
            [self.scoreArr addObject:self.tmpGameRecord];
            
            //设置大比分
            int ts = [[self.teamScoreArr objectAtIndex:self.currentRoundNum-1] intValue];
            int os = [[self.opponentScoreArr objectAtIndex:self.currentRoundNum-1] intValue];
            
            if(self.tmpGameRecord.team == 0){
                if(self.tmpGameRecord.attackType < [[Utilities getType] count] / 2){
                    [self.tmpGameRecord setTeamScore:ts+1];
                    [self.tmpGameRecord setOpponentScore:[[self.opponentScoreArr objectAtIndex:self.currentRoundNum-1] intValue]];
                }else{
                    [self.tmpGameRecord setOpponentScore:os+1];
                    [self.tmpGameRecord setTeamScore:[[self.teamScoreArr objectAtIndex:self.currentRoundNum-1] intValue]];
                }
            }else{
                if(self.tmpGameRecord.attackType < [[Utilities getType] count] / 2){
                    [self.tmpGameRecord setOpponentScore:os+1];
                    [self.tmpGameRecord setTeamScore:[[self.teamScoreArr objectAtIndex:self.currentRoundNum-1] intValue]];
                }else{
                    [self.tmpGameRecord setTeamScore:ts+1];
                    [self.tmpGameRecord setOpponentScore:[[self.opponentScoreArr objectAtIndex:self.currentRoundNum-1] intValue]];
                }
            }
            
            [self.teamScoreArr replaceObjectAtIndex:self.currentRoundNum-1
                                         withObject:[NSNumber numberWithInt:self.tmpGameRecord.teamScore]];
            [self.opponentScoreArr replaceObjectAtIndex:self.currentRoundNum-1
                                             withObject:[NSNumber numberWithInt:self.tmpGameRecord.opponentScore]];
            
            [self refreshScoreLabel];
            [self.customTableView reloadData];
            [self.tableView reloadData];
        }
            break;
    }
}

- (void)refreshScoreLabel{
    self.tmpGameRecord = [[GameRecord alloc] initWithMember:nil
                                                     inTeam:-1
                                                    andType:-1
                                                 andMyScore:0
                                           andOpponentScore:0];
    self.teamScoreLabel.text = [NSString stringWithFormat:@"%@",[self.teamScoreArr objectAtIndex:self.currentRoundNum-1]];
    self.opponentScoreLabel.text = [NSString stringWithFormat:@"%@",[self.opponentScoreArr objectAtIndex:self.currentRoundNum-1]];
}

- (void)finishGame{
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"结束比赛"
                                        message:@"确定要结束比赛?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定结束"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          int myscore = 0;
                                                          int opponentScore = 0;
                                                          for (int i = 0; i < self.roundNum; i++) {
                                                              int m = [[self.teamScoreArr objectAtIndex:i] intValue];
                                                              int n = [[self.opponentScoreArr objectAtIndex:i] intValue];
                                                              if(m > n){
                                                                  myscore++;
                                                              }else{
                                                                  opponentScore++;
                                                              }
                                                          }
                                                          
//                                                          NSLog(@"~~! %lu",(unsigned long)[self.allScoreArr count]);
                                                          
                                                          [GameManager addGame:self.teamName
                                                                   andOpponent:self.opponent
                                                                   withMyScore:myscore
                                                              andOpponentScore:opponentScore
                                                                  withScoreArr:self.allScoreArr];
                                                          
                                                          self.navigationController.toolbarHidden = YES;
                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                      }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setBarButtonLabel:(int)num{
    self.roundNumLabel.text = [NSString stringWithFormat:@"第 %d 局, 共 %d 局", num, self.roundNum];
}

#pragma mark - Choose Member and Type

- (void)chooseThings:(UITapGestureRecognizer *)gesture{
    
    //获得当前手势触发的在UITableView中的坐标
    CGPoint location = [gesture locationInView:self.customTableView];
    //获得当前坐标对应的indexPath
    self.tmpIndexPath = [self.customTableView indexPathForRowAtPoint:location];
    
    if(self.tmpIndexPath.row == [self.scoreArr count]){
    
        CGPoint p = [gesture locationInView:self.view];
        NSMutableArray *nameArr = [[NSMutableArray alloc] initWithCapacity:[self.memberArr count]];
        for(MemberData *m in self.memberArr){
            [nameArr addObject:[NSString stringWithFormat:@"%d - %@",m.number,m.name]];
        }
        [self.menuPopover dismissMenuPopover];
        
        int i = 0;
        if(p.x < self.view.center.x){
            i = 1;
        }else{
            i = -1;
        }
        
        VSGameTableViewCell *cell = [self.customTableView cellForRowAtIndexPath:self.tmpIndexPath];
        CGPoint q = [gesture locationInView:cell.stackView];
        
        NSArray *menuArr;
        if(CGRectContainsPoint(cell.teamMemberLabel.frame, q)){
            NSLog(@"CONTAINS LABEL");
            menuArr = nameArr;
            _chooseItem = TEAM_LABEL;
        }else if(CGRectContainsPoint(cell.teamTypeImageView.frame, q)){
            NSLog(@"CONTAINS IMG");
            menuArr = TYPE_ARR;
            _chooseItem = TEAM_IMG;
        }else if(CGRectContainsPoint(cell.opponentTypeImageView.frame, q)){
            NSLog(@"CONTAINS IMG 2");
            menuArr = TYPE_ARR;
            _chooseItem = OPPONENT_IMG;
        }
        
        if(menuArr){
            int height = 35;
            int width = 160;
            self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:CGRectMake(p.x,
                                                                                p.y + 10 + height * (menuArr.count) > self.view.center.y * 2 ? self.view.center.y * 2 - 10 - height * (menuArr.count) : p.y,
                                                                                i * width,
                                                                                height * menuArr.count)
                                                           menuItems:menuArr];
            self.menuPopover.menuPopoverDelegate = self;
            [self.menuPopover showInView:self.view];
        }
    }
    
}

#pragma mark - MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex{
    VSGameTableViewCell *cell = [self.customTableView cellForRowAtIndexPath:self.tmpIndexPath];
    //改成：更新数组，然后 reloadData。
    switch (_chooseItem) {
        case TEAM_LABEL:
            NSLog(@"choose label");
            [self.tmpGameRecord setTeam:0];
            [self.tmpGameRecord setMember:[self.memberArr objectAtIndex:selectedIndex]];
            cell.teamMemberLabel.text = [NSString stringWithFormat:@"%@",[[self.memberArr objectAtIndex:selectedIndex] name]];
            [cell.opponentTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
            cell.opponentNumberText.text = @"";
            break;
        case TEAM_IMG:
        {
            NSLog(@"choose img");
            [self.tmpGameRecord setTeam:0];
            [self.tmpGameRecord setAttackType:(int)selectedIndex];
            UIImage *img = [UIImage imageNamed:[Utilities getType][selectedIndex]];
            [cell.teamTypeImageView setImage:img];
            [cell.opponentTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
            cell.opponentNumberText.text = @"";
        }
            break;
        case OPPONENT_IMG:
        {
            NSLog(@"choose img2");
            [self.tmpGameRecord setTeam:1];
            [self.tmpGameRecord setAttackType:(int)selectedIndex];
            UIImage *img = [UIImage imageNamed:[Utilities getType][selectedIndex]];
            [cell.opponentTypeImageView setImage:img];
            [cell.teamTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
            cell.teamMemberLabel.text = @"";
        }
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return [self.scoreArr count] + 1;
        default:
            return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"VSGameTableViewCell";
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        VSGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        UITapGestureRecognizer *chooseMemberGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(chooseThings:)];
        chooseMemberGesture.numberOfTapsRequired = 1;
        [cell.contentView addGestureRecognizer:chooseMemberGesture];
        
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
                [cell.opponentNumberText setFont: [UIFont fontWithName:FONT_NAME size:20]];
                cell.teamMemberLabel.text = @"";
                cell.teamMemberLabel.userInteractionEnabled = NO;
            }else{
                
                //我方队员的姓名
                
                cell.teamMemberLabel.text = [NSString stringWithFormat:@"%@",[[[self.scoreArr objectAtIndex:indexPath.row] member] name]];
                [cell.teamMemberLabel setFont: [UIFont fontWithName:FONT_NAME size:20]];
                cell.teamMemberLabel.userInteractionEnabled = NO;
                cell.opponentNumberText.text = @"";
                cell.opponentNumberText.userInteractionEnabled = NO;
            }
        }else{
            cell.addButton.hidden = NO;
            UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(doneAction)];
            t.numberOfTapsRequired = 1;
            [cell.addButton addGestureRecognizer:t];
            
            cell.teamScoreLabel.text = self.teamScoreLabel.text;
            cell.opponentScoreLabel.text = self.opponentScoreLabel.text;
            
            cell.teamMemberLabel.text = @"选择队员";
            [cell.teamMemberLabel setFont: [UIFont fontWithName:FONT_NAME size:15]];
            cell.opponentNumberText.placeholder = @"输入号码";
            cell.opponentNumberText.delegate = self;
            [cell.opponentNumberText setFont: [UIFont fontWithName:FONT_NAME size:15]];
            [cell.teamTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
            [cell.opponentTypeImageView setImage:[UIImage imageNamed:@"DefaultVS"]];
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

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self.tmpGameRecord setMember:[[MemberData alloc] initWithName:@"" andNumber:[textField.text intValue]]];
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    [self.tmpGameRecord setMember:[[MemberData alloc] initWithName:@"" andNumber:[textField.text intValue]]];
//    
//    return true;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL flag = YES;
    [self.tmpGameRecord setMember:[[MemberData alloc] initWithName:@"" andNumber:[textField.text intValue]]];
    [textField resignFirstResponder];
    return flag;
}

- (void)setFont{
    [self.roundNumLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:20]];
    [self.teamScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:50]];
    [self.opponentScoreLabel setFont:[UIFont fontWithName:[Utilities getFontName] size:50]];
}
                                              
@end
