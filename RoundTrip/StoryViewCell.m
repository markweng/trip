//
//  StoryViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "StoryViewCell.h"
#import <UIImageView+WebCache.h>
#import "HomeDataModel.h"
#import "ListStoryModel.h"
@implementation StoryViewCell{
    ElementDataModel *_elementModel;
    IBOutlet UIView *bgView1;
    IBOutlet UIView *bgView2;
    IBOutlet UIView *bgView3;
    IBOutlet UIView *bgView4;
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    IBOutlet UIImageView *imageView3;
    IBOutlet UIImageView *imageView4;
    IBOutlet UILabel *contentLabel1;
    IBOutlet UILabel *contentLabel2;
    IBOutlet UILabel *contentLabel3;
    IBOutlet UILabel *contentLabel4;
}

- (void)awakeFromNib {
    
    
}


- (IBAction)moreAction:(id)sender {
    if (_moreActionBlock) {
        _moreActionBlock();
    }
    
}

- (void)setStoryModels:(NSArray *)storyModels {
   
    _storyModels = storyModels;
    _elementModel = [[ElementDataModel alloc] init];
    _elementModel = _storyModels[0];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:_elementModel.index_cover] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];
    imageView1.clipsToBounds = YES;
    imageView1.layer.cornerRadius = 10;
    contentLabel1.text = _elementModel.index_title;
    _elementModel = _storyModels[1];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:_elementModel.index_cover] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];
    imageView2.clipsToBounds = YES;
    imageView2.layer.cornerRadius = 10;
    contentLabel2.text = _elementModel.index_title;
    
    _elementModel = _storyModels[2];
    [imageView3 sd_setImageWithURL:[NSURL URLWithString:_elementModel.index_cover] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];
    imageView3.clipsToBounds = YES;
    imageView3.layer.cornerRadius = 10;
    contentLabel3.text = _elementModel.index_title;
    
    _elementModel = _storyModels[3];
    [imageView4 sd_setImageWithURL:[NSURL URLWithString:_elementModel.index_cover] placeholderImage:[UIImage imageNamed:@"doublebrand_defaultImage"]];
    imageView4.clipsToBounds = YES;
    imageView4.layer.cornerRadius = 10;
    contentLabel4.text = _elementModel.index_title;
   
 
    UITapGestureRecognizer * tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerAction:)];
    bgView1.tag = 1000;
    [bgView1 addGestureRecognizer:tapRecognizer1];
    
    UITapGestureRecognizer * tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerAction:)];
    bgView2.tag = 1001;
    [bgView2 addGestureRecognizer:tapRecognizer2];
    
    UITapGestureRecognizer * tapRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerAction:)];
    bgView3.tag = 1002;
    [bgView3 addGestureRecognizer:tapRecognizer3];
    
    UITapGestureRecognizer * tapRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerAction:)];
    bgView4.tag = 1003;
    [bgView4 addGestureRecognizer:tapRecognizer4];
    
}

- (void)tapRecognizerAction:(UITapGestureRecognizer *)tapRecognizer {
    UIView *view = [tapRecognizer view];
    _elementModel = _storyModels[view.tag - 1000];
    HotSpotListModel *model = [[HotSpotListModel alloc] init];

    model.spot_id = _elementModel.spot_id;
    model.index_cover = _elementModel.index_cover;
    model.index_title = _elementModel.index_title;
    model.view_count = _elementModel.view_count;
    
    if (_storyItemSelectBlock) {
        _storyItemSelectBlock(model);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
