//
//  MainTableViewController.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeTableViewCell.h"

@interface MainTableViewController : UITableViewController

@property (nonatomic) NSArray * employees;
@property (nonatomic, strong) EmployeeTableViewCell * selectedCell;

@end
