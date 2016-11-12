//
//  VSMemberAddTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSMemberAddTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonnull, nonatomic) IBOutlet UITextField *nameText;
@property (nonnull, nonatomic) IBOutlet UITextField *numberText;

- (IBAction)addAction:(_Nonnull id)sender;

@end
