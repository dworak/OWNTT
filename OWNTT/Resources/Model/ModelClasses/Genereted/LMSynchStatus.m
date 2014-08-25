
#import "LMSynchStatus.h"
#import "LMSynchStatus.h"

static NSString*const kSyncStatus = @"SyncStatus";

@interface LMSynchStatus ()

// Private interface goes here.

@end


@implementation LMSynchStatus

// Custom logic goes here.
+ (NSDate*) getLastUpdatedDateForEntityClass: (Class) entityClass
{
    LMSynchStatus *syncStatus = [LMSynchStatus fetchManagedObjectWithClass:entityClass];
    return syncStatus.lastSynchDate;
}


+ (void) setLastUpdatedDateForEnityClass: (Class) entityClass withDate:(NSDate*) date inContext: (NSManagedObjectContext*) context
{
    LMSynchStatus *syncStatus;
    NSDate *previousDate = [LMSynchStatus getLastUpdatedDateForEntityClass:entityClass];
    
    if(previousDate==nil)
    {
        syncStatus = [NSEntityDescription insertNewObjectForEntityForName:kSyncStatus inManagedObjectContext:context];
    }
    else
    {
        syncStatus = [LMSynchStatus fetchManagedObjectWithClass:entityClass];
    }
    
    syncStatus.entityClass = NSStringFromClass(entityClass);
    syncStatus.lastSynchDate = date;
    
    [context performBlockAndWait:^{
        NSError *error;
        [context save:&error];
        if(!error)
        {
            [context.parentContext performBlockAndWait:^{
                NSError *error;
                [context.parentContext save:&error];
                if(error)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"An error occured during saving context after modyfing SyncHelper entity.");
                    });
                }
                
            }];
        }
    }];
}


+ (LMSynchStatus *) fetchManagedObjectWithClass: (Class) class
{
    NSEntityDescription *syncHelper = [NSEntityDescription entityForName:kSyncStatus inManagedObjectContext:[LMCoreDataManager sharedInstance].masterManagedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:syncHelper];
    [request setPredicate:[NSPredicate predicateWithFormat:@"entityClass = %@", NSStringFromClass(class)]];
    
    NSError*error;
    
    NSArray * results = [[LMCoreDataManager sharedInstance].masterManagedObjectContext executeFetchRequest:request error:&error];
    
    if(error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"An error occured: %@", error);
        });
        assert(error==nil);
    }
    
    if(results.count>1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"An error occured, multiple values for one entity in LMSynchStatus entity");
        });
        assert(results.count<=1);
    }
    
    return [results firstObject];
}


@end
