#import "AppUpdater.h"
@implementation AppUpdater
+ (NSString *)localVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (void)checkUpgrade
{
}
+ (ECUpgrade *)upgrade
{
    return nil;
}
+ (BOOL)checkFilterVersionChange
{
    return NO;
}
+ (BOOL)checkSubwayVersionChange
{
    return NO;
}
@end
