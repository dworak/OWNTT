//
//  LMOWNTTHTTPClient.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 26/08/14.
//
//

#import "LMOWNTTHTTPClient.h"

static NSString * const kAPIBaseURLString = @"kAPIBaseURLString";
static NSString * const kAPIApplicationId = @"kAPIApplicationId";
static NSString * const kAPIKey = @"kAPIKey";
static NSString * const kAPIHeaders = @"kAPIHeaders";

@interface LMOWNTTHTTPClient ()
@property (strong, nonatomic) NSDictionary *requestHeaders;
@property (strong, nonatomic) NSNumberFormatter *idNumberFormatter;
@end

@implementation LMOWNTTHTTPClient
+ (instancetype)sharedClient
{
    static LMOWNTTHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSString * urlString = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
        NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:urlString];
        NSLog(@"%@", urlString);
        if (!settingsDictionary) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"There is no settings.plist file in the project."
                                         userInfo:nil];
        }
        
        NSString *baseURLString = [settingsDictionary valueForKey:kAPIBaseURLString];
        
        if (!baseURLString) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"There is no 'kAPIBaseURLString' key in settings.plist file."
                                         userInfo:nil];
        }
        
        NSDictionary *tempDictionary = [settingsDictionary valueForKey:kAPIHeaders];
        sharedClient = [[LMOWNTTHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseURLString] andHTTPRequestHeaders:sharedClient.requestHeaders];
        sharedClient.requestHeaders = [[NSDictionary alloc] initWithDictionary:tempDictionary];
    });
    
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url andHTTPRequestHeaders: (NSDictionary*) requestHeaders{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [requestHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString * obj, BOOL *stop) {
            [self.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
        self.idNumberFormatter = [[NSNumberFormatter alloc] init];
        [self.idNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    
    return self;
}

+ (NSString*)httpCleintServiseName:(LMOWNTTHTTPClientServiceName)service
{
    switch (service) {
        case LMOWNTTHTTPClientServiceName_LoadApplicationData:
            return @"LoadApplicationData";
        case LMOWNTTHTTPClientServiceName_GetAlertPush:
            return @"GetAlertPush";
        case LMOWNTTHTTPClientServiceName_GetReport:
            return @"GetReport";
        case LMOWNTTHTTPClientServiceName_RegisterAlertPush:
            return @"RegisterAlertPush";
        case LMOWNTTHTTPClientServiceName_RegisterDevice:
            return @"RegisterDevice";
        case LMOWNTTHTTPClientServiceName_UnregisterAlertPush:
            return @"UnregisterAlertPush";
        case LMOWNTTHTTPClientServiceName_UnregisterDevice:
            return @"UnregisterDevice";
        default:
        {
            NSAssert(0, @"%@ Unknown service type", NSStringFromSelector(_cmd));
            return nil;
        }
    }
}

+ (NSString*)httpClientResponseMessage:(LMOWNTTHTTPClientResponse)response
{
    switch (response) {
        case LMOWNTTHTTPClientResponse_Success:
            return nil;
        case LMOWNTTHTTPClientResponse_BadAccess:
            return @"Żądanie próbowało uzyskać dostęp do raportu lub programu, do którego użytkownik podany w żądaniu nie ma dostępu.";
        case LMOWNTTHTTPClientResponse_AuthorizationError:
            return @"TOKEN otrzymany z urządzenia nie odpowiada TOKENOWI zapamiętanemu przez serwer dla użytkownika podanego w żądaniu.";
        case LMOWNTTHTTPClientResponse_BadRequest:
            return @"Parametry żądania przesłane do serwera były nieprawidłowe lub niepełne.";
        case LMOWNTTHTTPClientResponse_ServerError:
            return @"Podczas obsługo żądania wystąpił problem po stronie serwera.";
        default:
        {
            NSAssert(0, @"%@ Unknown response type", NSStringFromSelector(_cmd));
            return nil;
        }
    }
}

+ (NSString*)httpCleintServiseParamName:(LMOWNTTHTTPCLIENTServiceParamName)paramName
{
    switch (paramName) {
        case LMOWNTTHTTPCLIENTServiceParamName_Login:
            return @"login";
        case LMOWNTTHTTPCLIENTServiceParamName_Password:
             return @"password";
        case LMOWNTTHTTPCLIENTServiceParamName_PushKey:
            return @"pushKey";
        case LMOWNTTHTTPCLIENTServiceParamName_Os:
            return @"os";
        case LMOWNTTHTTPCLIENTServiceParamName_Token:
            return @"token";
        case LMOWNTTHTTPCLIENTServiceParamName_LocalId:
            return @"localId";
        case LMOWNTTHTTPCLIENTServiceParamName_ProgramIds:
            return @"programIds";
        case LMOWNTTHTTPCLIENTServiceParamName_DateFrom:
            return @"dateFrom";
        case LMOWNTTHTTPCLIENTServiceParamName_DateTo:
            return @"dateTo";
        case LMOWNTTHTTPCLIENTServiceParamName_BorderType:
            return @"borderType";
        case LMOWNTTHTTPCLIENTServiceParamName_Hour:
            return @"hour";
        case LMOWNTTHTTPCLIENTServiceParamName_MonitorType:
            return @"monitorType";
        case LMOWNTTHTTPCLIENTServiceParamName_Name:
            return @"name";
        case LMOWNTTHTTPCLIENTServiceParamName_ProgramId:
            return @"programId";
        case LMOWNTTHTTPCLIENTServiceParamName_ReportType:
            return @"reportType";
        case LMOWNTTHTTPCLIENTServiceParamName_Value:
            return @"value";
        case LMOWNTTHTTPCLIENTServiceParamName_ProgramType:
            return @"programType";
        default:
        {
            NSAssert(0, @"%@ Unknown param type", NSStringFromSelector(_cmd));
            return nil;
        }
    }
}

+ (NSString*)getAlertBordertypeName:(LMOWNTTGetAlertBorderType)bordertype
{
    switch (bordertype) {
        case LMOWNTTGetAlertBorderType_GreaterThan:
            return @">";
        case LMOWNTTGetAlertBorderType_LessThan:
            return @"<";
        default:
        {
            NSAssert(0, @"%@ Unknown alert border type", NSStringFromSelector(_cmd));
            return nil;
        }
    }
}

+ (NSString*)getAlertMonitoringTypeName:(LMOWNTTGetalertMonitoringType)monitoringType
{
    switch (monitoringType) {
        case LMOWNTTGetalertMonitoringType_Daily:
            return @"DAILY";
        case LMOWNTTGetalertMonitoringType_Increasing:
            return @"INCREASING";
        default:
        {
            NSAssert(0, @"%@ Unknown alert monitoring type", NSStringFromSelector(_cmd));
            return nil;
        }
    }
}

+ (NSString*)getAlertParamTypeName:(LMOWNTTGetAlertParamType)paramType
{
    switch (paramType) {
        case LMOWNTTGetAlertParamType_Display:
            return @"DISPLAY";
        case LMOWNTTGetAlertParamType_Click:
            return @"CLICK";
        case LMOWNTTGetAlertParamType_Visit:
            return @"VISIT";
        case LMOWNTTGetAlertParamType_NewVisit:
            return @"NEW_VISIT";
        case LMOWNTTGetAlertParamType_TimeOnPage:
            return @"TIME_ON_PAGE";
        case LMOWNTTGetAlertParamType_Checkpoint:
            return @"CHECKPOINT";
        case LMOWNTTGetAlertParamType_Lead:
            return @"LEAD";
        case LMOWNTTGetAlertParamType_Sell:
            return @"SELL";
        default:
        {
            NSAssert(0, @"%@ Unknown alert param type", NSStringFromSelector(_cmd));
            return nil;
        }
    }
}

+ (NSDictionary*)registerDeviceParamsLogin:(NSString *)login password:(NSString *)pass pushKey:(NSString *)pushKey os:(NSString *)os
{
    NSAssert(login, @"registerDeviceParamsLogin: empty login");
    NSAssert(pass, @"registerDeviceParamsLogin: empty password");
    NSAssert(pushKey, @"registerDeviceParamsLogin: empty push key");
    NSAssert(os, @"registerDeviceParamsLogin: empty os");
    return @{[LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Login] : login,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Password] : pass,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_PushKey] : pushKey,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Os] : os
             };
}

