#import "_LMSynchStatus.h"

@interface LMSynchStatus : _LMSynchStatus {}
// Custom logic goes here.
+ (NSDate*) getLastUpdatedDateForEntityClass: (Class) entityClass;
+ (void) setLastUpdatedDateForEnityClass: (Class) entityClass withDate:(NSDate*) date inContext: (NSManagedObjectContext*) context;
@end
