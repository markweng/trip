//
//  UIImage+UIImage_Common.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "UIImage+UIImage_Common.h"

@implementation UIImage (UIImage_Common)
+ (UIImage *)decompressedImageFromImageString:(NSString *)imageString
{
    UIImage *image = [UIImage imageNamed:imageString];
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
    [image drawAtPoint:CGPointZero];
    UIImage *decompressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return decompressedImage;
}
@end
