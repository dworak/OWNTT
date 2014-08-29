// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMInstance.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMInstanceAttributes {
	__unsafe_unretained NSString *isReport1;
	__unsafe_unretained NSString *isReport5;
	__unsafe_unretained NSString *isReport8;
} LMInstanceAttributes;

extern const struct LMInstanceRelationships {
	__unsafe_unretained NSString *advertisers;
	__unsafe_unretained NSString *reports;
} LMInstanceRelationships;

extern const struct LMInstanceFetchedProperties {
} LMInstanceFetchedProperties;

@class LMAdvertiser;
@class LMReport;





@interface LMInstanceID : NSManagedObjectID {}
@end

@interface _LMInstance : LMReadOnlyObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LMInstanceID*)objectID;





@property (nonatomic, strong) NSNumber* isReport1;



@property BOOL isReport1Value;
- (BOOL)isReport1Value;
- (void)setIsReport1Value:(BOOL)value_;

//- (BOOL)validateIsReport1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isReport5;



@property BOOL isReport5Value;
- (BOOL)isReport5Value;
- (void)setIsReport5Value:(BOOL)value_;

//- (BOOL)validateIsReport5:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isReport8;



@property BOOL isReport8Value;
- (BOOL)isReport8Value;
- (void)setIsReport8Value:(BOOL)value_;

//- (BOOL)validateIsReport8:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *advertisers;

- (NSMutableSet*)advertisersSet;




@property (nonatomic, strong) NSSet *reports;

- (NSMutableSet*)reportsSet;





@end

@interface _LMInstance (CoreDataGeneratedAccessors)

- (void)addAdvertisers:(NSSet*)value_;
- (void)removeAdvertisers:(NSSet*)value_;
- (void)addAdvertisersObject:(LMAdvertiser*)value_;
- (void)removeAdvertisersObject:(LMAdvertiser*)value_;

- (void)addReports:(NSSet*)value_;
- (void)removeReports:(NSSet*)value_;
- (void)addReportsObject:(LMReport*)value_;
- (void)removeReportsObject:(LMReport*)value_;

@end

@interface _LMInstance (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsReport1;
- (void)setPrimitiveIsReport1:(NSNumber*)value;

- (BOOL)primitiveIsReport1Value;
- (void)setPrimitiveIsReport1Value:(BOOL)value_;




- (NSNumber*)primitiveIsReport5;
- (void)setPrimitiveIsReport5:(NSNumber*)value;

- (BOOL)primitiveIsReport5Value;
- (void)setPrimitiveIsReport5Value:(BOOL)value_;




- (NSNumber*)primitiveIsReport8;
- (void)setPrimitiveIsReport8:(NSNumber*)value;

- (BOOL)primitiveIsReport8Value;
- (void)setPrimitiveIsReport8Value:(BOOL)value_;





- (NSMutableSet*)primitiveAdvertisers;
- (void)setPrimitiveAdvertisers:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReports;
- (void)setPrimitiveReports:(NSMutableSet*)value;


@end
