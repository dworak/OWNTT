//
//  LMUtils.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import <Foundation/Foundation.h>

@interface LMUtils : NSObject
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

+ (NSNumber *)getCurrentInstance;

+ (NSArray*)datesForReportTimeInterval:(NSString*)timeinterval;
@end
