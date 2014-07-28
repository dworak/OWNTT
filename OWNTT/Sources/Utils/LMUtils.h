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
@end
