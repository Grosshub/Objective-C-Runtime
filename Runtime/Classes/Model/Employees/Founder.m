//
//  Founder.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Founder.h"
#import "Constants.h"

@implementation Founder

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Founder protocol

- (void)goIPO {
    NSLog(@"goIPO");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kConstantNotification_DoIpoCompleted
                                                        object:self];
}

@end
