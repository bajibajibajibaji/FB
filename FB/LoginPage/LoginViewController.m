//
//  LoginViewController.m
//  LARPage
//
//  Created by 朱志先 on 16/6/23.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+ZXAdd.h"
#import "LoginAndRegistView.h"
#import "ForgetPasswordView.h"
#import "ChangePasswordView.h"
#import "FBLoginButton.h"
#import "Masonry.h"


typedef NS_ENUM(NSInteger, LoginViewControllerState) {
    LoginViewControllerStateLoginAndRegist = 0,
    LoginViewControllerStateForgetPassword  = 1,
    LoginViewControllerStateChangePassword  = 2,
};


@interface LoginViewController () <LoginAndRegistViewDelegate,ForgetPasswordViewDelegate,ChangePasswordViewDelegate>
@property (nonatomic, strong) LoginAndRegistView *lrView;
@property (nonatomic, strong) ForgetPasswordView *fpView;
@property (nonatomic, strong) ChangePasswordView *cpView;
@property (nonatomic, strong) UIVisualEffectView *visualView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) BOOL keyboardDidAppear;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) LoginViewControllerState state;
@property (nonatomic, strong) FBLoginButton *loginButton;
@property (nonatomic, strong) FBLoginButton *forgetPasswordButton;
@property (nonatomic, strong) FBLoginButton *changePasswordButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyboardDidAppear = NO;
    self.state = LoginViewControllerStateLoginAndRegist;
    __weak LoginViewController *weakself = self;
    //屏幕尺寸参数
    self.ratio = [UIScreen mainScreen].bounds.size.width > 320 ? 1 : 320/375.0;
    //设置虚化背景
    UIBlurEffect *blureffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    self.visualView = [[UIVisualEffectView alloc]initWithEffect:blureffect];
    self.visualView.frame = self.view.frame;
    [self.view addSubview:self.visualView];
    
    
    //设置登录窗口
    self.lrView = [[LoginAndRegistView alloc]init];
    [self.visualView.contentView addSubview:self.lrView];
    _lrView.delegate = self;
    [_lrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(- 450);
        make.width.equalTo(317 * self.ratio);
        make.height.equalTo(315 * self.ratio);
    }];
    
    //设置登录按钮
    
    if ([UIScreen mainScreen].bounds.size.height > 500)
    {
        self.loginButton = [FBLoginButton new];
        [self.visualView.contentView addSubview:self.loginButton];
        [_loginButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(93 * self.ratio);
            make.centerX.equalTo(self.lrView);
            make.top.equalTo(self.lrView.mas_bottom).offset(15);
        }];
        
        self.loginButton.buttonBlock = ^(){
            switch (weakself.lrView.laState) {
                case DynamicPasswordLogin:
                    [weakself loginAndRegistView:weakself.lrView PrepareToLoginWithPhone:weakself.lrView.phoneNumber AndDynamicPassword:weakself.lrView.password];
                    break;
                    
                case RegistState:
                    [weakself loginAndRegistView:weakself.lrView PrepareToRegistWithPhone:weakself.lrView.phoneNumber AndDynamicPassword:weakself.lrView.password isAgreeProtocol:weakself.lrView.agreeProtocol];
                    break;
                    
                case NormalPasswordLogin:
                    [weakself loginAndRegistView:weakself.lrView PrepareToLoginWithPhone:weakself.lrView.phoneNumber AndNormalPassword:weakself.lrView.password];
                    break;
                    
                default:
                    break;
            }
            
        };
        
    }
    
    
    //设置忘记密码窗口
    self.fpView = [ForgetPasswordView new];
    self.fpView.delegate = self;
    [self.visualView.contentView addSubview:self.fpView];
    [self.fpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lrView);
        make.width.equalTo(317 * self.ratio);
        make.height.equalTo(240 * self.ratio);
        make.centerX.equalTo(self.lrView).offset(self.view.frame.size.width);
    }];
    
    
    //设置忘记密码确认按钮
    if ([UIScreen mainScreen].bounds.size.height > 500)
    {
        self.forgetPasswordButton = [FBLoginButton new];
        self.forgetPasswordButton.buttonType = FBLoginButtonTypeNext;
        [self.visualView.contentView addSubview:self.forgetPasswordButton];
        [_forgetPasswordButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(93 * self.ratio);
            make.centerX.equalTo(self.fpView);
            make.top.equalTo(self.fpView.mas_bottom).offset(15);
        }];
        
        self.forgetPasswordButton.buttonBlock = ^(){
            switch (weakself.fpView.fpState) {
                case ForgetPasswordViewStateUsePhone:
                    [weakself ForgetPasswordViewPrepareToVerify:weakself.fpView WithPhoneNumber:weakself.fpView.phoneNumber AndPassword:weakself.fpView.password];
                    break;
                    
                case ForgetPasswordViewStateUseEmail:
                    [weakself ForgetPasswordViewPrepareToVerify:weakself.fpView WithEmail:weakself.fpView.phoneNumber AndPassword:weakself.fpView.password];
                    break;
                    
                default:
                    break;
            }
            
        };
    }
    
    
    
    
    //设置修改密码窗口
    self.cpView = [ChangePasswordView new];
    self.cpView.delegate = self;
    [self.visualView.contentView addSubview:self.cpView];
    [self.cpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fpView);
        make.width.equalTo(317 * self.ratio);
        make.height.equalTo(168 * self.ratio);
        make.centerX.equalTo(self.fpView).offset(self.view.frame.size.width);
    }];
    
    //设置修改密码按钮
    if ([UIScreen mainScreen].bounds.size.height > 500)
    {
        self.changePasswordButton = [FBLoginButton new];
        self.changePasswordButton.buttonType = FBLoginButtonTypeDone;
        [self.visualView.contentView addSubview:self.changePasswordButton];
        [_changePasswordButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(93 * self.ratio);
            make.centerX.equalTo(self.cpView);
            make.top.equalTo(self.cpView.mas_bottom).offset(15);
        }];
        self.changePasswordButton.buttonBlock = ^(){
            [weakself ChangePasswordViewChangePassword:weakself.cpView WithNewPassWord:weakself.cpView.password];
        };
        
    }
    
    
    
    //设置标题图片
    self.titleImageView = [[UIImageView alloc]init];
    self.titleImageView.image = [UIImage imageWithContentsOfFile:[NSString adaptiveImagePathWithFullImageName:@"word1.png"]];
    self.titleImageView.alpha = 0;
    [self.visualView.contentView addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(255 * self.ratio);
        make.height.equalTo(72 * self.ratio);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.lrView.mas_top).offset(-25 * self.ratio);
    }];
    
    
    //设置关闭窗口按钮
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 20, 35, 35)];
    [closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [closeButton setImage:kGetImage(@"close.png") forState:(UIControlStateNormal)];
    [self.view addSubview:closeButton];
    
    //设置返回按钮
    
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 25, 25)];
    [self.backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backButton setImage:kGetImage(@"close1.png") forState:(UIControlStateNormal)];
    [self.view addSubview:self.backButton];
    self.backButton.hidden = YES;
    self.backButton.alpha = 0;
    
    
    
    
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidAppear:(BOOL)animated
{
    __weak LoginViewController *weakSelf = self;
    [super viewDidAppear:animated];
    
    [self.lrView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(96 + 72 * self.ratio);
    }];
    
    [UIView animateWithDuration:0.5 delay:0.7 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.titleImageView.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        [weakSelf.lrView layoutIfNeeded];
        [weakSelf.loginButton layoutIfNeeded];
        [weakSelf.changePasswordButton layoutIfNeeded];
        [weakSelf.forgetPasswordButton layoutIfNeeded];
    } completion:nil];
    
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    //    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //    CGRect keyboardRect = [aValue CGRectValue];
    //    CGFloat keyBoardHeight = keyboardRect.size.height;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    self.lrView.keyBoardDidAppear = YES;
    self.keyboardDidAppear = YES;
    
    
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [self.lrView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(86 + 72 * self.ratio - 100);
    }];
    
    [UIView animateWithDuration:animationDuration delay:0 options:curve.intValue animations:^{
        [_lrView layoutIfNeeded];
        [_fpView layoutIfNeeded];
        [_cpView layoutIfNeeded];
        [_loginButton layoutIfNeeded];
        [_changePasswordButton layoutIfNeeded];
        [_forgetPasswordButton layoutIfNeeded];
        _titleImageView.alpha = 0;
        _titleImageView.center = CGPointMake(_titleImageView.center.x, _titleImageView.center.y - 100);
    } completion:^(BOOL finished){
        if (self.ratio != 1) {
            [self.lrView compressView];
        }
    }];
    
    
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    //    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //    CGRect keyboardRect = [aValue CGRectValue];
    //    CGFloat keyBoardHeight = keyboardRect.size.height;
    
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    self.lrView.keyBoardDidAppear = NO;
    self.keyboardDidAppear = NO;
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    
    [self.lrView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(96 + 72 * self.ratio);
    }];
    
    [UIView animateWithDuration:animationDuration delay:0 options:curve.intValue animations:^{
        [_lrView layoutIfNeeded];
        [_fpView layoutIfNeeded];
        [_cpView layoutIfNeeded];
        [_loginButton layoutIfNeeded];
        [_changePasswordButton layoutIfNeeded];
        [_forgetPasswordButton layoutIfNeeded];
        [_loginButton layoutIfNeeded];
        _titleImageView.center = CGPointMake(_titleImageView.center.x, _titleImageView.center.y + 100);
    } completion:^(BOOL finished){
        if (self.ratio != 1 && self.lrView.laState != RegistState) {
            [self.lrView stretchView];
        }
        [UIView animateWithDuration:0.4 animations:^{
            _titleImageView.alpha = 1;
        }];
    }];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void) clickCloseButton:(UIButton* )button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) clickBackButton:(UIButton *)button
{
    switch (self.state) {
        case LoginViewControllerStateForgetPassword:
            self.state = LoginViewControllerStateLoginAndRegist;
            [self makeBackButtonDisappear];
            [self viewMoveLeftAndRight];
            break;
        case LoginViewControllerStateLoginAndRegist:
            self.state = LoginViewControllerStateLoginAndRegist;
            break;
        case LoginViewControllerStateChangePassword:
            self.state = LoginViewControllerStateForgetPassword;
            [self changeTitleImageWithImageName:@"word3.png"];
            [self viewMoveLeftAndRight];
            break;
            
        default:
            break;
    }
}



