#import "NSUserDefaultMemory.h"
@implementation NSUserDefaultMemory
+ (void)defaultSetMemory:(id)obj unityKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", obj] forKey:key];
}
+ (id)defaultGetwithUnityKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
