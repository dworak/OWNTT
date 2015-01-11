// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUserReport.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyUserObject.h"

extern const struct LMUserReportAttributes {
	__unsafe_unretained NSString *advertiserId;
	__unsafe_unretained NSString *instanceId;
	__unsafe_unretained NSString *programId;
	__unsafe_unretained NSString *reportId;
	__unsafe_unretained NSString *timeintervalType;
} LMUserReportAttributes;

extern const struct LMUserReportRelationships {
	__unsafe_unretained NSString *reportObject;
	__unsafe_unretained NSString *user;
} LMUserReportRelationships;

@class LMReport;
@class LMUser;

@interface LMUserReportID : LMReadOnlyUserObjectID {}
@end

@interface _LMUserReport : LMReadOnlyUserObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LMUserReportID* objectID;

@property (nonatomic, strong) NSNumber* advertiserId;

@property (atomic) int64_t advertiserIdValue;
- (int64_t)advertiserIdValue;
- (void)setAdvertiserIdValue:(int64_t)value_;

//- (BOOL)validateAdvertiserId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* instanceId;

@property (atomic) int64_t instanceIdValue;
- (int64_t)instanceIdValue;
- (void)setInstanceIdValue:(int64_t)value_;

//- (BOOL)validateInstanceId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* programId;

@property (atomic) int64_t programIdValue;
- (int64_t)programIdValue;
- (void)setProgramIdValue:(int64_t)value_;

//- (BOOL)validateProgramId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* reportId;

@property (atomic) int64_t reportIdValue;
- (int64_t)reportIdValue;
- (void)setReportIdValue:(int64_t)value_;

//- (BOOL)validateReportId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeintervalType;

@property (atomic) int16_t timeintervalTypeValue;
- (int16_t)timeintervalTypeValue;
- (void)setTimeintervalTypeValue:(int16_t)value_;

//- (BOOL)validateTimeintervalType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LMReport *reportObject;

//- (BOOL)validateReportObject:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _LMUserReport (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAdvertiserId;
- (void)setPrimitiveAdvertiserId:(NSNumber*)value;

- (int64_t)primitiveAdvertiserIdValue;
- (void)setPrimitiveAdvertiserIdValue:(int64_t)value_;

- (NSNumber*)primitiveInstanceId;
- (void)setPrimitiveInstanceId:(NSNumber*)value;

- (int64_t)primitiveInstanceIdValue;
- (void)setPrimitiveInstanceIdValue:(int64_t)value_;

- (NSNumber*)primitiveProgramId;
- (void)setPrimitiveProgramId:(NSNumber*)value;

- (int64_t)primitiveProgramIdValue;
- (void)setPrimitiveProgramIdValue:(int64_t)value_;

- (NSNumber*)primitiveReportId;
- (void)setPrimitiveReportId:(NSNumber*)value;

- (int64_t)primitiveReportIdValue;
- (void)setPrimitiveReportIdValue:(int64_t)value_;

- (NSNumber*)primitiveTimeintervalType;
- (void)setPrimitiveTimeintervalType:(NSNumber*)value;

- (int16_t)primitiveTimeintervalTypeValue;
- (void)setPrimitiveTimeintervalTypeValue:(int16_t)value_;

- (LMReport*)primitiveReportObject;
- (void)setPrimitiveReportObject:(LMReport*)value;

- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;

@end
