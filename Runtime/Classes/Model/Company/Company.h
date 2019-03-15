//
//  Company.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Founder.h"
#import "Developer.h"
#import "Marketer.h"

@protocol CompanyProtocol <NSObject>

- (void)addEmployee:(Employee *)employee;

@end

/*
 Company class declared a CompanyProtocol and purposely does not define it: you could see a warning about it in the .m file.
 We will use Runtime to resolve it
 */

@interface Company : NSObject <CompanyProtocol, FounderProtocol, MarketerProtocol, DeveloperProtocol> {
    // I add this ivar to show how we could set its value with KVC
    NSString * name;
}

@property (nonatomic, strong) NSMutableArray * employees;

@end
