// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSettings.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMSettingsAttributes {
	__unsafe_unretained NSString *alertDefaultBorderType;
	__unsafe_unretained NSString *alertDefaultHour;
	__unsafe_unretained NSString *alertDefaultMonitorType;
	__unsafe_unretained NSString *alertDefaultPointer;
	__unsafe_unretained NSString *alertDefaultValue;
	__unsafe_unretained NSString *reportDefaultDateFrom;
	__unsafe_unretained NSString *reportDefaultDateTo;
	__unsafe_unretained NSString *reportDefaultEnum;
	__unsafe_unretained NSString *reportDefaultIsEnum;
} LMSettingsAttributes;

extern const struct LMSettingsRelationships {
	__unsafe_unretained NSString *user;
} LMSettingsRelationships;

@class LMUser;

@interface LMSettingsID : NSManagedObjectID {}
@end

@interface _LMSettings : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LMSettingsID* objectID;

@property (nonatomic, strong) NSNumber* alertDefaultBorderType;

@property (atomic) int16_t alertDefaultBorderTypeValue;
- (int16_t)alertDefaultBorderTypeValue;
- (void)setAlertDefaultBorderTypeValue:(int16_t)value_;

//- (BOOL)validateAlertDefaultBorderType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* alertDefaultHour;

@property (atomic) int16_t alertDefaultHourValue;
- (int16_t)alertDefaultHourValue;
- (void)setAlertDefaultHourValue:(int16_t)value_;

//- (BOOL)validateAlertDefaultHour:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* alertDefaultMonitorType;

@property (atomic) int16_t alertDefaultMonitorTypeValue;
- (int16_t)alertDefaultMonitorTypeValue;
- (void)setAlertDefaultMonitorTypeValue:(int16_t)value_;

//- (BOOL)validateAlertDefaultMonitorType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* alertDefaultPointer;

@property (atomic) int16_t alertDefaultPointerValue;
- (int16_t)alertDefaultPointerValue;
- (void)setAlertDefaultPointerValue:(int16_t)value_;

//- (BOOL)validateAlertDefaultPointer:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* alertDefaultValue;

@property (atomic) int16_t alertDefaultValueValue;
- (int16_t)alertDefaultValueValue;
- (void)setAlertDefaultValueValue:(int16_t)value_;

//- (BOOL)validateAlertDefaultValue:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* reportDefaultDateFrom;

//- (BOOL)validateReportDefaultDateFrom:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* reportDefaultDateTo;

//- (BOOL)validateReportDefaultDateTo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* reportDefaultEnum;

@property (atomic) int16_t reportDefaultEnumValue;
- (int16_t)reportDefaultEnumValue;
- (void)setReportDefaultEnumValue:(int16_t)value_;

//- (BOOL)validateReportDefaultEnum:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* reportDefaultIsEnum;

@property (atomic) BOOL reportDefaultIsEnumValue;
- (BOOL)reportDefaultIsEnumValue;
- (void)setReportDefaultIsEnumValue:(BOOL)value_;

//- (BOOL)validateReportDefaultIsEnum:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _LMSettings (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAlertDefaultBorderType;
- (void)setPrimitiveAlertDefaultBorderType:(NSNumber*)value;

- (int16_t)primitiveAlertDefaultBorderTypeValue;
- (void)setPrimitiveAlertDefaultBorderTypeValue:(int16_t)value_;

- (NSNumber*)primitiveAlertDefaultHour;
- (void)setPrimitiveAlertDefaultHour:(NSNumber*)value;

- (int16_t)primitiveAlertDefaultHourValue;
- (void)setPrimitiveAlertDefaultHourValue:(int16_t)value_;

- (NSNumber*)primitiveAlertDefaultMonitorType;
- (void)setPrimitiveAlertDefaultMonitorType:(NSNumber*)value;

- (int16_t)primitiveAlertDefaultMonitorTypeValue;
- (void)setPrimitiveAlertDefaultMonitorTypeValue:(int16_t)value_;

- (NSNumber*)primitiveAlertDefaultPointer;
- (void)setPrimitiveAlertDefaultPointer:(NSNumber*)value;

- (int16_t)primitiveAlertDefaultPointerValue;
- (void)setPrimitiveAlertDefaultPointerValue:(int16_t)value_;

- (NSNumber*)primitiveAlertDefaultValue;
- (void)setPrimitiveAlertDefaultValue:(NSNumber*)value;

- (int16_t)primitiveAlertDefaultValueValue;
- (void)setPrimitiveAlertDefaultValueValue:(int16_t)value_;

- (NSDate*)primitiveReportDefaultDateFrom;
- (void)setPrimitiveReportDefaultDateFrom:(NSDate*)value;

- (NSDate*)primitiveReportDefaultDateTo;
- (void)setPrimitiveReportDefaultDateTo:(NSDate*)value;

- (NSNumber*)primitiveReportDefaultEnum;
- (void)setPrimitiveReportDefaultEnum:(NSNumber*)value;

- (int16_t)primitiveReportDefaultEnumValue;
- (void)setPrimitiveReportDefaultEnumValue:(int16_t)value_;

- (NSNumber*)primitiveReportDefaultIsEnum;
- (void)setPrimitiveReportDefaultIsEnum:(NSNumber*)value;

- (BOOL)primitiveReportDefaultIsEnumValue;
- (void)setPrimitiveReportDefaultIsEnumValue:(BOOL)value_;

- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;

@end
