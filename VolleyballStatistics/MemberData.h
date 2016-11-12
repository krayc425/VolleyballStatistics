//
//  MemberData.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/21.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "Member+CoreDataClass.h"

@interface MemberData : NSObject <NSCoding>

@property (nonnull) NSString *name;
@property int16_t number;

- (_Nonnull instancetype)initWithName:(NSString *_Nonnull)name andNumber:(int)num;

@end
