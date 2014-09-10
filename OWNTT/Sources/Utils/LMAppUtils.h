//
//  LMAppUtils.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 02/08/14.
//
//

#import <Foundation/Foundation.h>
#import "LMUser.h"

#define LMAppUtilsInternetConnected @"InternetConnected"
#define LMAppUtilsInternetDisconnected @"InternedDisconnected"

enum {
	kUsernameSection = 0,
	kPasswordSection
};

@interface LMAppUtils : NSObject
@property (unsafe_unretained, nonatomic) BOOL internetConnected;

@property (strong, nonatomic) LMUser *currentUser;
@property (strong, nonatomic) NSString *notSaveDeviceKey;

+ (BOOL)connected;
+ (id)secAttrForSection:(NSInteger)section;
- (void)checkInternetConnection;
- (void)internetConnectionChange:(BOOL)connected;

@end
