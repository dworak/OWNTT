//
//  ManagedObject.h
//  Expenses
//
//  Created by Maciej Kaszuba on 5/11/13.
//  Copyright (c) 2013 Company. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ManagedObject : NSManagedObject
+ (id)createObjectInMainContext;
+ (id)createObjectInContext:(NSManagedObjectContext*)context;

- (void)print;

@end
