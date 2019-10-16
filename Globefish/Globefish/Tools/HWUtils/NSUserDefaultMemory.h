#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaultMemory : NSObject
+ (void)defaultSetMemory:(id)obj unityKey:(NSString *)key;
+ (id)defaultGetwithUnityKey:(NSString *)key;
@end
NS_ASSUME_NONNULL_END
