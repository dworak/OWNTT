//
//  MLAppDelegate.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMAppDelegate.h"
#import "LMUser.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPRequestOperationLogger.h"
#import "JSONModel.h"

@implementation LMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Register for remote notification
    self.appUtils.notSaveDeviceKey = @"Not register yet";
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeNewsstandContentAvailability];
    
    if (launchOptions != nil)
	{
		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
			//TODO: Update badge
		}
	}
    // Override point for customization after application launch.
    [LMUtils setupCurrentLanguage];
    //Create app utils
    self.appUtils = [LMAppUtils new];
    [self.appUtils checkInternetConnection];
    
    //Get current user
    [LMUtils getCurrentUser];
    
    //Setup json model
    [JSONModel setGlobalKeyMapper:[
                                   [JSONKeyMapper alloc] initWithDictionary:@{
                                                                              @"id":@"objectId",
                                                                              }]
     ];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                          target:self
                                        selector:@selector(update)
                                        userInfo:nil
                                         repeats:YES];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [[LMCoreDataManager sharedInstance] saveMasterContext];
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"%@", userInfo);
    [LMAlertManager showInfoAlertWithOkWithText:[userInfo objectForKey:@"inAppMessage"] delegate:nil];
}

- (void)postUpdateRequest
{
    //Add update device token
    [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_UpdateDevice parameters:[LMOWNTTHTTPClient updateDeviceParamsToken:self.appUtils.currentUser.httpToken pushKey:self.appUtils.currentUser.deviceToken] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Correct update push key");
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: Could not update push key");
    }];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSString* newToken = [deviceToken description];
    NSString* oldToken = @"";
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *users = [LMUser fetchLMUsersInContext:[[LMCoreDataManager sharedInstance] masterManagedObjectContext]];
    if(users.count > 0)
    {
        self.appUtils.currentUser = [users objectAtIndex:0];
        oldToken = self.appUtils.currentUser.deviceToken;
    }
    if(self.appUtils.currentUser)
    {
        self.appUtils.currentUser.deviceToken = newToken;
        [[LMCoreDataManager sharedInstance] saveMasterContext];
    }
    else
    {
        self.appUtils.notSaveDeviceKey = newToken;
    }
	if (self.appUtils.currentUser && ![newToken isEqualToString:oldToken])
	{
		[self postUpdateRequest];
	}
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)update
{
    
}

@end
