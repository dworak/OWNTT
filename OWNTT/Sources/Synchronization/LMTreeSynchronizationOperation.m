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
+(void)ttFillEntityAndBind:(LMInstance*) entity fromWSObject:(LMInstanceWS*)modelObject
{
    entity.objectId = modelObject.objectId;
    entity.activeValue = YES;
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
    [self unactiveAllTreeElements];
    
    LMUser *currentUser = [[LMUser fetchLMUsersInContext:self.managedObjectContextForTheOperation] objectAtIndex:0];
    
    [webServiceManager POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_LoadApplicationData parameters:[LMOWNTTHTTPClient unregisterDeviceParamsToken:currentUser.httpToken] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
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
    
    for(int i=0; i<3; i++)
    {
        LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:i+1] inContext:self.managedObjectContextForTheOperation];
        if(!report)
        {
            report = [LMReport createObjectInContext:self.managedObjectContextForTheOperation];
            report.objectId = [NSNumber numberWithInt:i+1];
        }
        report.activeValue = YES;
        switch (i+1) {
            case 1:
                report.name = @"Raport łączny kampanii";
                report.htmlName = @"1.html";
                break;
            case 2:
                report.name = @"Raport wszystkich wydawców";
                report.htmlName = @"2.html";
                break;
            case 3:
                report.name = @"Raport form reklamowych";
                report.htmlName = @"3.html";
            default:
                break;
        }
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
        
        [LMTreeSynchronizationOperation ttFillEntityAndBind:instance fromWSObject:instanceModel];
        
        for(NSString *reportName in instanceModel.reportPermissions)
        {
            LMOWNTTReportType reportType = [LMOWNTTHTTPClient reportTypeForName:reportName];
            switch (reportType) {
                case LMOWNTTReportType_Type1:
                {
                    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:1] inContext:self.managedObjectContextForTheOperation];
                    NSAssert(report, @"ERROR: report 1 can not exist");
                    [instance addReportsObject:report];
                    break;
                }
                case LMOWNTTReportType_Type5:
                {
                    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:2] inContext:self.managedObjectContextForTheOperation];
                    NSAssert(report, @"ERROR: report 2 can not exist");
                    [instance addReportsObject:report];
                    break;
                }
                case LMOWNTTReportType_Type8:
                {
                    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:3] inContext:self.managedObjectContextForTheOperation];
                    NSAssert(report, @"ERROR: report 3 can not exist");
                    [instance addReportsObject:report];
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
            advertiser.activeValue = YES;
            for(LMProgramWS *programWS in advertiserWS.programs)
            {
                LMProgram *program = [LMProgram fetchActiveEntityOfClass:[LMProgram class] withObjectID:programWS.objectId inContext:self.managedObjectContextForTheOperation];
                if(!program)
                {
                    program = [LMProgram createObjectInContext:self.managedObjectContextForTheOperation];
                    program.objectId = programWS.objectId;
                }
                program.activeValue = YES;
                program.name = programWS.name;
                [advertiser addProgramsObject:program];
            }
            [instance addAdvertisersObject:advertiser];
        }
    }
    
    [self ttSaveContext];
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
