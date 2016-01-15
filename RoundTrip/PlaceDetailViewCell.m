//
//  PlaceDetailViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/3.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceDetailViewCell.h"
#import "PlaceDataModel.h"
#import "UIView+Common.h"


@implementation PlaceDetailViewCell

- (void)awakeFromNib {
    
}
- (void)setToolsArray:(NSArray *)toolsArray {
    _toolsArray = toolsArray;
    CGFloat padding = 20.0;
    CGFloat width = (screenWidth() - 5*padding)/4;
    NSInteger j = 0;
    NSDictionary *dict = @{@"1":@"指南",@"3":@"游记",@"5":@"折扣",@"6":@"路线",@"7":@"推荐"};
    for (NSInteger i=0; i<toolsArray.count; i++) {
        PlaceModel *model = toolsArray[i];
        if ((model.url.length > 0&&[model.type integerValue] !=4) ||[model.type integerValue] == 3) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:dict[model.type] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            button.tag = 4000 + [model.type integerValue];
            if (j < 4) {
                button.frame = CGRectMake((width + padding)*j + padding, padding, width, width);
                
            } else {
                
               button.frame = CGRectMake((width + padding)*(j - 4) + padding, padding*2 +width, width, width);
                
            }
            button.layer.cornerRadius = width/2;
            button.backgroundColor = [UIColor colorWithRed:0 green:171/255.0 blue:238 alpha:1.0];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            j++;

        }
    }
}
- (void)buttonAction:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(placeTypeButtonAction:)]) {
        [_delegate placeTypeButtonAction:(button.tag - 4000)];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
