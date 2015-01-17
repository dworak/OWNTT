// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMInstance.m instead.

#import "_LMInstance.h"

const struct LMInstanceAttributes LMInstanceAttributes = {
	.isReport1 = @"isReport1",
	.isReport5 = @"isReport5",
	.isReport6 = @"isReport6",
	.isReport8 = @"isReport8",
};

const struct LMInstanceRelationships LMInstanceRelationships = {
	.advertisers = @"advertisers",
	.reports = @"reports",
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

	if ([key isEqualToString:@"isReport1Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isReport1"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isReport5Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isReport5"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isReport6Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isReport6"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isReport8Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isReport8"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic isReport1;

- (BOOL)isReport1Value {
	NSNumber *result = [self isReport1];
	return [result boolValue];
}

- (void)setIsReport1Value:(BOOL)value_ {
	[self setIsReport1:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsReport1Value {
	NSNumber *result = [self primitiveIsReport1];
	return [result boolValue];
}

- (void)setPrimitiveIsReport1Value:(BOOL)value_ {
	[self setPrimitiveIsReport1:[NSNumber numberWithBool:value_]];
}

@dynamic isReport5;

- (BOOL)isReport5Value {
	NSNumber *result = [self isReport5];
	return [result boolValue];
}

- (void)setIsReport5Value:(BOOL)value_ {
	[self setIsReport5:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsReport5Value {
	NSNumber *result = [self primitiveIsReport5];
	return [result boolValue];
}

- (void)setPrimitiveIsReport5Value:(BOOL)value_ {
	[self setPrimitiveIsReport5:[NSNumber numberWithBool:value_]];
}

@dynamic isReport6;

- (BOOL)isReport6Value {
	NSNumber *result = [self isReport6];
	return [result boolValue];
}

- (void)setIsReport6Value:(BOOL)value_ {
	[self setIsReport6:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsReport6Value {
	NSNumber *result = [self primitiveIsReport6];
	return [result boolValue];
}

- (void)setPrimitiveIsReport6Value:(BOOL)value_ {
	[self setPrimitiveIsReport6:[NSNumber numberWithBool:value_]];
}

@dynamic isReport8;

- (BOOL)isReport8Value {
	NSNumber *result = [self isReport8];
	return [result boolValue];
}

- (void)setIsReport8Value:(BOOL)value_ {
	[self setIsReport8:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsReport8Value {
	NSNumber *result = [self primitiveIsReport8];
	return [result boolValue];
}

- (void)setPrimitiveIsReport8Value:(BOOL)value_ {
	[self setPrimitiveIsReport8:[NSNumber numberWithBool:value_]];
}

@dynamic advertisers;

- (NSMutableSet*)advertisersSet {
	[self willAccessValueForKey:@"advertisers"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"advertisers"];

	[self didAccessValueForKey:@"advertisers"];
	return result;
}

@dynamic reports;

- (NSMutableSet*)reportsSet {
	[self willAccessValueForKey:@"reports"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reports"];

	[self didAccessValueForKey:@"reports"];
	return result;
}

@end

