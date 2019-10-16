#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    RACEventTypeCompleted,
    RACEventTypeError,
    RACEventTypeNext
} RACEventType;
@interface RACEvent : NSObject <NSCopying>
+ (instancetype)completedEvent;
+ (instancetype)eventWithError:(NSError *)error;
+ (instancetype)eventWithValue:(id)value;
@property (nonatomic, assign, readonly) RACEventType eventType;
@property (nonatomic, getter = isFinished, assign, readonly) BOOL finished;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong, readonly) id value;
@end
