#import <Foundation/Foundation.h>
@class ECUpgrade;
@interface AppUpdater : NSObject
+ (NSString *)localVersion;
+ (void)checkUpgrade;
+ (ECUpgrade *)upgrade;
+ (BOOL)checkFilterVersionChange;
+ (BOOL)checkSubwayVersionChange;
@end
