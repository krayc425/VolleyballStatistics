//
//  VSMemberAddTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSMemberAddTableViewController.h"
#import <CoreData/CoreData.h>
#import "MemberData.h"
#import "MemberManager.h"

@interface VSMemberAddTableViewController ()

@end

@implementation VSMemberAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameText.delegate = self;
    self.numberText.delegate = self;
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];

    [self clearAction];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideKeyboard{
    [self.nameText resignFirstResponder];
    [self.numberText resignFirstResponder];
}

- (void)clearAction{
    self.nameText.text = @"";
    self.numberText.text = @"";
    [self.nameText becomeFirstResponder];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addAction:(_Nonnull id)sender{
    if([self.numberText.text isEqual: @""] || [self.nameText.text isEqual: @""]){
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"错误"
                                            message:@"您未填满所有所需信息！"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
        if([MemberManager addMemberWithName:self.nameText.text andNum:[self.numberText.text intValue]]){
            //添加成功
            UIAlertController *alertController;
            alertController  = [UIAlertController alertControllerWithTitle:@"添加成功"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"返回"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action) {
                                                                   [self backAction];
                                                               }];
            [alertController addAction:backAction];
            UIAlertAction *againAction = [UIAlertAction actionWithTitle:@"继续添加"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    [self clearAction];
                                                                }];
            [alertController addAction:againAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            NSLog(@"Add error");
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL flag = NO;
    if(textField == self.nameText){
        [self.numberText becomeFirstResponder];
    }else{
        [self.numberText resignFirstResponder];
        flag = YES;
    }
    return flag;
}

@end
