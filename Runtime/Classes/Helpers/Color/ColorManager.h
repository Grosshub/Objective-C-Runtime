//
//  ColorManager.h
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ColorManager : NSObject

+ (UIColor *)colorWithHex:(NSString *)hex;

@end

