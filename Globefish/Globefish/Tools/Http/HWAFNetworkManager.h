#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^ZHandlerBlock)(BOOL success, id request);
@interface HWAFNetworkManager : AFHTTPSessionManager
+ (instancetype)shareManager;
- (void)accountRequest:(NSDictionary *)parameters loginByPassword:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters loginByMessageCode:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters sendMessage:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters loginSendMessage:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters login:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters forgetMessage:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters updataPassword:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters logonAndloginByMessage:(ZHandlerBlock)handler;
- (void)userLimitPositionRequest:(NSDictionary *)parameters userPosition:(ZHandlerBlock)handler;
- (void)position:(NSDictionary *)parameters postion:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters positionInfo:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters doJob:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters checkStatus:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters initPhonecard:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters selectResumeByuserid:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters getStyle:(ZHandlerBlock)handler;
- (void)commonAcquireImg:(NSDictionary *)parameters firstImg:(ZHandlerBlock)handler;
- (void)userInfo:(NSDictionary *)parameters postUserInfo:(ZHandlerBlock)handler;
- (void)userInfo:(NSDictionary *)parameters getUserInfo:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler;
- (void)resumeInfo:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeHunting:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeCompany:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeSchool:(ZHandlerBlock)handler;
- (void)discover:(NSDictionary *)parameters defaultFound:(ZHandlerBlock)handler;
- (void)clickOperation:(NSDictionary *)parameters advertismentclick:(ZHandlerBlock)handler;
@end
NS_ASSUME_NONNULL_END
