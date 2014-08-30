//
//  LMAlertManager.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 30/08/14.
//
//

#import <Foundation/Foundation.h>

@interface LMAlertManager : NSObject
+ (void)showErrorAlertWithOkWithText:(NSString *)text;
+ (void)showInfoAlertWithOkWithText:(NSString *)text;
@end
