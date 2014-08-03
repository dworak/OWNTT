// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMProgram.m instead.

#import "_LMProgram.h"

const struct LMProgramAttributes LMProgramAttributes = {
};

const struct LMProgramRelationships LMProgramRelationships = {
	.advertiser = @"advertiser",
	.reports = @"reports",
};

const struct LMProgramFetchedProperties LMProgramFetchedProperties = {
};

@implementation LMProgramID
@end

@implementation _LMProgram

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMProgram" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMProgram";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMProgram" inManagedObjectContext:moc_];
}

- (LMProgramID*)objectID {
	return (LMProgramID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic advertiser;

	

@dynamic reports;

	
- (NSMutableSet*)reportsSet {
	[self willAccessValueForKey:@"reports"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reports"];
  
	[self didAccessValueForKey:@"reports"];
	return result;
}
	






@end
