//
//  Marketer.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Employee.h"

@protocol MarketerProtocol <NSObject>

- (void)runMarketingCampaign;

@end

@interface Marketer : Employee <MarketerProtocol>

@end
