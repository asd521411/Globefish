@class RACSignal;
@interface NSObject (RACLifting)
- (RACSignal *)rac_liftSelector:(SEL)selector withSignals:(RACSignal *)firstSignal, ... NS_REQUIRES_NIL_TERMINATION;
- (RACSignal *)rac_liftSelector:(SEL)selector withSignalsFromArray:(NSArray *)signals;
@end
@interface NSObject (RACLiftingDeprecated)
- (RACSignal *)rac_liftSelector:(SEL)selector withObjects:(id)arg, ... __attribute__((deprecated("Use -rac_liftSelector:withSignals: instead")));
- (RACSignal *)rac_liftSelector:(SEL)selector withObjectsFromArray:(NSArray *)args __attribute__((deprecated("Use -rac_liftSelector:withSignalsFromArray: instead")));
- (RACSignal *)rac_liftBlock:(id)block withArguments:(id)arg, ... NS_REQUIRES_NIL_TERMINATION __attribute__((deprecated("Use +combineLatest:reduce: instead")));
- (RACSignal *)rac_liftBlock:(id)block withArgumentsFromArray:(NSArray *)args __attribute__((deprecated("Use +combineLatest:reduce: instead")));
@end
@interface NSObject (RACLiftingUnavailable)
- (instancetype)rac_lift __attribute__((unavailable("Use -rac_liftSelector:withSignals: instead")));
@end
