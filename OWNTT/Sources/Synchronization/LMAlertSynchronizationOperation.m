//
//  LMAlertSynchronizationOperation.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/08/14.
//
//

#import "LMAlertSynchronizationOperation.h"
#import "LMAlertWS.h"
#import "LMUserAlert.h"
#import "LMSettings.h"

@implementation LMAlertSynchronizationOperation
+(void)fillEntityAndBind:(LMUserAlert*) entity fromWSObject:(LMAlertWS*)modelObject
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    entity.objectId = modelObject.localId;
    entity.programId = modelObject.programId;
    entity.value = modelObject.value;
    entity.hour = modelObject.hour;
    entity.dateFrom = [dateFormatter dateFromString:modelObject.dateFrom];
    entity.dateTo = [dateFormatter dateFromString:modelObject.dateTo];
    entity.active = [NSNumber numberWithInt:1];
    entity.monitorType = modelObject.monitorType;
    entity.paramType = modelObject.paramType;
    entity.borderType = modelObject.borderType;
    entity.name = modelObject.name;
}


- (void)lmBegin
{
    LMOWNTTHTTPClient *webServiceManager = [LMOWNTTHTTPClient sharedClient];
    
    if(!self.manager)
    {
        self.manager = [LMCoreDataManager sharedInstance];
    }
    
    if(!self.managedObjectContextForTheOperation)
    {
        self.managedObjectContextForTheOperation = [self.manager newManagedObjectContext];
    }
    //[self unactiveAllTreeElements];
    
    LMUser *currentUser = [[LMUser fetchLMUsersInContext:self.managedObjectContextForTheOperation] objectAtIndex:0];
    
    [webServiceManager POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_GetAlertPush parameters:[LMOWNTTHTTPClient unregisterDeviceParamsToken:currentUser.httpToken] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self setFetchedResponse:responseObject];
         [self lmSignalFinish];
     } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"ERROR: Alert operation: %@",error.description);
         [self lmCancel];
     }];
    
}

- (void)lmFinish
{
    
    if(!self.manager)
    {
        self.manager = [LMCoreDataManager sharedInstance];
    }
    int currentLocalId = OWNTT_APP_DELEGATE.appUtils.currentUser.alertsCount.intValue;
    for(NSDictionary * objectDictionary in self.fetchedResponse[@"alerts"])
    {
        
        if (self.isCancelled)
        {
            [self lmSignalFinish];
            return;
        }
        
        NSError *error = nil;
        
        LMAlertWS *userAlertModel = [[LMAlertWS alloc]initWithDictionary:objectDictionary error:&error];
        
        if(error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"ERROR: An error occured during parsing AlertWS model.");
            });
            
            [self lmCancel];
        }
        
        LMUserAlert *userAlert = [LMUserAlert fetchActiveEntityOfClass:[LMUserAlert class] withObjectID:userAlertModel.localId inContext:self.managedObjectContextForTheOperation];
        
        if(!userAlert)
        {
            userAlert = [LMUserAlert createObjectInContext:self.managedObjectContextForTheOperation];
        }
        
        [LMAlertSynchronizationOperation fillEntityAndBind:userAlert fromWSObject:userAlertModel];
        if(currentLocalId < userAlert.objectId.intValue)
        {
            currentLocalId = userAlert.objectId.intValue;
        }
    }
    OWNTT_APP_DELEGATE.appUtils.currentUser.alertsCount = [NSNumber numberWithInt:currentLocalId];
    [self lmSaveContext];
}

/*- (void)unactiveAllTreeElements
{
    NSArray *readonlyObject = [LMReadOnlyObject fetchEntitiesOfClass:[LMReadOnlyObject class] inContext:self.managedObjectContextForTheOperation];
    for(LMReadOnlyObject *object in readonlyObject)
    {
        if(![object isKindOfClass:[LMReport class]])
        {
            object.activeValue = NO;
        }
    }
    [self ttSaveContext];
}*/

- (void)lmCancel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ERROR: There is a problem with data from API server.");
        [[LMNotificationService instance] postNotification:LMNotification_AlertOperationCancel withObject:nil];
    });
    [super.managedObjectContextForTheOperation rollback];
    
}

- (void)lmCancelOnPreviousCancel
{
    
}

@end
