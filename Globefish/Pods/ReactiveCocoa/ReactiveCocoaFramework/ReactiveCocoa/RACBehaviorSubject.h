#import "RACSubject.h"
@interface RACBehaviorSubject : RACSubject
+ (instancetype)behaviorSubjectWithDefaultValue:(id)value;
@end
