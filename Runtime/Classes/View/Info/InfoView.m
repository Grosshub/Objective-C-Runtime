//
//  InfoView.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "InfoView.h"
#import "ColorManager.h"
#import "Constants.h"

@interface InfoView()

@end

@implementation InfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIColor * mainColor = [ColorManager colorWithHex:@"2d3a80"];
        UIColor * highlightedColor = [ColorManager colorWithHex:@"39499D"];
        UIColor * descriptionColor = [ColorManager colorWithHex:@"1f1e1e"];
        NSString * descriptionString = @"This application created to show the power of Objective-C Runtime. This is not about the user interface, this is about the code. I tried to make a visual representation of my code, not vice versa. Runtime allows you to make an introspection of objects/classes or modify them when the app is already running (not in compile time). The most powerful Runtime feature as for me is a message forwarding mechanism which is presented in code too. Enjoy!";
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setText:@"Objective-C Runtime"];
        [_titleLabel setFont:[UIFont systemFontOfSize:35 weight:UIFontWeightSemibold]];
        [_titleLabel setTextColor:mainColor];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
        
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_descriptionLabel setText:descriptionString];
        [_descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
        [_descriptionLabel setTextColor:descriptionColor];
        [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [_descriptionLabel setNumberOfLines:0];
        [self addSubview:_descriptionLabel];
        
        _startButton = [HighlightedButton buttonWithType:UIButtonTypeCustom];
        [_startButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startButton setBackgroundColor:mainColor];
        [_startButton setValue:mainColor forKey:@"mainColor"];
        [_startButton setValue:highlightedColor forKey:@"highlightedColor"];
        [_startButton.layer setCornerRadius:4];
        [_startButton setClipsToBounds:YES];
        [self addSubview:_startButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    /* Title label */
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake((self.frame.size.width - self.titleLabel.frame.size.width) / 2,
                                       100,
                                       self.titleLabel.frame.size.width,
                                       self.titleLabel.frame.size.height);
    
    
    /* Description label */
    UILayoutGuide * descriptionLabelMargin = self.titleLabel.layoutMarginsGuide;
    [self.descriptionLabel.leftAnchor constraintEqualToAnchor:descriptionLabelMargin.leftAnchor].active = YES;
    [self.descriptionLabel.rightAnchor constraintEqualToAnchor:descriptionLabelMargin.rightAnchor].active = YES;
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:descriptionLabelMargin.topAnchor constant:50].active = YES;
    
    
    /* Start button */
    UILayoutGuide * startButtonMargin = self.layoutMarginsGuide;
    CGFloat startButtonWidth = 250;
    CGFloat startButtonHeight = 60;
    [self.startButton.widthAnchor constraintEqualToConstant:startButtonWidth].active = YES;
    [self.startButton.heightAnchor constraintEqualToConstant:startButtonHeight].active = YES;
    [self.startButton.bottomAnchor constraintEqualToAnchor:startButtonMargin.bottomAnchor constant:-50].active = YES;
    [self.startButton.centerXAnchor constraintEqualToAnchor:startButtonMargin.centerXAnchor].active = YES;
    
}

@end
