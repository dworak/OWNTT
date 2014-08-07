//
//  NSManagedObject+Fetch.m
//  Expenses
//
//  Created by Kaszuba Maciej on 08/04/14.
//  Copyright (c) 2014 Company. All rights reserved.
//

#import "NSManagedObject+Fetch.h"
#import <LM/LMCoreDataManager.h>

@implementation NSManagedObject (Fetch)
+ (id)fetchActiveEntityOfClass:(Class)entityClass withObjectID:(NSNumber *)objectId inContext:(NSManagedObjectContext*)context
{
    NSMutableArray *predicates = [NSMutableArray new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@", objectId];
    [predicates addObject:predicate];
    predicate = [NSPredicate predicateWithFormat:@"active=YES"];
    [predicates addObject:predicate];
    predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    NSArray* results = [self fetchEntitiesOfClass:entityClass withPredicate:predicate sortDescriptors:nil inContext:context];
    
    assert(results.count <= 1);
    
    if (results.count == 0)
    {
        return nil;
    }
    else
    {
        return [results objectAtIndex:0];
    }
}

+ (id)fetchEntityOfClass:(Class)entityClass withObjectID:(NSNumber *)objectId inContext:(NSManagedObjectContext*)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@", objectId];
    NSArray* results = [self fetchEntitiesOfClass:entityClass withPredicate:predicate sortDescriptors:nil inContext:context];
    
    assert(results.count <= 1);
    
    if (results.count == 0)
    {
        return nil;
    }
    else
    {
        return [results objectAtIndex:0];
    }
}

+ (id)fetchEntityOfClass:(Class)entityClass withPredicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext*)context
{
    NSArray* results = [self fetchEntitiesOfClass:entityClass withPredicate:predicate sortDescriptors:nil inContext:context];
    
    assert(results.count <= 1);
    
    if (results.count == 0)
    {
        return nil;
    }
    else
    {
        return [results objectAtIndex:0];
    }
}

+ (id)fetchEntityOfClass:(Class)entityClass withURI:(NSURL *)uri inContext:(NSManagedObjectContext *)context {
    return [LMCoreDataManager getRowWithURI:uri inContext:context];
}

+ (NSArray*)fetchEntitiesOfClass:(Class)entityClass withPredicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext*)context {
    return [LMCoreDataManager getRowsFromEntity:[self class] withPredicate:predicate andSortDescriptors:nil fromRow:-1 maxCount:-1 inContext:context];
}

+ (NSArray*)fetchEntitiesOfClass:(Class)entityClass withPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext*)context
{
    return [LMCoreDataManager getRowsFromEntity:entityClass withPredicate:predicate andSortDescriptors:sortDescriptors fromRow:-1 maxCount:-1 inContext:context];
}

+ (NSArray*)fetchEntitiesOfClass:(Class)entityClass inContext:(NSManagedObjectContext*)context
{
    return [LMCoreDataManager getRowsFromEntity:entityClass inContext:context];
}

+ (NSArray *)fetchActiveEntityOfClass:(Class)entityClass inContext:(NSManagedObjectContext*)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"active=YES"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [LMCoreDataManager getRowsFromEntity:entityClass withPredicate:predicate andSortDescriptors:[NSArray arrayWithObject:sortDescriptor] fromRow:-1 maxCount:-1 inContext:context];
}


@end
