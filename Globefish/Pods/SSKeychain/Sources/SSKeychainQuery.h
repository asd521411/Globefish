#if __has_feature(modules)
	@import Foundation;
	@import Security;
#else
	#import <Foundation/Foundation.h>
	#import <Security/Security.h>
#endif
#if __IPHONE_7_0 || __MAC_10_9
	#define SSKEYCHAIN_SYNCHRONIZATION_AVAILABLE 1
#endif
#if __IPHONE_3_0 || __MAC_10_9
	#define SSKEYCHAIN_ACCESS_GROUP_AVAILABLE 1
#endif
#ifdef SSKEYCHAIN_SYNCHRONIZATION_AVAILABLE
typedef NS_ENUM(NSUInteger, SSKeychainQuerySynchronizationMode) {
	SSKeychainQuerySynchronizationModeAny,
	SSKeychainQuerySynchronizationModeNo,
	SSKeychainQuerySynchronizationModeYes
};
#endif
@interface SSKeychainQuery : NSObject
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *service;
@property (nonatomic, copy) NSString *label;
#ifdef SSKEYCHAIN_ACCESS_GROUP_AVAILABLE
@property (nonatomic, copy) NSString *accessGroup;
#endif
#ifdef SSKEYCHAIN_SYNCHRONIZATION_AVAILABLE
@property (nonatomic) SSKeychainQuerySynchronizationMode synchronizationMode;
#endif
@property (nonatomic, copy) NSData *passwordData;
@property (nonatomic, copy) id<NSCoding> passwordObject;
@property (nonatomic, copy) NSString *password;
- (BOOL)save:(NSError **)error;
- (BOOL)deleteItem:(NSError **)error;
- (NSArray<NSDictionary<NSString *, id> *> *)fetchAll:(NSError **)error;
- (BOOL)fetch:(NSError **)error;
#ifdef SSKEYCHAIN_SYNCHRONIZATION_AVAILABLE
+ (BOOL)isSynchronizationAvailable;
#endif
@end
