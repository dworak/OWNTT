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

@implementation LMAlertSynchronizationOperation
+(void)ttFillEntityAndBind:(LMUserAlert*) entity fromWSObject:(LMAlertWS*)modelObject
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


- (void)ttBegin
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
         [self ttSignalFinish];
     } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self ttCancel];
     }];
    
}

- (void)ttFinish
{
    
    if(!self.manager)
    {
        self.manager = [LMCoreDataManager sharedInstance];
    }
    
    for(NSDictionary * objectDictionary in self.fetchedResponse[@"alerts"])
    {
        
        if (self.isCancelled)
        {
            [self ttSignalFinish];
            return;
        }
        
        NSError *error = nil;
        
        LMAlertWS *userAlertModel = [[LMAlertWS alloc]initWithDictionary:objectDictionary error:&error];
        
        if(error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"ERROR: An error occured during parsing AlertWS model.");
            });
            
            [self ttCancel];
        }
        
        LMUserAlert *userAlert = [LMUserAlert fetchActiveEntityOfClass:[LMUserAlert class] withObjectID:userAlertModel.localId inContext:self.managedObjectContextForTheOperation];
        
        if(!userAlert)
        {
            userAlert = [LMUserAlert createObjectInContext:self.managedObjectContextForTheOperation];
        }
        
        [LMAlertSynchronizationOperation ttFillEntityAndBind:userAlert fromWSObject:userAlertModel];
    }
    
    [self ttSaveContext];
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

- (void)ttCancel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ERROR: There is a problem with data from API server.");
        [[LMNotificationService instance] postNotification:LMNotification_AlertOperationCancel withObject:nil];
    });
    [super.managedObjectContextForTheOperation rollback];
    
}

- (void)ttCancelOnPreviousCancel
{
    
}

@end
