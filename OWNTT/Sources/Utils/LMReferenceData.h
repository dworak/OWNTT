//
//  LMReferenceData.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import <Foundation/Foundation.h>

@interface LMReferenceData : NSObject
+ (NSArray *)staticReportTimeIntervalValues;
+ (NSArray *)staticAlertMonitoringTypes;
+ (NSArray *)staticAlertHourTypes;
+ (NSArray *)staticAlertPointerTypes;
+ (NSArray *)staticAlertBorderTypes;
@end
