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
#import "SignUpTableViewController.h"
#import "UIViewController+Common.h"
#import "MBProgressHUD.h"
#import "NSString+Commom.h"
#import "ReSetPsdViewController.h"
@interface LoginViewController () {


    __weak IBOutlet UIImageView *_iconImg;

    __weak IBOutlet UIButton *resign;
    
    __weak IBOutlet UITextField *UserNameTextField;
    
    __weak IBOutlet UITextField *PsdTextField;
}

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:21/255.0 green:153/255.0 blue:225/255.0 alpha:1.0];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor] };
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setResignBolder];
    [self.navigationController setNavigationBarHidden:YES];
    PsdTextField.secureTextEntry = YES;


}
- (IBAction)loginAction:(id)sender {
    
    if ([self isEmpty]) {
        
        return;
    }
    [BmobUser loginWithUsernameInBackground:UserNameTextField.text password:MD5Hash(PsdTextField.text) block:^(BmobUser *user, NSError *error) {
        if (error) {
            [self showHudWithTitle:@"用户名或密码错误"];

            NSLog(@"%@",[error description]);

        } else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINSUCCESS" object:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];

}
- (IBAction)resignAction:(id)sender {
    
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
    
    resign.layer.cornerRadius = 5.0;
    resign.layer.borderWidth = 0.5;
    resign.layer.borderColor = [[UIColor lightGrayColor] CGColor];

}
- (IBAction)disMiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)forgectPsdAction:(id)sender {
    
    ReSetPsdViewController *reSetPsd = [[ReSetPsdViewController alloc] init];
    
    [self.navigationController pushViewController:reSetPsd animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    if ([PsdTextField isFirstResponder]) {
        
        [PsdTextField resignFirstResponder];
        return;
    } else if ([UserNameTextField isFirstResponder]) {
        
        [UserNameTextField resignFirstResponder];
        return;
    }
}

- (BOOL)isEmpty {
    
    if (UserNameTextField.text.length == 0) {
        
        return YES;
    } else if (PsdTextField.text.length == 0) {
        [self showHudWithTitle:@""];

        return YES;
    }
    return NO;
}

@end
