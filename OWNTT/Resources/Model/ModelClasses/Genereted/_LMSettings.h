// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMSettings.h instead.

#import <CoreData/CoreData.h>
#import "ManagedObject.h"

extern const struct LMSettingsAttributes {
	__unsafe_unretained NSString *reportDefaultDate;
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





@property (nonatomic, strong) NSString* reportDefaultDate;



//- (BOOL)validateReportDefaultDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) LMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _LMSettings (CoreDataGeneratedAccessors)

@end

@interface _LMSettings (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveReportDefaultDate;
- (void)setPrimitiveReportDefaultDate:(NSString*)value;





- (LMUser*)primitiveUser;
- (void)setPrimitiveUser:(LMUser*)value;


@end
