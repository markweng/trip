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

    [_iconImg sd_setImageWithURL:[NSURL URLWithString:@"http://www.uimaker.com/uploads/allimg/110427/1_110427061433_14.jpg"] placeholderImage:[UIImage imageNamed:@"UMS_facebook_icon"]];
}
- (IBAction)loginAction:(id)sender {
    [BmobUser loginWithUsernameInBackground:UserNameTextField.text password:PsdTextField.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"%@",[error description]);
        } else {
        
            NSLog(@"%@",[user description]);

        
        }
    }];

}
- (IBAction)resignAction:(id)sender {
    
    
//    BmobObject *userInfo = [BmobObject objectWithClassName:@"User"];
//    [userInfo setObject:UserNameTextField.text forKey:@"userName"];
//
//    [userInfo setObject:PsdTextField.text forKey:@"passWord"];
//    //    [userInfo setObject:@78 forKey:@"score"];
//    //    [userInfo setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
//    [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        NSLog(@"%@",[error description]);
// 
//    }];
   //  BmobUser signOrLoginInbackgroundWithMobilePhoneNumber:UserNameTextField.text SMSCode:PsdTextField.text andPassword:<#(NSString *)#> block:<#^(BmobUser *user, NSError *error)block#>
    ResignViewController  *resignVC = [[ResignViewController alloc] init];
    
   [self.navigationController pushViewController:resignVC animated:YES];

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
