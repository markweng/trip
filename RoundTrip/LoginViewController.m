//
//  LoginViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/7.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "LoginViewController.h"
#import <UIImageView+WebCache.h>
#import <BmobSDK/Bmob.h>
#import "ResignViewController.h"
#import "SignUpTableViewController.h"

@interface LoginViewController () {


    __weak IBOutlet UIImageView *_iconImg;

    __weak IBOutlet UIButton *resign;
    
    __weak IBOutlet UITextField *UserNameTextField;
    
    __weak IBOutlet UITextField *PsdTextField;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setResignBolder];
    [self.navigationController setNavigationBarHidden:YES];


}
- (IBAction)loginAction:(id)sender {
    
    
    [BmobUser loginWithUsernameInBackground:UserNameTextField.text password:PsdTextField.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"%@",[error description]);
        } else {
            
            NSLog(@"%@",[user description]);
//            UIAlertView *tip = [[UIAlertView alloc] initWithTitle:nil message:@"登录成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [tip show];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINSUCCESS" object:nil];
            [self dismissViewControllerAnimated:self completion:^{
                
            }];
        }
    }];

}
- (IBAction)resignAction:(id)sender {
    
//    ResignViewController  *resignVC = [[ResignViewController alloc] init];
//    
//   [self.navigationController pushViewController:resignVC animated:YES];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpTableViewController *signUp = [mainStoryboard instantiateViewControllerWithIdentifier:@"SignUpTableViewController"];
  
    [self.navigationController pushViewController:signUp animated:YES];

}
- (IBAction)upLoadIcon:(id)sender {
    
    BmobUser *bUser = [BmobUser getCurrentUser];
//    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        NSLog(@"error %@",[error description]);
//    }];
    NSBundle    *bundle = [NSBundle mainBundle];
    NSString *fileString = [NSString stringWithFormat:@"%@/MyIcon.jpg" ,[bundle bundlePath] ];
    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:fileString];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到usericon列
        if (isSuccessful) {
            [bUser setObject:file1  forKey:@"usericon"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"error %@",[error description]);
            }];
            
            //打印file文件的url地址
        [_iconImg sd_setImageWithURL:[NSURL URLWithString:file1.url] placeholderImage:[UIImage imageNamed:@"UMS_facebook_icon"]];
            NSLog(@"file1 url %@",file1.url);
        }else{
            //进行处理
        }
    }];

}

- (void)setResignBolder {
  
    resign.layer.borderWidth = 0.5;
    resign.layer.borderColor = [[UIColor lightGrayColor] CGColor];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
