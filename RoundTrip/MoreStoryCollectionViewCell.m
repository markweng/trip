//
//  MoreStoryCollectionViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "MoreStoryCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MoreStoryCollectionViewCell {

    IBOutlet UIImageView *bgView;

    IBOutlet UIImageView *iconView;

    IBOutlet UILabel *authorNameLabel;
    IBOutlet UILabel *nameLabel;
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(HotSpotListModel *)model {
    _model = model;
    [bgView sd_setImageWithURL:[NSURL URLWithString:_model.index_cover] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 10;
    [iconView sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_m] placeholderImage:nil];
    iconView.clipsToBounds = YES;
    iconView.layer.cornerRadius = iconView.bounds.size.height/2;
    authorNameLabel.text = _model.user.name;
    nameLabel.text = _model.index_title;
}
@end
