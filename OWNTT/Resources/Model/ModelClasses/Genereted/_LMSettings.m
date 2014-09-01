// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSettings.m instead.

#import "_LMSettings.h"

const struct LMSettingsAttributes LMSettingsAttributes = {
	.alertDefaultBorderType = @"alertDefaultBorderType",
	.alertDefaultHour = @"alertDefaultHour",
	.alertDefaultMonitorType = @"alertDefaultMonitorType",
	.alertDefaultPointer = @"alertDefaultPointer",
	.alertDefaultValue = @"alertDefaultValue",
	.reportDefaultDateFrom = @"reportDefaultDateFrom",
	.reportDefaultDateTo = @"reportDefaultDateTo",
	.reportDefaultEnum = @"reportDefaultEnum",
	.reportDefaultIsEnum = @"reportDefaultIsEnum",
};

const struct LMSettingsRelationships LMSettingsRelationships = {
	.user = @"user",
};

const struct LMSettingsFetchedProperties LMSettingsFetchedProperties = {
};

@implementation LMSettingsID
@end

@implementation _LMSettings

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMSettings" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMSettings";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMSettings" inManagedObjectContext:moc_];
}

- (LMSettingsID*)objectID {
	return (LMSettingsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"alertDefaultBorderTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alertDefaultBorderType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"alertDefaultHourValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alertDefaultHour"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"alertDefaultMonitorTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alertDefaultMonitorType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"alertDefaultPointerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alertDefaultPointer"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"alertDefaultValueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alertDefaultValue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"reportDefaultEnumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reportDefaultEnum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"reportDefaultIsEnumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reportDefaultIsEnum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic alertDefaultBorderType;



- (int16_t)alertDefaultBorderTypeValue {
	NSNumber *result = [self alertDefaultBorderType];
	return [result shortValue];
}

- (void)setAlertDefaultBorderTypeValue:(int16_t)value_ {
	[self setAlertDefaultBorderType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAlertDefaultBorderTypeValue {
	NSNumber *result = [self primitiveAlertDefaultBorderType];
	return [result shortValue];
}

- (void)setPrimitiveAlertDefaultBorderTypeValue:(int16_t)value_ {
	[self setPrimitiveAlertDefaultBorderType:[NSNumber numberWithShort:value_]];
}





@dynamic alertDefaultHour;



- (int16_t)alertDefaultHourValue {
	NSNumber *result = [self alertDefaultHour];
	return [result shortValue];
}

- (void)setAlertDefaultHourValue:(int16_t)value_ {
	[self setAlertDefaultHour:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAlertDefaultHourValue {
	NSNumber *result = [self primitiveAlertDefaultHour];
	return [result shortValue];
}

- (void)setPrimitiveAlertDefaultHourValue:(int16_t)value_ {
	[self setPrimitiveAlertDefaultHour:[NSNumber numberWithShort:value_]];
}





@dynamic alertDefaultMonitorType;



- (int16_t)alertDefaultMonitorTypeValue {
	NSNumber *result = [self alertDefaultMonitorType];
	return [result shortValue];
}

- (void)setAlertDefaultMonitorTypeValue:(int16_t)value_ {
	[self setAlertDefaultMonitorType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAlertDefaultMonitorTypeValue {
	NSNumber *result = [self primitiveAlertDefaultMonitorType];
	return [result shortValue];
}

- (void)setPrimitiveAlertDefaultMonitorTypeValue:(int16_t)value_ {
	[self setPrimitiveAlertDefaultMonitorType:[NSNumber numberWithShort:value_]];
}





@dynamic alertDefaultPointer;



- (int16_t)alertDefaultPointerValue {
	NSNumber *result = [self alertDefaultPointer];
	return [result shortValue];
}

- (void)setAlertDefaultPointerValue:(int16_t)value_ {
	[self setAlertDefaultPointer:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAlertDefaultPointerValue {
	NSNumber *result = [self primitiveAlertDefaultPointer];
	return [result shortValue];
}

- (void)setPrimitiveAlertDefaultPointerValue:(int16_t)value_ {
	[self setPrimitiveAlertDefaultPointer:[NSNumber numberWithShort:value_]];
}





@dynamic alertDefaultValue;



- (int16_t)alertDefaultValueValue {
	NSNumber *result = [self alertDefaultValue];
	return [result shortValue];
}

- (void)setAlertDefaultValueValue:(int16_t)value_ {
	[self setAlertDefaultValue:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAlertDefaultValueValue {
	NSNumber *result = [self primitiveAlertDefaultValue];
	return [result shortValue];
}

- (void)setPrimitiveAlertDefaultValueValue:(int16_t)value_ {
	[self setPrimitiveAlertDefaultValue:[NSNumber numberWithShort:value_]];
}





@dynamic reportDefaultDateFrom;






@dynamic reportDefaultDateTo;






@dynamic reportDefaultEnum;



- (int16_t)reportDefaultEnumValue {
	NSNumber *result = [self reportDefaultEnum];
	return [result shortValue];
}

- (void)setReportDefaultEnumValue:(int16_t)value_ {
	[self setReportDefaultEnum:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveReportDefaultEnumValue {
	NSNumber *result = [self primitiveReportDefaultEnum];
	return [result shortValue];
}

- (void)setPrimitiveReportDefaultEnumValue:(int16_t)value_ {
	[self setPrimitiveReportDefaultEnum:[NSNumber numberWithShort:value_]];
}





@dynamic reportDefaultIsEnum;



- (BOOL)reportDefaultIsEnumValue {
	NSNumber *result = [self reportDefaultIsEnum];
	return [result boolValue];
}

- (void)setReportDefaultIsEnumValue:(BOOL)value_ {
	[self setReportDefaultIsEnum:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReportDefaultIsEnumValue {
	NSNumber *result = [self primitiveReportDefaultIsEnum];
	return [result boolValue];
}

- (void)setPrimitiveReportDefaultIsEnumValue:(BOOL)value_ {
	[self setPrimitiveReportDefaultIsEnum:[NSNumber numberWithBool:value_]];
}





@dynamic user;

	






@end
