//
//  LMReportData.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMData.h"

@implementation LMData
-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    LMData *another = [[LMData alloc] init];
    another.programIds = [self.programIds copyWithZone: zone];
    another.instanceId = [self.instanceId copyWithZone:zone];
    another.reportId = [self.reportId copyWithZone:zone];
    another.advertiserId = [self.advertiserId copyWithZone:zone];
    another.isReport = self.isReport;
    return another;
}
@end
