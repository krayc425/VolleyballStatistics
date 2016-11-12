//
//  Member+CoreDataProperties.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "Member+CoreDataProperties.h"

@implementation Member (CoreDataProperties)

+ (NSFetchRequest<Member *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Member"];
}

@dynamic name;
@dynamic number;

@end
