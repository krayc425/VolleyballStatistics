//
//  GameManager.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "GameManager.h"
#import "AppDelegate.h"
#import "Game+CoreDataClass.h"

@implementation GameManager

+ (NSArray *)loadGames{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Game"
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *fetchResult = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (!fetchResult){
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    return fetchResult;
}

+ (Boolean)addGame:(NSString *)teamName andOpponent:(NSString *)opponentName withMyScore:(int)myScore andOpponentScore:(int)opponentScore withScoreArr:(NSArray *)scoreArr{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game"
                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    if(game != nil){
        game.teamName = teamName;
        game.opponentName = opponentName;
        game.teamScore = myScore;
        game.opponentScore = opponentScore;
        game.scoreData = [NSKeyedArchiver archivedDataWithRootObject:scoreArr];
        game.date = [NSDate date];
    }
    NSError *savingError = nil;
    if ([appDelegate.managedObjectContext save:&savingError]) {
        return true;
    }else{
        return false;
    }
}

+ (Boolean)deleteGameWithName:(NSString *)teamName andOpponent:(NSString *)opponentName withMyScore:(int)myScore andOpponentScore:(int)opponentScore{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Game *game;
    game.teamName = teamName;
    game.opponentName = opponentName;
    game.teamScore = myScore;
    game.opponentScore = opponentScore;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    request.predicate = [NSPredicate predicateWithFormat:@"teamName = %@ && opponentName = %@ && teamScore == %d && opponentScore == %d", teamName, opponentName, myScore, opponentScore];
    NSArray *result = [[appDelegate managedObjectContext] executeFetchRequest:request error:nil];
    for (Game *game in result) {
        [[appDelegate managedObjectContext] deleteObject:game];
        break;
    }
    NSError *savingError = nil;
    if ([[appDelegate managedObjectContext] save:&savingError]) {
        return true;
    } else {
        return false;
    }
}

@end
