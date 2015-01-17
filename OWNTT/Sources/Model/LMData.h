//
//  LMReportData.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import <Foundation/Foundation.h>

@interface LMData : NSObject
@property (unsafe_unretained, nonatomic) BOOL isReport;
@property (unsafe_unretained, nonatomic) BOOL isTemplate;
@property (strong, nonatomic) NSNumber *instanceId;
@property (strong, nonatomic) NSNumber *advertiserId;
@property (strong, nonatomic) NSArray *programIds;
@property (strong, nonatomic) NSNumber *reportId;
@property (strong, nonatomic) NSDate *dateFrom;
@property (strong, nonatomic) NSDate *dateTo;
@property (strong, nonatomic) NSNumber *siteId;
@property (strong, nonatomic) NSNumber *siteAdvertiserId;
@property (unsafe_unretained, nonatomic) int interval;
@end
