//
//  TeavelNotesViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "TeavelNotesViewCell.h"
#import <UIImageView+WebCache.h>
#import "HomeDataModel.h"
@implementation TeavelNotesViewCell {

    IBOutlet UIImageView *bgImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *dayCountLabel;
    IBOutlet UILabel *cityNameLabel;
    IBOutlet UILabel *skimCountLabel;
    IBOutlet UIImageView *iconImageView;
    IBOutlet UILabel *authorLabel;
    UITapGestureRecognizer *_tapGestureRecognizer;
    
    
}


- (void)setModel:(ElementDataModel *)model {
    _model = model;
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover_image_w640] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
    titleLabel.text = _model.name;
    dateLabel.text = _model.first_day;
    dayCountLabel.text = _model.day_count;
    cityNameLabel.text = _model.popular_place_str;
    skimCountLabel.text = _model.view_count;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_m] placeholderImage:nil];
    iconImageView.clipsToBounds = YES;
    iconImageView.layer.cornerRadius = 15;
    authorLabel.text = _model.user.name;
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
