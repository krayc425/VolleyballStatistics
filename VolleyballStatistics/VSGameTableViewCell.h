//
//  VSGameTableViewCell.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

//VSGame(Record)TableViewCell

#import <UIKit/UIKit.h>

@interface VSGameTableViewCell : UITableViewCell

//@property (nonnull, nonatomic) IBOutlet UILabel *roundNumLabel;

@property (nonnull, nonatomic) IBOutlet UIStackView *stackView;

@property (nonnull, nonatomic) IBOutlet UILabel *teamMemberLabel;
@property (nonnull, nonatomic) IBOutlet UIImageView *teamTypeImageView;
@property (nonnull, nonatomic) IBOutlet UIImageView *opponentTypeImageView;
@property (nonnull, nonatomic) IBOutlet UITextField *opponentNumberText;
@property (nonnull, nonatomic) IBOutlet UILabel *teamScoreLabel;
@property (nonnull, nonatomic) IBOutlet UILabel *opponentScoreLabel;
@property (nonnull, nonatomic) IBOutlet UIButton *addButton;

@property (nonnull, nonatomic) IBOutlet UIStackView *subStackView;

@property (nonnull, nonatomic) NSString *teamMember;

//@property (nonnull, nonatomic) NSArray *memberArr;

@end
