// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserReport.m instead.

#import "_LMUserReport.h"

const struct LMUserReportAttributes LMUserReportAttributes = {
	.timeintervalType = @"timeintervalType",
};

const struct LMUserReportRelationships LMUserReportRelationships = {
	.reportObject = @"reportObject",
	.user = @"user",
};

const struct LMUserReportFetchedProperties LMUserReportFetchedProperties = {
};

@implementation LMUserReportID
@end

@implementation _LMUserReport

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMUserReport" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMUserReport";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMUserReport" inManagedObjectContext:moc_];
}

- (LMUserReportID*)objectID {
	return (LMUserReportID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"timeintervalTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeintervalType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic timeintervalType;



- (int16_t)timeintervalTypeValue {
	NSNumber *result = [self timeintervalType];
	return [result shortValue];
}

- (void)setTimeintervalTypeValue:(int16_t)value_ {
	[self setTimeintervalType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTimeintervalTypeValue {
	NSNumber *result = [self primitiveTimeintervalType];
	return [result shortValue];
}

- (void)setPrimitiveTimeintervalTypeValue:(int16_t)value_ {
	[self setPrimitiveTimeintervalType:[NSNumber numberWithShort:value_]];
}





@dynamic reportObject;

	

@dynamic user;

	






@end
