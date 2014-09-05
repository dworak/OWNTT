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
    LMOWNTTHTTPClientServiceName_GetAlertPush,
    LMOWNTTHTTPClientServiceName_UpdateDevice
} LMOWNTTHTTPClientServiceName;

typedef enum {
    LMOWNTTHTTPClientResponse_Success = 200,
    LMOWNTTHTTPClientResponse_BadRequest = 400,
    LMOWNTTHTTPClientResponse_AuthorizationError = 401,
    LMOWNTTHTTPClientResponse_BadAccess = 402,
    LMOWNTTHTTPClientResponse_ServerError = 500
} LMOWNTTHTTPClientResponse;

typedef enum {
    LMOWNTTHTTPCLIENTServiceParamName_Login = 0,
    LMOWNTTHTTPCLIENTServiceParamName_Password,
    LMOWNTTHTTPCLIENTServiceParamName_PushKey,
    LMOWNTTHTTPCLIENTServiceParamName_Os,
    LMOWNTTHTTPCLIENTServiceParamName_Token,
    LMOWNTTHTTPCLIENTServiceParamName_ReportType,
    LMOWNTTHTTPCLIENTServiceParamName_DateFrom,
    LMOWNTTHTTPCLIENTServiceParamName_DateTo,
    LMOWNTTHTTPCLIENTServiceParamName_ProgramIds,
    LMOWNTTHTTPCLIENTServiceParamName_LocalId,
    LMOWNTTHTTPCLIENTServiceParamName_Name,
    LMOWNTTHTTPCLIENTServiceParamName_ProgramId,
    LMOWNTTHTTPCLIENTServiceParamName_MonitorType,
    LMOWNTTHTTPCLIENTServiceParamName_Value,
    LMOWNTTHTTPCLIENTServiceParamName_BorderType,
    LMOWNTTHTTPCLIENTServiceParamName_Hour,
    LMOWNTTHTTPCLIENTServiceParamName_ProgramType,
    LMOWNTTHTTPCLIENTServiceParamName_ParamType
} LMOWNTTHTTPCLIENTServiceParamName;

typedef enum {
    LMOWNTTGetAlertParamType_Display = 1,
    LMOWNTTGetAlertParamType_Click,
    LMOWNTTGetAlertParamType_Visit,
    LMOWNTTGetAlertParamType_NewVisit,
    LMOWNTTGetAlertParamType_TimeOnPage,
    LMOWNTTGetAlertParamType_Checkpoint,
    LMOWNTTGetAlertParamType_Lead,
    LMOWNTTGetAlertParamType_Sell
} LMOWNTTGetAlertParamType;

typedef enum {
    LMOWNTTGetalertMonitoringType_Increasing = 1,
    LMOWNTTGetalertMonitoringType_Daily
} LMOWNTTGetalertMonitoringType;

typedef enum {
    LMOWNTTGetAlertBorderType_GreaterThan = 1,
    LMOWNTTGetAlertBorderType_LessThan
} LMOWNTTGetAlertBorderType;

typedef enum {
    LMOWNTTReportType_Type1 = 1,
    LMOWNTTReportType_Type5 = 2,
    LMOWNTTReportType_Type8 = 3
} LMOWNTTReportType;

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@class LMUserAlert;

typedef void (^succedBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface LMOWNTTHTTPClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

+ (NSString*)httpCleintServiseName:(LMOWNTTHTTPClientServiceName)service;
+ (NSString*)httpClientResponseMessage:(LMOWNTTHTTPClientResponse)response;
+ (NSString*)httpCleintServiseParamName:(LMOWNTTHTTPCLIENTServiceParamName)paramName;
+ (NSString*)getAlertParamTypeName:(LMOWNTTGetAlertParamType)paramType;
+ (NSString*)getAlertMonitoringTypeName:(LMOWNTTGetalertMonitoringType)monitoringType;
+ (NSString*)getAlertBordertypeName:(LMOWNTTGetAlertBorderType)bordertype;
+ (NSString*)reportTypeName:(LMOWNTTReportType)reportType;
+ (NSString*)reportTypeAppName:(LMOWNTTReportType)reportType;

+ (LMOWNTTReportType)reportTypeForName:(NSString*)name;

+ (NSDictionary*)registerDeviceParamsLogin:(NSString*)login
                                  password:(NSString*)pass
                                   pushKey:(NSString *)pushKey
                                        os:(NSString*)os;
+ (NSDictionary*)unregisterDeviceParamsToken:(NSString*)token;
+ (NSDictionary*)getReportParamsToken:(NSString *)token
                           reportType:(NSString *)reportType
                             dateFrom:(NSString *)dateFrom
                               dateTo:(NSString*)dateTo
                           programIds:(NSArray*)programIds;
+ (NSDictionary*)registerAlertPushParams:(LMUserAlert *)userAlert;
+ (NSDictionary*)unregisterAlertPushParamsToken:(NSString *)token
                                        localId:(NSNumber*)localId;
+ (NSDictionary*)updateDeviceParamsToken:(NSString *)token
                                 pushKey:(NSString*)pushKey;

- (AFHTTPRequestOperation *)POSTHTTPRequestOperationForServiceName: (LMOWNTTHTTPClientServiceName)serviceName
                                                  parameters: (NSDictionary *) parameters
                                                 succedBlock: (succedBlock) theSuccedBlock
                                                failureBlock: (failureBlock) theFailureBlock;
@end
