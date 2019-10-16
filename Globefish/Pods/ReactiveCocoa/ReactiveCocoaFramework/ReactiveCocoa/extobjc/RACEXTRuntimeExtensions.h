#import <objc/runtime.h>
typedef enum {
    rac_propertyMemoryManagementPolicyAssign = 0,
    rac_propertyMemoryManagementPolicyRetain,
    rac_propertyMemoryManagementPolicyCopy
} rac_propertyMemoryManagementPolicy;
typedef struct {
    BOOL readonly;
    BOOL nonatomic;
    BOOL weak;
    BOOL canBeCollected;
    BOOL dynamic;
    rac_propertyMemoryManagementPolicy memoryManagementPolicy;
    SEL getter;
    SEL setter;
    const char *ivar;
    Class objectClass;
    char type[];
} rac_propertyAttributes;
Method rac_getImmediateInstanceMethod (Class aClass, SEL aSelector);
rac_propertyAttributes *rac_copyPropertyAttributes (objc_property_t property);
