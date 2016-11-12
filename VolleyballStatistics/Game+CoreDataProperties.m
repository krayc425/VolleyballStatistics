//
//  Game+CoreDataProperties.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "Game+CoreDataProperties.h"

@implementation Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Game"];
}

@dynamic date;
@dynamic opponentName;
@dynamic opponentScore;
@dynamic scoreData;
@dynamic teamName;
@dynamic teamScore;

@end
