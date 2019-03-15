//
//  MainView.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "MainView.h"
#import "ColorManager.h"

@interface MainView() {
    CGFloat navigationBarHeight;
}

@end

@implementation MainView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIColor * mainColor = [ColorManager colorWithHex:@"2d3a80"];
        UIColor * highlightedColor = [ColorManager colorWithHex:@"39499D"];
        UIColor * tableViewColor = [UIColor whiteColor];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = tableViewColor;
        [self addSubview:_tableView];
        
        _actionButton = [HighlightedButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setTitle:@"Do something" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]];
        [_actionButton setBackgroundColor:mainColor];
        [_actionButton setValue:mainColor forKey:@"mainColor"];
        [_actionButton setValue:highlightedColor forKey:@"highlightedColor"];
        [self addSubview:_actionButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    /* Table view */
    CGFloat tableViewSideOffset = 10;
    CGFloat tableViewTopOffset = 10;
    CGFloat actionButtonHeight = 90;
    self.tableView.frame = CGRectMake(tableViewSideOffset,
                                      navigationBarHeight + tableViewTopOffset,
                                      self.frame.size.width - tableViewSideOffset * 2,
                                      self.frame.size.height - navigationBarHeight - tableViewTopOffset * 2 - actionButtonHeight);
    
    /* Action button */
    self.actionButton.frame = CGRectMake(0,
                                         self.frame.size.height - actionButtonHeight,
                                         self.frame.size.width,
                                         actionButtonHeight);
}

@end
