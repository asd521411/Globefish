#import "NSObject+MJProperty.h"
#import "NSObject+MJKeyValue.h"
#import "NSObject+MJCoding.h"
#import "NSObject+MJClass.h"
#import "MJProperty.h"
#import "MJFoundation.h"
#import <objc/runtime.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
static const char MJReplacedKeyFromPropertyNameKey = '\0';
static const char MJReplacedKeyFromPropertyName121Key = '\0';
static const char MJNewValueFromOldValueKey = '\0';
static const char MJObjectClassInArrayKey = '\0';
static const char MJCachedPropertiesKey = '\0';
@implementation NSObject (Property)
+ (NSMutableDictionary *)mj_propertyDictForKey:(const void *)key
{
    static NSMutableDictionary *replacedKeyFromPropertyNameDict;
    static NSMutableDictionary *replacedKeyFromPropertyName121Dict;
    static NSMutableDictionary *newValueFromOldValueDict;
    static NSMutableDictionary *objectClassInArrayDict;
    static NSMutableDictionary *cachedPropertiesDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        replacedKeyFromPropertyNameDict = [NSMutableDictionary dictionary];
        replacedKeyFromPropertyName121Dict = [NSMutableDictionary dictionary];
        newValueFromOldValueDict = [NSMutableDictionary dictionary];
        objectClassInArrayDict = [NSMutableDictionary dictionary];
        cachedPropertiesDict = [NSMutableDictionary dictionary];
    });
    if (key == &MJReplacedKeyFromPropertyNameKey) return replacedKeyFromPropertyNameDict;
    if (key == &MJReplacedKeyFromPropertyName121Key) return replacedKeyFromPropertyName121Dict;
    if (key == &MJNewValueFromOldValueKey) return newValueFromOldValueDict;
    if (key == &MJObjectClassInArrayKey) return objectClassInArrayDict;
    if (key == &MJCachedPropertiesKey) return cachedPropertiesDict;
    return nil;
}
#pragma mark - --私有方法--
+ (id)mj_propertyKey:(NSString *)propertyName
{
    MJExtensionAssertParamNotNil2(propertyName, nil);
    __block id key = nil;
    if ([self respondsToSelector:@selector(mj_replacedKeyFromPropertyName121:)]) {
        key = [self mj_replacedKeyFromPropertyName121:propertyName];
    }
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName121:)]) {
        key = [self performSelector:@selector(replacedKeyFromPropertyName121:) withObject:propertyName];
    }
    if (!key) {
        [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            MJReplacedKeyFromPropertyName121 block = objc_getAssociatedObject(c, &MJReplacedKeyFromPropertyName121Key);
            if (block) {
                key = block(propertyName);
            }
            if (key) *stop = YES;
        }];
    }
    if ((!key || [key isEqual:propertyName]) && [self respondsToSelector:@selector(mj_replacedKeyFromPropertyName)]) {
        key = [self mj_replacedKeyFromPropertyName][propertyName];
    }
    if ((!key || [key isEqual:propertyName]) && [self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self performSelector:@selector(replacedKeyFromPropertyName)][propertyName];
    }
    if (!key || [key isEqual:propertyName]) {
        [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            NSDictionary *dict = objc_getAssociatedObject(c, &MJReplacedKeyFromPropertyNameKey);
            if (dict) {
                key = dict[propertyName];
            }
            if (key && ![key isEqual:propertyName]) *stop = YES;
        }];
    }
    if (!key) key = propertyName;
    return key;
}
+ (Class)mj_propertyObjectClassInArray:(NSString *)propertyName
{
    __block id clazz = nil;
    if ([self respondsToSelector:@selector(mj_objectClassInArray)]) {
        clazz = [self mj_objectClassInArray][propertyName];
    }
    if ([self respondsToSelector:@selector(objectClassInArray)]) {
        clazz = [self performSelector:@selector(objectClassInArray)][propertyName];
    }
    if (!clazz) {
        [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            NSDictionary *dict = objc_getAssociatedObject(c, &MJObjectClassInArrayKey);
            if (dict) {
                clazz = dict[propertyName];
            }
            if (clazz) *stop = YES;
        }];
    }
    if ([clazz isKindOfClass:[NSString class]]) {
        clazz = NSClassFromString(clazz);
    }
    return clazz;
}
#pragma mark - --公共方法--
+ (void)mj_enumerateProperties:(MJPropertiesEnumeration)enumeration
{
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    NSArray *cachedProperties = [self mj_properties];
    MJExtensionSemaphoreSignal
    BOOL stop = NO;
    for (MJProperty *property in cachedProperties) {
        enumeration(property, &stop);
        if (stop) break;
    }
}
#pragma mark - 公共方法
+ (NSMutableArray *)mj_properties
{
    NSMutableArray *cachedProperties = [self mj_propertyDictForKey:&MJCachedPropertiesKey][NSStringFromClass(self)];
    if (cachedProperties == nil) {
        if (cachedProperties == nil) {
            cachedProperties = [NSMutableArray array];
            [self mj_enumerateClasses:^(__unsafe_unretained Class c, BOOL *stop) {
                unsigned int outCount = 0;
                objc_property_t *properties = class_copyPropertyList(c, &outCount);
                for (unsigned int i = 0; i<outCount; i++) {
                    MJProperty *property = [MJProperty cachedPropertyWithProperty:properties[i]];
                    if ([MJFoundation isClassFromFoundation:property.srcClass]) continue;
                    if ([MJFoundation isFromNSObjectProtocolProperty:property.name]) continue;
                    property.srcClass = c;
                    [property setOriginKey:[self mj_propertyKey:property.name] forClass:self];
                    [property setObjectClassInArray:[self mj_propertyObjectClassInArray:property.name] forClass:self];
                    [cachedProperties addObject:property];
                }
                free(properties);
            }];
            [self mj_propertyDictForKey:&MJCachedPropertiesKey][NSStringFromClass(self)] = cachedProperties;
        }
    }
    return cachedProperties;
}
#pragma mark - 新值配置
+ (void)mj_setupNewValueFromOldValue:(MJNewValueFromOldValue)newValueFormOldValue
{
    objc_setAssociatedObject(self, &MJNewValueFromOldValueKey, newValueFormOldValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
+ (id)mj_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(MJProperty *__unsafe_unretained)property{
    if ([object respondsToSelector:@selector(mj_newValueFromOldValue:property:)]) {
        return [object mj_newValueFromOldValue:oldValue property:property];
    }
    if ([self respondsToSelector:@selector(newValueFromOldValue:property:)]) {
        return [self performSelector:@selector(newValueFromOldValue:property:) withObject:oldValue withObject:property];
    }
    __block id newValue = oldValue;
    [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
        MJNewValueFromOldValue block = objc_getAssociatedObject(c, &MJNewValueFromOldValueKey);
        if (block) {
            newValue = block(object, oldValue, property);
            *stop = YES;
        }
    }];
    return newValue;
}
#pragma mark - array model class配置
+ (void)mj_setupObjectClassInArray:(MJObjectClassInArray)objectClassInArray
{
    [self mj_setupBlockReturnValue:objectClassInArray key:&MJObjectClassInArrayKey];
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    [[self mj_propertyDictForKey:&MJCachedPropertiesKey] removeAllObjects];
    MJExtensionSemaphoreSignal
}
#pragma mark - key配置
+ (void)mj_setupReplacedKeyFromPropertyName:(MJReplacedKeyFromPropertyName)replacedKeyFromPropertyName
{
    [self mj_setupBlockReturnValue:replacedKeyFromPropertyName key:&MJReplacedKeyFromPropertyNameKey];
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    [[self mj_propertyDictForKey:&MJCachedPropertiesKey] removeAllObjects];
    MJExtensionSemaphoreSignal
}
+ (void)mj_setupReplacedKeyFromPropertyName121:(MJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121
{
    objc_setAssociatedObject(self, &MJReplacedKeyFromPropertyName121Key, replacedKeyFromPropertyName121, OBJC_ASSOCIATION_COPY_NONATOMIC);
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    [[self mj_propertyDictForKey:&MJCachedPropertiesKey] removeAllObjects];
    MJExtensionSemaphoreSignal
}
@end
@implementation NSObject (MJPropertyDeprecated_v_2_5_16)
+ (void)enumerateProperties:(MJPropertiesEnumeration)enumeration
{
    [self mj_enumerateProperties:enumeration];
}
+ (void)setupNewValueFromOldValue:(MJNewValueFromOldValue)newValueFormOldValue
{
    [self mj_setupNewValueFromOldValue:newValueFormOldValue];
}
+ (id)getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained MJProperty *)property
{
    return [self mj_getNewValueFromObject:object oldValue:oldValue property:property];
}
+ (void)setupReplacedKeyFromPropertyName:(MJReplacedKeyFromPropertyName)replacedKeyFromPropertyName
{
    [self mj_setupReplacedKeyFromPropertyName:replacedKeyFromPropertyName];
}
+ (void)setupReplacedKeyFromPropertyName121:(MJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121
{
    [self mj_setupReplacedKeyFromPropertyName121:replacedKeyFromPropertyName121];
}
+ (void)setupObjectClassInArray:(MJObjectClassInArray)objectClassInArray
{
    [self mj_setupObjectClassInArray:objectClassInArray];
}
@end
#pragma clang diagnostic pop
