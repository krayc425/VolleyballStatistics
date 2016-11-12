//
//  AppDelegate.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/11.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//上下文对象
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//导入上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *importObjectContext;
//数据模型
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//协调者
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//在应用程序终止的时候会调用该方法
- (void)saveContext;
//得到应用程序的 Documents 路径, 将数据库存在此目录下
- (NSURL *)applicationDocumentsDirectory;

@end

