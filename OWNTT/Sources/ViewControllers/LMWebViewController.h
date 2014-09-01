//
//  LMWebViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>

@class LMData;

@interface LMWebViewController : LMHostChildBaseViewController <UIAlertViewDelegate>
@property (strong, nonatomic) LMData *transactionData;
@property (unsafe_unretained, nonatomic) BOOL isPop;
@property (unsafe_unretained, nonatomic) BOOL isInstance;
@property (unsafe_unretained, nonatomic) BOOL backActionPerform;
@end
