// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSettings.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMSettingsAttributes {
	__unsafe_unretained NSString *reportDefaultDateFrom;
	__unsafe_unretained NSString *reportDefaultDateTo;
	__unsafe_unretained NSString *reportDefaultEnum;
	__unsafe_unretained NSString *reportDefaultIsEnum;
} LMSettingsAttributes;

extern const struct LMSettingsRelationships {
	__unsafe_unretained NSString *user;
} LMSettingsRelationships;

extern const struct LMSettingsFetchedProperties {
} LMSettingsFetchedProperties;

@class LMUser;






@interface LMSettingsID : NSManagedObjectID {}
@end

@interface _LMSettings : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMSettingsID*)objectID;





@property (nonatomic, strong) NSDate* reportDefaultDateFrom;



//- (BOOL)validateReportDefaultDateFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* reportDefaultDateTo;



//- (BOOL)validateReportDefaultDateTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* reportDefaultEnum;



@property int64_t reportDefaultEnumValue;
- (int64_t)reportDefaultEnumValue;
- (void)setReportDefaultEnumValue:(int64_t)value_;

//- (BOOL)validateReportDefaultEnum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* reportDefaultIsEnum;



@property BOOL reportDefaultIsEnumValue;
- (BOOL)reportDefaultIsEnumValue;
- (void)setReportDefaultIsEnumValue:(BOOL)value_;

//- (BOOL)validateReportDefaultIsEnum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _LMSettings (CoreDataGeneratedAccessors)

@end

@interface _LMSettings (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveReportDefaultDateFrom;
- (void)setPrimitiveReportDefaultDateFrom:(NSDate*)value;




- (NSDate*)primitiveReportDefaultDateTo;
- (void)setPrimitiveReportDefaultDateTo:(NSDate*)value;




- (NSNumber*)primitiveReportDefaultEnum;
- (void)setPrimitiveReportDefaultEnum:(NSNumber*)value;

- (int64_t)primitiveReportDefaultEnumValue;
- (void)setPrimitiveReportDefaultEnumValue:(int64_t)value_;




- (NSNumber*)primitiveReportDefaultIsEnum;
- (void)setPrimitiveReportDefaultIsEnum:(NSNumber*)value;

- (BOOL)primitiveReportDefaultIsEnumValue;
- (void)setPrimitiveReportDefaultIsEnumValue:(BOOL)value_;





- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;


@end
