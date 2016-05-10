//
//  BannerdescViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "BannerdescViewController.h"
#import <WebKit/WebKit.h>
@interface BannerdescViewController (){
    WKWebView *_wkWebView;
}

@end

@implementation BannerdescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWkWebView];
}
- (void)createWkWebView {
    _wkWebView = [[WKWebView alloc] init];
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _wkWebView.frame = frame;
    [self.view addSubview:_wkWebView];
     NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_bannerUrl]];
    NSLog(@"%@",_bannerUrl);
    [_wkWebView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
