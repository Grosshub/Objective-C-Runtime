//
//  Developer.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "Employee.h"

@protocol DeveloperProtocol <NSObject>

- (void)doAllWork;

@end

@interface Developer : Employee <DeveloperProtocol>

@end
