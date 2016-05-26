//
//  UserInfoTableViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/11.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import <BmobSDK/Bmob.h>
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"
#import "UIViewController+Common.h"

@interface UserInfoTableViewController ()  <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate> {


    UIBarButtonItem *_rightItem;
    
    __weak IBOutlet UILabel *_sexLabel;
    
    __weak IBOutlet UIImageView *_iconImage;
    __weak IBOutlet UITextField *_eMialTextField;

    __weak IBOutlet UITextField *_nickNameTextField;
    
    IBOutlet UITableView *_myTableVIew;
    UIActionSheet *_sheet;
}

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *sex;
@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButtonItem];
    _nickNameTextField.delegate = self;
    _eMialTextField.delegate = self;

}
- (void)createButtonItem {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:21/255.0 green:153/255.0 blue:225/255.0 alpha:1.0];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor] };
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
   _rightItem  = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
}
- (void)back {

   [self dismissViewControllerAnimated:YES completion:^{
       
   }];


}
- (void)sureAction {
    [self hiddenKeyBoard];
    if ([self isEmpty]) {
        return;
    }
    
    BmobUser *bUser = [BmobUser getCurrentUser];
    BmobFile *file1 = [[BmobFile alloc] initWithFileName:[NSString stringWithFormat:@"%@%@",_nickNameTextField.text,@".png"] withFileData:UIImagePNGRepresentation(_icon)];
    NSLog(@"%@",[file1 description]);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到usericon列
        if (isSuccessful) {
            [bUser setObject:file1  forKey:@"usericon"];
            bUser.email = _eMialTextField.text;
            [bUser setObject:_nickNameTextField.text forKey:@"nickname"];
            [bUser setObject:_sex forKey:@"sex"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];

                        if (isSuccessful) {

                            [self dismissViewControllerAnimated:YES completion:^{
                
                            }];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGINSUCCESS" object:nil];
                        }

                NSLog(@"error %@",[error description]);
            }];

          
            NSLog(@"file1 url %@",file1.url);
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            NSLog(@"error %@",[error description]);
        }
    }];

   
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
   if (indexPath.section == 0) {
        if ([self hiddenKeyBoard]) {
            return;
        }
        _sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册",nil];
        [_sheet showInView:self.view];
        
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        
        if ([self hiddenKeyBoard]) {
            return;
        }

        UIActionSheet *sexSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
        [sexSheet showInView:self.view];

        
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet isEqual:_sheet]) {
        if (buttonIndex == 0) {
            NSLog(@"相机");
            
            // 判断有摄像头，并且支持拍照功能
            if ([self isCameraAvailable]){
                // 初始化图片选择控制器
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
                controller.allowsEditing = YES;

                [controller setDelegate:self];// 设置代理
                [self presentViewController:controller animated:YES completion:^{
                    
                }];
                
            } else {
                NSLog(@"Camera is not available.");
            }
            
        } else if (buttonIndex == 1) {
            
            NSLog(@"相册");
            
            if ([self isPhotoLibraryAvailable]){
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
                controller.allowsEditing = YES;
                [controller setDelegate:self];// 设置代理
                [self presentViewController:controller animated:YES completion:^{
                    
                }];
                
            }
        }
  
    } else {
    
        if (buttonIndex == 0) {
            self.sex = @"男";
            
            
        } else if(buttonIndex == 1) {
        
          self.sex = @"女";
        }
    
    
    }

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

}
#pragma mark - 摄像头和相册相关的公共类

// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}


#pragma mark - 相册文件选取相关
// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}


#pragma mark - UIImagePickerControllerDelegate 代理方法


// 保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    _iconImage.image = paramImage;
}

// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@", info);
    // 判断获取类型：图片
  //  if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
        _iconImage.image = theImage;
        _icon = theImage;
        // 保存图片到相册中
       // SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
       // UIImageWriteToSavedPhotosAlbum(theImage, self,selectorToCall, NULL);
        [picker dismissViewControllerAnimated:YES completion:^{
        
       }];
      self.navigationItem.rightBarButtonItem = _rightItem;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = _rightItem;
    }
}

- (BOOL)isEmpty {

    if (_icon == nil) {
        return YES;
    }
    if (_nickNameTextField.text.length == 0) {
    
        return YES;
    }
    if (_eMialTextField.text.length == 0 ) {
    
        return YES;
    }
    if (![self validateEmail:_eMialTextField.text]) {
        
        [self showHudWithTitle:@"请输入正确的邮箱地址"];
        return YES;
    }
    if (_sex == nil) {
        
        return YES;

    }

    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}
- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (BOOL)hiddenKeyBoard {
    
        if ([_nickNameTextField isFirstResponder]) {
    
            [_nickNameTextField resignFirstResponder];
            return YES;
    
        } else if ([_eMialTextField isFirstResponder]) {
    
            [_eMialTextField resignFirstResponder];
            return YES;
        }
     return NO;
}
- (void)setSex:(NSString *)sex {

    _sex = sex;
    _sexLabel.text = _sex;

}
@end
