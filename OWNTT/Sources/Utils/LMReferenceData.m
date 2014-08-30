//
//  LMReferenceData.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMReferenceData.h"

#define STATIC_DATA_FILE_NAME @"pickListData"
#define STATIC_REPORT_TIME_INTERVAL_KEY @"reportTimeInterval"
#define STATIC_ALERT_MONITORING_TYPE_KEY @"alertMonitoringTypes"
#define STATIC_ALERT_HOUR_TYPE_KEY @"alertHourTypes"
#define STATIC_ALERT_POINTER_TYPE_KEY @"alertPointertypes"
#define STATIC_ALERT_BORDER_TYPE_KEY @"alertBorderTypes"

static NSDictionary *staticData = nil;

@implementation LMReferenceData

+ (NSDictionary* )staticValuesPicklist
{
    if (!staticData.allKeys.count)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:STATIC_DATA_FILE_NAME ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error;
        staticData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if(error)
        {
            NSLog(@"Error reading data");
            return nil;
        }
    }
    return staticData;
}

+ (NSArray *)staticReportTimeIntervalValues
{
    NSDictionary *staticData = [LMReferenceData staticValuesPicklist];
    if(staticData)
    {
        return [staticData valueForKey:STATIC_REPORT_TIME_INTERVAL_KEY];
    }
    else
    {
        return nil;
    }
}

+ (NSArray *)staticAlertMonitoringTypes
{
    NSDictionary *staticData = [LMReferenceData staticValuesPicklist];
    if(staticData)
    {
        return [staticData valueForKey:STATIC_ALERT_MONITORING_TYPE_KEY];
    }
    else
    {
        return nil;
    }
}

+ (NSArray *)staticAlertHourTypes
{
    NSMutableArray *hours = [NSMutableArray new];
    for(int i = 1; i<25; i++)
    {
        [hours addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return [NSArray arrayWithArray:hours];
}

+ (NSArray *)staticAlertPointerTypes
{
    NSDictionary *staticData = [LMReferenceData staticValuesPicklist];
    if(staticData)
    {
        return [staticData valueForKey:STATIC_ALERT_POINTER_TYPE_KEY];
    }
    else
    {
        return nil;
    }
}

+ (NSArray *)staticAlertBorderTypes
{
    NSDictionary *staticData = [LMReferenceData staticValuesPicklist];
    if(staticData)
    {
        return [staticData valueForKey:STATIC_ALERT_BORDER_TYPE_KEY];
    }
    else
    {
        return nil;
    }
}

@end