#pragma mark - LoginAndRegistDelegate

- (void)loginAndRegistView:(LoginAndRegistView *)laView PrepareToLoginWithPhone:(NSString *)phoneNumber AndNormalPassword:(NSString *)password
{
    NSLog(@"normal %@,%@",phoneNumber,password);
}

- (void)loginAndRegistView:(LoginAndRegistView *)laView PrepareToRegistWithPhone:(NSString *)phoneNumber AndDynamicPassword:(NSString *)password isAgreeProtocol:(BOOL)isAgree
{
    NSLog(@"regist %@,%@, %d",phoneNumber,password, isAgree);
}

- (void)loginAndRegistView:(LoginAndRegistView *)laView PrepareToLoginWithPhone:(NSString *)phoneNumber AndDynamicPassword:(NSString *)password
{
    NSLog(@"dynamic %@,%@",phoneNumber,password);
}

- (void)loginAndRegistViewGetLonginDynamicPassword:(LoginAndRegistView *)laView WithPhoneNumber:(NSString *)phoneNumber
{
    NSLog(@"get login message");
}

- (void)loginAndRegistViewGetRegistDynamicPassword:(LoginAndRegistView *)laView WithPhoneNumber:(NSString *)phoneNumber
{
    NSLog(@"get regist message");
}


