//
//  LMTreeSynchronizationOperation.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "LMSynchronizationBaseOperation.h"

@class LMInstanceWS;
@class LMInstance;

@interface LMTreeSynchronizationOperation : LMSynchronizationBaseOperation
+(void)ttFillEntityAndBind:(LMInstance*) entity fromWSObject:(LMInstanceWS*)modelObject inContext:(NSManagedObjectContext *)context;
@end
