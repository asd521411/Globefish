#import <Foundation/Foundation.h>
typedef void (^MJClassesEnumeration)(Class c, BOOL *stop);
typedef NSArray * (^MJAllowedPropertyNames)(void);
typedef NSArray * (^MJAllowedCodingPropertyNames)(void);
typedef NSArray * (^MJIgnoredPropertyNames)(void);
typedef NSArray * (^MJIgnoredCodingPropertyNames)(void);
@interface NSObject (MJClass)
+ (void)mj_enumerateClasses:(MJClassesEnumeration)enumeration;
+ (void)mj_enumerateAllClasses:(MJClassesEnumeration)enumeration;
#pragma mark - 属性白名单配置
+ (void)mj_setupAllowedPropertyNames:(MJAllowedPropertyNames)allowedPropertyNames;
+ (NSMutableArray *)mj_totalAllowedPropertyNames;
#pragma mark - 属性黑名单配置
+ (void)mj_setupIgnoredPropertyNames:(MJIgnoredPropertyNames)ignoredPropertyNames;
+ (NSMutableArray *)mj_totalIgnoredPropertyNames;
#pragma mark - 归档属性白名单配置
+ (void)mj_setupAllowedCodingPropertyNames:(MJAllowedCodingPropertyNames)allowedCodingPropertyNames;
+ (NSMutableArray *)mj_totalAllowedCodingPropertyNames;
#pragma mark - 归档属性黑名单配置
+ (void)mj_setupIgnoredCodingPropertyNames:(MJIgnoredCodingPropertyNames)ignoredCodingPropertyNames;
+ (NSMutableArray *)mj_totalIgnoredCodingPropertyNames;
#pragma mark - 内部使用
+ (void)mj_setupBlockReturnValue:(id (^)(void))block key:(const char *)key;
@end
