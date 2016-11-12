//
//  MemberManager.m
//  VolleyballStatistics
//
//  Created by 宋 奎熹 on 2016/10/12.
//  Copyright © 2016年 宋 奎熹. All rights reserved.
//

#import "MemberManager.h"
#import "AppDelegate.h"
#import "Member+CoreDataClass.h"

@implementation MemberManager

+ (NSArray *)loadMembers{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member"
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *fetchResult = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (!fetchResult){
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    return fetchResult;
}

+ (Boolean)addMemberWithName:(NSString *)name andNum:(int)num{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Member *member = [NSEntityDescription insertNewObjectForEntityForName:@"Member"
                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    if(member != nil){
        member.name = name;
        member.number = num;
    }
    NSError *savingError = nil;
    if ([appDelegate.managedObjectContext save:&savingError]) {
        return true;
    }else{
        return false;
    }
}

+ (Boolean)deleteMemberWithName:(NSString *)name andNum:(int)num{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Member *member;
    member.name = name;
    member.number = num;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Member"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@ && number = %d", name, num];
    NSArray *result = [[appDelegate managedObjectContext] executeFetchRequest:request error:nil];
    for (Member *member in result) {
        [[appDelegate managedObjectContext] deleteObject:member];
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
