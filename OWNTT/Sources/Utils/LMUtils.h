//
//  LMUtils.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import <Foundation/Foundation.h>

@interface LMUtils : NSObject
+ (BOOL)userExist;
+ (UIViewController *)checkAndSetControllersByTreeHierarchyForStoryboard:(UIStoryboard *)storyboard;
+ (void)saveCoreDataContext:(NSManagedObjectContext *)context;
+ (UIViewController *)currentStoryboardControllerForIdentifier:(NSString *)identifier;
+ (BOOL)validateEmail:(NSString *)candidate;
+ (BOOL)isNumeric:(NSString*)inputString;
+ (void)downloadAppData;
+ (void)storeCurrentInstance:(NSNumber *)instanceId;
+ (void)removeCurrentInstance;
+ (NSNumber *)getCurrentInstance;
@end
