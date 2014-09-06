//
//  LMUtils.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import "Constans.h"
#import "LMAppDelegate.h"
#import "LMBranchAdvertiserViewController.h"
#import "LMBranchInstanceViewController.h"
#import "LMBranchProgramViewController.h"
#import "LMUtils.h"
#import "LMUser.h"
#import "LMReportWS.h"
#import "LMReport.h"
#import "LMInstance.h"
#import "LMAdvertiser.h"
#import "LMProgram.h"
#import "LMReport.h"
#import "LMReadOnlyObject.h"
#import "LMSettings.h"

@implementation LMUtils
+ (NSString *)reportTimeIntervalTypeToString:(ReportTimeIntervalType)reportType
{
    switch (reportType) {
        case ReportTimeInterval_PreviousMonth:
            return LM_LOCALIZE(@"reportTimeInterval_PreviousMonth");
        case ReportTimeInterval_PreviousWeek:
            return LM_LOCALIZE(@"reportTimeInterval_PreviousWeek");
        case ReportTimeInterval_ThisWeek:
            return LM_LOCALIZE(@"reportTimeInterval_ThisWeek");
        case ReportTimeInterval_ThisYear:
            return LM_LOCALIZE(@"reportTimeInterval_ThisYear");
        case ReportTimeInterval_Today:
            return LM_LOCALIZE(@"reportTimeInterval_Today");
        case ReportTimeInterval_Yesterday:
            return LM_LOCALIZE(@"reportTimeInterval_Yesterday");
        case ReportTimeInterval_ActualMonth:
            return LM_LOCALIZE(@"reportTimeInterval_ActualMonth");
        case ReportTimeInterval_Custom:
            return LM_LOCALIZE(@"reportTimeInterval_Custom");
        default:
            return nil;
    }
}

+ (ReportTimeIntervalType)reportTimeIntervalStringToType:(NSString *)reportStr
{
    if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_PreviousMonth")])
    {
        return ReportTimeInterval_PreviousMonth;
    }
    else if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_PreviousWeek")])
    {
        return ReportTimeInterval_PreviousWeek;
    }
    else if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_ThisWeek")])
    {
        return ReportTimeInterval_ThisWeek;
    }
    else if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_ThisYear")])
    {
        return ReportTimeInterval_ThisYear;
    }
    else if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_Today")])
    {
        return ReportTimeInterval_Today;
    }
    else if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_Yesterday")])
    {
        return ReportTimeInterval_Yesterday;
    }
    else if([reportStr isEqualToString:LM_LOCALIZE(@"reportTimeInterval_ActualMonth")])
    {
        return ReportTimeInterval_ActualMonth;
    }
    else
    {
        return ReportTimeInterval_Custom;
    }
}

+ (NSString *)alertMonitoringTypeToString:(AlertMonitoringTypes)monitoringType
{
    switch (monitoringType) {
        case AlertMonitoringTypes_Daily:
            return LM_LOCALIZE(@"alertMonitoringTypes_Daily");
        case AlertMonitoringTypes_Growing:
            return LM_LOCALIZE(@"alertMonitoringTypes_Growing");
        default:
            return nil;
    }
}

+ (AlertMonitoringTypes)alertMonitoringStringToType:(NSString *)monitoringStr
{
    if([monitoringStr isEqualToString:LM_LOCALIZE(@"alertMonitoringTypes_Daily")])
    {
        return AlertMonitoringTypes_Daily;
    }
    else
    {
        return AlertMonitoringTypes_Growing;
    }
}

+ (NSString *)alertPointerTypeToString:(AlertPointerTypes)pointerType
{
    switch (pointerType) {
        case AlertPointertypes_Display:
            return LM_LOCALIZE(@"alertPointerTypes_Display");
        case AlertPointertypes_Click:
            return LM_LOCALIZE(@"alertPointerTypes_Click");
        case AlertPointertypes_Visit:
            return LM_LOCALIZE(@"alertPointerTypes_Visit");
        case AlertPointertypes_NewVisit:
            return LM_LOCALIZE(@"alertPointerTypes_NewVisit");
        case AlertPointertypes_Checkpoint:
            return LM_LOCALIZE(@"alertPointerTypes_Checkpoint");
        case AlertPointertypes_Lead:
            return LM_LOCALIZE(@"alertPointerTypes_Lead");
        case AlertPointertypes_Sale:
            return LM_LOCALIZE(@"alertPointerTypes_Sale");
        case AlertPointertypes_WebTime:
            return LM_LOCALIZE(@"alertPointerTypes_WebTime");
        default:
            return nil;
    }
}

