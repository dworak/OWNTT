//
//  LMSynchronizationService.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "LMAlertSynchronizationOperation.h"
#import "LMSynchronizationService.h"
#import "LMTreeSynchronizationOperation.h"

@implementation LMSynchronizationService
+ (LMSynchronizationService *)instance {
    static LMSynchronizationService *synchService;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        synchService = [[LMSynchronizationService alloc] init];
    });
    return synchService;
}

- (BOOL) isSynchronizationRunning
{
    return (_lmOperationQueue.operationCount>0);
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _lmOperationQueue = [[NSOperationQueue alloc] init];
        _lmOperationQueue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void) downloadTree: (BOOL) initial
{
    LMSynchronizationBlockOperation *treeOperationBlock = [[LMSynchronizationBlockOperation alloc] init];
    treeOperationBlock.block = ^(LMSynchronizationBlockOperation *blockOperation){
        dispatch_async(dispatch_get_main_queue(), ^{
            if(initial)
            {
            }
        });
    };
    [_lmOperationQueue addOperation:treeOperationBlock];
    
    LMTreeSynchronizationOperation *treeOperation = [[LMTreeSynchronizationOperation alloc] init];
    [_lmOperationQueue addOperation:treeOperation];
    
    
    treeOperationBlock = [[LMSynchronizationBlockOperation alloc] init];
    treeOperationBlock.block = ^(LMSynchronizationBlockOperation *blockOperation){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LMNotificationService instance] postNotification:LMNotification_TreeOperationFinished withObject:nil];
        });
    };
    [_lmOperationQueue addOperation:treeOperationBlock];
}

- (void) downloadUserAlerts: (BOOL) initial
{
    LMSynchronizationBlockOperation *userAlertOperationBlock = [[LMSynchronizationBlockOperation alloc] init];
    userAlertOperationBlock.block = ^(LMSynchronizationBlockOperation *blockOperation){
        dispatch_async(dispatch_get_main_queue(), ^{
            if(initial)
            {
            }
        });
    };
    [_lmOperationQueue addOperation:userAlertOperationBlock];
    
    LMAlertSynchronizationOperation *userAlertOperation = [[LMAlertSynchronizationOperation alloc] init];
    [_lmOperationQueue addOperation:userAlertOperation];
    
    
    userAlertOperationBlock = [[LMSynchronizationBlockOperation alloc] init];
    userAlertOperationBlock.block = ^(LMSynchronizationBlockOperation *blockOperation){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LMNotificationService instance] postNotification:LMNotification_AlertOperationFinished withObject:nil];
        });
    };
    [_lmOperationQueue addOperation:userAlertOperationBlock];
}





@end
