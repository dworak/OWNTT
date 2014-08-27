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
    }
}

@end
