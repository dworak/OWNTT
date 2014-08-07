// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserReport.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyUserObject.h"

extern const struct LMUserReportAttributes {
} LMUserReportAttributes;

extern const struct LMUserReportRelationships {
	__unsafe_unretained NSString *reportObject;
	__unsafe_unretained NSString *user;
} LMUserReportRelationships;

extern const struct LMUserReportFetchedProperties {
} LMUserReportFetchedProperties;

@class LMReport;
@class LMUser;


@interface LMUserReportID : NSManagedObjectID {}
@end

@interface _LMUserReport : LMReadOnlyUserObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMUserReportID*)objectID;





@property (nonatomic, strong) LMReport *reportObject;

//- (BOOL)validateReportObject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _LMUserReport (CoreDataGeneratedAccessors)

@end

@interface _LMUserReport (CoreDataGeneratedPrimitiveAccessors)



- (LMReport*)primitiveReportObject;
- (void)setPrimitiveReportObject:(LMReport*)value;



- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;


@end
