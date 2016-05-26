//
//  UILabel+Common.m
//  zhixueTeacher
//
//  Created by 翁成 on 16/3/29.
//  Copyright © 2016年 jsmysoft. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)
+ (UILabel *)createLine:(CGFloat)valueY {
    
    UILabel  *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, valueY, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithRed:228.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    
    return lineLabel;
}
@end
