//
//  GameManager.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

+ (NSArray *)loadGames;
+ (Boolean)addGame:(NSString *)teamName andOpponent:(NSString *)opponentName withMyScore:(int)myScore andOpponentScore:(int)opponentScore withScoreArr:(NSArray *)scoreArr;
+ (Boolean)deleteGameWithName:(NSString *)teamName andOpponent:(NSString *)opponentName withMyScore:(int)myScore andOpponentScore:(int)opponentScore;

@end
