//
//  ScrollViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/10.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "ScrollViewController.h"
#import "UIView+Common.h"
#import "CellScrollView.h"
@interface ScrollViewController (){

    UIView *_bottomView;

}

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self creatScroll];
    [self createGesture];
}

- (void)creatScroll {

    CellScrollView *scrollView = [[CellScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.imageView.image = _bgImage;
    
    [self.view addSubview:scrollView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createGesture {
    UITapGestureRecognizer *gestureOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureChange:)];
    [self.view addGestureRecognizer:gestureOnce];
    
    UITapGestureRecognizer *gestureTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTwoAction:)];
    gestureTwo.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:gestureTwo];
    
    [gestureOnce requireGestureRecognizerToFail:gestureTwo];
}

- (void)gestureTwoAction:(UIGestureRecognizer *)gesture {
   
}

- (void)gestureChange:(UITapGestureRecognizer *)gesture {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