//用户点击忘记密码
- (void)loginAndRegistViewClickForgetPasswordButton:(LoginAndRegistView *)laView
{
    self.state = LoginViewControllerStateForgetPassword;
    [self viewMoveLeftAndRight];
    [self makeBackButtonAppear];
    [self changeTitleImageWithImageName:@"word3.png"];
    
    
}

- (void)loginAndRegistViewClickReadProtocol:(LoginAndRegistView *)laView
{
    
}

- (void)loginAndRegistViewClickUseQQLoginButton:(LoginAndRegistView *)laView
{
    
}

- (void) loginAndRegistViewClickUseWeChatLoginButton:(LoginAndRegistView *)laView
{
    
}

- (void) loginAndRegistViewClickUseWeicoLoginButton:(LoginAndRegistView *)laView
{
    
}

- (void) loginAndRegistViewChangeToRegist:(LoginAndRegistView *)laView
{
    [self changeTitleImageWithImageName:@"word2.png"];
}

- (void) loginAndRegistViewChangeToLogin:(LoginAndRegistView *)laView
{
    [self changeTitleImageWithImageName:@"word1.png"];
}

#pragma mark - ForGetPasswordViewDelegate
-(void)ForgetPasswordViewPrepareToVerify:(ForgetPasswordView *)fpView WithPhoneNumber:(NSString *)phoneNumber AndPassword:(NSString *)password
{
    self.state = LoginViewControllerStateChangePassword;
    [self viewMoveLeftAndRight];
    [self changeTitleImageWithImageName:@"word4.png"];
    NSLog(@"修改密码");
}

