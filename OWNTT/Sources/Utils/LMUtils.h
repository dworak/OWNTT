//
//  LMUtils.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    ReportTimeInterval_ThisYear = 0,
    ReportTimeInterval_PreviousMonth,
    ReportTimeInterval_ActualMonth,
    ReportTimeInterval_PreviousWeek,
    ReportTimeInterval_ThisWeek,
    ReportTimeInterval_Yesterday,
    ReportTimeInterval_Today,
    ReportTimeInterval_Custom
} ReportTimeIntervalType;

typedef enum {
    AlertMonitoringTypes_Growing = 0,
    AlertMonitoringTypes_Daily
} AlertMonitoringTypes;

typedef enum {
    AlertPointertypes_Display = 0,
    AlertPointertypes_Click,
    AlertPointertypes_Visit,
    AlertPointertypes_NewVisit,
    AlertPointertypes_WebTime,
    AlertPointertypes_Checkpoint,
    AlertPointertypes_Lead,
    AlertPointertypes_Sale
} AlertPointerTypes;

@interface LMUtils : NSObject
+ (NSString *)reportTimeIntervalTypeToString:(ReportTimeIntervalType)reportType;
+ (NSString *)alertMonitoringTypeToString:(AlertMonitoringTypes)monitoringType;
+ (NSString *)alertPointerTypeToString:(AlertPointerTypes)pointerType;

+ (void)getCurrentUser;
+ (BOOL)validateEmail:(NSString *)candidate;
+ (BOOL)isNumeric:(NSString*)inputString;

+ (UIViewController *)checkAndSetControllersByTreeHierarchyForStoryboard:(UIStoryboard *)storyboard;
+ (UIViewController *)currentStoryboardControllerForIdentifier:(NSString *)identifier;

+ (void)saveCoreDataContext:(NSManagedObjectContext *)context;
+ (void)storeCurrentInstance:(NSNumber *)instanceId;
+ (void)removeCurrentInstance;
+ (void)showErrorAlertWithText:(NSString *)text;
+ (void)createReportObjects;
+ (void)performSynchronization:(BOOL)initial;
+ (void)setupCurrentLanguage;

+ (ReportTimeIntervalType)reportTimeIntervalStringToType:(NSString *)reportStr;

+ (NSNumber *)getCurrentInstance;

+ (NSArray*)datesForReportTimeInterval:(ReportTimeIntervalType)timeintervalType;
@end
