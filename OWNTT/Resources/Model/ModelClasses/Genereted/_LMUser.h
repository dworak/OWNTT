// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMUser.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMUserAttributes {
	__unsafe_unretained NSString *createDate;
	__unsafe_unretained NSString *deviceToken;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *httpToken;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *password;
	__unsafe_unretained NSString *surname;
} LMUserAttributes;

extern const struct LMUserRelationships {
	__unsafe_unretained NSString *userAlerts;
	__unsafe_unretained NSString *userReports;
} LMUserRelationships;

extern const struct LMUserFetchedProperties {
} LMUserFetchedProperties;

@class LMUserAlert;
@class LMUserReport;









@interface LMUserID : NSManagedObjectID {}
@end

@interface _LMUser : ManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMUserID*)objectID;





@property (nonatomic, strong) NSDate* createDate;



//- (BOOL)validateCreateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* deviceToken;



//- (BOOL)validateDeviceToken:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* httpToken;



//- (BOOL)validateHttpToken:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* password;



//- (BOOL)validatePassword:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* surname;



//- (BOOL)validateSurname:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *userAlerts;

- (NSMutableSet*)userAlertsSet;




@property (nonatomic, strong) NSSet *userReports;

- (NSMutableSet*)userReportsSet;





@end

@interface _LMUser (CoreDataGeneratedAccessors)

- (void)addUserAlerts:(NSSet*)value_;
- (void)removeUserAlerts:(NSSet*)value_;
- (void)addUserAlertsObject:(LMUserAlert*)value_;
- (void)removeUserAlertsObject:(LMUserAlert*)value_;

- (void)addUserReports:(NSSet*)value_;
- (void)removeUserReports:(NSSet*)value_;
- (void)addUserReportsObject:(LMUserReport*)value_;
- (void)removeUserReportsObject:(LMUserReport*)value_;

@end

@interface _LMUser (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreateDate;
- (void)setPrimitiveCreateDate:(NSDate*)value;




- (NSString*)primitiveDeviceToken;
- (void)setPrimitiveDeviceToken:(NSString*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveHttpToken;
- (void)setPrimitiveHttpToken:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePassword;
- (void)setPrimitivePassword:(NSString*)value;




- (NSString*)primitiveSurname;
- (void)setPrimitiveSurname:(NSString*)value;





- (NSMutableSet*)primitiveUserAlerts;
- (void)setPrimitiveUserAlerts:(NSMutableSet*)value;



- (NSMutableSet*)primitiveUserReports;
- (void)setPrimitiveUserReports:(NSMutableSet*)value;


@end
