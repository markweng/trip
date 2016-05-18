//
//  InfoTableViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "UIView+Common.h"
#import "NSString+Commom.h"
@implementation InfoTableViewCell {




}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setInfoArray:(NSArray *)infoArray {
    _infoArray = infoArray;
    CGFloat padding = 10.0;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [_infoArray firstObject];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titleLabel.frame = CGRectMake(padding, padding, screenWidth()-2*padding, 20);
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    UILabel *textLbel = [[UILabel alloc] init];
    textLbel.text = [_infoArray lastObject];
    textLbel.font = [UIFont systemFontOfSize:15];
    CGSize size = [[_infoArray lastObject] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(screenWidth()-2*padding, MAXFLOAT)];
    textLbel.frame = CGRectMake(padding, getMaxY(titleLabel) + padding, screenWidth()-2*padding, size.height);
    textLbel.numberOfLines = 0;
    
   textLbel.textColor = [UIColor blackColor];
    [self addSubview:textLbel];

}
@end
