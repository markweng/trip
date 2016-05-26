//
//  AboutUsViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/24.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"关于我们";
}
- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
  // @" D.W是一支以交互体验为核心的产品团队，交互设计，动态视觉设计，GUI设计，产品设计是我们的擅长点，多样的客户渠道和深入的行业人脉是我们的资源链，巧妙的跨界整合伴随着我们一直成长，D.W坚信专注于设计品质和交互体验的提升，将会为用户创造出更好的产品服务。"
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
