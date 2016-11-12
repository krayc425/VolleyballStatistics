//
//  VSGameAddTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSGameAddTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonnull, nonatomic) NSMutableArray *memberArr;
@property (nonnull, nonatomic) NSMutableArray *selectedMemberArr;
@property (nonatomic) int roundNum;

@property (nonnull, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonnull, nonatomic) IBOutlet UITextField *teamNameText;
@property (nonnull, nonatomic) IBOutlet UITextField *opponentText;
@property (nonnull, nonatomic) IBOutlet UITextField *roundNumText;

- (IBAction)startGameAction:(_Nonnull id)sender;
    
@end
