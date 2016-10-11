//
//  FBVisualBackgroudBaseViewController.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBVisualBackgroudBaseViewController.h"

@interface FBVisualBackgroudBaseViewController ()
@property (nonatomic, strong) UIVisualEffectView *visualView;
@end

@implementation FBVisualBackgroudBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        UIBlurEffect *blureffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
        self.visualView = [[UIVisualEffectView alloc]initWithEffect:blureffect];
        self.visualView.frame = self.view.frame;
        [self.view addSubview: self.visualView];
    }
    return self;
}

- (UIView *)contentView
{
    return self.visualView.contentView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
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
