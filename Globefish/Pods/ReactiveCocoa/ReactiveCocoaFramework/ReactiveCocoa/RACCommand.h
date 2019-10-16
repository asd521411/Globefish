#import <Foundation/Foundation.h>
@class RACSignal;
extern NSString * const RACCommandErrorDomain;
extern const NSInteger RACCommandErrorNotEnabled;
extern NSString * const RACUnderlyingCommandErrorKey;
@interface RACCommand : NSObject
@property (nonatomic, strong, readonly) RACSignal *executionSignals;
@property (nonatomic, strong, readonly) RACSignal *executing;
@property (nonatomic, strong, readonly) RACSignal *enabled;
@property (nonatomic, strong, readonly) RACSignal *errors;
@property (atomic, assign) BOOL allowsConcurrentExecution;
- (id)initWithSignalBlock:(RACSignal * (^)(id input))signalBlock;
- (id)initWithEnabled:(RACSignal *)enabledSignal signalBlock:(RACSignal * (^)(id input))signalBlock;
- (RACSignal *)execute:(id)input;
@end
@interface RACCommand (Unavailable)
@property (atomic, readonly) BOOL canExecute __attribute__((unavailable("Use the 'enabled' signal instead")));
+ (instancetype)command __attribute__((unavailable("Use -initWithSignalBlock: instead")));
+ (instancetype)commandWithCanExecuteSignal:(RACSignal *)canExecuteSignal __attribute__((unavailable("Use -initWithEnabled:signalBlock: instead")));
- (id)initWithCanExecuteSignal:(RACSignal *)canExecuteSignal __attribute__((unavailable("Use -initWithEnabled:signalBlock: instead")));
- (RACSignal *)addSignalBlock:(RACSignal * (^)(id value))signalBlock __attribute__((unavailable("Pass the signalBlock to -initWithSignalBlock: instead")));
@end
