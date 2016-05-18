//
//  BaseViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+Common.h"
@interface BaseViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES];

        
    NSString *backArrowString = @"back";
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backArrowString style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem =  backBarButtonItem;
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)customNavigationBar {
   // [self.navigationController setNavigationBarHidden:NO];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), 64)];
    view.backgroundColor = [UIColor colorWithRed:21/255.0 green:153/255.0 blue:225/255.0 alpha:1.0];
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 20, 44, 44);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(44, 24, screenWidth() - 88, 40);
    _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    //self.titleLabel.text = _titleString;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_titleLabel];
    [view addSubview:button];
    [self.view addSubview:view];


   self.navigationController.navigationBar.alpha = 0;
 
}
- (void)setTitleString:(NSString *)titleString {

    _titleString = titleString;
    _titleLabel.text = _titleString;

}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
