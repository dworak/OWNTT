// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LMInstance.h instead.

#import <CoreData/CoreData.h>
#import "LMReadOnlyObject.h"

extern const struct LMInstanceAttributes {
	__unsafe_unretained NSString *report1;
	__unsafe_unretained NSString *report5;
	__unsafe_unretained NSString *report8;
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





@property (nonatomic, strong) NSNumber* report1;



@property BOOL report1Value;
- (BOOL)report1Value;
- (void)setReport1Value:(BOOL)value_;

//- (BOOL)validateReport1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* report5;



@property BOOL report5Value;
- (BOOL)report5Value;
- (void)setReport5Value:(BOOL)value_;

//- (BOOL)validateReport5:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* report8;



@property BOOL report8Value;
- (BOOL)report8Value;
- (void)setReport8Value:(BOOL)value_;

//- (BOOL)validateReport8:(id*)value_ error:(NSError**)error_;





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


- (NSNumber*)primitiveReport1;
- (void)setPrimitiveReport1:(NSNumber*)value;

- (BOOL)primitiveReport1Value;
- (void)setPrimitiveReport1Value:(BOOL)value_;




- (NSNumber*)primitiveReport5;
- (void)setPrimitiveReport5:(NSNumber*)value;

- (BOOL)primitiveReport5Value;
- (void)setPrimitiveReport5Value:(BOOL)value_;




- (NSNumber*)primitiveReport8;
- (void)setPrimitiveReport8:(NSNumber*)value;

- (BOOL)primitiveReport8Value;
- (void)setPrimitiveReport8Value:(BOOL)value_;





- (NSMutableSet*)primitiveAdvertisers;
- (void)setPrimitiveAdvertisers:(NSMutableSet*)value;



- (NSMutableSet*)primitiveReports;
- (void)setPrimitiveReports:(NSMutableSet*)value;


@end
