// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMInstance.m instead.

#import "_LMInstance.h"

const struct LMInstanceAttributes LMInstanceAttributes = {
	.report1 = @"report1",
	.report5 = @"report5",
	.report8 = @"report8",
};

const struct LMInstanceRelationships LMInstanceRelationships = {
	.advertisers = @"advertisers",
	.reports = @"reports",
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
