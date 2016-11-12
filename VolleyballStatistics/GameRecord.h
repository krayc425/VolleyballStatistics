//
//  GameRecord.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MemberData;

@interface GameRecord : NSObject <NSCoding>

@property (nonatomic) int team;
@property (nonatomic) MemberData *member;
@property (nonatomic) int attackType;
@property (nonatomic) int teamScore;
@property (nonatomic) int opponentScore;

- (instancetype)initWithMember:(MemberData *)member inTeam:(int)team andType:(int)type andMyScore:(int)teamScore andOpponentScore:(int)opponentScore;

@end
