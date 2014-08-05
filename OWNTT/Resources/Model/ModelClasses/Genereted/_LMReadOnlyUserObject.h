// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyUserObject.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMReadOnlyUserObjectAttributes {
	__unsafe_unretained NSString *createDate;
	__unsafe_unretained NSString *name;
} LMReadOnlyUserObjectAttributes;

extern const struct LMReadOnlyUserObjectRelationships {
} LMReadOnlyUserObjectRelationships;

extern const struct LMReadOnlyUserObjectFetchedProperties {
} LMReadOnlyUserObjectFetchedProperties;





@interface LMReadOnlyUserObjectID : NSManagedObjectID {}
@end

@interface _LMReadOnlyUserObject : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMReadOnlyUserObjectID*)objectID;





@property (nonatomic, strong) NSDate* createDate;



//- (BOOL)validateCreateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _LMReadOnlyUserObject (CoreDataGeneratedAccessors)

@end

@interface _LMReadOnlyUserObject (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreateDate;
- (void)setPrimitiveCreateDate:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
