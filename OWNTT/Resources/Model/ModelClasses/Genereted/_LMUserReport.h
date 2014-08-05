// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserReport.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyUserObject.h"

extern const struct LMUserReportAttributes {
} LMUserReportAttributes;

extern const struct LMUserReportRelationships {
} LMUserReportRelationships;

extern const struct LMUserReportFetchedProperties {
} LMUserReportFetchedProperties;



@interface LMUserReportID : NSManagedObjectID {}
@end

@interface _LMUserReport : LMReadOnlyUserObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMUserReportID*)objectID;






@end

@interface _LMUserReport (CoreDataGeneratedAccessors)

@end

@interface _LMUserReport (CoreDataGeneratedPrimitiveAccessors)


@end
