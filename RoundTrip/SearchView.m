//
//  SearchView.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/31.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "SearchView.h"
#import "UIView+Common.h"
#import "HomeDataModel.h"
@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customViews];
    }
    
    return self;
}

- (void)customViews {
    
    self.backgroundColor = [UIColor whiteColor];
    
}
- (void)setDataModel:(HomeDataModel *)dataModel {
    _dataModel = dataModel;
    SearchModel *searchModel1 = [_dataModel.search_data firstObject];
    SearchModel *searchModel2 = [_dataModel.search_data lastObject];
    CGFloat padding = 10.0;
    UILabel *titleLabel1 = [self createTitleLabelWithTitle:searchModel1.title];
    titleLabel1.frame = CGRectMake(0, padding, screenWidth(), 20);
    [self addSubview:titleLabel1];
    CGFloat width = (screenWidth() - 4*padding)/3;
    CGFloat height = 30.0;
    CGFloat lastButtonMaxy = 0;
    for (NSInteger i=0; i<searchModel1.elements.count; i++) {
        SearchElementModel *elementModel = searchModel1.elements[i];
        UIButton *button = [self createButton];
        [button setTitle:elementModel.name forState:UIControlStateNormal];
        button.frame = CGRectMake((padding+width)*(i%3)+padding, getMaxY(titleLabel1)+(padding+height)*(i/3) + padding, width, height);
        lastButtonMaxy = getMaxY(button);
        button.tag = 5000 + i;
        [self addSubview:button];
    }
    
    UILabel *titleLabel2 = [self createTitleLabelWithTitle:searchModel2.title];
    titleLabel2.frame = CGRectMake(0, padding + lastButtonMaxy, screenWidth(), 20);
    [self addSubview:titleLabel2];
    
    for (NSInteger i=0; i<searchModel2.elements.count; i++) {
        SearchElementModel *elementModel = searchModel2.elements[i];
        UIButton *button = [self createButton];
        [button setTitle:elementModel.name forState:UIControlStateNormal];
        button.frame = CGRectMake((padding+width)*(i%3)+padding, getMaxY(titleLabel2)+(padding+height)*(i/3) + padding, width, height);
        lastButtonMaxy = getMaxY(button);
        button.tag = 6000 + i;
        
        [self addSubview:button];
    }
    
}
- (UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.textColor = [UIColor blackColor];
    button.layer.cornerRadius = 15;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (UILabel *)createTitleLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
- (void)buttonAction:(UIButton *)button {
    
    if ([_delegate respondsToSelector:@selector(searchButtonAction:)]) {
        [_delegate searchButtonAction:button.tag];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([_delegate respondsToSelector:@selector(hiddenSearchView)]) {
        [_delegate hiddenSearchView];
    }
}
@end

