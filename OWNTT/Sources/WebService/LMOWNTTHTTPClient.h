//
//  LMOWNTTHTTPClient.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 26/08/14.
//
//

typedef enum {
    LMOWNTTHTTPClientServiceName_RegisterDevice = 0,
    LMOWNTTHTTPClientServiceName_UnregisterDevice,
    LMOWNTTHTTPClientServiceName_LoadApplicationData,
    LMOWNTTHTTPClientServiceName_GetReport,
    LMOWNTTHTTPClientServiceName_RegisterAlertPush,
    LMOWNTTHTTPClientServiceName_UnregisterAlertPush,
    LMOWNTTHTTPClientServiceName_GetAlertPush
} LMOWNTTHTTPClientServiceName;

typedef enum {
    LMOWNTTHTTPClientResponse_Success = 200,
    LMOWNTTHTTPClientResponse_BadRequest = 400,
    LMOWNTTHTTPClientResponse_AuthorizationError = 401,
    LMOWNTTHTTPClientResponse_BadAccess = 402,
    LMOWNTTHTTPClientResponse_ServerError = 500
} LMOWNTTHTTPClientResponse;

typedef enum {
    LMOWNTTHTTPCLIENTServiceParamName_Login,
    LMOWNTTHTTPCLIENTServiceParamName_Password,
    LMOWNTTHTTPCLIENTServiceParamName_PushKey,
    LMOWNTTHTTPCLIENTServiceParamName_Os
} LMOWNTTHTTPCLIENTServiceParamName;

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

typedef void (^succedBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface LMOWNTTHTTPClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
+ (NSString*)httpCleintServiseName:(LMOWNTTHTTPClientServiceName)service;
+ (NSString*)httpClientResponseMessage:(LMOWNTTHTTPClientResponse)response;
+ (NSString*)httpCleintServiseParamName:(LMOWNTTHTTPCLIENTServiceParamName)paramName;

+ (NSDictionary*)registerDeviceParamsLogin:(NSString*)login
                                  password:(NSString*)pass
                                   pushKey:(NSString *)pushKey
                                        os:(NSString*)os;

- (AFHTTPRequestOperation *)POSTHTTPRequestOperationForServiceName: (LMOWNTTHTTPClientServiceName)serviceName
                                                  parameters: (NSDictionary *) parameters
                                                 succedBlock: (succedBlock) theSuccedBlock
                                                failureBlock: (failureBlock) theFailureBlock;
@end
