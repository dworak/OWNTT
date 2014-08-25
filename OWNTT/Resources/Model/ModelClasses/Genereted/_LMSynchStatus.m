// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSynchStatus.m instead.

#import "_LMSynchStatus.h"

const struct LMSynchStatusAttributes LMSynchStatusAttributes = {
	.entityClass = @"entityClass",
	.lastSynchDate = @"lastSynchDate",
};

const struct LMSynchStatusRelationships LMSynchStatusRelationships = {
};

const struct LMSynchStatusFetchedProperties LMSynchStatusFetchedProperties = {
};

@implementation LMSynchStatusID
@end

@implementation _LMSynchStatus

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMSynchStatus" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMSynchStatus";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMSynchStatus" inManagedObjectContext:moc_];
}

- (LMSynchStatusID*)objectID {
	return (LMSynchStatusID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic entityClass;






@dynamic lastSynchDate;











@end
