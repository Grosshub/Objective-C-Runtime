//
//  EmployeeTableViewCell.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "EmployeeTableViewCell.h"
#import "ColorManager.h"
#import "Founder.h"
#import "Marketer.h"
#import "Developer.h"

@interface EmployeeTableViewCell()

@property (nonatomic, strong) UIColor * highlightedColor;

@end

@implementation EmployeeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIColor * fullnameColor = [ColorManager colorWithHex:@"1D1D26"];
        UIColor * positionColor = [ColorManager colorWithHex:@"2d3a80"];
        _highlightedColor = [ColorManager colorWithHex:@"F9E7FE"];
        
        _fullnameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_fullnameLabel setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]];
        [_fullnameLabel setTextColor:fullnameColor];
        [_fullnameLabel setTextAlignment:NSTextAlignmentLeft];
        [_fullnameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_fullnameLabel];
        
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_positionLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
        [_positionLabel setTextColor:positionColor];
        [_positionLabel setTextAlignment:NSTextAlignmentLeft];
        [_positionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_positionLabel];
        
        _salaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_salaryLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightRegular]];
        [_salaryLabel setTextColor:fullnameColor];
        [_salaryLabel setTextAlignment:NSTextAlignmentLeft];
        [_salaryLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_salaryLabel];
    }
    return self;
}

- (void)updateWithEmployee:(Employee *)employee {
    
    self.employee = employee;
    
    NSString * position = [NSString string];
    if ([employee isMemberOfClass:[Founder class]]) {
        position = NSStringFromClass([Founder class]);
        
    } else if ([employee isMemberOfClass:[Marketer class]]) {
        position = NSStringFromClass([Marketer class]);
        
    } else if ([employee isMemberOfClass:[Developer class]]) {
        position = NSStringFromClass([Developer class]);
    }
    
    [self.positionLabel setText:position];
    [self.fullnameLabel setText:employee.fullname];
    [self.salaryLabel setText:[NSString stringWithFormat:@"$%d", employee.salary]];
    
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView * backgroundColorView = [[UIView alloc] init];
    if (selected) {
        backgroundColorView.backgroundColor = _highlightedColor;
    }
    [self setSelectedBackgroundView:backgroundColorView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    [self.salaryLabel sizeToFit];
    CGFloat salaryLabelWidth = self.salaryLabel.frame.size.width;
    
    
    CGFloat labelSideOffset = 10;
    CGFloat labelTopOffset = 5;
    self.fullnameLabel.frame = CGRectMake(labelSideOffset,
                                          labelTopOffset,
                                          self.frame.size.width - labelSideOffset * 2 - salaryLabelWidth,
                                          20);
    
    
    self.positionLabel.frame = CGRectMake(labelSideOffset,
                                          self.fullnameLabel.frame.origin.y + self.fullnameLabel.frame.size.height + 3,
                                          self.fullnameLabel.frame.size.width,
                                          self.fullnameLabel.frame.size.height);
    
    
    self.salaryLabel.frame = CGRectMake(self.frame.size.width - salaryLabelWidth - labelSideOffset,
                                        self.fullnameLabel.frame.origin.y,
                                        salaryLabelWidth,
                                        self.salaryLabel.frame.size.height);
}

@end
