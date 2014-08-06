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

static NSDictionary *StaticData = nil;

@implementation LMReferenceData

+ (NSDictionary* )staticValuesPicklist
{
    if (!StaticData.allKeys.count)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:STATIC_DATA_FILE_NAME ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error;
        StaticData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if(error)
        {
            NSLog(@"Error reading data");
            return nil;
        }
    }
    return StaticData;
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
    NSDictionary *staticData = [LMReferenceData staticValuesPicklist];
    if(staticData)
    {
        return [staticData valueForKey:STATIC_ALERT_HOUR_TYPE_KEY];
    }
    else
    {
        return nil;
    }
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

@end
