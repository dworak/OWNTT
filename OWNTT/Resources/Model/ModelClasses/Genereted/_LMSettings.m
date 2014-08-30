// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSettings.m instead.

#import "_LMSettings.h"

const struct LMSettingsAttributes LMSettingsAttributes = {
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




@dynamic reportDefaultDateFrom;






@dynamic reportDefaultDateTo;






@dynamic reportDefaultEnum;



- (int64_t)reportDefaultEnumValue {
	NSNumber *result = [self reportDefaultEnum];
	return [result longLongValue];
}

- (void)setReportDefaultEnumValue:(int64_t)value_ {
	[self setReportDefaultEnum:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveReportDefaultEnumValue {
	NSNumber *result = [self primitiveReportDefaultEnum];
	return [result longLongValue];
}

- (void)setPrimitiveReportDefaultEnumValue:(int64_t)value_ {
	[self setPrimitiveReportDefaultEnum:[NSNumber numberWithLongLong:value_]];
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
