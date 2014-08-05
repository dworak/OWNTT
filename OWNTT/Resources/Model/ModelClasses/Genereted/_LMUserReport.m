// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserReport.m instead.

#import "_LMUserReport.h"

const struct LMUserReportAttributes LMUserReportAttributes = {
};

const struct LMUserReportRelationships LMUserReportRelationships = {
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
	

	return keyPaths;
}









@end
