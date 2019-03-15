//
//  Company.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Company.h"
#import <objc/runtime.h>

@interface Company()

// That's also possible to set ivars from Categories in .m file of Class via KVC
@property (nonatomic) Founder * founder;

@end

@implementation Company

- (id)init {
    self = [super init];
    if (self) {
        _employees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setFounder:(Founder *)founder {
    _founder = founder;
    
    if (!_employees.count) {
        [_employees addObject:founder];
        return;
    }
    
    for (Employee * employee in _employees) {
        
        if ([employee isMemberOfClass:[Founder class]]) {
            
            __weak __typeof(self)weakSelf = self;
            dispatch_queue_t serialQueue = dispatch_queue_create("com.gross.syncQueue", DISPATCH_QUEUE_SERIAL);
            dispatch_sync(serialQueue, ^{
                [weakSelf.employees removeObject:employee];
                [weakSelf.employees addObject:founder];
            });
        }
    }
}

#pragma mark - Message Forwarding

/* First checkpoint for a missed instance method. In total, we have 3 checkpoints to handle message which were not processed the first time */
+ (BOOL)resolveInstanceMethod:(SEL)selector {
    
    if (selector == @selector(addEmployee:)) {
        // Runtime: dynamically add a missed method. v - void, @ - object (self), : - selector. Check code table for more information.
        class_addMethod([self class], selector, (IMP)dynamicAddEmployee, "v@:@");
    }

    
    return [super resolveInstanceMethod:selector];
}

/* Second checkpoint to handle message */
- (id)forwardingTargetForSelector:(SEL)selector {
    
    // The method returns an object that can process the message (method call)
    // Good for Compositor pattern
    // This method is some kind of optimisation before Full Message Forwarding mechanism (3rd step)
    // Try to do all stuff here, the next step will have more performance costs
    
    return nil;
}

/* Third checkpoint - Full Message Forwarding mechanism */
- (void)forwardInvocation:(NSInvocation *)invocation {
    
    SEL selector = [invocation selector];
    
    if ([self.founder respondsToSelector:selector]) {
        [invocation invokeWithTarget:self.founder];
        
    } else if ([self checkWhoCanDoTheTask:selector]) {
        Employee * empoyeeWhoCan = [self checkWhoCanDoTheTask:selector];
        [invocation invokeWithTarget:empoyeeWhoCan];
        
    } else {
        [super forwardInvocation:invocation];
    }
}

- (Employee *)checkWhoCanDoTheTask:(SEL)task {
    
    for (Employee * empoyee in self.employees) {
        if ([empoyee respondsToSelector:task]) {
            return empoyee;
        }
    }
    
    return nil;
}

#pragma mark - Functions to resolve missed methods

void dynamicAddEmployee(id self, SEL _cmd, id value) {
    [((Company *)self)->_employees addObject:value];
}

@end
