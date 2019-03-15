//
//  Developer.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Developer.h"
#import "Constants.h"

@implementation Developer

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Developer protocol

- (void)doAllWork {
    NSLog(@"doAllWork");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kConstantNotification_DidAllWork
                                                        object:self];
}

@end
