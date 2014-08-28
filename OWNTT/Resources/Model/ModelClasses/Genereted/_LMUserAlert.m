// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserAlert.m instead.

#import "_LMUserAlert.h"

const struct LMUserAlertAttributes LMUserAlertAttributes = {
	.borderType = @"borderType",
	.dateFrom = @"dateFrom",
	.dateTo = @"dateTo",
	.hour = @"hour",
	.monitorType = @"monitorType",
	.objectId = @"objectId",
	.paramType = @"paramType",
	.programId = @"programId",
	.value = @"value",
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
	
	if ([key isEqualToString:@"borderTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"borderType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hourValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hour"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"monitorTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"monitorType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"objectIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"objectId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"paramTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"paramType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"programIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"programId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic borderType;



- (double)borderTypeValue {
	NSNumber *result = [self borderType];
	return [result doubleValue];
}

- (void)setBorderTypeValue:(double)value_ {
	[self setBorderType:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveBorderTypeValue {
	NSNumber *result = [self primitiveBorderType];
	return [result doubleValue];
}

- (void)setPrimitiveBorderTypeValue:(double)value_ {
	[self setPrimitiveBorderType:[NSNumber numberWithDouble:value_]];
}





@dynamic dateFrom;






@dynamic dateTo;






@dynamic hour;



- (int64_t)hourValue {
	NSNumber *result = [self hour];
	return [result longLongValue];
}

- (void)setHourValue:(int64_t)value_ {
	[self setHour:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveHourValue {
	NSNumber *result = [self primitiveHour];
	return [result longLongValue];
}

- (void)setPrimitiveHourValue:(int64_t)value_ {
	[self setPrimitiveHour:[NSNumber numberWithLongLong:value_]];
}





@dynamic monitorType;



- (int64_t)monitorTypeValue {
	NSNumber *result = [self monitorType];
	return [result longLongValue];
}

- (void)setMonitorTypeValue:(int64_t)value_ {
	[self setMonitorType:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveMonitorTypeValue {
	NSNumber *result = [self primitiveMonitorType];
	return [result longLongValue];
}

- (void)setPrimitiveMonitorTypeValue:(int64_t)value_ {
	[self setPrimitiveMonitorType:[NSNumber numberWithLongLong:value_]];
}





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





@dynamic paramType;



- (int64_t)paramTypeValue {
	NSNumber *result = [self paramType];
	return [result longLongValue];
}

- (void)setParamTypeValue:(int64_t)value_ {
	[self setParamType:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveParamTypeValue {
	NSNumber *result = [self primitiveParamType];
	return [result longLongValue];
}

- (void)setPrimitiveParamTypeValue:(int64_t)value_ {
	[self setPrimitiveParamType:[NSNumber numberWithLongLong:value_]];
}





@dynamic programId;



- (int64_t)programIdValue {
	NSNumber *result = [self programId];
	return [result longLongValue];
}

- (void)setProgramIdValue:(int64_t)value_ {
	[self setProgramId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveProgramIdValue {
	NSNumber *result = [self primitiveProgramId];
	return [result longLongValue];
}

- (void)setPrimitiveProgramIdValue:(int64_t)value_ {
	[self setPrimitiveProgramId:[NSNumber numberWithLongLong:value_]];
}





@dynamic value;






@dynamic user;

	






@end
