//
//  DeclareViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/14.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "DeclareViewController.h"

@interface DeclareViewController ()

@end

@implementation DeclareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"免责声明";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
