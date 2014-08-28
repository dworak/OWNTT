//
//  LMSynchronizationService.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import <Foundation/Foundation.h>

@interface LMSynchronizationService : NSObject
+(LMSynchronizationService *)instance;

- (BOOL) isSynchronizationRunning;
- (void) downloadTree: (BOOL) initial;
- (void) downloadUserAlerts: (BOOL) initial;

@property (strong, nonatomic) NSOperationQueue *lmOperationQueue;
@end
