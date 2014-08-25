//
//  LMAppUtils.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 02/08/14.
//
//

#import "LMAppUtils.h"
#import "AFNetworkReachabilityManager.h"

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
    if(connected)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LMAppUtilsInternetConnected object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LMAppUtilsInternetDisconnected object:nil];
    }
}

+ (BOOL)connected
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

@end
