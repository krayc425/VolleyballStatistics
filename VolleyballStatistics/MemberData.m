//
//  MemberData.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/21.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "MemberData.h"

@implementation MemberData

- (instancetype)initWithName:(NSString *)name andNumber:(int)num{
    
    self.name = name;
    self.number = num;
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder{
    [coder encodeObject:self.name forKey:@"memberName"];
    [coder encodeInteger:self.number forKey:@"memberNumber"];
}

- (id)initWithCoder: (NSCoder *)coder{
    self.number = [coder decodeIntegerForKey:@"memberNumber"];
    self.name = [coder decodeObjectForKey:@"memberName"];
    return self;
}

@end
