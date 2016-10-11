//
//  LoginAndRegistView.h
//  LARPage
//
//  Created by 朱志先 on 16/6/24.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginAndRegistView;
typedef NS_ENUM(NSInteger, LoginAndRegistViewState) {
    DynamicPasswordLogin = 1,
    NormalPasswordLogin  = 2,
    RegistState  = 3,
};

@protocol LoginAndRegistViewDelegate <NSObject>
//获取登录动态密码
- (void)loginAndRegistViewGetLonginDynamicPassword:(LoginAndRegistView *)laView WithPhoneNumber:(NSString *)phoneNumber;
//获取注册动态密码
- (void)loginAndRegistViewGetRegistDynamicPassword:(LoginAndRegistView *)laView WithPhoneNumber:(NSString *)phoneNumber;
//使用动态密码登录
- (void)loginAndRegistView:(LoginAndRegistView *)laView PrepareToLoginWithPhone:(NSString *)phoneNumber AndDynamicPassword:(NSString *)password;
//使用普通密码登录
- (void)loginAndRegistView:(LoginAndRegistView *)laView PrepareToLoginWithPhone:(NSString *)phoneNumber AndNormalPassword:(NSString *)password;
//使用动态密码注册
- (void)loginAndRegistView:(LoginAndRegistView *)laView PrepareToRegistWithPhone:(NSString *)phoneNumber AndDynamicPassword:(NSString *)password isAgreeProtocol:(BOOL)isAgree;
//选择忘记密码
- (void)loginAndRegistViewClickForgetPasswordButton:(LoginAndRegistView *)laView;
//选择微信登录
- (void)loginAndRegistViewClickUseWeChatLoginButton:(LoginAndRegistView *)laView;
//选择QQ登录
- (void)loginAndRegistViewClickUseQQLoginButton:(LoginAndRegistView *)laView;
//选择微博登录
- (void)loginAndRegistViewClickUseWeicoLoginButton:(LoginAndRegistView *)laView;
//选择阅读用户协议
- (void)loginAndRegistViewClickReadProtocol:(LoginAndRegistView *)laView;
//切换至登录窗口
- (void)loginAndRegistViewChangeToLogin:(LoginAndRegistView *)laView;
//切换至注册窗口
- (void)loginAndRegistViewChangeToRegist:(LoginAndRegistView *)laView;
@end

@interface LoginAndRegistView : UIView
@property (nonatomic, weak) id<LoginAndRegistViewDelegate> delegate;

@property (nonatomic, weak, readonly) NSString *phoneNumber;
@property (nonatomic, weak, readonly) NSString *password;
@property (nonatomic, assign, readonly) BOOL agreeProtocol;
@property (nonatomic, assign, readonly) LoginAndRegistViewState laState;


@property (nonatomic, assign) BOOL keyBoardDidAppear;

- (void)compressView;
- (void)stretchView;


@end
