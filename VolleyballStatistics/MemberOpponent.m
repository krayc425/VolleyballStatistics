//
//  MemberOpponent.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/15.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "MemberOpponent.h"

@implementation MemberOpponent

- (instancetype)initWithNum:(int)num{
    self = [super init];
    if (self) {
        self.name = @"";
        self.number = num;
    }
    return self;
}

@end
