#if __has_feature(modules)
	@import Foundation;
#else
	#import <Foundation/Foundation.h>
#endif
typedef NS_ENUM(OSStatus, SSKeychainErrorCode) {
	SSKeychainErrorBadArguments = -1001,
};
extern NSString *const kSSKeychainErrorDomain;
extern NSString *const kSSKeychainAccountKey;
extern NSString *const kSSKeychainCreatedAtKey;
extern NSString *const kSSKeychainClassKey;
extern NSString *const kSSKeychainDescriptionKey;
extern NSString *const kSSKeychainLabelKey;
extern NSString *const kSSKeychainLastModifiedKey;
extern NSString *const kSSKeychainWhereKey;
@interface SSKeychain : NSObject
#pragma mark - Classic methods
+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account;
+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error __attribute__((swift_error(none)));
+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account;
+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error __attribute__((swift_error(none)));
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error __attribute__((swift_error(none)));
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error __attribute__((swift_error(none)));
+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error __attribute__((swift_error(none)));
+ (NSArray<NSDictionary<NSString *, id> *> *)allAccounts;
+ (NSArray<NSDictionary<NSString *, id> *> *)allAccounts:(NSError *__autoreleasing *)error __attribute__((swift_error(none)));
+ (NSArray<NSDictionary<NSString *, id> *> *)accountsForService:(NSString *)serviceName;
+ (NSArray<NSDictionary<NSString *, id> *> *)accountsForService:(NSString *)serviceName error:(NSError *__autoreleasing *)error __attribute__((swift_error(none)));
#pragma mark - Configuration
#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType;
+ (void)setAccessibilityType:(CFTypeRef)accessibilityType;
#endif
@end
#import <SSKeychain/SSKeychainQuery.h>
