//
//  BannerViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "BannerViewCell.h"
#import "UIView+Common.h"
#import "HomeDataModel.h"
#import <UIImageView+WebCache.h>
#import "SDCycleScrollView.h"

@interface BannerViewCell ()<SDCycleScrollViewDelegate>

@end
@implementation BannerViewCell {
    NSMutableArray *_dataSource;
    SDCycleScrollView *_cycleScrollView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
    }
    return self;
}
- (void)customViews {
    
    CGFloat WIDTH = screenWidth();
    _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0,WIDTH, WIDTH/2)];

    _cycleScrollView.autoScrollTimeInterval = 4;
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.pageDotColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    _cycleScrollView.currentPageDotColor = [UIColor colorWithRed:132.0/255 green:188.0/255 blue:248.0/255 alpha:1];
    [self addSubview:_cycleScrollView];
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"brand_defaultImage"];
    _dataSource = [NSMutableArray array];

}

- (void)setModel:(HomeElementsModel *)model {
   
    if (model != nil) {
        _model = model;
        [_dataSource removeAllObjects];
       for (NSInteger i=0; i<_model.data.count; i++) {
           [_dataSource addObject:[_model.data[i] image_url]];
        }
        _cycleScrollView.imageURLStringsGroup = _dataSource;
}
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    if ([_delegate respondsToSelector:@selector(didSelectedBannerPage:)]) {
        [_delegate didSelectedBannerPage:index];
    }


}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
