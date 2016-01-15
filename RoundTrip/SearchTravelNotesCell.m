//
//  SearchTravelNotesCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "SearchTravelNotesCell.h"
#import "SearchMoreModel.h"
#import <UIImageView+WebCache.h>
@implementation SearchTravelNotesCell{

    IBOutlet UIImageView *largeImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *viewCount;
    IBOutlet UILabel *likeCount;
}
- (void)setModel:(TripsModel *)model {
    _model = model;
    [largeImage sd_setImageWithURL:[NSURL URLWithString:_model.cover_image_default] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
    nameLabel.text = _model.name;
    viewCount.text = _model.view_count;
    likeCount.text = _model.liked_count;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
