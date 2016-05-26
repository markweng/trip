//
//  UIColor+RGB.h
//  智学老师端
//
//  Created by jsmysoft on 15/8/10.
//  Copyright (c) 2015年 jsmysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)
+(UIColor *)colorWithRGBString:(NSString *)color;

+(UIColor *)colorWithRGBString:(NSString *)color alpha:(CGFloat)alpha;
@end
