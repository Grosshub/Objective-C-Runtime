//
//  EmployeeTableViewCell.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface EmployeeTableViewCell : UITableViewCell

@property (nonatomic) UILabel * fullnameLabel;
@property (nonatomic) UILabel * positionLabel;
@property (nonatomic) UILabel * salaryLabel;

@property (nonatomic) Employee * employee;

- (void)updateWithEmployee:(Employee *)employee;

@end
