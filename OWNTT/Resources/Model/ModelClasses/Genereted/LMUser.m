#import "LMUser.h"


@interface LMUser ()

// Private interface goes here.

@end


@implementation LMUser

// Custom logic goes here.
+ (NSArray *)fetchLMUsersInContext:(NSManagedObjectContext *)context
{
    return [self fetchEntitiesOfClass:[self class] inContext:context];
}

@end
