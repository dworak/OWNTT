// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSettings.m instead.

#import "_LMSettings.h"

const struct LMSettingsAttributes LMSettingsAttributes = {
	.reportDefaultDate = @"reportDefaultDate",
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
	

	return keyPaths;
}




@dynamic reportDefaultDate;






@dynamic user;

	






@end
