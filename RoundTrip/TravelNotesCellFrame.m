//
//  TravelNotesCellFrame.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "TravelNotesCellFrame.h"
#import "UIView+Common.h"
#import "NSString+Commom.h"
#import "TravelNotesModel.h"
@implementation TravelNotesCellFrame
- (void)setModel:(WaypointsModel *)model {
    _model = model;
    CGFloat padding = 10.0;
    CGFloat leftPadding = 25;
    CGFloat width = screenWidth();
    _largeImageFrame = CGRectMake(padding, padding, width - 2*padding, width);
    CGSize contentSize = [_model.text sizeWithFont:TEXYFONT maxSize:CGSizeMake(width -50, MAXFLOAT)];
    _textLabelFrame = CGRectMake(40, getMaxYForFrame(_largeImageFrame)+padding, contentSize.width, contentSize.height);
    _clockImageFrame = CGRectMake(padding, getMaxYForFrame(_textLabelFrame), 30, 30);
    
    _timeLabelFrame = CGRectMake(getMaxXForFrame(_clockImageFrame)+padding, CGRectGetMinY(_clockImageFrame) + 5, width - getMaxXForFrame(_clockImageFrame)-2*padding, 20);
    
    
    if (_model.poi.name != nil) {
        _locationImageFrame = CGRectMake(padding, getMaxYForFrame(_clockImageFrame) + padding, 30, 30);
        
        _locationLabelFrame = CGRectMake(getMaxXForFrame(_locationImageFrame) + padding, CGRectGetMinY(_locationImageFrame) + 5, width - getMaxXForFrame(_locationImageFrame)-2*padding, 20);
        
    } else {
        _locationImageFrame = CGRectMake(padding, getMaxYForFrame(_clockImageFrame), 30, 0);
        
        _locationLabelFrame = CGRectMake(getMaxXForFrame(_locationImageFrame) + padding, CGRectGetMinY(_locationImageFrame) + 5, width - getMaxXForFrame(_locationImageFrame)-2*padding, 0);
        
    }
    _linelabelFrame = CGRectMake(leftPadding - 2, 0, 4, getMaxYForFrame(_locationImageFrame) + padding);
    _cellHeight = getMaxYForFrame(_locationImageFrame) + padding;
    
}

@end
