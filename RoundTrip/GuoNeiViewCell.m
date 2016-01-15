//
//  GuoNeiViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "GuoNeiViewCell.h"
#import "SearchMoreModel.h"
#import <UIImageView+WebCache.h>
@interface GuoNeiViewCell()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *label;
@end
@implementation GuoNeiViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setupImageView];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) [self setupImageView];
    return self;
}
- (void)setupImageView
{

    self.clipsToBounds = YES;
    self.imageView= [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, IMAGE_HEIGHT)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = NO;
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
    self.label.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 30);
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:27];
    self.label.center = self.contentView.center;
    [self addSubview:_label];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    _imageOffset = imageOffset;
    CGRect frame = self.imageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
    self.imageView.frame = offsetFrame;
}
- (void)setModel:(PlaceModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
    self.label.text = _model.name;
}
@end