+ (NSDictionary*)unregisterDeviceParamsToken:(NSString *)token
{
    NSAssert(token, @"unregisterDeviceParamsLogin: empty token");
    return @{[LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Token] : token
             };
}

+ (NSDictionary*)getReportParamsToken:(NSString *)token reportType:(NSString *)reportType dateFrom:(NSString *)dateFrom dateTo:(NSString*)dateTo programIds:(NSArray*)programIds
{
    NSAssert(token, @"getReportParamsLogin: empty token");
    NSAssert(reportType, @"getReportParamsLogin: empty reportType");
    NSAssert(dateFrom, @"getReportParamsLogin: empty date from");
    NSAssert(dateTo, @"getReportParamsLogin: empty date from");
    NSAssert(programIds, @"getReportParamsLogin: empty programIds");
    return @{[LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Token] : token,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_ReportType] : reportType,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_DateFrom] : dateFrom,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_DateTo] : dateTo,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_ProgramIds] : programIds
             };
}

+ (NSDictionary*)registerAlertPushParamsToken:(NSString *)token
                                      localId:(NSNumber*)localId
                                         name:(NSString*)name
                                    programId:(NSNumber*)programId
                                  programType:(LMOWNTTGetAlertParamType)programType
                                  monitorType:(LMOWNTTGetalertMonitoringType)monitoringType
                                        value:(NSNumber*)value
                                     dateFrom:(NSString *)dateFrom
                                       dateTo:(NSString*)dateTo
                                   bordertype:(LMOWNTTGetAlertBorderType)bordertype
                                         hour:(NSNumber *)hour
{
    NSAssert(token, @"registerAlertPushParamsToken: empty token");
    NSAssert(localId, @"registerAlertPushParamsToken: empty localId");
    NSAssert(name, @"registerAlertPushParamsToken: empty name");
    NSAssert(programId, @"registerAlertPushParamsToken: empty programId");
    NSAssert(monitoringType, @"registerAlertPushParamsToken: empty monitor type");
    NSAssert(value, @"registerAlertPushParamsToken: empty value");
    NSAssert(dateFrom, @"registerAlertPushParamsToken: empty date from");
    NSAssert(dateTo, @"registerAlertPushParamsToken: empty date to");
    NSAssert(bordertype, @"registerAlertPushParamsToken: empty border type");
    NSAssert(hour, @"registerAlertPushParamsToken: empty hour");
    
    return @{[LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Token] : token,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_LocalId] : localId,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Name] : name,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_ProgramId] : programId,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_ProgramType] : [LMOWNTTHTTPClient getAlertParamTypeName:programType],
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_MonitorType] : [LMOWNTTHTTPClient getAlertMonitoringTypeName:monitoringType],
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Value] : value,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_DateFrom] : dateFrom,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_DateTo] : dateTo,
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_BorderType] : [LMOWNTTHTTPClient getAlertBordertypeName:bordertype],
             [LMOWNTTHTTPClient httpCleintServiseParamName:LMOWNTTHTTPCLIENTServiceParamName_Hour] : hour,
             };
}

- (AFHTTPRequestOperation *)POSTHTTPRequestOperationForServiceName:(LMOWNTTHTTPClientServiceName)serviceName
                                                        parameters:(NSDictionary *) parameters
                                                       succedBlock:(succedBlock) theSuccedBlock
                                                      failureBlock:(failureBlock) theFailureBlock
{
    AFHTTPRequestOperation *operation;
    operation = [self POST:[LMOWNTTHTTPClient httpCleintServiseName:serviceName] parameters:parameters success:theSuccedBlock failure:theFailureBlock];
    return operation;
}





@end
