// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMAdvertiser.m instead.

#import "_LMAdvertiser.h"

const struct LMAdvertiserRelationships LMAdvertiserRelationships = {
	.instance = @"instance",
	.programs = @"programs",
};

@implementation LMAdvertiserID
@end

@implementation _LMAdvertiser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LMAdvertiser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LMAdvertiser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LMAdvertiser" inManagedObjectContext:moc_];
}

- (LMAdvertiserID*)objectID {
	return (LMAdvertiserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic instance;

@dynamic programs;

- (NSMutableSet*)programsSet {
	[self willAccessValueForKey:@"programs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"programs"];

	[self didAccessValueForKey:@"programs"];
	return result;
}

@end

