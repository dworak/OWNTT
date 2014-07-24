//
//  MLSegueKeys.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMSegueKeys.h"

DEFINE_ENUM(LMSegueKeyType, SEGUE_TYPE);

@implementation LMSegueKeys
+ (NSString *)segueIdentifierForSegueKey:(LMSegueKeyType)type {
    return NSStringFromLMSegueKeyType(type);
}

@end
