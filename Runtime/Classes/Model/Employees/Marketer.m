//
//  Marketer.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Marketer.h"
#import "Constants.h"

@implementation Marketer

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Marketer protocol

- (void)runMarketingCampaign {
    NSLog(@"runMarketingCampaign");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kConstantNotification_RunMarketingCampaignCompleted
                                                        object:self];
}

@end
