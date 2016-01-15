//
//  NSString+Commom.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/23.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Commom)

NSString * URLEncodedString(NSString *str);
NSString * MD5Hash(NSString *aString);
/**
 *  计算字符串 CGSize
 *
 *  @param font    字符串的 font
 *  @param maxSize  字符串的最大显示的 CGSize
 *
 *  @return  字符串实际的CGSize
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
