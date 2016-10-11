//
//  FBMyQRCodeViewController.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBMyQRCodeViewController.h"
#import "FBMyQRCodeView.h"
@interface FBMyQRCodeViewController ()
@property (nonatomic, strong) FBMyQRCodeView *myQRCodeView;
@end

@implementation FBMyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myQRCodeView = [FBMyQRCodeView new];
    self.myQRCodeView.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.myQRCodeView];
    self.myQRCodeView.center = self.view.center;
    self.myQRCodeView.nickName = @"闯堂兔";
    self.myQRCodeView.signature = @"创闯闯~ 创闯闯~";
    self.myQRCodeView.avatarImage = [UIImage imageNamed:@"72bOOOPICc9"];
    self.myQRCodeView.qrCodeImage = [UIImage imageNamed:@"movieStyle"];
    __weak UIViewController *weakSelf = self;
    self.myQRCodeView.closeButtonHandler = ^(){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1.3 initialSpringVelocity:20 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.myQRCodeView.frame = CGRectMake(0, 0, 323, 470);
        self.myQRCodeView.center = self.view.center;
    } completion:nil];
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
