#import <Foundation/Foundation.h>
#import "MJExtensionConst.h"
@class MJProperty;
typedef void (^MJPropertiesEnumeration)(MJProperty *property, BOOL *stop);
typedef NSDictionary * (^MJReplacedKeyFromPropertyName)(void);
typedef id (^MJReplacedKeyFromPropertyName121)(NSString *propertyName);
typedef NSDictionary * (^MJObjectClassInArray)(void);
typedef id (^MJNewValueFromOldValue)(id object, id oldValue, MJProperty *property);
@interface NSObject (MJProperty)
#pragma mark - 遍历
+ (void)mj_enumerateProperties:(MJPropertiesEnumeration)enumeration;
#pragma mark - 新值配置
+ (void)mj_setupNewValueFromOldValue:(MJNewValueFromOldValue)newValueFormOldValue;
+ (id)mj_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained MJProperty *)property;
#pragma mark - key配置
+ (void)mj_setupReplacedKeyFromPropertyName:(MJReplacedKeyFromPropertyName)replacedKeyFromPropertyName;
+ (void)mj_setupReplacedKeyFromPropertyName121:(MJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121;
#pragma mark - array model class配置
+ (void)mj_setupObjectClassInArray:(MJObjectClassInArray)objectClassInArray;
@end
@interface NSObject (MJPropertyDeprecated_v_2_5_16)
+ (void)enumerateProperties:(MJPropertiesEnumeration)enumeration MJExtensionDeprecated("请在方法名前面加上mj_前缀，使用mj_***");
+ (void)setupNewValueFromOldValue:(MJNewValueFromOldValue)newValueFormOldValue MJExtensionDeprecated("请在方法名前面加上mj_前缀，使用mj_***");
+ (id)getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained MJProperty *)property MJExtensionDeprecated("请在方法名前面加上mj_前缀，使用mj_***");
+ (void)setupReplacedKeyFromPropertyName:(MJReplacedKeyFromPropertyName)replacedKeyFromPropertyName MJExtensionDeprecated("请在方法名前面加上mj_前缀，使用mj_***");
+ (void)setupReplacedKeyFromPropertyName121:(MJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121 MJExtensionDeprecated("请在方法名前面加上mj_前缀，使用mj_***");
+ (void)setupObjectClassInArray:(MJObjectClassInArray)objectClassInArray MJExtensionDeprecated("请在方法名前面加上mj_前缀，使用mj_***");
@end
