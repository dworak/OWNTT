//
//  NSManagedObject+Fetch.h
//  Expenses
//
//  Created by Kaszuba Maciej on 08/04/14.
//  Copyright (c) 2014 Company. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Fetch)
+ (id)fetchEntityOfClass:(Class)entityClass withPredicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext*)context;
+ (id)fetchEntityOfClass:(Class)entityClass withURI:(NSURL *)uri inContext:(NSManagedObjectContext *)context;
+ (NSArray*)fetchEntitiesOfClass:(Class)entityClass withPredicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext*)context;
+ (NSArray*)fetchEntitiesOfClass:(Class)entityClass withPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext*)context;
+ (NSArray*)fetchEntitiesOfClass:(Class)entityClass inContext:(NSManagedObjectContext*)context;

@end
