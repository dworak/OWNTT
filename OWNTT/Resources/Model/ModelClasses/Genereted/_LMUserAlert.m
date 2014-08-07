// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserAlert.m instead.

#import "_LMUserAlert.h"

const struct LMUserAlertAttributes LMUserAlertAttributes = {
};

const struct LMUserAlertRelationships LMUserAlertRelationships = {
	.user = @"user",
};

const struct LMUserAlertFetchedProperties LMUserAlertFetchedProperties = {
};

@implementation LMUserAlertID
@end

@implementation _LMUserAlert

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMUserAlert" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMUserAlert";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMUserAlert" inManagedObjectContext:moc_];
}

- (LMUserAlertID*)objectID {
	return (LMUserAlertID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic user;

	






@end
