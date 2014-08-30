//
//  LMAlertManager.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 30/08/14.
//
//

#import "LMAlertManager.h"

@implementation LMAlertManager

+ (void)showErrorAlertWithOkWithText:(NSString *)text
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LM_LOCALIZE(@"LMAlertManager_Error") message:text delegate:self cancelButtonTitle:@"LMAlertManager_Ok" otherButtonTitles:nil];
    [alertView show];
}
+ (void)showInfoAlertWithOkWithText:(NSString *)text
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LM_LOCALIZE(@"LMAlertManager_Info") message:text delegate:self cancelButtonTitle:@"LMAlertManager_Ok" otherButtonTitles:nil];
    [alertView show];
}
@end
