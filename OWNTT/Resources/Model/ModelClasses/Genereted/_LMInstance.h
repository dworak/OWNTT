// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMInstance.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMInstanceAttributes {
} LMInstanceAttributes;

extern const struct LMInstanceRelationships {
	__unsafe_unretained NSString *advertisers;
} LMInstanceRelationships;

extern const struct LMInstanceFetchedProperties {
} LMInstanceFetchedProperties;

@class LMAdvertiser;


@interface LMInstanceID : NSManagedObjectID {}
@end

@interface _LMInstance : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMInstanceID*)objectID;





@property (nonatomic, strong) NSSet *advertisers;

- (NSMutableSet*)advertisersSet;





@end

@interface _LMInstance (CoreDataGeneratedAccessors)

- (void)addAdvertisers:(NSSet*)value_;
- (void)removeAdvertisers:(NSSet*)value_;
- (void)addAdvertisersObject:(LMAdvertiser*)value_;
- (void)removeAdvertisersObject:(LMAdvertiser*)value_;

@end

@interface _LMInstance (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveAdvertisers;
- (void)setPrimitiveAdvertisers:(NSMutableSet*)value;


@end
