//
//  TextTableCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "TextTableCell.h"
#import "NSString+Commom.h"
#import "UIView+Common.h"
@implementation TextTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}
- (void)setTextString:(NSString *)textString {
    _textString = textString;
    UILabel *label = [[UILabel alloc] init];
    CGSize size = [textString sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(screenWidth()- 50, MAXFLOAT)];
    label.frame = CGRectMake(25, 10, size.width, size.height);
    label.layer.cornerRadius = 20;
    label.text = textString;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:label];

}
@end
