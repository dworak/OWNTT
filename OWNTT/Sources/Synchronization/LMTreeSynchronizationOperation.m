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
+(void)fillEntityAndBind:(LMInstance*) entity fromWSObject:(LMInstanceWS*)modelObject
{
    entity.objectId = modelObject.objectId;
    entity.active = [NSNumber numberWithInt:1];
    entity.name = modelObject.name;
    entity.isReport1 = [NSNumber numberWithBool:NO];
    entity.isReport5 = [NSNumber numberWithBool:NO];
    entity.isReport8 = [NSNumber numberWithBool:NO];
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
    
    LMUser *currentUser = OWNTT_APP_DELEGATE.appUtils.currentUser;
    
    [webServiceManager POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_LoadApplicationData parameters:[LMOWNTTHTTPClient unregisterDeviceParamsToken:currentUser.httpToken] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self unactiveAllTreeElements];
         [self setFetchedResponse:responseObject];
         [self lmSignalFinish];
     } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"ERROR: Tree operation: %@",error.description);
         [self lmCancel];
     }];
    
}

- (void)lmFinish
{
    
    if(!self.manager)
    {
        self.manager = [LMCoreDataManager sharedInstance];
    }
    
    for(NSDictionary * objectDictionary in self.fetchedResponse[@"instances"])
    {
        
        if (self.isCancelled)
        {
            [self lmSignalFinish];
            return;
        }
        
        NSError *error = nil;
        
        LMInstanceWS *instanceModel = [[LMInstanceWS alloc]initWithDictionary:objectDictionary error:&error];
        
        if(error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"ERROR: An error occured during parsing InstanceWS model.");
            });
            
            [self lmCancel];
        }
        
        LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:instanceModel.objectId inContext:self.managedObjectContextForTheOperation];
        
        if(!instance)
        {
            instance = [LMInstance createObjectInContext:self.managedObjectContextForTheOperation];
        }
        
        [LMTreeSynchronizationOperation fillEntityAndBind:instance fromWSObject:instanceModel];
        
        for(NSString *reportName in instanceModel.reportPermissions)
        {
            LMOWNTTReportType reportType = [LMOWNTTHTTPClient reportTypeForName:reportName];
            switch (reportType) {
                case LMOWNTTReportType_Type1:
                {
                    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:1] inContext:self.managedObjectContextForTheOperation];
                    NSAssert(report, @"ERROR: report 1 can not exist");
                    [instance addReportsObject:report];
                    instance.isReport1 = [NSNumber numberWithBool:YES];
                    break;
                }
                case LMOWNTTReportType_Type5:
                {
                    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:2] inContext:self.managedObjectContextForTheOperation];
                    NSAssert(report, @"ERROR: report 2 can not exist");
                    [instance addReportsObject:report];
                    instance.isReport5 = [NSNumber numberWithBool:YES];
                    break;
                }
                case LMOWNTTReportType_Type8:
                {
                    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:3] inContext:self.managedObjectContextForTheOperation];
                    NSAssert(report, @"ERROR: report 3 can not exist");
                    [instance addReportsObject:report];
                    instance.isReport8 = [NSNumber numberWithBool:YES];
                    break;
                }
                default:
                    break;
            }
        }
        for(LMAdvertiserWS *advertiserWS in instanceModel.advertisers)
        {
            LMAdvertiser *advertiser = [LMAdvertiser fetchActiveEntityOfClass:[LMAdvertiser class] withObjectID:advertiserWS.objectId inContext:self.managedObjectContextForTheOperation];
            if(!advertiser)
            {
                advertiser = [LMAdvertiser createObjectInContext:self.managedObjectContextForTheOperation];
                advertiser.objectId = advertiserWS.objectId;
            }
            advertiser.name = advertiserWS.name;
            advertiser.active = [NSNumber numberWithInt:1];
            for(LMProgramWS *programWS in advertiserWS.programs)
            {
                LMProgram *program = [LMProgram fetchActiveEntityOfClass:[LMProgram class] withObjectID:programWS.objectId inContext:self.managedObjectContextForTheOperation];
                if(!program)
                {
                    program = [LMProgram createObjectInContext:self.managedObjectContextForTheOperation];
                    program.objectId = programWS.objectId;
                }
                program.active = [NSNumber numberWithInt:1];
                program.name = programWS.name;
                [advertiser addProgramsObject:program];
            }
            [instance addAdvertisersObject:advertiser];
        }
    }
    
    [self lmSaveContext];
}

- (void)unactiveAllTreeElements
{
    NSArray *readonlyObject = [LMReadOnlyObject fetchEntitiesOfClass:[LMReadOnlyObject class] inContext:self.managedObjectContextForTheOperation];
    for(LMReadOnlyObject *object in readonlyObject)
    {
        if(![object isKindOfClass:[LMReport class]])
        {
            object.activeValue = NO;
        }
    }
    [self lmSaveContext];
}

- (void)lmCancel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ERROR: There is a problem with data from API server.");
        [[LMNotificationService instance] postNotification:LMNotification_TreeOperationCancel withObject:nil];
    });
    [super.managedObjectContextForTheOperation rollback];
    
}

- (void)lmCancelOnPreviousCancel
{
    
}

@end
