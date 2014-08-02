//
//  ManagedObject.m
//  Expenses
//
//  Created by Maciej Kaszuba on 5/11/13.
//  Copyright (c) 2013 Company. All rights reserved.
//

#import "LMAppDelegate.h"
#import "ManagedObject.h"

@implementation ManagedObject

+ (id)createObjectInContext:(NSManagedObjectContext *)context {
    return [[ManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context] insertIntoManagedObjectContext:context];
}

+ (id)createObjectInMainContext {
    return [[ManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[[LMCoreDataManager sharedInstance] masterManagedObjectContext]] insertIntoManagedObjectContext:[[LMCoreDataManager sharedInstance] masterManagedObjectContext]];
}

- (void)print
{
   NSLog(@"Prints information about object, this is super print , you must first override this selector!");
}

@end
