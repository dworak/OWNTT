// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMAdvertiser.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMAdvertiserRelationships {
	__unsafe_unretained NSString *instance;
	__unsafe_unretained NSString *programs;
} LMAdvertiserRelationships;

@class LMInstance;
@class LMProgram;

@interface LMAdvertiserID : LMReadOnlyObjectID {}
@end

@interface _LMAdvertiser : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LMAdvertiserID* objectID;

@property (nonatomic, strong) LMInstance *instance;

//- (BOOL)validateInstance:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *programs;

- (NSMutableSet*)programsSet;

@end

@interface _LMAdvertiser (ProgramsCoreDataGeneratedAccessors)
- (void)addPrograms:(NSSet*)value_;
- (void)removePrograms:(NSSet*)value_;
- (void)addProgramsObject:(LMProgram*)value_;
- (void)removeProgramsObject:(LMProgram*)value_;

@end

@interface _LMAdvertiser (CoreDataGeneratedPrimitiveAccessors)

- (LMInstance*)primitiveInstance;
- (void)setPrimitiveInstance:(LMInstance*)value;

- (NSMutableSet*)primitivePrograms;
- (void)setPrimitivePrograms:(NSMutableSet*)value;

@end
