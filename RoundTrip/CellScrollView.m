//
//  CellScrollView.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/10.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "CellScrollView.h"
#import "UIView+Common.h"

@implementation CellScrollView {

    UIImageView *_imageView;
    BOOL _isLongPress;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.tag = 1000;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        [self addLongPressGesture];
        [self miscInit];
        [self addDoubleTapGesture];
    }
    return self;
}
- (void)addLongPressGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    self.gestureRecognizers = @[longPress];
    
    

}
- (void)longPressAction:(UIGestureRecognizer *)gesture {
    
    if (!_isLongPress) {
        _isLongPress = !_isLongPress;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存到手机",@"赞一个",@"举报", nil];
        [alert show];
    }
}
- (void)downloadImage {

    // 保存照片到相册
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        // 保存照片到相册
        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    if (buttonIndex == 2) {
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"点赞成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [aView show];
    }
    if (buttonIndex == 3) {
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"举报成功,感谢您的帮助,客服人员会尽快处理😊" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [aView show];
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [aView show];
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _isLongPress = NO;
}
- (void)miscInit
{
    self.delegate = self;
    
    // 缩放倍数设置
    self.minimumZoomScale = 0.5;
    self.maximumZoomScale = 2;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
}

- (void)addDoubleTapGesture
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
}

- (void)zoomImage:(UITapGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self];
    if (self.zoomScale != 1.0) {
        [self setZoomScale:1 animated:YES];
    } else {
        [self zoomToRect:CGRectMake(location.x-50, location.y-100, 100, 200) animated:YES];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
