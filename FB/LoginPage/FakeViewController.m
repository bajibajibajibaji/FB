//
//  FakeViewController.m
//  LARPage
//
//  Created by 朱志先 on 16/6/23.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FakeViewController.h"
#import "UIImage+BlurImage.h"
#import "LoginViewController.h"
#import "ForgetPasswordView.h"
#import "ChangePasswordView.h"
#import "LoginAndRegistView.h"
#import "NSString+ZXAdd.h"
#import <Masonry.h>
@interface FakeViewController ()
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, assign) CGFloat ratio;
@end

@implementation FakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ratio = [UIScreen mainScreen].bounds.size.width > 320 ? 1 : 320/375.0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    UIImageView *image = [[UIImageView alloc]init];
    UIImage *imagec = [UIImage imageNamed:@"HomePage"];
    image.frame = self.view.frame;
    image.image = imagec;
    [self.view addSubview:image];
    self.navigationController.navigationBarHidden = YES;
    
    UIView *vv = [[UIView alloc]initWithFrame:self.view.frame];
    vv.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    [self.view addSubview:vv];
    

//    
//    ChangePasswordView * view1 = [ChangePasswordView new];
//    [self.view addSubview:view1];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(view1.superview.center).offset(CGPointMake(0,0));
//        make.width.equalTo(317 * self.ratio);
//        make.height.equalTo(160 * self.ratio);
//    }];
//    
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LoginViewController *lvc = [[LoginViewController alloc]init];
    
    [self presentViewController:lvc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
