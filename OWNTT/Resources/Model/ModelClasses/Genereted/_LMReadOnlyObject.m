// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyObject.m instead.

#import "_LMReadOnlyObject.h"

const struct LMReadOnlyObjectAttributes LMReadOnlyObjectAttributes = {
	.active = @"active",
	.name = @"name",
	.objectId = @"objectId",
	.report1 = @"report1",
	.report5 = @"report5",
	.report8 = @"report8",
};

const struct LMReadOnlyObjectRelationships LMReadOnlyObjectRelationships = {
};

const struct LMReadOnlyObjectFetchedProperties LMReadOnlyObjectFetchedProperties = {
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
	if ([key isEqualToString:@"report1Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"report1"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"report5Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"report5"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"report8Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"report8"];
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





@dynamic report1;



- (BOOL)report1Value {
	NSNumber *result = [self report1];
	return [result boolValue];
}

- (void)setReport1Value:(BOOL)value_ {
	[self setReport1:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReport1Value {
	NSNumber *result = [self primitiveReport1];
	return [result boolValue];
}

- (void)setPrimitiveReport1Value:(BOOL)value_ {
	[self setPrimitiveReport1:[NSNumber numberWithBool:value_]];
}





@dynamic report5;



- (BOOL)report5Value {
	NSNumber *result = [self report5];
	return [result boolValue];
}

- (void)setReport5Value:(BOOL)value_ {
	[self setReport5:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReport5Value {
	NSNumber *result = [self primitiveReport5];
	return [result boolValue];
}

- (void)setPrimitiveReport5Value:(BOOL)value_ {
	[self setPrimitiveReport5:[NSNumber numberWithBool:value_]];
}





@dynamic report8;



- (BOOL)report8Value {
	NSNumber *result = [self report8];
	return [result boolValue];
}

- (void)setReport8Value:(BOOL)value_ {
	[self setReport8:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReport8Value {
	NSNumber *result = [self primitiveReport8];
	return [result boolValue];
}

- (void)setPrimitiveReport8Value:(BOOL)value_ {
	[self setPrimitiveReport8:[NSNumber numberWithBool:value_]];
}










@end
