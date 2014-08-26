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
            return nil;
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
            return nil;
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
        default:
            return nil;
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

- (AFHTTPRequestOperation *)POSTHTTPRequestOperationForServiceName: (LMOWNTTHTTPClientServiceName)serviceName
                                                        parameters: (NSDictionary *) parameters
                                                       succedBlock: (succedBlock) theSuccedBlock
                                                      failureBlock: (failureBlock) theFailureBlock
{
    AFHTTPRequestOperation *operation;
    //TODO: walidacja parametrow
    operation = [self POST:[LMOWNTTHTTPClient httpCleintServiseName:serviceName] parameters:parameters success:theSuccedBlock failure:theFailureBlock];
    return operation;
}





@end
