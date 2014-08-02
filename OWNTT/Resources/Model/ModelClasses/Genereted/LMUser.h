#import "_LMUser.h"

@interface LMUser : _LMUser {}
// Custom logic goes here.
+ (NSArray *)fetchLMUsersInContext:(NSManagedObjectContext *)context;
@end
