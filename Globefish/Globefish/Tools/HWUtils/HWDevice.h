#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, EDeviceType)
{
    EDeviceType_4 = 0,
    EDeviceType_5 = 1,
    EDeviceType_6 = 2,
    EDeviceType_6p = 3,
    EDeviceType_X = 4,
};
@interface HWDevice : NSObject
+ (NSDictionary *)clientInfo;
+ (EDeviceType)getDeviceType;
+ (BOOL)isUnderIPhone5;
+ (float)systemVersion;
+ (BOOL)isIOS8;
@end
