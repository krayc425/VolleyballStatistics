//
//  MemberManager.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberManager : NSObject

+ (NSArray *)loadMembers;
+ (Boolean)addMemberWithName:(NSString *)name andNum:(int)num;
+ (Boolean)deleteMemberWithName:(NSString *)name andNum:(int)num;

@end
