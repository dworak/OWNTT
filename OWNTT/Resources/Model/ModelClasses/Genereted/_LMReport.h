// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReport.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMReportAttributes {
	__unsafe_unretained NSString *htmlName;
} LMReportAttributes;

extern const struct LMReportRelationships {
	__unsafe_unretained NSString *instance;
	__unsafe_unretained NSString *userReports;
} LMReportRelationships;

@class LMInstance;
@class LMUserReport;

@interface LMReportID : LMReadOnlyObjectID {}
@end

@interface _LMReport : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LMReportID* objectID;

@property (nonatomic, strong) NSString* htmlName;

//- (BOOL)validateHtmlName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *instance;

- (NSMutableSet*)instanceSet;

@property (nonatomic, strong) NSSet *userReports;

- (NSMutableSet*)userReportsSet;

@end

@interface _LMReport (InstanceCoreDataGeneratedAccessors)
- (void)addInstance:(NSSet*)value_;
- (void)removeInstance:(NSSet*)value_;
- (void)addInstanceObject:(LMInstance*)value_;
- (void)removeInstanceObject:(LMInstance*)value_;

@end

@interface _LMReport (UserReportsCoreDataGeneratedAccessors)
- (void)addUserReports:(NSSet*)value_;
- (void)removeUserReports:(NSSet*)value_;
- (void)addUserReportsObject:(LMUserReport*)value_;
- (void)removeUserReportsObject:(LMUserReport*)value_;

@end

@interface _LMReport (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveHtmlName;
- (void)setPrimitiveHtmlName:(NSString*)value;

- (NSMutableSet*)primitiveInstance;
- (void)setPrimitiveInstance:(NSMutableSet*)value;

- (NSMutableSet*)primitiveUserReports;
- (void)setPrimitiveUserReports:(NSMutableSet*)value;

@end
