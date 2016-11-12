//
//  Member+CoreDataProperties.h
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "Member+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Member (CoreDataProperties)

+ (NSFetchRequest<Member *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t number;

@end

NS_ASSUME_NONNULL_END
