// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserAlert.m instead.

#import "_LMUserAlert.h"

const struct LMUserAlertAttributes LMUserAlertAttributes = {
	.advertiserId = @"advertiserId",
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

	if ([key isEqualToString:@"advertiserIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"advertiserId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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

@dynamic advertiserId;

- (int16_t)advertiserIdValue {
	NSNumber *result = [self advertiserId];
	return [result shortValue];
}

- (void)setAdvertiserIdValue:(int16_t)value_ {
	[self setAdvertiserId:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAdvertiserIdValue {
	NSNumber *result = [self primitiveAdvertiserId];
	return [result shortValue];
}

- (void)setPrimitiveAdvertiserIdValue:(int16_t)value_ {
	[self setPrimitiveAdvertiserId:[NSNumber numberWithShort:value_]];
}

@dynamic borderType;

- (int16_t)borderTypeValue {
	NSNumber *result = [self borderType];
	return [result shortValue];
}

- (void)setBorderTypeValue:(int16_t)value_ {
	[self setBorderType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveBorderTypeValue {
	NSNumber *result = [self primitiveBorderType];
	return [result shortValue];
}

- (void)setPrimitiveBorderTypeValue:(int16_t)value_ {
	[self setPrimitiveBorderType:[NSNumber numberWithShort:value_]];
}

@dynamic dateFrom;

@dynamic dateTo;

@dynamic hour;

- (int16_t)hourValue {
	NSNumber *result = [self hour];
	return [result shortValue];
}

- (void)setHourValue:(int16_t)value_ {
	[self setHour:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveHourValue {
	NSNumber *result = [self primitiveHour];
	return [result shortValue];
}

- (void)setPrimitiveHourValue:(int16_t)value_ {
	[self setPrimitiveHour:[NSNumber numberWithShort:value_]];
}

@dynamic monitorType;

- (int16_t)monitorTypeValue {
	NSNumber *result = [self monitorType];
	return [result shortValue];
}

- (void)setMonitorTypeValue:(int16_t)value_ {
	[self setMonitorType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMonitorTypeValue {
	NSNumber *result = [self primitiveMonitorType];
	return [result shortValue];
}

- (void)setPrimitiveMonitorTypeValue:(int16_t)value_ {
	[self setPrimitiveMonitorType:[NSNumber numberWithShort:value_]];
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

- (int16_t)paramTypeValue {
	NSNumber *result = [self paramType];
	return [result shortValue];
}

- (void)setParamTypeValue:(int16_t)value_ {
	[self setParamType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveParamTypeValue {
	NSNumber *result = [self primitiveParamType];
	return [result shortValue];
}

- (void)setPrimitiveParamTypeValue:(int16_t)value_ {
	[self setPrimitiveParamType:[NSNumber numberWithShort:value_]];
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

