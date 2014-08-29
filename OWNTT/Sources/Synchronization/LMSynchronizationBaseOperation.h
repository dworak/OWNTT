//
//  LMSynchronizationBaseOperation.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import <Foundation/Foundation.h>

typedef void(^LMSynchronizationInfoBlock)(id sender);

@interface LMSynchronizationBaseOperation : NSOperation
{
    dispatch_semaphore_t lmExitSemaphore;
}

/*
 * Synchronization base operation
 */
@property (weak, nonatomic) LMSynchronizationBaseOperation* nextOperation;

// This is set by previous operation (which has nextOperation set).
@property (assign, nonatomic) BOOL didPreviousOperationFail;

// This works similar to property above.
@property (assign, nonatomic) BOOL didAnyPrecedingOperationFail;

// All synchronization operations has got their own local context, which is saved if everything went ok.
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContextForTheOperation;
// Fetched response returned async from server.
@property (strong, nonatomic) NSDictionary *fetchedResponse;

// For relation value: object with destination relation, key parent id
@property (strong, nonatomic) NSMutableDictionary *fetchedResponseDictionary;

// Fetched response as a mutable array
@property (strong, nonatomic) NSMutableArray *fetchedResponseArray;

// A pointer to a singleton manager.
@property (strong, nonatomic) LMCoreDataManager *manager;

// Method for saving local context.
-(void)lmSaveContext;

// Unlock mutex, if everything is done.
-(void)lmSignalFinish;
@end

@class LMSynchronizationBlockOperation;

typedef void (^LMSynchronizationBlock)(LMSynchronizationBlockOperation* operation);

@interface LMSynchronizationBlockOperation : LMSynchronizationBaseOperation

@property (copy, nonatomic) LMSynchronizationInfoBlock block;

@end
