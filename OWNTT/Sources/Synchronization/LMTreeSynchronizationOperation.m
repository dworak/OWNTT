//
//  LMTreeSynchronizationOperation.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "LMTreeSynchronizationOperation.h"
#import "LMInstance.h"
#import "LMReport.h"
#import "LMProgram.h"
#import "LMAdvertiser.h"
#import "LMInstanceWS.h"
#import "LMReportWS.h"
#import "LMProgramWS.h"
#import "LMAdvertiserWS.h"
#import "LMUser.h"

@implementation LMTreeSynchronizationOperation
+(void)ttFillEntityAndBind:(LMInstance*) entity fromWSObject:(LMInstanceWS*)modelObject inContext:(NSManagedObjectContext *)context
{
    entity.objectId = modelObject.objectId;
    entity.activeValue = YES;
    entity.name = modelObject.name;
    for(NSString *reportName in modelObject.reportPermissions)
    {
        LMOWNTTReportType reportType = [LMOWNTTHTTPClient reportTypeForName:reportName];
        switch (reportType) {
            case LMOWNTTReportType_Type1:
            {
                entity.report1Value = YES;
                break;
            }
            case LMOWNTTReportType_Type5:
            {
                entity.report5Value = YES;
                break;
            }
            case LMOWNTTReportType_Type8:
            {
                entity.report8Value = YES;
            }
            default:
                break;
        }
    }
    for(LMAdvertiserWS *advertiserWS in modelObject.advertisers)
    {
        LMAdvertiser *advertiser = [LMAdvertiser fetchActiveEntityOfClass:[LMAdvertiser class] withObjectID:advertiserWS.objectId inContext:context];
        if(!advertiser)
        {
            advertiser = [LMAdvertiser createObjectInContext:context];
            advertiser.objectId = advertiserWS.objectId;
        }
        advertiser.name = advertiserWS.name;
        advertiser.activeValue = YES;
        for(LMProgramWS *programWS in advertiserWS.programs)
        {
            LMProgram *program = [LMProgram fetchActiveEntityOfClass:[LMProgram class] withObjectID:programWS.objectId inContext:context];
            if(!program)
            {
                program = [LMProgram createObjectInContext:context];
                program.objectId = programWS.objectId;
            }
            program.activeValue = YES;
            program.name = programWS.name;
            [advertiser addProgramsObject:program];
        }
        [entity addAdvertisersObject:advertiser];
    }
}


- (void)ttBegin
{
    dispatch_group_t checkPointSyncGroup = dispatch_group_create();
    dispatch_queue_t queuePointSync = dispatch_queue_create("pl.com.tt.tree", 0);
    
    __weak LMTreeSynchronizationOperation *weakSelf = self;
    
    dispatch_group_async(checkPointSyncGroup, queuePointSync, ^{
        dispatch_group_enter(checkPointSyncGroup);
        
        LMOWNTTHTTPClient *webServiceManager = [LMOWNTTHTTPClient sharedClient];
        
        if(!weakSelf.manager)
        {
            weakSelf.manager = [LMCoreDataManager sharedInstance];
        }
        
        if(!weakSelf.managedObjectContextForTheOperation)
        {
            weakSelf.managedObjectContextForTheOperation = [self.manager newManagedObjectContext];
        }
        [weakSelf unactiveAllTreeElements];
        
        LMUser *currentUser = [[LMUser fetchLMUsersInContext:weakSelf.managedObjectContextForTheOperation] objectAtIndex:0];
        
        [webServiceManager POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_LoadApplicationData parameters:[LMOWNTTHTTPClient unregisterDeviceParamsToken:currentUser.httpToken] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            [weakSelf setFetchedResponse:responseObject];
            [weakSelf ttSignalFinish];
            dispatch_group_leave(checkPointSyncGroup);;
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            [weakSelf ttCancel];
        }];
    });
    
    dispatch_group_notify(checkPointSyncGroup, queuePointSync, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"DEBUG: Tree data download has been completed.");
            [[LMNotificationService instance] postNotification:LMNotification_TreeOperationDownload withObject:nil];
        });
    });
    
}

- (void)ttFinish
{
    
    if(!self.manager)
    {
        self.manager = [LMCoreDataManager sharedInstance];
    }
    
    for(NSDictionary * objectDictionary in self.fetchedResponse[@"instances"])
    {
        
        if (self.isCancelled)
        {
            [self ttSignalFinish];
            return;
        }
        
        NSError *error = nil;
        
        LMInstanceWS *instanceModel = [[LMInstanceWS alloc]initWithDictionary:objectDictionary error:&error];
        
        if(error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"ERROR: An error occured during parsing InstanceWS model.");
            });
            
            [self ttCancel];
        }
        
        LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:instanceModel.objectId inContext:self.managedObjectContextForTheOperation];
        
       if(!instance)
       {
           instance = [LMInstance createObjectInContext:self.managedObjectContextForTheOperation];
       }
    
        [LMTreeSynchronizationOperation ttFillEntityAndBind:instance fromWSObject:instanceModel inContext:self.managedObjectContextForTheOperation];
    }
    
    [self ttSaveContext];
}

- (void)unactiveAllTreeElements
{
    NSArray *readonlyObject = [LMReadOnlyObject fetchEntitiesOfClass:[LMReadOnlyObject class] inContext:self.managedObjectContextForTheOperation];
    for(LMReadOnlyObject *object in readonlyObject)
    {
        object.activeValue = NO;
    }
}

- (void)ttCancel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ERROR: There is a problem with data from API server.");
        [[LMNotificationService instance] postNotification:LMNotification_TreeOperationCancel withObject:nil];
    });
    [super.managedObjectContextForTheOperation rollback];
    
}

- (void)ttCancelOnPreviousCancel
{
    
}

@end
