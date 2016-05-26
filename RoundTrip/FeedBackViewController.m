//
//  FeedBackViewController.m
//  zhixueTeacher
//
//  Created by 翁成 on 16/5/4.
//  Copyright © 2016年 jsmysoft. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UILabel+Common.h"
#import "UIColor+RGB.h"
#import "UIView+Common.h"
#import "MBProgressHUD.h"
#define BACKGROUNDCOLOR [UIColor colorWithRed:242.0/255 green:246.0/255 blue:249.0/255 alpha:1.0]
#define mainScreenW [UIScreen mainScreen].bounds.size.width

@interface FeedBackViewController () <UITextViewDelegate>{

    UIScrollView *_scrollView;
    UITextView *_textView;
    UILabel *_wordNumLabel;

}

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self createViews];
}
- (void)createViews {
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 64, mainScreenW, [UIScreen mainScreen].bounds.size.height - 64);
    _scrollView.backgroundColor = BACKGROUNDCOLOR;
    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponde)];
    [_scrollView addGestureRecognizer:tapgest];
    [self.view addSubview:_scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, 0, mainScreenW - 20, 48);
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"问题和意见";
    titleLabel.textColor = [UIColor colorWithRGBString:@"#333333"];
    [_scrollView addSubview:titleLabel];
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 48 , mainScreenW, 225);
    backView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:[UILabel createLine:0]];
    [backView addSubview:[UILabel createLine:224.5]];
    
    [_scrollView addSubview:backView];
    
    _textView= [[UITextView alloc] init];
    _textView.frame = CGRectMake(10, 10, mainScreenW - 20, 181);
    _textView.text = @"请描述你遇到的问题并给出意见";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textColor = [UIColor colorWithRGBString:@"CCCCCC"];
    _textView.delegate = self;
    [backView addSubview:_textView];
    
    _wordNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainScreenW - 10 - 100, getMaxY(_textView) + 8, 100, 14)];
    _wordNumLabel.font = [UIFont systemFontOfSize:14];
    _wordNumLabel.textAlignment = NSTextAlignmentRight;
    [_wordNumLabel setAttributedText:[self numOfWords:@"0/200字"]] ;
    [backView addSubview:_wordNumLabel];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, getMaxY(backView)+88, mainScreenW - 20, 44);
    button.backgroundColor = [UIColor colorWithRed:31/255.0 green:140/255.0 blue:228/255.0 alpha:1.0];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    _scrollView.contentSize = CGSizeMake(mainScreenW, getMaxY(button)+10);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"请描述你遇到的问题并给出意见"]) {
        textView.text = @"";
        textView.textColor = [UIColor colorWithRGBString:@"#333333"];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请描述你遇到的问题并给出意见";
        textView.textColor = [UIColor colorWithRGBString:@"CCCCCC"];

    }
}
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length>200){
        
        textView.text = [textView.text substringToIndex:200];
    }

    NSInteger numWord = textView.text.length;
    if (numWord > 200) {
        numWord = 200;
    }
    
    NSString *numStr = [NSString stringWithFormat:@"%ld/200字",(long)numWord];
     [_wordNumLabel setAttributedText:[self numOfWords:numStr]];
}
- (void)sureAction:(UIButton *)button {
//    
//    button.userInteractionEnabled = NO;
//
//    NSString *contentText = [_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if (contentText.length > 0 && ![contentText isEqualToString:@"请描述你遇到的问题并给出意见"]) {
//        NSDictionary *dict = @{@"teacherId":self.loginModel.teacherId,@"schoolId":self.loginModel.schoolId,@"content":contentText};
//        __weak typeof(self) weakSelf = self;
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [[NetWorking shareNet] methodPostWithURL:TFEEDBACK parameters:dict success:^(NSDictionary *dataDict) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//            NSLog(@"%@",[dataDict description]);
//            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
//            if ([dataDict[@"code"]isEqualToString:@"1"]) {
//
//                HUD.labelText = @"提交成功";
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//            } else {
//                HUD.labelText = dataDict[@"msg"];
//            }
//            HUD.labelFont = [UIFont systemFontOfSize:14];
//            HUD.mode = MBProgressHUDModeText;
//            [HUD hide:YES afterDelay:2];
//            button.userInteractionEnabled = YES;
//        } fail:^(NSError *error) {
//            NSLog(@"%@",[error description]);
//            button.userInteractionEnabled = YES;
//
//        }];
//    } else {
//        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
//        
//        HUD.labelText = @"请输入内容";
//         
//        HUD.labelFont = [UIFont systemFontOfSize:14];
//        HUD.mode = MBProgressHUDModeText;
//        [HUD hide:YES afterDelay:1];
//        button.userInteractionEnabled = YES;
//
//    }
}
// 统计字数
- (NSMutableAttributedString *)numOfWords:(NSString *)numStr {
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:numStr];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"/"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    
    return noteStr;
}
- (void)resignFirstResponde {

    [_textView resignFirstResponder];

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
