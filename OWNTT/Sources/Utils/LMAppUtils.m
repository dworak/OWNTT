//
//  LMAppUtils.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 02/08/14.
//
//

#import "LMAppUtils.h"
#import "AFNetworkReachabilityManager.h"
#import <Security/Security.h>
#import "LMSiteAdvertiserWS.h"
#import "LMSiteWS.h"

@implementation LMAppUtils
- (void)checkInternetConnection
{
    //Check internet status
    __weak LMAppUtils *appUtils = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [appUtils internetConnectionChange:[[AFNetworkReachabilityManager sharedManager] isReachable]];
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)internetConnectionChange:(BOOL)connected
{
    /*if(connected)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LMAppUtilsInternetConnected object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LMAppUtilsInternetDisconnected object:nil];
    }*/
    [[NSNotificationCenter defaultCenter] postNotificationName:LM_CONNECTION_NOTIFICATION_CHANGE object:nil];
}

- (NSError *)createCurrentSitesForDictionary:(NSDictionary *)jsonData
{
    NSMutableArray *tmpArray = [NSMutableArray new];
    NSError *error;
    for(NSDictionary * objectDictionary in jsonData[@"sites"])
    {
        LMSiteWS *site = [[LMSiteWS alloc] initWithDictionary:objectDictionary error:&error];
        if(error)
        {
            break;
        }
        else
        {
            [tmpArray addObject:site];
        }
    }
    if(!error)
    {
        self.currentSites = [NSArray arrayWithArray:tmpArray];
    }
    return error;
}

+ (BOOL)connected
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

+ (id)secAttrForSection:(NSInteger)section
{
    switch (section)
    {
        case kUsernameSection: return (__bridge id)kSecAttrAccount;
        case kPasswordSection: return (__bridge id)kSecValueData;
    }
    return nil;
}

@end
