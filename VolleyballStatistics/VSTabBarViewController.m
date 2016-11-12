//
//  VSTabBarViewController.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "VSTabBarViewController.h"
#import "VSStatisticsTableViewController.h"
#import "Utilities.h"
#import "GameManager.h"
#import "Game+CoreDataClass.h"
#import "MemberManager.h"

@interface VSTabBarViewController ()

@end

@implementation VSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     NSArray *fontFamilies = [UIFont familyNames];
     for (int i = 0; i < [fontFamilies count]; i++){
     NSString *fontFamily = [fontFamilies objectAtIndex:i];
     NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
     NSLog (@"%@: %@", fontFamily, fontNames);
     }
     */
    
    self.delegate = self;
    [self.naviItem setTitle:@"比赛"];
    //设置底下 item
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    [[self.tabBar.items objectAtIndex:0] setTitle:@"比赛"];
    [[self.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"TAB_V"]];
    [[self.tabBar.items objectAtIndex:1] setTitle:@"统计"];
    [[self.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"TAB_S"]];
    [[self.tabBar.items objectAtIndex:2] setTitle:@"队员"];
    [[self.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"TAB_M"]];
    [[self.tabBar.items objectAtIndex:3] setTitle:@"设置"];
    [[self.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"TAB_SE"]];
    
    self.vsGameTableViewController = (VSGameTableViewController *)[self.viewControllers objectAtIndex:0];
    self.vsStatisticsTableViewController = (VSStatisticsTableViewController *)[self.viewControllers objectAtIndex:1];
    self.vsMemberTableViewController = (VSMemberTableViewController *)[self.viewControllers objectAtIndex:2];
    self.vsSettingsTableViewController = (VSSettingsTableViewController *)[self.viewControllers objectAtIndex:3];
    
    UIBarButtonItem *R1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                        target:self.vsGameTableViewController
                                                                        action:@selector(addAction:)];
    self.naviItem.rightBarButtonItems = [NSArray arrayWithObjects:R1,nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self setHomepageStatisticData];
    [self setColor];
}

- (void)setHomepageStatisticData{
    NSMutableArray *scoreArr = [[NSMutableArray alloc] init];
    for(Game *game in [GameManager loadGames]){
        [scoreArr addObject:[NSKeyedUnarchiver unarchiveObjectWithData:game.scoreData]];
    }
    [self.vsStatisticsTableViewController setMemberArr:(NSMutableArray *)[MemberManager loadMembers]];
    [self.vsStatisticsTableViewController setAllScoreArr:scoreArr];
}

#pragma mark - UITabBarController Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    switch (self.selectedIndex) {
        case 0:
        {
            [self.naviItem setTitle:@"比赛"];
            UIBarButtonItem *R1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self.vsGameTableViewController
                                                                                action:@selector(addAction:)];
            self.naviItem.rightBarButtonItems = [NSArray arrayWithObjects:R1,nil];
        }
            break;
        case 1:
        {
            [self.naviItem setTitle:@"统计"];
            self.naviItem.rightBarButtonItems = nil;
            [self setHomepageStatisticData];
        }
            break;
        case 2:
        {
            [self.naviItem setTitle:@"队员"];
            UIBarButtonItem *R1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self.vsMemberTableViewController
                                                                                action:@selector(addAction:)];
            self.naviItem.rightBarButtonItems = [NSArray arrayWithObjects:R1,nil];
        }
            break;
        case 3:
        {
            [self.naviItem setTitle:@"设置"];
            self.naviItem.rightBarButtonItems = nil;
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setColor{
    UIColor *color = [Utilities getColor];
    
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = color;
}

@end
