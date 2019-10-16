#import <Foundation/Foundation.h>
@interface RACValueTransformer : NSValueTransformer
+ (instancetype)transformerWithBlock:(id (^)(id value))block;
@end
