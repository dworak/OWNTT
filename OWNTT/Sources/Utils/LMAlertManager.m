//
//  LMAlertManager.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 30/08/14.
//
//

#import "LMAlertManager.h"

@implementation LMAlertManager

+ (void)showErrorAlertWithOkWithText:(NSString *)text delegate:(id)delegate
{
    id alertDelegate = self;
    if(delegate)
    {
        alertDelegate = delegate;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LM_LOCALIZE(@"LMAlertManager_Error") message:text delegate:alertDelegate cancelButtonTitle:LM_LOCALIZE(@"LMAlertManager_Ok") otherButtonTitles:nil];
    [alertView show];
}
+ (void)showInfoAlertWithOkWithText:(NSString *)text delegate:(id)delegate
{
    id alertDelegate = self;
    if(delegate)
    {
        alertDelegate = delegate;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LM_LOCALIZE(@"LMAlertManager_Info") message:text delegate:alertDelegate cancelButtonTitle:LM_LOCALIZE(@"LMAlertManager_Ok") otherButtonTitles:nil];
    [alertView show];
}
@end
