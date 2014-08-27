//
//  LMSynchronizationBaseOperation.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "LMSynchronizationBaseOperation.h"
#import "JSONModel.h"

@implementation LMSynchronizationBaseOperation

+(void)ttFillEntity: (NSManagedObject*) entity fromWSObject: (JSONModel*) modelObject
{
    @throw TT_MAKE_EXCEPTION([self class], TT_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)cancel
{
    [super cancel];
    
    // This is only used for debugging.
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        lmExitSemaphore = dispatch_semaphore_create(0);
    }
    
    return self;
}

- (void)ttSignalFinish
{
    dispatch_semaphore_signal(lmExitSemaphore);
}

- (void)ttBegin
{
    @throw TT_MAKE_EXCEPTION([self class], TT_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)ttFinish
{
    @throw TT_MAKE_EXCEPTION([self class], TT_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)ttCancel
{
    @throw TT_MAKE_EXCEPTION([self class], TT_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)ttCancelOnPreviousCancel
{
    @throw TT_MAKE_EXCEPTION([self class], TT_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

-(void)ttSaveContext
{
    [self.managedObjectContextForTheOperation performBlockAndWait:^{
        NSError *error;
        [self.managedObjectContextForTheOperation save:&error];
        if(!error)
        {
            [[[LMCoreDataManager sharedInstance] masterManagedObjectContext] performBlockAndWait:^{
                NSError *error;
                [[[LMCoreDataManager sharedInstance] masterManagedObjectContext]save:&error];
                if(error)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"An error occured during sychronization proccess");
                    });
                }
            }];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"An error occured during sychronization proccess");
            });
        }
    }];
}

- (void)main
{
    if (self.didPreviousOperationFail)
    {
        [self cancel];
        
        self.nextOperation.didPreviousOperationFail = YES;
        self.nextOperation.didAnyPrecedingOperationFail = YES;
        
        [self ttCancelOnPreviousCancel];
        [self ttSignalFinish];
        
        return;
    }
    
    NSLog(@"INFO: %@ is going to run", NSStringFromClass([self class]));
    
    [self ttBegin];
    dispatch_semaphore_wait(lmExitSemaphore, DISPATCH_TIME_FOREVER);
    
    if (self.isCancelled)
    {
        self.nextOperation.didPreviousOperationFail = YES;
        self.nextOperation.didAnyPrecedingOperationFail = YES;
        [self ttCancel];
    }
    else
    {
        [self ttFinish];
    }
    
    if (self.didPreviousOperationFail || self.didAnyPrecedingOperationFail)
    {
        self.nextOperation.didAnyPrecedingOperationFail = YES;
    }
    
    NSLog(@"INFO: %@ finished", NSStringFromClass([self class]));
}

@end

@implementation LMSynchronizationBlockOperation
- (void)ttBegin
{
    self.block(self);
    [self ttSignalFinish];
}

- (void)ttFinish
{
}

- (void)ttCancel
{
    self.nextOperation.didPreviousOperationFail = YES;
}

- (void)ttCancelOnPreviousCancel
{
    self.block(self);
    [self ttSignalFinish];
}
@end

