//
//  GameRecord.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "GameRecord.h"

@implementation GameRecord

- (instancetype)initWithMember:(MemberData *)member inTeam:(int)team andType:(int)type andMyScore:(int)teamScore andOpponentScore:(int)opponentScore{
    self.team = team;
    self.attackType = type;
    self.member = member;
    self.teamScore = teamScore;
    self.opponentScore = opponentScore;
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder{
    [coder encodeObject:self.member forKey:@"member"];
    [coder encodeInteger:self.team forKey:@"team"];
    [coder encodeInteger:self.attackType forKey:@"type"];
    [coder encodeInteger:self.teamScore forKey:@"teamScore"];
    [coder encodeInteger:self.opponentScore forKey:@"opponentScore"];
}

- (id)initWithCoder: (NSCoder *) coder{
    self.team = (int)[coder decodeIntegerForKey:@"team"];
    self.attackType = (int)[coder decodeIntegerForKey:@"type"];
    self.teamScore = (int)[coder decodeIntegerForKey:@"teamScore"];
    self.opponentScore = (int)[coder decodeIntegerForKey:@"opponentScore"];
    self.member = [coder decodeObjectForKey:@"member"];
    return self;
}

@end
