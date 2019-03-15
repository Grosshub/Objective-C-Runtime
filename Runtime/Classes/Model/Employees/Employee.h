//
//  Employee.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Company;

@interface Employee : NSObject

@property (nonatomic, strong) Company * company;

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * lastname;
@property (nonatomic, copy) NSString * fullname;

@end
