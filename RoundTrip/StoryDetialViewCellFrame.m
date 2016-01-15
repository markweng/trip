//
//  StoryDetialViewCellFrame.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "StoryDetialViewCellFrame.h"
#import "UIView+Common.h"
#import "StoryDetailModel.h"
#import "NSString+Commom.h"
@implementation StoryDetialViewCellFrame
- (void)setModel:(DetailListModel *)model {
    _model = model;
    CGFloat padding = 10.0;
    CGFloat timeImageLength = 30.0;
    CGFloat timeLabelHeight = 20.0;
    CGFloat width = screenWidth();
    _timeImageFrame = CGRectMake(padding, padding, timeImageLength, timeImageLength);
    _timeLabelFrame = CGRectMake(getMaxXForFrame(_timeImageFrame)+ padding, padding + (timeImageLength - timeLabelHeight)/2, width - 3*padding - timeImageLength, timeLabelHeight);
    _largeImageViewFrme = CGRectMake(padding, getMaxYForFrame(_timeImageFrame) + padding, width -2*padding, (width -2*padding)* [_model.photo_height intValue]/[_model.photo_width intValue]);
    
     CGSize contentSize = [_model.text sizeWithFont:TEXYFONT maxSize:CGSizeMake(width -2*padding, MAXFLOAT)];
    if (_model.text.length > 0) {
      _contentLabelFrame = CGRectMake(padding, getMaxYForFrame(_largeImageViewFrme) + padding, width -2*padding, contentSize.height);
        _cellHeight = getMaxYForFrame(_contentLabelFrame) +padding;
    }else {
    
        _cellHeight = getMaxYForFrame(_largeImageViewFrme) + padding;
    }
}

@end
