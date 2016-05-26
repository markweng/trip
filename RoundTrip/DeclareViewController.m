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
     //@"  本App作为一个网络平台，不存在商业目的，所有内容均来自互联网，以通过交流与分享，达到传递与分享的目的，因此本App所链接内容仅供网友了解与借鉴，无意侵害原作者版权；未完整注明作者或出处的链接，并非不尊重作者或者链接来源。
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
