#import <UIKit/UIKit.h>
#import "UITextField+RACSignalSupport.h"
#import "RACEXTKeyPathCoding.h"
#import "RACEXTScope.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import "RACSignal+Operations.h"
#import "UIControl+RACSignalSupport.h"
#import "UIControl+RACSignalSupportPrivate.h"

@interface UITextField (RACSignalSupportHw)
+ (BOOL)rac_textSignalHw:(NSInteger)hw;
+ (BOOL)rac_newTextChannelHw:(NSInteger)hw;

@end
