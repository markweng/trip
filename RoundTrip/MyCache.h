//
//  MyCache.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/30.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyCache : NSObject

// 获取缓存大小
+ (CGFloat)fileSize;

+ (NSString*) cacheDirectory ;

+ (void) resetCache;

+ (void) setObject:(NSData*)data forKey:(NSString*)key;

+ (id) objectForKey:(NSString*)key;
@end
