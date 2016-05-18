//
//  LoginModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/5/10.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserIconModel : JSONModel
@property (nonatomic, copy) NSString *url;
@end

@interface LoginModel : JSONModel
@property (nonatomic, copy) NSString *mobilePhoneNumber;
@property (nonatomic, copy) NSString *mobilePhoneNumberVerified;
@property (nonatomic, copy) NSString <Optional> *nickname;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) UserIconModel <Optional> *usericon;
@end
//createdAt = "2016-05-09 22:47:17";
//mobilePhoneNumber = 13569105203;
//mobilePhoneNumberVerified = 1;
//nickname = wong;
//objectId = ed46f8c896;
//updatedAt = "2016-05-10 10:54:07";
//usericon =     {
//    "__type" = File;
//    filename = "MyIcon.jpg";
//    url = "http://bmob-cdn-1227.b0.upaiyun.com/2016/05/10/2aae02954cf6472893a3866488114fb7.jpg";
//};
//username = 13569105203;