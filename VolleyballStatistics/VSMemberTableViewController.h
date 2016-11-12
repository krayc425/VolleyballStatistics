//
//  VSMemberTableViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface VSMemberTableViewController : UITableViewController

@property (nonnull, nonatomic, retain) AppDelegate *appDelegate;

@property (nonnull, nonatomic, strong) NSMutableArray *dataArr;

@property (nonnull, nonatomic) IBOutlet UINavigationItem *memberNaviItem;

- (void)addAction:(_Nonnull id)sender;

@end
