//
//  StoryDetialViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "StoryDetialViewCell.h"
#import <UIImageView+WebCache.h>
#import "StoryDetailModel.h"
#import "StoryDetialViewCellFrame.h"


@implementation StoryDetialViewCell {
    UIImageView *_timeImageView;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self customViews];
    }
    return self;
}
- (void)customViews {
    _timeImageView = [UIImageView new];
    _timeLabel = [UILabel new];
    _largeImageView = [UIImageView new];
    _contentLabel = [UILabel new];
    _largeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_timeImageView];
    [self addSubview:_timeLabel];
    [self addSubview:_largeImageView];
    [self addSubview:_contentLabel];
}


- (void)setCellFrame:(StoryDetialViewCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    _timeImageView.frame = _cellFrame.timeImageFrame;
    _timeImageView.image = [UIImage imageNamed:@"clock_image"];
    _timeLabel.frame = _cellFrame.timeLabelFrame;
    
    
    NSArray *strArray1 = [_cellFrame.model.photo_date_created componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"T"]];
    NSArray *strArray2 = [strArray1[1]componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"+"]];
    NSString *textString = [NSString stringWithFormat:@"%@  %@",strArray1[0],strArray2[0]];
    _timeLabel.text = textString;
    _largeImageView.frame = _cellFrame.largeImageViewFrme;
    
    [_largeImageView sd_setImageWithURL:[NSURL URLWithString:_cellFrame.model.photo_w640] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
    
    _largeImageView.clipsToBounds = YES;
    _contentLabel.frame = _cellFrame.contentLabelFrame;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = TEXYFONT;
    _contentLabel.text = _cellFrame.model.text;
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
