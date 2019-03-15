//
//  MainView.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighlightedButton.h"

@interface MainView : UIView

@property (nonatomic) UITableView * tableView;
@property (nonatomic) HighlightedButton * actionButton;

@end