+ (AlertPointerTypes)alertPointerStringToType:(NSString *)pointerStr
{
    if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_Display")])
    {
        return AlertPointertypes_Display;
    }
    else if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_Click")])
    {
        return AlertPointertypes_Click;
    }
    else if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_Visit")])
    {
        return AlertPointertypes_Visit;
    }
    else if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_NewVisit")])
    {
        return AlertPointertypes_NewVisit;
    }
    else if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_Checkpoint")])
    {
        return AlertPointertypes_Checkpoint;
    }
    else if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_Lead")])
    {
        return AlertPointertypes_Lead;
    }
    else if([pointerStr isEqualToString:LM_LOCALIZE(@"alertPointertypes_Sale")])
    {
        return AlertPointertypes_Sale;
    }
    else
    {
        return AlertPointertypes_WebTime;
    }
}

+ (NSString *)alertBorderTypeToString:(AlertBorderTypes)borderType
{
    switch (borderType) {
        case AlertBorderTypes_GreaterThan:
            return LM_LOCALIZE(@"alertBorderTypes_GreaterThan");
        case AlertBorderTypes_LessThan:
            return LM_LOCALIZE(@"alertBorderTypes_LessThan");
        default:
            return nil;
    }
}

+ (AlertBorderTypes)alertBorderStringToType:(NSString *)borderStr
{
    if([borderStr isEqualToString:LM_LOCALIZE(@"alertBorderType_GreaterThan")])
    {
        return AlertBorderTypes_GreaterThan;
    }
    else
    {
        return AlertBorderTypes_LessThan;
    }
}

+ (void)getCurrentUser
{
    LMAppDelegate *appDelegate = (LMAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *users = [LMUser fetchLMUsersInContext:[[LMCoreDataManager sharedInstance] masterManagedObjectContext]];
    NSAssert(users.count < 2, @"Fatal error: users > 1");
    if(users.count == 0)
    {
        return;
    }
    appDelegate.appUtils.currentUser = [users objectAtIndex:0];
}

+ (UIViewController *)checkAndSetControllersByTreeHierarchyForStoryboard:(UIStoryboard *)storyboard
{
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LMBranchAdvertiserViewController class])];
}

+ (void)saveCoreDataContext:(id)context {
    if(!context) {
        NSLog(@"Null context");
        return;
    }
    if(context == [[LMCoreDataManager sharedInstance] masterManagedObjectContext]) {
        [[LMCoreDataManager sharedInstance] saveMasterContext];
    } else {
        [context performBlockAndWait:^{
            NSError *error = nil;
            BOOL saved = [context save:&error];
            if (!saved) {
                // do some real error handling
                NSLog(@"Could not save background context due to %@", error);
            } else {
                [[LMCoreDataManager sharedInstance] saveMasterContext];
            }
        }];
    }
}

+ (UIViewController *)currentStoryboardControllerForIdentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

+ (BOOL)validateEmail:(NSString *)candidate {
    if(candidate.length > 255 || candidate.length < 1) {
        return NO;
    }
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)isNumeric:(NSString*)inputString {
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}

+ (void)storeCurrentInstance:(NSNumber *)instanceId
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:instanceId forKey:USER_DEFAULTS_CURRENT_INSTANCE];
    [standardUserDefaults synchronize];
}

+ (void)removeCurrentInstance
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:nil forKey:USER_DEFAULTS_CURRENT_INSTANCE];
    [standardUserDefaults synchronize];
}

+ (NSNumber *)getCurrentInstance
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    return [standardUserDefaults valueForKey:USER_DEFAULTS_CURRENT_INSTANCE];
}

+ (void)storeCurrentDate
{
    NSDateFormatter *dF = [NSDateFormatter new];
    [dF setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:[dF stringFromDate:[NSDate date]] forKey:USER_DEFAULTS_CURRENT_DATE];
    [standardUserDefaults synchronize];
}

