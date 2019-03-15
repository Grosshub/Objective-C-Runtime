//
//  InfoView.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighlightedButton.h"

@interface InfoView : UIView

@property (nonatomic) UILabel * titleLabel;
@property (nonatomic) UILabel * descriptionLabel;
@property (nonatomic) HighlightedButton * startButton;

@end

