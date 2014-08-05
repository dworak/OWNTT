// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReport.m instead.

#import "_LMReport.h"

const struct LMReportAttributes LMReportAttributes = {
};

const struct LMReportRelationships LMReportRelationships = {
	.instance = @"instance",
};

const struct LMReportFetchedProperties LMReportFetchedProperties = {
};

@implementation LMReportID
@end

@implementation _LMReport

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMReport" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMReport";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMReport" inManagedObjectContext:moc_];
}

- (LMReportID*)objectID {
	return (LMReportID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic instance;

	
- (NSMutableSet*)instanceSet {
	[self willAccessValueForKey:@"instance"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"instance"];
  
	[self didAccessValueForKey:@"instance"];
	return result;
}
	






@end
