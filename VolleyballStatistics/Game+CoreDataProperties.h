//
//  Game+CoreDataProperties.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/14.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "Game+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *opponentName;
@property (nonatomic) int16_t opponentScore;
@property (nullable, nonatomic, retain) NSData *scoreData;
@property (nullable, nonatomic, copy) NSString *teamName;
@property (nonatomic) int16_t teamScore;

@end

NS_ASSUME_NONNULL_END
