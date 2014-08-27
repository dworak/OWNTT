// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyObject.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMReadOnlyObjectAttributes {
	__unsafe_unretained NSString *active;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *objectId;
} LMReadOnlyObjectAttributes;

extern const struct LMReadOnlyObjectRelationships {
} LMReadOnlyObjectRelationships;

extern const struct LMReadOnlyObjectFetchedProperties {
} LMReadOnlyObjectFetchedProperties;






@interface LMReadOnlyObjectID : NSManagedObjectID {}
@end

@interface _LMReadOnlyObject : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMReadOnlyObjectID*)objectID;





@property (nonatomic, strong) NSNumber* active;



@property BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* objectId;



@property int64_t objectIdValue;
- (int64_t)objectIdValue;
- (void)setObjectIdValue:(int64_t)value_;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;






@end

@interface _LMReadOnlyObject (CoreDataGeneratedAccessors)

@end

@interface _LMReadOnlyObject (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSNumber*)value;

- (int64_t)primitiveObjectIdValue;
- (void)setPrimitiveObjectIdValue:(int64_t)value_;




@end
