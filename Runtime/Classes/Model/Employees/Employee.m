//
//  Employee.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Employee.h"
#import "Company.h"
#import "Constants.h"

@implementation Employee

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - KVO

- (void)setName:(NSString *)name {
    
    [self addObserver:self forKeyPath:kConstant_FullnamePropertyKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    _name = name;
}

- (void)setLastname:(NSString *)lastname {
    
    [self addObserver:self forKeyPath:kConstant_FullnamePropertyKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    _lastname = lastname;
}

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
    
    [self removeObserver:self forKeyPath:kConstant_FullnamePropertyKey];
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
