// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserAlert.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyUserObject.h"

extern const struct LMUserAlertAttributes {
	__unsafe_unretained NSString *borderType;
	__unsafe_unretained NSString *dateFrom;
	__unsafe_unretained NSString *dateTo;
	__unsafe_unretained NSString *hour;
	__unsafe_unretained NSString *monitorType;
	__unsafe_unretained NSString *objectId;
	__unsafe_unretained NSString *paramType;
	__unsafe_unretained NSString *programId;
	__unsafe_unretained NSString *value;
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





@property (nonatomic, strong) NSNumber* borderType;



@property double borderTypeValue;
- (double)borderTypeValue;
- (void)setBorderTypeValue:(double)value_;

//- (BOOL)validateBorderType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* dateFrom;



//- (BOOL)validateDateFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* dateTo;



//- (BOOL)validateDateTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hour;



@property int64_t hourValue;
- (int64_t)hourValue;
- (void)setHourValue:(int64_t)value_;

//- (BOOL)validateHour:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* monitorType;



@property int64_t monitorTypeValue;
- (int64_t)monitorTypeValue;
- (void)setMonitorTypeValue:(int64_t)value_;

//- (BOOL)validateMonitorType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* objectId;



@property int64_t objectIdValue;
- (int64_t)objectIdValue;
- (void)setObjectIdValue:(int64_t)value_;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* paramType;



@property int64_t paramTypeValue;
- (int64_t)paramTypeValue;
- (void)setParamTypeValue:(int64_t)value_;

//- (BOOL)validateParamType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* programId;



@property int64_t programIdValue;
- (int64_t)programIdValue;
- (void)setProgramIdValue:(int64_t)value_;

//- (BOOL)validateProgramId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* value;



//- (BOOL)validateValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _LMUserAlert (CoreDataGeneratedAccessors)

@end

@interface _LMUserAlert (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveBorderType;
- (void)setPrimitiveBorderType:(NSNumber*)value;

- (double)primitiveBorderTypeValue;
- (void)setPrimitiveBorderTypeValue:(double)value_;




- (NSDate*)primitiveDateFrom;
- (void)setPrimitiveDateFrom:(NSDate*)value;




- (NSDate*)primitiveDateTo;
- (void)setPrimitiveDateTo:(NSDate*)value;




- (NSNumber*)primitiveHour;
- (void)setPrimitiveHour:(NSNumber*)value;

- (int64_t)primitiveHourValue;
- (void)setPrimitiveHourValue:(int64_t)value_;




- (NSNumber*)primitiveMonitorType;
- (void)setPrimitiveMonitorType:(NSNumber*)value;

- (int64_t)primitiveMonitorTypeValue;
- (void)setPrimitiveMonitorTypeValue:(int64_t)value_;




- (NSNumber*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSNumber*)value;

- (int64_t)primitiveObjectIdValue;
- (void)setPrimitiveObjectIdValue:(int64_t)value_;




- (NSNumber*)primitiveParamType;
- (void)setPrimitiveParamType:(NSNumber*)value;

- (int64_t)primitiveParamTypeValue;
- (void)setPrimitiveParamTypeValue:(int64_t)value_;




- (NSNumber*)primitiveProgramId;
- (void)setPrimitiveProgramId:(NSNumber*)value;

- (int64_t)primitiveProgramIdValue;
- (void)setPrimitiveProgramIdValue:(int64_t)value_;




- (NSString*)primitiveValue;
- (void)setPrimitiveValue:(NSString*)value;





- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;


@end
