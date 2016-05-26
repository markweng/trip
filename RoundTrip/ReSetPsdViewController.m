//
//  ReSetPsdViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/26.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "ReSetPsdViewController.h"
#import <BmobSDK/Bmob.h>
#import "UIViewController+Common.h"
#import "NSString+Commom.h"
#define BUTTONNORCOLOR [UIColor colorWithRed:31/255.0 green:140/255.0 blue:228/255.0 alpha:1.0]
@interface ReSetPsdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTFD;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTFD;
@property (weak, nonatomic) IBOutlet UITextField *psdTFD;
@property (weak, nonatomic) IBOutlet UITextField *agginPsdTFD;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBut;
@end

@implementation ReSetPsdViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
   [self.navigationController setNavigationBarHidden:NO animated:YES];
   self.title = @"找回密码";

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)getCodeAction:(id)sender {
    
    if (![self checkPhoneNumInput:_phoneNumTFD.text]) {
        UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [tip show];
        
        return;
    }
    _getCodeBut.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:_phoneNumTFD.text andTemplate:@"release" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:@"手机号或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tip show];
            _getCodeBut.userInteractionEnabled = YES;
            
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
            _time = 60;
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(timeDece) userInfo:nil repeats:YES];
            _getCodeBut.userInteractionEnabled = NO;
            
        }
    }];

    
}
- (IBAction)reSetAction:(id)sender {
    if ([self isEmpty]) {
        return;
    }
    [BmobUser resetPasswordInbackgroundWithSMSCode:_smsCodeTFD.text andNewPassword:MD5Hash(_agginPsdTFD.text) block:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            
        }
        if (isSuccessful) {
            [self showHudWithTitle:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}
- (BOOL)isEmpty {
    
    if (_phoneNumTFD.text.length == 0) {
        return YES;
    }
    if (_smsCodeTFD.text.length == 0) {
        return YES;
    }

    if (_psdTFD.text.length == 0) {
        return YES;
    }
    if (_agginPsdTFD.text.length == 0) {
        return YES;
    }
    if (![_agginPsdTFD.text isEqualToString:_psdTFD.text]) {
        [self showHudWithTitle:@"两次输入密码不一致"];
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkPhoneNumInput:(NSString *)phoneNum{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phoneNum];
    BOOL res2 = [regextestcm evaluateWithObject:phoneNum];
    BOOL res3 = [regextestcu evaluateWithObject:phoneNum];
    BOOL res4 = [regextestct evaluateWithObject:phoneNum];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
- (void)timeDece
{
    _time -= 1;
    
    if (_time > 0) {
        
        [_getCodeBut setTitle:[NSString stringWithFormat:@"%ld s",_time] forState:UIControlStateNormal];
        [_getCodeBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        
    }else{
        
        [self.timer invalidate];
        
        [_getCodeBut setTitle:@"获取" forState:(UIControlStateNormal)];
        [_getCodeBut setTitleColor:BUTTONNORCOLOR forState:UIControlStateNormal];
        _getCodeBut.userInteractionEnabled = YES;
        
    }
    
}

@end
