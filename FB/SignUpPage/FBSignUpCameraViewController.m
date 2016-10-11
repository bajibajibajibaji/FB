//
//  FBSignUpCameraViewController.m
//  SignUp
//
//  Created by 朱志先 on 16/7/14.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBSignUpCameraViewController.h"
#import "FBSignCalendarViewController.h"
#import "Masonry.h"
#import "FBCameraView.h"
#import <MBProgressHUD.h>
@interface FBSignUpCameraViewController ()
@property (nonatomic, strong) FBCameraView *cameraView;
@end

@implementation FBSignUpCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraView = [[FBCameraView alloc]initWithFrame:(CGRect){20, 220, 346, 277 }];
    [self.contentView addSubview:self.cameraView];
    [self.cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(-800);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(346);
        make.height.equalTo(277);
    }];
    __weak typeof(self) weakSelf = self;
    self.cameraView.closeButtonBlock = ^(){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.cameraView.calendarButtonBlock = ^(){
        FBSignCalendarViewController *vc = [FBSignCalendarViewController new];
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    
    self.cameraView.signUpButtonBlock = ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.cameraView animated:YES];
        hud.labelText = @"Loading...";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.cameraView setTodayIsSignUpWithAnimation:YES];
                [hud hide:YES];
            });
        });
    };
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.cameraView animated:YES];
    hud.labelText = @"Loading...";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *arr = [NSArray array];
            self.cameraView.prize = arr;
            [hud hide:YES];
        });
    });
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.cameraView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7   initialSpringVelocity:3 options:(UIViewAnimationOptionCurveLinear) animations:^{
        [self.cameraView layoutIfNeeded];
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
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
