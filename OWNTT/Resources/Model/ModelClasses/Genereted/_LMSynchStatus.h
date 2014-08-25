// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSynchStatus.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMSynchStatusAttributes {
	__unsafe_unretained NSString *entityClass;
	__unsafe_unretained NSString *lastSynchDate;
} LMSynchStatusAttributes;

extern const struct LMSynchStatusRelationships {
} LMSynchStatusRelationships;

extern const struct LMSynchStatusFetchedProperties {
} LMSynchStatusFetchedProperties;





@interface LMSynchStatusID : NSManagedObjectID {}
@end

@interface _LMSynchStatus : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMSynchStatusID*)objectID;





@property (nonatomic, strong) NSString* entityClass;



//- (BOOL)validateEntityClass:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* lastSynchDate;



//- (BOOL)validateLastSynchDate:(id*)value_ error:(NSError**)error_;






@end

@interface _LMSynchStatus (CoreDataGeneratedAccessors)

@end

@interface _LMSynchStatus (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEntityClass;
- (void)setPrimitiveEntityClass:(NSString*)value;




- (NSDate*)primitiveLastSynchDate;
- (void)setPrimitiveLastSynchDate:(NSDate*)value;




@end
