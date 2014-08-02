//
//  LMUtils.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import "LMAppDelegate.h"
#import "LMBranchAdvertiserViewController.h"
#import "LMBranchInstanceViewController.h"
#import "LMBranchProgramViewController.h"
#import "LMUtils.h"
#import "LMUser.h"

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

@end
