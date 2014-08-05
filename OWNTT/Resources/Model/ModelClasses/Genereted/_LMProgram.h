// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMProgram.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMProgramAttributes {
} LMProgramAttributes;

extern const struct LMProgramRelationships {
	__unsafe_unretained NSString *advertiser;
} LMProgramRelationships;

extern const struct LMProgramFetchedProperties {
} LMProgramFetchedProperties;

@class LMAdvertiser;


@interface LMProgramID : NSManagedObjectID {}
@end

@interface _LMProgram : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMProgramID*)objectID;





@property (nonatomic, strong) LMAdvertiser *advertiser;

//- (BOOL)validateAdvertiser:(id*)value_ error:(NSError**)error_;





@end

@interface _LMProgram (CoreDataGeneratedAccessors)

@end

@interface _LMProgram (CoreDataGeneratedPrimitiveAccessors)



- (LMAdvertiser*)primitiveAdvertiser;
- (void)setPrimitiveAdvertiser:(LMAdvertiser*)value;


@end
