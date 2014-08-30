//
//  LMAlertSummaryViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

typedef enum {
    LMAlertSummaryButtonType_DateFrom = 1,
    LMAlertSummaryButtonType_DateTo,
    LMAlertSummaryButtonType_Monitoring,
    LMAlertSummaryButtonType_Hour,
    LMAlertSummaryButtonType_Pointer,
    LMAlertSummaryButtonType_Border
} LMAlertSummaryButtonType;

#import <UIKit/UIKit.h>
#import "LMSummaryBaseViewController.h"

@interface LMAlertSummaryViewController : LMSummaryBaseViewController

@end
