//
//  LMUtils.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    ReportTimeInterval_ThisYear = 1,
    ReportTimeInterval_PreviousMonth,
    ReportTimeInterval_ActualMonth,
    ReportTimeInterval_PreviousWeek,
    ReportTimeInterval_ThisWeek,
    ReportTimeInterval_Yesterday,
    ReportTimeInterval_Today,
    ReportTimeInterval_Custom
} ReportTimeIntervalType;

typedef enum {
    AlertMonitoringTypes_Growing = 1,
    AlertMonitoringTypes_Daily,
    AlertMonitoringTypes_Continuous
} AlertMonitoringTypes;

typedef enum {
    AlertPointertypes_Display = 1,
    AlertPointertypes_Click,
    AlertPointertypes_Visit,
    AlertPointertypes_NewVisit,
    AlertPointertypes_WebTime,
    AlertPointertypes_Checkpoint,
    AlertPointertypes_Lead,
    AlertPointertypes_Sale,
    AlertPointertypes_CTR,
    AlertPointertypes_LR
} AlertPointerTypes;

typedef enum {
    AlertBorderTypes_GreaterThan = 1,
    AlertBorderTypes_LessThan
} AlertBorderTypes;

@interface LMUtils : NSObject
+ (NSString *)reportTimeIntervalTypeToString:(ReportTimeIntervalType)reportType;
+ (NSString *)alertMonitoringTypeToString:(AlertMonitoringTypes)monitoringType;
+ (NSString *)alertPointerTypeToString:(AlertPointerTypes)pointerType;
+ (NSString *)alertBorderTypeToString:(AlertBorderTypes)borderType;

+ (void)getCurrentUser;
+ (BOOL)validateEmail:(NSString *)candidate;
+ (BOOL)isNumeric:(NSString*)inputString;

+ (UIViewController *)checkAndSetControllersByTreeHierarchyForStoryboard:(UIStoryboard *)storyboard;
+ (UIViewController *)currentStoryboardControllerForIdentifier:(NSString *)identifier;

+ (void)saveCoreDataContext:(NSManagedObjectContext *)context;
+ (void)storeCurrentInstance:(NSNumber *)instanceId;
+ (void)removeCurrentInstance;
+ (void)createReportObjects;
+ (void)performSynchronization:(BOOL)initial;
+ (void)setupCurrentLanguage;
+ (void)storeCurrentDate;

+ (NSDate *)getCurrentDate;

+ (ReportTimeIntervalType)reportTimeIntervalStringToType:(NSString *)reportStr;
+ (AlertMonitoringTypes)alertMonitoringStringToType:(NSString *)monitoringStr;
+ (AlertPointerTypes)alertPointerStringToType:(NSString *)pointerStr;
+ (AlertBorderTypes)alertBorderStringToType:(NSString *)borderStr;

+ (NSNumber *)getCurrentInstance;

+ (NSArray*)datesForReportTimeInterval:(ReportTimeIntervalType)timeintervalType;
@end
