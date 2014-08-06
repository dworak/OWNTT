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
XX(LMSegueKeyType_PushLogin,) \
XX(LMSegueKeyType_PushTabBar,) \
XX(LMSegueKeyType_PushNavigation,) \
XX(LMSegueKeyType_PushInstanceList,) \
XX(LMSegueKeyType_PushAdvertiserList,) \
XX(LMSegueKeyType_PushProgramList,) \
XX(LMSegueKeyType_PushReport,) \
XX(LMSegueKeyType_PushSettings,) \
XX(LMSegueKeyType_PushReportSummary,) \
XX(LMSegueKeyType_PushAlertSummary,) \
XX(LMSegueKeyType_PushWeb,) \

DECLARE_ENUM(LMSegueKeyType,SEGUE_TYPE)

@interface LMSegueKeys : NSObject

+ (NSString *)segueIdentifierForSegueKey:(LMSegueKeyType)type;

@end
