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
        case RreportTimeInterval_ActualMonth:
            return LM_LOCALIZE(@"reportTimeInterval_ActualMonth");
        default:
            return nil;
    }
}

+ (NSString *)alertMonitoringTypeToString:(AlertMonitoringTypes)monitoringType
{
    switch (monitoringType) {
        case AlertMonitoringTypes_Daily:
            return LM_LOCALIZE(@"alertMonitoringTypes_Daily");
        case AlertMonitoringTypes_Growing:
            return LM_LOCALIZE(@"lertMonitoringTypes_Growing");
        default:
            return nil;
    }
}

+ (NSString *)alertPointerTypeToString:(AlertPointerTypes)pointerType
{
    switch (pointerType) {
        case AlertPointertypes_Display:
            return LM_LOCALIZE(@"alertPointertypes_Display");
        case AlertPointertypes_Click:
            return LM_LOCALIZE(@"alertPointertypes_Click");
        case AlertPointertypes_Visit:
            return LM_LOCALIZE(@"alertPointertypes_Visit");
        case AlertPointertypes_NewVisit:
            return LM_LOCALIZE(@"alertPointertypes_NewVisit");
        case AlertPointertypes_Checkpoint:
            return LM_LOCALIZE(@"alertPointertypes_Checkpoint");
        case AlertPointertypes_Lead:
            return LM_LOCALIZE(@"alertPointertypes_Lead");
        case AlertPointertypes_Sale:
            return LM_LOCALIZE(@"alertPointertypes_Sale");
        case AlertPointertypes_WebTime:
            return LM_LOCALIZE(@"alertPointertypes_WebTime");
        default:
            return nil;
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

+ (void)showErrorAlertWithText:(NSString *)text
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Błąd" message:text delegate:self cancelButtonTitle:@"Popraw" otherButtonTitles:nil];
    [alertView show];
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

+ (NSArray*)datesForReportTimeInterval:(NSString *)timeinterval
{
    NSDate *today = [NSDate date];
    NSArray *datesArray;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    if([timeinterval isEqual:@"Ten rok"])
    {
        NSDateComponents *dateComponents = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
        [dateComponents setDay:1];
        [dateComponents setMonth:1];
        datesArray = [NSArray arrayWithObjects:[gregorian dateFromComponents:dateComponents], today, nil];
    }
    else if([timeinterval isEqual:@"Aktualny miesiąc"])
    {
        NSDateComponents *dateComponents = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
        [dateComponents setDay:1];
        datesArray = [NSArray arrayWithObjects:[gregorian dateFromComponents:dateComponents], today, nil];
    }
    else if([timeinterval isEqual:@"Poprzedni miesiąc"])
    {
        NSDateComponents* comps = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
        
        // Set your month here
        [comps setDay:10];
        [comps setMonth:comps.month-1];
        
        NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:[gregorian dateFromComponents:comps]];
        int numberOfNaysInMonth = range.length;
        [comps setDay:1];
        NSDate *dateFrom = [gregorian dateFromComponents:comps];
        [comps setDay:numberOfNaysInMonth];;
        NSDate *dateTo = [gregorian dateFromComponents:comps];
        datesArray = [NSArray arrayWithObjects:dateFrom, dateTo, nil];
    }
    else if([timeinterval isEqual:@"Poprzedni tydzień"])
    {
        
    }
    else if([timeinterval isEqual:@"Ten tydzień"])
    {
        
    }
    else if([timeinterval isEqual:@"Wczoraj"])
    {
        
    }
    else if([timeinterval isEqual:@"Dzisiaj"])
    {
        return [NSArray arrayWithObjects:today, today, nil];
    }
    return [NSArray arrayWithObjects:[NSDate date], [NSDate date], nil];
}

@end