+ (NSDate *)getCurrentDate
{
    NSDateFormatter *dF = [NSDateFormatter new];
    [dF setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *dateStr = [standardUserDefaults valueForKey:USER_DEFAULTS_CURRENT_DATE];
    if(dateStr)
    {
        return [dF dateFromString:dateStr];
    }
    else
    {
        return nil;
    }
}

+ (void)createReportObjects
{
}

+(void)performSynchronization: (BOOL) initial
{
    LMSynchronizationService *synchInstance = [LMSynchronizationService instance];
    
    BOOL running = [synchInstance isSynchronizationRunning];
    
    if(!running)
    {
        [synchInstance downloadTree:initial];
        [synchInstance downloadUserAlerts:initial];
    }
}

+ (NSArray*)datesForReportTimeInterval:(ReportTimeIntervalType)timeintervalType
{
    NSDate *today = [NSDate date];
    NSArray *datesArray;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    switch (timeintervalType) {
        case ReportTimeInterval_ThisYear:
        {
            NSDateComponents *dateComponents = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
            [dateComponents setDay:1];
            [dateComponents setMonth:1];
            datesArray = [NSArray arrayWithObjects:[gregorian dateFromComponents:dateComponents], today, nil];
            break;
        }
        case ReportTimeInterval_ActualMonth:
        {
            NSDateComponents *dateComponents = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
            [dateComponents setDay:1];
            datesArray = [NSArray arrayWithObjects:[gregorian dateFromComponents:dateComponents], today, nil];
            break;
        }
        case ReportTimeInterval_PreviousMonth:
        {
            NSDateComponents* comps = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
            
            // Set your month here
            [comps setDay:10];
            [comps setMonth:comps.month-1];
            
            NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit
                                            inUnit:NSMonthCalendarUnit
                                           forDate:[gregorian dateFromComponents:comps]];
            int numberOfNaysInMonth = (int)range.length;
            [comps setDay:1];
            NSDate *dateFrom = [gregorian dateFromComponents:comps];
            [comps setDay:numberOfNaysInMonth];;
            NSDate *dateTo = [gregorian dateFromComponents:comps];
            datesArray = [NSArray arrayWithObjects:dateFrom, dateTo, nil];
            break;
        }
        case ReportTimeInterval_PreviousWeek:
        {
            NSCalendar *cal = [NSCalendar currentCalendar];
            [cal setFirstWeekday:2];    //2 is monday. 1:Sunday .. 7:Saturday don't set it, if user's locale should determine the start of a week
            NSDateFormatter *dFor = [NSDateFormatter new];
            [dFor setDateFormat:@"yyyy-MM-dd"];
            NSDate *now = [NSDate date];
            NSDate *monday;
            [cal rangeOfUnit:NSWeekCalendarUnit  // we want to have the start of the week
                   startDate:&monday             // we will write the date object to monday
                    interval:NULL                // we don't care for the seconds a week has
                     forDate:now];               // we want the monday of today's week
            NSDateComponents *san = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:monday];
            [san setDay:san.day-1];
            monday = [cal dateFromComponents:san];
            [san setDay:san.day - 6];
            NSDate *saturday = [cal dateFromComponents:san];
            datesArray = [NSArray arrayWithObjects:monday, saturday, nil];
            break;
        }
        case ReportTimeInterval_ThisWeek:
        {
            NSCalendar *cal = [NSCalendar currentCalendar];
            [cal setFirstWeekday:2];    //2 is monday. 1:Sunday .. 7:Saturday don't set it, if user's locale should determine the start of a week
            NSDateFormatter *dFor = [NSDateFormatter new];
            [dFor setDateFormat:@"yyyy-MM-dd"];
            NSDate *now = [NSDate date];
            NSDate *monday;
            [cal rangeOfUnit:NSWeekCalendarUnit  // we want to have the start of the week
                   startDate:&monday             // we will write the date object to monday
                    interval:NULL                // we don't care for the seconds a week has
                     forDate:now];               // we want the monday of today's week
            NSDateComponents *san = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:monday];
            [san setDay:san.day+6];
            NSDate *saturday = [cal dateFromComponents:san];
            datesArray = [NSArray arrayWithObjects:monday, saturday, nil];
            break;
        }
        case ReportTimeInterval_Yesterday:
        {
            NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];
            datesArray = [NSArray arrayWithObjects:yesterday, yesterday, nil];
            break;
        }
        case ReportTimeInterval_Today:
            return [NSArray arrayWithObjects:today, today, nil];
        default:
            return [NSArray arrayWithObjects:[NSDate date], [NSDate date], nil];
    }
    return datesArray;
}

+ (void)setupCurrentLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    if(![preferredLang isEqualToString:@"pl"])
    {
        preferredLang = @"en";
    }
    
    LocalizationSetLanguage(preferredLang);
}

@end
