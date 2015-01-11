// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReadOnlyUserObject.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMReadOnlyUserObjectAttributes {
	__unsafe_unretained NSString *active;
	__unsafe_unretained NSString *createDate;
	__unsafe_unretained NSString *name;
} LMReadOnlyUserObjectAttributes;

@interface LMReadOnlyUserObjectID : NSManagedObjectID {}
@end

@interface _LMReadOnlyUserObject : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LMReadOnlyUserObjectID* objectID;

@property (nonatomic, strong) NSNumber* active;

@property (atomic) BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* createDate;

//- (BOOL)validateCreateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _LMReadOnlyUserObject (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;

- (NSDate*)primitiveCreateDate;
- (void)setPrimitiveCreateDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
