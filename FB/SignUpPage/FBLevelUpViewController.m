//
//  FBLevelUpViewController.m
//  SignUp
//
//  Created by 朱志先 on 16/7/22.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBLevelUpViewController.h"
#import "FBLevelUpView.h"
@interface FBLevelUpViewController ()
@property (nonatomic, strong) FBLevelUpView *levelView;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation FBLevelUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.levelView = [FBLevelUpView new];
    self.levelView.bounds = CGRectMake(0, 0, 250, 400);
    self.levelView.center = self.view.center;
    FBLevelUpPrizeModel *model = [FBLevelUpPrizeModel new];
    model.prizeNumber = 1;
    model.prizeImage = kGetImage(@"up box1.png");
    FBLevelUpPrizeModel *model1 = [FBLevelUpPrizeModel new];
    model1.prizeNumber = 50;
    model1.prizeImage = kGetImage(@"up box2.png");
    FBLevelUpPrizeModel *model2 = [FBLevelUpPrizeModel new];
    model2.prizeNumber = 100;
    model2.prizeImage = kGetImage(@"up box3.png");
    self.levelView.prizeArray = @[model,model1,model2];
    
    self.closeButton = [UIButton new];
    self.closeButton.frame = CGRectMake(self.levelView.frame.origin.x + 255, self.levelView.frame.origin.y - 22, 21, 21);
    [self.closeButton setBackgroundImage:kGetImage(@"up close.png") forState:(UIControlStateNormal)];
    [self.closeButton addTarget:self action:@selector(closeVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.contentView addSubview:self.levelView];
    [self.contentView addSubview:self.closeButton];
    
    // Do any additional setup after loading the view.
}

- (void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.levelView startAnimation];
    });
    
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
