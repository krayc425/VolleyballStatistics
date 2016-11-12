//
//  VSGameBrowseTabBarViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/21.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSGameRecordTabBarViewController.h"
#import "VSGameBrowseTableViewController.h"
#import "VSGameStatisticsTableViewController.h"

@interface VSGameBrowseTabBarViewController : VSGameRecordTabBarViewController <UITabBarControllerDelegate>

@property (nonnull) VSGameBrowseTableViewController *vsGameBrowseTableViewController;

@end
