//
//  MLAppDelegate.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import <UIKit/UIKit.h>
#import "LMAppUtils.h"

@class KeychainItemWrapper;

@class LMAppUtils;

@interface LMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LMAppUtils *appUtils;

@property (strong, nonatomic) KeychainItemWrapper *passwordItem;
@property (strong, nonatomic) KeychainItemWrapper *accountItem;

@end
