#import "HWAFNetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"
@implementation HWAFNetworkManager
+ (instancetype)shareManager {
    static HWAFNetworkManager *_instance = nil;
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
        _instance = [[HWAFNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:PartTimeBaseUrl]];
    });
    return _instance;
}
- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        self.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        __weak HWAFNetworkManager *weakSelf = self;
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"" object:nil] subscribeNext:^(id x) {
            __block HWAFNetworkManager *strongSelf = weakSelf;
            [strongSelf networkStatusChanged:x];
        }];
    }
    return self;
}
- (void)networkStatusChanged:(NSNotification *)notification
{
    NSOperationQueue *operationQueue = self.operationQueue;
    switch (self.reachabilityManager.networkReachabilityStatus) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [operationQueue setSuspended:NO];
            break;
        case AFNetworkReachabilityStatusNotReachable:
        default:
            [operationQueue setSuspended:YES];
            break;
    }
}
- (NSDictionary *)wrappedParameters:(NSDictionary *)parameters {
    return parameters;
}
- (NSURLSessionDataTask *)appGet:(NSString *)url parameters:(NSDictionary *)parameters handler:(void(^)(BOOL success, NSDictionary *response))handler{
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self handleError:[[NSError alloc] initWithDomain:@"network" code:-1009 userInfo:nil] withHandle:nil];
        return nil;
    }
    url = [PartTimeBaseUrl stringByAppendingString:url];
    return [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        [self handleData:response withHandle:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error withHandle:handler];
    }];
}
- (NSURLSessionDataTask *)appPost:(NSString *)url parameters:(NSDictionary *)parameters handler:(void(^)(BOOL success, NSDictionary *response))handler{
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self handleError:[[NSError alloc] initWithDomain:@"network" code:-1009 userInfo:nil] withHandle:nil];
        return nil;
    }
    return [self POST:url parameters:[self wrappedParameters:parameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        [self handleData:response withHandle:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error withHandle:handler];
    }];
}
- (void)handleData:(NSDictionary *)data withHandle:(void(^)(BOOL success, NSDictionary *response))handler {
        id response = data;
        handler(YES, response);
}
- (void)handleError:(NSError *)error withHandle:(void(^)(BOOL success, NSDictionary *response))handler {
    NSLog(@"handleError--------%ld--------!!!!!!!", (long)error.code);
    if (error.code == -1009) {
    }else {
    }
}
- (void)accountRequest:(NSDictionary *)parameters loginByPassword:(nonnull ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGINBYPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters loginByMessageCode:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGINBYMESSAGECODE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters sendMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_SENDMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters loginSendMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGONSENDMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters login:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGON parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters forgetMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOMERFORGINMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters updataPassword:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_UPDATEPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)userLimitPositionRequest:(NSDictionary *)parameters userPosition:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_USERPOSITION parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)position:(NSDictionary *)parameters postion:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_POSITION parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)positionRequest:(NSDictionary *)parameters positionInfo:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_POSITIONINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)positionRequest:(NSDictionary *)parameters doJob:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_DOJOB parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)positionRequest:(NSDictionary *)parameters getStyle:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_GETSQUAREIMG parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters checkStatus:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_CHECKSTATUS parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters initPhonecard:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_INITPHONECARD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
//河豚
- (void)accountRequest:(NSDictionary *)parameters logonAndloginByMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOEMR_LOGONANDLOGINBYMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)positionRequest:(NSDictionary *)parameters selectResumeByuserid:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_SELECTRESUMEBYUSERID parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)commonAcquireImg:(NSDictionary *)parameters firstImg:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_FIRSTIMG parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)resume:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_RESUMEINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)resumeInfo:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMEINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)resume:(NSDictionary *)parameters resumeHunting:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMEHUNTING parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)resume:(NSDictionary *)parameters resumeCompany:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMECOMPANY parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)resume:(NSDictionary *)parameters resumeSchool:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMESCHOOL parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)userInfo:(NSDictionary *)parameters postUserInfo:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_USERINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)userInfo:(NSDictionary *)parameters getUserInfo:(ZHandlerBlock)handler{
    [self appGet:CUSTOMER_USERINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)discover:(NSDictionary *)parameters defaultFound:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_DEFAULTFOUND parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)clickOperation:(NSDictionary *)parameters advertismentclick:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_ADVERTISEMENTCLICK parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
@end
