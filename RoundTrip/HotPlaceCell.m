//
//  HotPlaceCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/3.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "HotPlaceCell.h"
#import "PlaceDataModel.h"
#import <UIImageView+WebCache.h>
#import "UIView+Common.h"
@implementation HotPlaceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPlaceArray:(NSArray *)placeArray {
    _placeArray = placeArray;
    NSInteger i=0;
    CGFloat padding = 10.0;
    CGFloat width = (screenWidth() - 3 * padding)/2;
    for (HottestSitesModel *model in _placeArray) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];
        imageView.frame = CGRectMake((width + padding) * (i%2) + padding, (width + padding) * (i/2) + padding, width, width);
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0,0,imageView.bounds.size.width, 20);
        label.center = CGPointMake(width/2, width/2);
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [imageView addSubview:label];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tapGestureRecognizer];
        imageView.tag = 7000 + i;
        
        i++;
    }
}
- (void)tapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIView *view = [tapGestureRecognizer view];
    if ([_delegate respondsToSelector:@selector(tapPictureAction:)]) {
        [_delegate tapPictureAction:view.tag-7000];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
