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

+(void)fillEntity: (NSManagedObject*) entity fromWSObject: (JSONModel*) modelObject
{
    @throw LM_MAKE_EXCEPTION([self class], LM_MAKE_REASON_NOT_IMPLEMENTED, nil);
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

- (void)lmSignalFinish
{
    dispatch_semaphore_signal(lmExitSemaphore);
}

- (void)lmBegin
{
    @throw LM_MAKE_EXCEPTION([self class], LM_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)lmFinish
{
    @throw LM_MAKE_EXCEPTION([self class], LM_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)lmCancel
{
    @throw LM_MAKE_EXCEPTION([self class], LM_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

- (void)lmCancelOnPreviousCancel
{
    @throw LM_MAKE_EXCEPTION([self class], LM_MAKE_REASON_NOT_IMPLEMENTED, nil);
}

-(void)lmSaveContext
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
        
        [self lmCancelOnPreviousCancel];
        [self lmSignalFinish];
        
        return;
    }
    
    NSLog(@"INFO: %@ is going to run", NSStringFromClass([self class]));
    
    [self lmBegin];
    dispatch_semaphore_wait(lmExitSemaphore, DISPATCH_TIME_FOREVER);
    
    if (self.isCancelled)
    {
        self.nextOperation.didPreviousOperationFail = YES;
        self.nextOperation.didAnyPrecedingOperationFail = YES;
        [self lmCancel];
    }
    else
    {
        [self lmFinish];
    }
    
    if (self.didPreviousOperationFail || self.didAnyPrecedingOperationFail)
    {
        self.nextOperation.didAnyPrecedingOperationFail = YES;
    }
    
    NSLog(@"INFO: %@ finished", NSStringFromClass([self class]));
}

@end

@implementation LMSynchronizationBlockOperation
- (void)lmBegin
{
    self.block(self);
    [self lmSignalFinish];
}

- (void)lmFinish
{
}

- (void)lmCancel
{
    self.nextOperation.didPreviousOperationFail = YES;
}

- (void)lmCancelOnPreviousCancel
{
    self.block(self);
    [self lmSignalFinish];
}
@end

