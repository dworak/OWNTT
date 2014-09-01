//
//  LMAlertManager.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 30/08/14.
//
//

#import <Foundation/Foundation.h>

@interface LMAlertManager : NSObject
+ (void)showErrorAlertWithOkWithText:(NSString *)text delegate:(id)delegate;
+ (void)showInfoAlertWithOkWithText:(NSString *)text delegate:(id)delegate;
@end
