#import <UIKit/UIKit.h>
#import "UITextView+RACSignalSupport.h"
#import "RACEXTScope.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import "RACDelegateProxy.h"
#import "RACSignal+Operations.h"
#import "RACTuple.h"
#import <objc/runtime.h>

@interface UITextView (RACSignalSupportHw)
+ (BOOL)rac_delegateProxyHw:(NSInteger)hw;
+ (BOOL)rac_textSignalHw:(NSInteger)hw;

@end
