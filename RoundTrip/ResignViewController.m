//
//  ResignViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/9.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "ResignViewController.h"
#import <BmobSDK/Bmob.h>

@interface ResignViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *niChengTextfield;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UIButton *resignButton;
@property (copy, nonatomic) NSString *smsCode;
@end

@implementation ResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)resignAction:(id)sender {
    [BmobUser signOrLoginInbackgroundWithMobilePhoneNumber:_niChengTextfield.text SMSCode:_phoneNumberTextfield.text andPassword:_psdTextField.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"%@",[error description]);
        }
    }];
}
- (IBAction)getSMSCode:(id)sender {
    __weak typeof(self)  weakSelf = self;
    //请求验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:_niChengTextfield.text andTemplate:@"release" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tip show];
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
            
            weakSelf.smsCode = [NSString stringWithFormat:@"%d",number];
            //设置不可点击
            // [self setRequestSmsCodeBtnCountDown];
        }
    }];
    
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
