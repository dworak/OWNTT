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

@implementation LMUtils
+ (BOOL)userExist {
    NSManagedObjectContext *mOC = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    LMAppDelegate *appDelegate = (LMAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *users = [LMUser fetchLMUsersInContext:mOC];
    NSAssert(users.count < 2, @"Fatal error: users > 1");
    if(users.count > 0)
    {
        appDelegate.appUtils.currentUser = [users objectAtIndex:0];
        return YES;
    }
    else
    {
        return NO;
    }
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

+ (void)downloadAppData
{
    NSManagedObjectContext *context = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:DOWNLOAD_JSON_FILE_NAME ofType:@"json"] options:NSDataReadingMapped error:&error];
    if(error)
    {
        NSLog(@"error: can't load json file");
    }
    //NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error)
    {
        NSLog(@"error: can't parse json file");
    }
    
    //Store data to database
    NSMutableArray *reportArray = [NSMutableArray new];
    if(jsonArray)
    {
        for (NSDictionary *dict in jsonArray)
        {
            LMReportWS *reportWS = [[LMReportWS alloc] initWithDictionary:dict error:&error];
            if(error)
            {
                NSLog(@"error: could not create report ws object");
            }
            else
            {
                [reportArray addObject:reportWS];
            }
        }
    }
    //Unactive all readonly objects
    NSArray *array = [NSManagedObject fetchEntitiesOfClass:[LMReadOnlyObject class] inContext:context];
    for(LMReadOnlyObject *readOnlyObj in array)
    {
        readOnlyObj.activeValue = NO;
    }
    
    if(!error)
    {
        for(LMReportWS *reportWS in reportArray)
        {
            LMInstance *instance;
            LMAdvertiser *advertiser;
            LMProgram *program;
            if(reportWS.InstancjaId)
            {
                instance = (LMInstance *)[LMReadOnlyObject fetchEntityOfClass:[LMInstance class] withObjectID:reportWS.InstancjaId inContext:context];
                if(!instance)
                {
                    instance = [LMInstance createObjectInContext:context];
                    instance.objectIdValue = reportWS.InstancjaId.intValue;
                    if(reportWS.Raport1.intValue)
                    {
                        LMReport *report = (LMReport *)[LMReadOnlyObject fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:1] inContext:context];
                        if(!report)
                        {
                            report = [LMReport createObjectInContext:context];
                            report.objectId = [NSNumber numberWithInt:1];
                        }
                        report.name = @"Raport łączny kampanii";
                        report.activeValue = YES;
                        [instance.reportsSet addObject:report];
                    }
                    if(reportWS.Raport5.intValue)
                    {
                        LMReport *report = (LMReport *)[LMReadOnlyObject fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:2] inContext:context];
                        if(!report)
                        {
                            report = [LMReport createObjectInContext:context];
                            report.objectId = [NSNumber numberWithInt:2];
                        }
                        report.name = @"Raport wszystkich wydawców";
                        report.activeValue = YES;
                        [instance.reportsSet addObject:report];
                    }
                    if(reportWS.Raport8.intValue)
                    {
                        LMReport *report = (LMReport *)[LMReadOnlyObject fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:3] inContext:context];
                        if(!report)
                        {
                            report = [LMReport createObjectInContext:context];
                            report.objectId = [NSNumber numberWithInt:3];
                        }
                        report.name = @"Raport form reklamowych";
                        report.activeValue = YES;
                        [instance.reportsSet addObject:report];
                    }
                }
                instance.name = reportWS.InstancjaNazwa;
                instance.activeValue = YES;
            }
            if(reportWS.ReklamodawcaId)
            {
                advertiser = (LMAdvertiser *)[LMReadOnlyObject fetchEntityOfClass:[LMAdvertiser class] withObjectID:reportWS.ReklamodawcaId inContext:context];
                if(!advertiser)
                {
                    advertiser = [LMAdvertiser createObjectInContext:context];
                    advertiser.objectIdValue = reportWS.ReklamodawcaId.intValue;
                }
                advertiser.name = reportWS.ReklamodawcaNazwa;
                advertiser.activeValue = YES;
                if(instance)
                {
                    [instance.advertisersSet addObject:advertiser];
                }
            }
            if(reportWS.ProgramId)
            {
                program = (LMProgram *)[LMReadOnlyObject fetchEntityOfClass:[LMProgram class] withObjectID:reportWS.ProgramId inContext:context];
                if(!program)
                {
                    program = [LMProgram createObjectInContext:context];
                    program.objectIdValue = reportWS.ProgramId.intValue;
                }
                program.name = reportWS.ProgramNazwa;
                program.activeValue = YES;
                if(advertiser)
                {
                    [advertiser.programsSet addObject:program];
                }
            }
        }
    }
    [LMUtils saveCoreDataContext:context];
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

@end
