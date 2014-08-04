// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMReport.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMReportAttributes {
} LMReportAttributes;

extern const struct LMReportRelationships {
	__unsafe_unretained NSString *program;
} LMReportRelationships;

extern const struct LMReportFetchedProperties {
} LMReportFetchedProperties;

@class LMProgram;


@interface LMReportID : NSManagedObjectID {}
@end

@interface _LMReport : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMReportID*)objectID;





@property (nonatomic, strong) LMProgram *program;

//- (BOOL)validateProgram:(id*)value_ error:(NSError**)error_;





@end

@interface _LMReport (CoreDataGeneratedAccessors)

@end

@interface _LMReport (CoreDataGeneratedPrimitiveAccessors)



- (LMProgram*)primitiveProgram;
- (void)setPrimitiveProgram:(LMProgram*)value;


@end
