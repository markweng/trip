//
//  GuideViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/26.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "GuideViewController.h"
#import "SMPageControl.h"
#import "SDiPhoneVersion.h"

#define mainScreenW [UIScreen mainScreen].bounds.size.width
#define mainScreenH [UIScreen mainScreen].bounds.size.height

@interface GuideViewController ()<UIScrollViewDelegate>{
    
    UIScrollView *_scrollView;
    
    
    
    NSUInteger _imageCount;//图片总数
    
}

@property (nonatomic, strong)  NSArray *imagesArray;
@property (nonatomic, strong) SMPageControl *pageControl;
@property (nonatomic, strong) UIButton *button;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        

        self.imagesArray = self.imagesArray = @[@"时光旅行3",@"记录分享3",@"游记攻略3",@"主题路线3"];
        
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        
        self.imagesArray = self.imagesArray = @[@"时光旅行4",@"记录分享4",@"游记攻略4",@"主题路线4"];

        
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        
        self.imagesArray = self.imagesArray = @[@"时光旅行4.7",@"记录分享4.7",@"游记攻略4.7",@"主题路线4.7"];

    } else {
        
        self.imagesArray = @[@"时光旅行5.5",@"记录分享5.5",@"游记攻略5.5",@"主题路线5.5"];

    }
    
    
    _imageCount = self.imagesArray.count;
    [self addScrollView];
    [self createEnterBut];
    
    [self addImageViews];
    [self createPageControl];
    
    
}
- (void)createEnterBut {
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        
     _button =[[UIButton alloc]initWithFrame:CGRectMake(mainScreenW/2 - 55, mainScreenH - 77, 110, 30)];
     
        
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        
       _button =[[UIButton alloc]initWithFrame:CGRectMake(mainScreenW/2 - 55, mainScreenH - 112, 110, 37)];
        
        
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        
       _button =[[UIButton alloc]initWithFrame:CGRectMake(mainScreenW/2 - 65, mainScreenH - 133, 130, 40)];
        
    } else {
        
       _button =[[UIButton alloc]initWithFrame:CGRectMake(mainScreenW/2 - 65, mainScreenH - 158, 130, 45)];
    }
    [_button addTarget:self action:@selector(PressBtn) forControlEvents:UIControlEventTouchUpInside];
    _button.showsTouchWhenHighlighted = YES;
    
}
- (void)createPageControl {
    
    _pageControl = [[SMPageControl alloc] init];
    _pageControl.numberOfPages = _imagesArray.count;
    _pageControl.verticalAlignment = SMPageControlVerticalAlignmentMiddle;
    _pageControl.alignment = SMPageControlAlignmentCenter;
    [_pageControl sizeToFit];
    _pageControl.frame = CGRectMake(0,  mainScreenH- 50, mainScreenW, 50);
    [_pageControl addTarget:self action:@selector(tapPage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark 添加控件
-(void)addScrollView{
    _scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_scrollView];
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(_imageCount * mainScreenW, mainScreenH) ;
    _scrollView.pagingEnabled=YES;
    _scrollView.delaysContentTouches = YES;
    _scrollView.userInteractionEnabled  = YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.bounces = NO;
    
}

#pragma mark 添加imageView
-(void)addImageViews{
    
    for (int i = 0; i < self.imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*mainScreenW, 0, mainScreenW, mainScreenH)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        imageView.image = [UIImage imageNamed:self.imagesArray[i]];
        if (i == self.imagesArray.count-1) {
            
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:_button];
        }
        [_scrollView addSubview:imageView];
    }
}
-(void)PressBtn {
    
//    CATransition *anim = [CATransition animation];
//    anim.type = @"rippleEffect";
//    anim.duration = 0.8;
//    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLunch"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"guideSuccess" object:nil];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger nearestPage = floorf([self pageOffset] + 0.5);
    self.pageControl.currentPage = nearestPage;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (offsetX > mainScreenW *4) {
        [self PressBtn];
    }
    
    
}
- (void)tapPage:(SMPageControl *)sender {
    
    CGRect rect = CGRectMake(sender.currentPage * mainScreenW, 0, mainScreenW, mainScreenH);
    [_scrollView scrollRectToVisible:rect animated:YES];
}

- (CGFloat)pageOffset
{
    CGFloat currentOffset = _scrollView.contentOffset.x;
    if (mainScreenW > 0.f) {
        currentOffset = currentOffset / mainScreenW;
    }
    return currentOffset;
}




@end
