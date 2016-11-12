//
//  Utilities.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (UIColor *)getColor{
    return [UIColor colorWithRed:29.0/255.0 green:170.0/255.0 blue:252.0/255.0 alpha:1.0];
}

+ (NSArray *)getType{
    return [[NSArray alloc] initWithObjects:
            @"发球得分",
            @"吊球得分",
            @"拦网得分",
            @"反击拦网得分",
            @"扣球得分",
            @"反击扣球得分",
            @"后排进攻得分",
            @"反击后排进攻得分",
            @"防守得分",
            @"发球失误",
            @"吊球失误",
            @"拦网失误",
            @"反击拦网失误",
            @"扣球失误",
            @"反击扣球失误",
            @"后排进攻失误",
            @"反击后排进攻失误",
            @"防守失误",
            nil];
}

+ (NSString *)getFontName{
    return @"IowanOldStyle-Roman";
}

@end
