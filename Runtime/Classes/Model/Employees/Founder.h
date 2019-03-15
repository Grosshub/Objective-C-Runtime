//
//  Founder.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Employee.h"

@protocol FounderProtocol <NSObject>

- (void)goIPO;

@end

@interface Founder : Employee <FounderProtocol>

@end
