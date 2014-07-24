//
//  MLSegueKeys.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import <Foundation/Foundation.h>

#define SEGUE_TYPE(XX) \
XX(LMSegueKeyType_None,) \
XX(LMSegueKeyType_PushNavigation,) \
XX(LMSegueKeyType_PushInstanceList,) \
XX(LMSegueKeyType_PushAdvertiserList,) \
XX(LMSegueKeyType_PushProgramList,) \

DECLARE_ENUM(LMSegueKeyType,SEGUE_TYPE)

@interface LMSegueKeys : NSObject

+ (NSString *)segueIdentifierForSegueKey:(LMSegueKeyType)type;

@end
