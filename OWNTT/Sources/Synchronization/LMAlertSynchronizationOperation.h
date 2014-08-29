//
//  LMAlertSynchronizationOperation.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/08/14.
//
//

#import "LMSynchronizationBaseOperation.h"

@class LMUserAlert;
@class LMAlertWS;

@interface LMAlertSynchronizationOperation : LMSynchronizationBaseOperation
+(void)fillEntityAndBind:(LMUserAlert*) entity fromWSObject:(LMAlertWS*)modelObject;
@end
