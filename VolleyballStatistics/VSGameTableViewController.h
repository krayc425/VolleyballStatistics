//
//  VSGameTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface VSGameTableViewController : UITableViewController

@property (nonnull, nonatomic, retain) AppDelegate *appDelegate;

//这个数组存的都是:VSGameRecordTVC 里面的 allScoreArr
@property (nonnull, nonatomic, strong) NSMutableArray *dataArr;

- (void)addAction:(_Nonnull id)sender;

@end
