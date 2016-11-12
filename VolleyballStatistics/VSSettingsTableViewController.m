//
//  VSSettingsTableViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSSettingsTableViewController.h"

@interface VSSettingsTableViewController ()

@end

@implementation VSSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置版本号
    self.versionLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    self.teamNameLabel.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"teamName"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)teamName{
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"键入球队名称"
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         UITextField *nameText = alertController.textFields.firstObject;
                                                         self.teamNameLabel.text = nameText.text;
                                                         [[NSUserDefaults standardUserDefaults] setObject:nameText.text
                                                                                                   forKey:@"teamName"];
                                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                                         [self.tableView reloadData];
                                                     }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 2;
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"球队";
        case 1:
            return @"信息";
        case 2:
            return @"其他";
        default:
            return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据不同的section 作出调整
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                    //球队名称
                case 0:
                    [self teamName];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            [self performSegueWithIdentifier:@"iconSegue" sender:nil];
            break;
        case 2:
            switch (indexPath.row) {
                    //提交 bug
                case 0:
                    [self sendBugEmail];
                    break;
                default:
                    break;
            }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@""]){
        
    }
}

#pragma mark - Send Email

- (void)sendBugEmail{
    if(![MFMailComposeViewController canSendMail]){
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"错误"
                                            message:@"不能发送邮件，请前往设置->邮件添加邮箱"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    MFMailComposeViewController *wMailViewController = [[MFMailComposeViewController alloc] init];
    wMailViewController.mailComposeDelegate = self;
    
    NSString *title = [NSString stringWithFormat:@"排球技术统计 Feedbacks"];
    [wMailViewController setSubject:title];
    
    [wMailViewController setToRecipients:[NSArray arrayWithObject:@"krayc@foxmail.com"]];
    
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSString *phoneModel  = [[UIDevice currentDevice] model];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString *emailBody = [NSMutableString stringWithFormat:@"排球技术统计\n\nBug提交:\n\n意见或建议:\n\n您的大名:\n\n"];
    emailBody = [emailBody stringByAppendingString: @"Phone Model:"];
    emailBody = [emailBody stringByAppendingString: phoneModel.description];
    emailBody = [emailBody stringByAppendingString: @"\niOS Version:"];
    emailBody = [emailBody stringByAppendingString: phoneVersion.description];
    emailBody = [emailBody stringByAppendingString: @"\nApp Version:"];
    emailBody = [emailBody stringByAppendingString: appVersion.description];
    
    [wMailViewController setMessageBody:emailBody isHTML:NO];
    [self presentViewController:wMailViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSString *msg;
    NSString *tle;
    BOOL flag = false;;
    switch (result) {
        case MFMailComposeResultSent:
            flag = true;
            tle = @"谢谢";
            msg = @"发送成功！感谢您的反馈！";
            break;
        case MFMailComposeResultSaved:
            flag = true;
            msg = @"您保存了这封邮件的草稿";
            break;
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultFailed:
            flag = true;
            tle = @"失败";
            msg = @"非常抱歉！发送失败！";
            break;
    }
    if(flag){
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:tle
                                            message:msg
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
