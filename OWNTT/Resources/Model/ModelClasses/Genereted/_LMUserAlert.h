// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserAlert.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyUserObject.h"

extern const struct LMUserAlertAttributes {
} LMUserAlertAttributes;

extern const struct LMUserAlertRelationships {
	__unsafe_unretained NSString *user;
} LMUserAlertRelationships;

extern const struct LMUserAlertFetchedProperties {
} LMUserAlertFetchedProperties;

@class LMUser;


@interface LMUserAlertID : NSManagedObjectID {}
@end

@interface _LMUserAlert : LMReadOnlyUserObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMUserAlertID*)objectID;





@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _LMUserAlert (CoreDataGeneratedAccessors)

@end

@interface _LMUserAlert (CoreDataGeneratedPrimitiveAccessors)



- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;


@end
