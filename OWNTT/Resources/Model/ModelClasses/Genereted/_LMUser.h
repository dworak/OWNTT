// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUser.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMUserAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *password;
} LMUserAttributes;

extern const struct LMUserRelationships {
} LMUserRelationships;

extern const struct LMUserFetchedProperties {
} LMUserFetchedProperties;





@interface LMUserID : NSManagedObjectID {}
@end

@interface _LMUser : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMUserID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* password;



//- (BOOL)validatePassword:(id*)value_ error:(NSError**)error_;






@end

@interface _LMUser (CoreDataGeneratedAccessors)

@end

@interface _LMUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePassword;
- (void)setPrimitivePassword:(NSString*)value;




@end
