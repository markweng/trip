//
//  SignUpTableViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/12.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "SignUpTableViewController.h"
#import <BmobSDK/Bmob.h>
#define BUTTONNORCOLOR [UIColor colorWithRed:31/255.0 green:140/255.0 blue:228/255.0 alpha:1.0]

@interface SignUpTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBut;

@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation SignUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)backAction:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)seginUp:(id)sender {
    
    if ([self isEmpty]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [BmobUser signOrLoginInbackgroundWithMobilePhoneNumber:_phoneNumberTextField.text SMSCode:_smsCodeTextField.text andPassword:_psdTextField.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"%@",[error description]);
        } else {
        
            UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tip show];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];

    
}
- (IBAction)getCodeAction:(id)sender {
    
    if (![self checkPhoneNumInput:_phoneNumberTextField.text]) {
        UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [tip show];

        return;
    }    //请求验证码
    _getCodeBut.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;

    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:_phoneNumberTextField.text andTemplate:@"release" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tip show];
            _getCodeBut.userInteractionEnabled = YES;

        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
            _time = 60;
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(timeDece) userInfo:nil repeats:YES];
            _getCodeBut.userInteractionEnabled = NO;

            //设置不可点击
            // [self setRequestSmsCodeBtnCountDown];
        }
    }];

    
    
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
- (BOOL)isEmpty {
    
    if (_phoneNumberTextField.text.length == 0) {
        
        return YES;
    } else if (_smsCodeTextField.text.length == 0) {
        
        return YES;
    } else if (_psdTextField.text.length == 0) {
        
        return YES;
        
    }
    
    return NO;
}
#pragma mark 倒计时
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
