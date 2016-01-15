//
//  PicCollectionViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PicCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation PicCollectionViewCell {

    IBOutlet UIImageView *bgImage;
}
- (void)setPicUrl:(NSString *)picUrl {
    _picUrl = picUrl;
    [bgImage sd_setImageWithURL:[NSURL URLWithString:_picUrl] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];

}
- (void)awakeFromNib {
    // Initialization code
}

@end
