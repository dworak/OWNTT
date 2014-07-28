//
//  LMUtils.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//

#import "LMBranchAdvertiserViewController.h"
#import "LMBranchInstanceViewController.h"
#import "LMBranchProgramViewController.h"
#import "LMUtils.h"

@implementation LMUtils
+ (BOOL)userExist {
    return YES;
}

+ (UIViewController *)checkAndSetControllersByTreeHierarchyForStoryboard:(UIStoryboard *)storyboard
{
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LMBranchAdvertiserViewController class])];
}
@end
