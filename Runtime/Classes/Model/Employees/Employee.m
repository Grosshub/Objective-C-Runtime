//
//  Employee.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Employee.h"
#import "Company.h"

@implementation Employee

- (id)init {
    self = [super init];
    if (self) {
        
        [self addObserver:self forKeyPath:@"fullname" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

#pragma mark - KVO

// KVO: dependent properties
- (NSString *)fullname {
    
    NSString * name = [NSString string];
    NSString * lastname = [NSString string];
    
    if (_name != nil) {
        name = [NSString stringWithFormat:@"%@ ", _name];
    }
    
    if (_lastname != nil) {
        lastname = [_lastname copy];
    }
    
    NSString * fullname = [NSString stringWithFormat:@"%@%@", name, lastname];
    return fullname;
}

+ (NSSet *)keyPathsForValuesAffectingFullname {
    return [NSSet setWithObjects:@"name", @"lastname", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

#pragma mark - Message Forwarding

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    // We try to pass the task to the company that any employee tried to do the task or the crash will happen
    SEL selector = [invocation selector];
    
    if ([self.company respondsToSelector:selector]) {
        [invocation invokeWithTarget:self.company];
        
    } else {
        
        [super forwardInvocation:invocation];
    }
}

@end
