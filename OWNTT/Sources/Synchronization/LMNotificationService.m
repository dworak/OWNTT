//
//  LMNotificationService.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "LMNotificationService.h"

@implementation LMNotificationService

+ (LMNotificationService*)instance {
    static LMNotificationService* instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[LMNotificationService alloc] init];
    });
    
    return instance;
}

+ (NSString*)lmNotificationEnumToString:(LMNotification)notification
{
    NSString* notificationString = nil;
    
    switch (notification)
    {
        case LMNotification_SynchBegan:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        case LMNotification_TreeOperationCancel:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        case LMNotification_TreeOperationFinished:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        case LMNotification_TreeOperationDownload:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        case LMNotification_AlertOperationCancel:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        case LMNotification_AlertOperationDownload:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        case LMNotification_AlertOperationFinished:
            notificationString = LM_STRINGIZE(LMNotificationSynchBegan);
            break;
        default:
            @throw LM_MAKE_EXCEPTION([self class], @"Unknown notification type", nil);
    }
    
    return notificationString;
}

- (void)postNotification:(LMNotification)notification withObject:(id)object
{
    NSString* notificationString = [LMNotificationService lmNotificationEnumToString:notification];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationString object:object];
}

- (void)addObserver:(id)observer forNotification:(LMNotification)notification withSelector:(SEL)selector
{
    NSString* notificationString = [LMNotificationService lmNotificationEnumToString:notification];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:notificationString object:nil];
}

- (void)removeObserver:(id)observer forNotification:(LMNotification)notification
{
    NSString* notificationString = [LMNotificationService lmNotificationEnumToString:notification];
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:notificationString object:nil];
}

@end