-(void)ForgetPasswordViewGetDynamicPassWord:(ForgetPasswordView *)fpView WithPhoneNumber:(NSString *)phoneNumber
{
    
}

-(void)ForgetPasswordViewGetDynamicPassWord:(ForgetPasswordView *)fpView WithEmail:(NSString *)email
{
    
}

-(void)ForgetPasswordViewPrepareToVerify:(ForgetPasswordView *)fpView WithEmail:(NSString *)email AndPassword:(NSString *)password
{
    
}


#pragma mark - ChangePasswordViewDelegate

-(void)ChangePasswordViewChangePassword:(ChangePasswordView *)cpView WithNewPassWord:(NSString *)newPassword
{
    
}


//控制器视图重新布局
- (void) viewMoveLeftAndRight
{
    [self.lrView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(- self.view.frame.size.width * self.state);
    }];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:2 initialSpringVelocity:10 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        [self.lrView layoutIfNeeded];
        [self.fpView layoutIfNeeded];
        [self.cpView layoutIfNeeded];
        [_loginButton layoutIfNeeded];
        [_changePasswordButton layoutIfNeeded];
        [_forgetPasswordButton layoutIfNeeded];
    } completion:nil];
    
}



- (void) makeBackButtonAppear
{
    self.backButton.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.backButton.alpha = 1;
    }];
}

- (void) makeBackButtonDisappear
{
    [UIView animateWithDuration:0.5 animations:^{
        self.backButton.alpha = 0;
    } completion:^(BOOL finished) {
        self.backButton.hidden = YES;
    }];
}

- (void)changeTitleImageWithImageName:(NSString *)imageName
{
    [UIView animateWithDuration:0.2 animations:^{
        self.titleImageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.titleImageView.image = [UIImage imageWithContentsOfFile:[NSString adaptiveImagePathWithFullImageName:imageName]];
        if (!self.keyboardDidAppear)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.titleImageView.alpha = 1;
            }];
        }
    }];
    
}





@end
