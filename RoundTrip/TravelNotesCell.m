//
//  TravelNotesCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "TravelNotesCell.h"
#import "TravelNotesCellFrame.h"
#import <UIImageView+WebCache.h>
#import "TravelNotesModel.h"
@implementation TravelNotesCell{
    
    
    UILabel *_textlabel;
    UIImageView *_clockImageView;
    UILabel *_timeLabel;
    UIImageView *_locationImageView;
    UILabel *_locationLabel;
    UILabel *_lineLabel;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
    }
    return self;
}
- (void)customViews {
    _largeImageView = [UIImageView new];
    _largeImageView.clipsToBounds = YES;
    _largeImageView.layer.cornerRadius = 20;
    _textlabel = [UILabel new];
    _clockImageView = [UIImageView new];
    _clockImageView.backgroundColor = [UIColor whiteColor];
    _timeLabel = [UILabel new];
    _locationImageView = [UIImageView new];
    _locationImageView.backgroundColor = [UIColor whiteColor];
    _locationLabel = [UILabel new];
    _lineLabel = [UILabel new];
    _lineLabel.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:0.9];
    [self addSubview:_lineLabel];
    [self addSubview:_largeImageView];
    [self addSubview:_textlabel];
    [self addSubview:_clockImageView];
    [self addSubview:_timeLabel];
    [self addSubview:_locationImageView];
    [self addSubview:_locationLabel];
}

- (void)setCellFrame:(TravelNotesCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    _largeImageView.frame = _cellFrame.largeImageFrame;
    _textlabel.frame = _cellFrame.textLabelFrame;
    _clockImageView.frame = _cellFrame.clockImageFrame;
    _timeLabel.frame = _cellFrame.timeLabelFrame;
    _locationImageView.frame =_cellFrame.locationImageFrame;
    _locationLabel.frame = _cellFrame.locationLabelFrame;
    _lineLabel.frame = _cellFrame.linelabelFrame;
    _largeImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_largeImageView sd_setImageWithURL:[NSURL URLWithString:_cellFrame.model.photo_w640] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
    _textlabel.text = _cellFrame.model.text;
    _textlabel.font = TEXYFONT;
    _textlabel.numberOfLines = 0;
    
    _clockImageView.image = [UIImage imageNamed:@"blueClock"];
    _timeLabel.text = _cellFrame.model.local_time;
    _locationImageView.image = [UIImage imageNamed:@"locationIcon"];
    _locationLabel.text = _cellFrame.model.poi.name;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
