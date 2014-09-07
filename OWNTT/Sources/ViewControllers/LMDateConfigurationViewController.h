//
//  LMDateConfigurationViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 09/08/14.
//
//

#import "LMSummaryBaseViewController.h"

typedef void(^DateChangeBlock)(NSDate *dateFrom, NSDate *dateTo);

@interface LMDateConfigurationViewController : LMSummaryBaseViewController
@property (unsafe_unretained, nonatomic) BOOL fromBranchReport;
@property (copy, nonatomic) DateChangeBlock dateChangeBlock;
@end
