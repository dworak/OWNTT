// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMInstance.m instead.

#import "_LMInstance.h"

const struct LMInstanceAttributes LMInstanceAttributes = {
};

const struct LMInstanceRelationships LMInstanceRelationships = {
	.advertisers = @"advertisers",
};

const struct LMInstanceFetchedProperties LMInstanceFetchedProperties = {
};

@implementation LMInstanceID
@end

@implementation _LMInstance

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMInstance" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMInstance";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMInstance" inManagedObjectContext:moc_];
}

- (LMInstanceID*)objectID {
	return (LMInstanceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic advertisers;

	
- (NSMutableSet*)advertisersSet {
	[self willAccessValueForKey:@"advertisers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"advertisers"];
  
	[self didAccessValueForKey:@"advertisers"];
	return result;
}
	






@end
