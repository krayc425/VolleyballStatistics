//
//  VSTabBarViewController.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSGameTableViewController;
@class VSStatisticsTableViewController;
@class VSMemberTableViewController;
@class VSSettingsTableViewController;

@interface VSTabBarViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonnull, nonatomic) IBOutlet UINavigationItem *naviItem;

@property (nonnull) VSGameTableViewController *vsGameTableViewController;
@property (nonnull) VSStatisticsTableViewController *vsStatisticsTableViewController;
@property (nonnull) VSMemberTableViewController *vsMemberTableViewController;
@property (nonnull) VSSettingsTableViewController *vsSettingsTableViewController;

@end
