// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyObject.m instead.

#import "_LMReadOnlyObject.h"

const struct LMReadOnlyObjectAttributes LMReadOnlyObjectAttributes = {
	.active = @"active",
	.name = @"name",
	.objectId = @"objectId",
};

@implementation LMReadOnlyObjectID
@end

@implementation _LMReadOnlyObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMReadOnlyObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMReadOnlyObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMReadOnlyObject" inManagedObjectContext:moc_];
}

- (LMReadOnlyObjectID*)objectID {
	return (LMReadOnlyObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"activeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"active"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"objectIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"objectId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic active;

- (BOOL)activeValue {
	NSNumber *result = [self active];
	return [result boolValue];
}

- (void)setActiveValue:(BOOL)value_ {
	[self setActive:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveActiveValue {
	NSNumber *result = [self primitiveActive];
	return [result boolValue];
}

- (void)setPrimitiveActiveValue:(BOOL)value_ {
	[self setPrimitiveActive:[NSNumber numberWithBool:value_]];
}

@dynamic name;

@dynamic objectId;

- (int64_t)objectIdValue {
	NSNumber *result = [self objectId];
	return [result longLongValue];
}

- (void)setObjectIdValue:(int64_t)value_ {
	[self setObjectId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveObjectIdValue {
	NSNumber *result = [self primitiveObjectId];
	return [result longLongValue];
}

- (void)setPrimitiveObjectIdValue:(int64_t)value_ {
	[self setPrimitiveObjectId:[NSNumber numberWithLongLong:value_]];
}

@end

