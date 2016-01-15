//
//  StroyCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/8.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "StroyCell.h"
#import <UIImageView+WebCache.h>
#import "PlaceTripItemModel.h"
@implementation StroyCell {

    IBOutlet UIImageView *bgImage;
    IBOutlet UILabel *nameTitle;

}
- (void)setModel:(ItemModel *)model {
    
    [bgImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image] placeholderImage:nil];
    nameTitle.text = model.name;
}
- (void)awakeFromNib {
    
}
- (IBAction)disLike:(id)sender {
    if (_block) {
        _block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
