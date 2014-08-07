// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUser.m instead.

#import "_LMUser.h"

const struct LMUserAttributes LMUserAttributes = {
	.name = @"name",
	.password = @"password",
};

const struct LMUserRelationships LMUserRelationships = {
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
	

	return keyPaths;
}




@dynamic name;






@dynamic password;






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
