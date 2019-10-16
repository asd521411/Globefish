#import <Foundation/Foundation.h>
#import "RACmetamacros.h"
@class RACSequence;
#define RACTuplePack(...) \
    RACTuplePack_(__VA_ARGS__)
#define RACTupleUnpack(...) \
        RACTupleUnpack_(__VA_ARGS__)
@interface RACTupleNil : NSObject <NSCopying, NSCoding>
+ (RACTupleNil *)tupleNil;
@end
@interface RACTuple : NSObject <NSCoding, NSCopying, NSFastEnumeration>
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id first;
@property (nonatomic, readonly) id second;
@property (nonatomic, readonly) id third;
@property (nonatomic, readonly) id fourth;
@property (nonatomic, readonly) id fifth;
@property (nonatomic, readonly) id last;
+ (instancetype)tupleWithObjectsFromArray:(NSArray *)array;
+ (instancetype)tupleWithObjectsFromArray:(NSArray *)array convertNullsToNils:(BOOL)convert;
+ (instancetype)tupleWithObjects:(id)object, ... NS_REQUIRES_NIL_TERMINATION;
- (id)objectAtIndex:(NSUInteger)index;
- (NSArray *)allObjects;
- (instancetype)tupleByAddingObject:(id)obj;
@end
@interface RACTuple (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
@interface RACTuple (ObjectSubscripting)
- (id)objectAtIndexedSubscript:(NSUInteger)idx; 
@end
#define RACTuplePack_(...) \
    ([RACTuple tupleWithObjectsFromArray:@[ metamacro_foreach(RACTuplePack_object_or_ractuplenil,, __VA_ARGS__) ]])
#define RACTuplePack_object_or_ractuplenil(INDEX, ARG) \
    (ARG) ?: RACTupleNil.tupleNil,
#define RACTupleUnpack_(...) \
    metamacro_foreach(RACTupleUnpack_decl,, __VA_ARGS__) \
    \
    int RACTupleUnpack_state = 0; \
    \
    RACTupleUnpack_after: \
        ; \
        metamacro_foreach(RACTupleUnpack_assign,, __VA_ARGS__) \
        if (RACTupleUnpack_state != 0) RACTupleUnpack_state = 2; \
        \
        while (RACTupleUnpack_state != 2) \
            if (RACTupleUnpack_state == 1) { \
                goto RACTupleUnpack_after; \
            } else \
                for (; RACTupleUnpack_state != 1; RACTupleUnpack_state = 1) \
                    [RACTupleUnpackingTrampoline trampoline][ @[ metamacro_foreach(RACTupleUnpack_value,, __VA_ARGS__) ] ]
#define RACTupleUnpack_state metamacro_concat(RACTupleUnpack_state, __LINE__)
#define RACTupleUnpack_after metamacro_concat(RACTupleUnpack_after, __LINE__)
#define RACTupleUnpack_loop metamacro_concat(RACTupleUnpack_loop, __LINE__)
#define RACTupleUnpack_decl_name(INDEX) \
    metamacro_concat(metamacro_concat(RACTupleUnpack, __LINE__), metamacro_concat(_var, INDEX))
#define RACTupleUnpack_decl(INDEX, ARG) \
    __strong id RACTupleUnpack_decl_name(INDEX);
#define RACTupleUnpack_assign(INDEX, ARG) \
    __strong ARG = RACTupleUnpack_decl_name(INDEX);
#define RACTupleUnpack_value(INDEX, ARG) \
    [NSValue valueWithPointer:&RACTupleUnpack_decl_name(INDEX)],
@interface RACTupleUnpackingTrampoline : NSObject
+ (instancetype)trampoline;
- (void)setObject:(RACTuple *)tuple forKeyedSubscript:(NSArray *)variables;
@end
