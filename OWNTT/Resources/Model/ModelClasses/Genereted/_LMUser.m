// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUser.m instead.

#import "_LMUser.h"

const struct LMUserAttributes LMUserAttributes = {
	.alertsCount = @"alertsCount",
	.createDate = @"createDate",
	.deviceToken = @"deviceToken",
	.email = @"email",
	.httpToken = @"httpToken",
	.name = @"name",
	.password = @"password",
	.surname = @"surname",
};

const struct LMUserRelationships LMUserRelationships = {
	.settings = @"settings",
	.userAlerts = @"userAlerts",
	.userReports = @"userReports",
};

const struct LMUserFetchedProperties LMUserFetchedProperties = {
};

@implementation LMUserID
@end

@implementation _LMUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMUser" inManagedObjectContext:moc_];
}

- (LMUserID*)objectID {
	return (LMUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"alertsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alertsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic alertsCount;



- (int64_t)alertsCountValue {
	NSNumber *result = [self alertsCount];
	return [result longLongValue];
}

- (void)setAlertsCountValue:(int64_t)value_ {
	[self setAlertsCount:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveAlertsCountValue {
	NSNumber *result = [self primitiveAlertsCount];
	return [result longLongValue];
}

- (void)setPrimitiveAlertsCountValue:(int64_t)value_ {
	[self setPrimitiveAlertsCount:[NSNumber numberWithLongLong:value_]];
}





@dynamic createDate;






@dynamic deviceToken;






@dynamic email;






@dynamic httpToken;






@dynamic name;






@dynamic password;






@dynamic surname;






@dynamic settings;

	

@dynamic userAlerts;

	
- (NSMutableSet*)userAlertsSet {
	[self willAccessValueForKey:@"userAlerts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"userAlerts"];
  
	[self didAccessValueForKey:@"userAlerts"];
	return result;
}
	

@dynamic userReports;

	
- (NSMutableSet*)userReportsSet {
	[self willAccessValueForKey:@"userReports"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"userReports"];
  
	[self didAccessValueForKey:@"userReports"];
	return result;
}
	






@end
