//
//  HighlightedButton.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "HighlightedButton.h"
#import <objc/runtime.h>
#import "Constants.h"

@implementation HighlightedButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    HighlightedButton * button = [super buttonWithType:buttonType];
    [button registerKVO];
    return button;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kConstant_InfoViewStartButtonHighlightedKey]) {
        
        if ([change[NSKeyValueChangeNewKey] isEqual:@1] && [change[NSKeyValueChangeOldKey] isEqual:@0]) {
            self.backgroundColor = highlightedColor;
            
        }
        
        if ([change[NSKeyValueChangeNewKey] isEqual:@0] && [change[NSKeyValueChangeOldKey] isEqual:@1]) {
            self.backgroundColor = mainColor;
        }
    }
}

#pragma mark - Private methods

- (void)registerKVO {
    
    // KVO: Needed to change button background color while it's highlighted
    [self addObserver:self
           forKeyPath:kConstant_InfoViewStartButtonHighlightedKey
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

@end
