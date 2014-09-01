// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserAlert.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyUserObject.h"

extern const struct LMUserAlertAttributes {
	__unsafe_unretained NSString *advertiserId;
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





@property (nonatomic, strong) NSNumber* advertiserId;



@property int16_t advertiserIdValue;
- (int16_t)advertiserIdValue;
- (void)setAdvertiserIdValue:(int16_t)value_;

//- (BOOL)validateAdvertiserId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* borderType;



@property int16_t borderTypeValue;
- (int16_t)borderTypeValue;
- (void)setBorderTypeValue:(int16_t)value_;

//- (BOOL)validateBorderType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* dateFrom;



//- (BOOL)validateDateFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* dateTo;



//- (BOOL)validateDateTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hour;



@property int16_t hourValue;
- (int16_t)hourValue;
- (void)setHourValue:(int16_t)value_;

//- (BOOL)validateHour:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* monitorType;



@property int16_t monitorTypeValue;
- (int16_t)monitorTypeValue;
- (void)setMonitorTypeValue:(int16_t)value_;

//- (BOOL)validateMonitorType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* objectId;



@property int64_t objectIdValue;
- (int64_t)objectIdValue;
- (void)setObjectIdValue:(int64_t)value_;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* paramType;



@property int16_t paramTypeValue;
- (int16_t)paramTypeValue;
- (void)setParamTypeValue:(int16_t)value_;

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


- (NSNumber*)primitiveAdvertiserId;
- (void)setPrimitiveAdvertiserId:(NSNumber*)value;

- (int16_t)primitiveAdvertiserIdValue;
- (void)setPrimitiveAdvertiserIdValue:(int16_t)value_;




- (NSNumber*)primitiveBorderType;
- (void)setPrimitiveBorderType:(NSNumber*)value;

- (int16_t)primitiveBorderTypeValue;
- (void)setPrimitiveBorderTypeValue:(int16_t)value_;




- (NSDate*)primitiveDateFrom;
- (void)setPrimitiveDateFrom:(NSDate*)value;




- (NSDate*)primitiveDateTo;
- (void)setPrimitiveDateTo:(NSDate*)value;




- (NSNumber*)primitiveHour;
- (void)setPrimitiveHour:(NSNumber*)value;

- (int16_t)primitiveHourValue;
- (void)setPrimitiveHourValue:(int16_t)value_;




- (NSNumber*)primitiveMonitorType;
- (void)setPrimitiveMonitorType:(NSNumber*)value;

- (int16_t)primitiveMonitorTypeValue;
- (void)setPrimitiveMonitorTypeValue:(int16_t)value_;




- (NSNumber*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSNumber*)value;

- (int64_t)primitiveObjectIdValue;
- (void)setPrimitiveObjectIdValue:(int64_t)value_;




- (NSNumber*)primitiveParamType;
- (void)setPrimitiveParamType:(NSNumber*)value;

- (int16_t)primitiveParamTypeValue;
- (void)setPrimitiveParamTypeValue:(int16_t)value_;




- (NSNumber*)primitiveProgramId;
- (void)setPrimitiveProgramId:(NSNumber*)value;

- (int64_t)primitiveProgramIdValue;
- (void)setPrimitiveProgramIdValue:(int64_t)value_;




- (NSString*)primitiveValue;
- (void)setPrimitiveValue:(NSString*)value;





- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;


@end
