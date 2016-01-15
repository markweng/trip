//
//  BannerViewCell.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "BannerViewCell.h"
#import "UIView+Common.h"
#import "HomeDataModel.h"
#import <UIImageView+WebCache.h>

@interface BannerViewCell ()<UIScrollViewDelegate>

@end
@implementation BannerViewCell {
    UIScrollView *_scrollView;
    UIImageView *_imgView1;
    UIImageView *_imgView2;
    UIImageView *_imgView3;
    UIImageView *_imgView4;
    //UITapGestureRecognizer *_tapGesture;
    UIPageControl *_pageControl;
    NSTimer *_timer;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
    }
    return self;
}
- (void)customViews {
    CGFloat WIDTH = screenWidth();
    _scrollView = [UIScrollView new];
    _scrollView.frame = CGRectMake(0, 0,WIDTH, WIDTH/2);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.delegate = self;
    
    _imgView1 = [UIImageView new];
    _imgView1.tag = 2000;
    _imgView2 = [UIImageView new];
    _imgView2.tag = 2001;
    _imgView3 = [UIImageView new];
    _imgView3.tag = 2002;
    _imgView4 = [UIImageView new];
    _imgView4.tag = 2003;
   // _tapGesture = [UITapGestureRecognizer new];
   // [_tapGesture addTarget:self action:@selector(GestureAction)];
    
    
    CGRect frame = CGRectMake(0, 0,WIDTH, WIDTH/2);
    _imgView1.frame = frame;
    frame.origin.x += WIDTH;
    _imgView2.frame = frame;
    _imgView2.backgroundColor = [UIColor redColor];
    frame.origin.x += WIDTH;
    _imgView3.frame = frame;
    frame.origin.x +=WIDTH;
    _imgView4.frame = frame;
    
    
    
    [_scrollView addSubview:_imgView1];
    [_scrollView addSubview:_imgView2];
    [_scrollView addSubview:_imgView3];
    [_scrollView addSubview:_imgView4];
    
    //[_scrollView addGestureRecognizer:_tapGesture];
    [self.contentView addSubview:_scrollView];
    

   
}

//- (void)GestureAction {
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(TapImageAction:)]) {
//        [_delegate TapImageAction:_scrollView.contentOffset.x];
//    }
//    
//}

- (void)setModel:(HomeElementsModel *)model {
   
    if (model != nil) {
        _model = model;
        ElementDataModel *elementModel = [[ElementDataModel alloc] init];
        for (NSInteger i=0; i<4; i++) {
            UIImageView *view = [self viewWithTag:2000+i];
            if ((i + 1) <= _model.data.count) {
                
                elementModel = _model.data[i];
                [view sd_setImageWithURL:[NSURL URLWithString:elementModel.image_url] placeholderImage:[UIImage imageNamed:@"brand_defaultImage"]];
            } else {
                view.hidden = YES;
            }
            
        }
        if(_model.data.count <= 4){
            _scrollView.contentSize = CGSizeMake(screenWidth() * _model.data.count, CGRectGetHeight(_scrollView.frame));
        } else {
            _scrollView.contentSize = CGSizeMake(screenWidth() * 4, CGRectGetHeight(_scrollView.frame));
        }
          _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(bannerScroll) userInfo:nil repeats:YES];
         [self setPageControl];
    }
}
- (void)setPageControl {
    //创建pageControl
    _pageControl = [[UIPageControl alloc] init];
    CGSize size = _scrollView.frame.size;
    CGFloat width = screenWidth();
    _pageControl.frame = CGRectMake(width - 110, size.height- 30, 100, 30);
    //设置总页数
    _pageControl.numberOfPages = _scrollView.contentSize.width/_scrollView.frame.size.width;
    //设置小圆点的颜色
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    CGSize pointSize = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
   
    CGFloat page_x = -(_pageControl.bounds.size.width - pointSize.width) / 2;
    [_pageControl setBounds:CGRectMake(-page_x, _pageControl.bounds.origin.y, _pageControl.bounds.size.width,_pageControl.bounds.size.height)];
   
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_pageControl];
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)changePage:(UIPageControl *)pageControl
{
    //根据页码计算偏移量
    CGPoint offset = CGPointMake(pageControl.currentPage*_scrollView.frame.size.width, 0);
    
    [_scrollView setContentOffset:offset animated:YES];
}
- (void)bannerScroll {
    
    static NSInteger flag = 1;
     NSInteger numberOfPages = _pageControl.numberOfPages;
    CGPoint offset = _scrollView.contentOffset;
    if (offset.x == 0) {
        flag = 1;
    }
    if (offset.x == (numberOfPages - 1) * self.frame.size.width) {
        flag = -1;
    }
    offset.x += flag*self.frame.size.width;
    [_scrollView setContentOffset:offset animated:YES];
    
    _pageControl.currentPage = offset.x/_scrollView.frame.size.width;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //减速结束时根据滚动视图偏移量更新当前页码
    _pageControl.currentPage = _scrollView.contentOffset.x/_scrollView.frame.size.width;
  
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
