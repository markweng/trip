//
//  PlaceNotesCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/4.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceNotesCell.h"
#import <UIImageView+WebCache.h>
#import "PlaceTripItemModel.h"
@implementation PlaceNotesCell {

    IBOutlet UIImageView *bgImage;
    IBOutlet UILabel *nameLabel;


}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(ItemModel *)model {
    _model = model;
    [bgImage sd_setImageWithURL:[NSURL URLWithString:_model.cover_image] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
    nameLabel.text = _model.name;
  //  NSString *dayString = [NSString stringWithFormat:@"%@ 天",_model.day_count];
   // dayCountlabel.text = dayString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
