#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class YYTextAsyncLayerDisplayTask;
NS_ASSUME_NONNULL_BEGIN
@interface YYTextAsyncLayer : CALayer
@property BOOL displaysAsynchronously;
@end
@protocol YYTextAsyncLayerDelegate <NSObject>
@required
- (YYTextAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end
@interface YYTextAsyncLayerDisplayTask : NSObject
@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGSize size, BOOL(^isCancelled)(void));
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);
@end
NS_ASSUME_NONNULL_END
