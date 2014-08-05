// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyUserObject.m instead.

#import "_LMReadOnlyUserObject.h"

const struct LMReadOnlyUserObjectAttributes LMReadOnlyUserObjectAttributes = {
	.createDate = @"createDate",
	.name = @"name",
};

const struct LMReadOnlyUserObjectRelationships LMReadOnlyUserObjectRelationships = {
};

const struct LMReadOnlyUserObjectFetchedProperties LMReadOnlyUserObjectFetchedProperties = {
};

@implementation LMReadOnlyUserObjectID
@end

@implementation _LMReadOnlyUserObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMReadOnlyUserObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMReadOnlyUserObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMReadOnlyUserObject" inManagedObjectContext:moc_];
}

- (LMReadOnlyUserObjectID*)objectID {
	return (LMReadOnlyUserObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic createDate;






@dynamic name;











@end
