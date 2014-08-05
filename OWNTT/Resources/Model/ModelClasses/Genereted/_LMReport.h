// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReport.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMReportAttributes {
} LMReportAttributes;

extern const struct LMReportRelationships {
	__unsafe_unretained NSString *instance;
} LMReportRelationships;

extern const struct LMReportFetchedProperties {
} LMReportFetchedProperties;

@class LMInstance;


@interface LMReportID : NSManagedObjectID {}
@end

@interface _LMReport : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMReportID*)objectID;





@property (nonatomic, strong) NSSet *instance;

- (NSMutableSet*)instanceSet;





@end

@interface _LMReport (CoreDataGeneratedAccessors)

- (void)addInstance:(NSSet*)value_;
- (void)removeInstance:(NSSet*)value_;
- (void)addInstanceObject:(LMInstance*)value_;
- (void)removeInstanceObject:(LMInstance*)value_;

@end

@interface _LMReport (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveInstance;
- (void)setPrimitiveInstance:(NSMutableSet*)value;


@end
