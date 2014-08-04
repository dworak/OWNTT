// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyObject.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMReadOnlyObjectAttributes {
	__unsafe_unretained NSString *active;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *objectId;
	__unsafe_unretained NSString *report1;
	__unsafe_unretained NSString *report5;
	__unsafe_unretained NSString *report8;
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





@property (nonatomic, strong) NSNumber* report1;



@property BOOL report1Value;
- (BOOL)report1Value;
- (void)setReport1Value:(BOOL)value_;

//- (BOOL)validateReport1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* report5;



@property BOOL report5Value;
- (BOOL)report5Value;
- (void)setReport5Value:(BOOL)value_;

//- (BOOL)validateReport5:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* report8;



@property BOOL report8Value;
- (BOOL)report8Value;
- (void)setReport8Value:(BOOL)value_;

//- (BOOL)validateReport8:(id*)value_ error:(NSError**)error_;






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




- (NSNumber*)primitiveReport1;
- (void)setPrimitiveReport1:(NSNumber*)value;

- (BOOL)primitiveReport1Value;
- (void)setPrimitiveReport1Value:(BOOL)value_;




- (NSNumber*)primitiveReport5;
- (void)setPrimitiveReport5:(NSNumber*)value;

- (BOOL)primitiveReport5Value;
- (void)setPrimitiveReport5Value:(BOOL)value_;




- (NSNumber*)primitiveReport8;
- (void)setPrimitiveReport8:(NSNumber*)value;

- (BOOL)primitiveReport8Value;
- (void)setPrimitiveReport8Value:(BOOL)value_;




@end
