//
//  LMNotificationService.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    LMNotification_SynchBegan,
    LMNotification_TreeOperationDownload,
    LMNotification_TreeOperationCancel,
    LMNotification_TreeOperationFinished,
    LMNotification_AlertOperationDownload,
    LMNotification_AlertOperationCancel,
    LMNotification_AlertOperationFinished
} LMNotification;

@interface LMNotificationService : NSObject
+ (LMNotificationService*)instance;

- (void)postNotification:(LMNotification)notification withObject:(id)object;

- (void)addObserver:(id)observer
    forNotification:(LMNotification)notification
       withSelector:(SEL)selector;

- (void)removeObserver:(id)observer
       forNotification:(LMNotification)notification;
@end
