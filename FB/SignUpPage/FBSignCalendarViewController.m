//
//  FBSignCalendarViewController.m
//  SignUp
//
//  Created by 朱志先 on 16/7/18.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBSignCalendarViewController.h"
#import "FBSignCalendarView.h"

@interface FBSignCalendarViewController ()
@property (nonatomic, strong) FBSignCalendarView *calendarView;
@property (nonatomic, strong) UIButton *signRuleButton;
@property (nonatomic, strong) UIButton * closeButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation FBSignCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//设置日历视图
    self.calendarView = [FBSignCalendarView new];
    self.calendarView.signUpDayNumber = 20;
    [self.contentView addSubview:self.calendarView];
    self.calendarView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//设置日历控制按钮
//阅读签到规则按钮
    self.signRuleButton = [UIButton new];
    [self.signRuleButton setBackgroundImage:kGetImage(@"Sign in rules2.png") forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.signRuleButton];

    [self.signRuleButton addTarget:self action:@selector(readRule) forControlEvents:(UIControlEventTouchUpInside)];
    self.signRuleButton.alpha = 0;
//向左滑动按钮
    self.leftButton = [UIButton new];
    [self.leftButton setBackgroundImage:kGetImage(@"left.png") forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.leftButton];
    [self.leftButton addTarget:self action:@selector(moveToLeft) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftButton.alpha = 0;
//向右滑动按钮
    self.rightButton = [UIButton new];
    [self.rightButton setBackgroundImage:kGetImage(@"right.png") forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.rightButton];
    [self.rightButton addTarget:self action:@selector(moveToRight) forControlEvents:(UIControlEventTouchUpInside)];
    self.rightButton.alpha = 0;
//关闭按钮
    self.closeButton = [UIButton new];
    [self.closeButton setBackgroundImage:kGetImage(@"sign close.png") forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(closeView) forControlEvents:(UIControlEventTouchUpInside)];
    self.closeButton.alpha = 0;
    
}

- (void)viewDidAppear:(BOOL)animated
{
//视图加载动画
    self.calendarView.bounds = CGRectMake(0, 0, 0, 0);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.3 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.calendarView.bounds = CGRectMake(0, 0, 317 * 0.9 , 440 * 0.9);
    } completion:^(BOOL comlete){
        self.closeButton.bounds = CGRectMake(0, 0, 21, 21);
        self.closeButton.center = CGPointMake(self.calendarView.frame.origin.x + self.calendarView.bounds.size.width, self.calendarView.frame.origin.y);
        self.signRuleButton.bounds = CGRectMake(0, 0, 96, 30);
        self.signRuleButton.center = CGPointMake(self.calendarView.center.x, self.calendarView.frame.origin.y + 450);
        self.rightButton.bounds = CGRectMake(0, 0, 21, 21);
        self.rightButton.center = CGPointMake(self.calendarView.frame.origin.x + self.calendarView.bounds.size.width, self.calendarView.center.y);
        self.leftButton.bounds = CGRectMake(0, 0, 21, 21);
        self.leftButton.center = CGPointMake(self.calendarView.frame.origin.x, self.calendarView.center.y);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.rightButton.alpha = 1;
        self.leftButton.alpha = 1;
        self.signRuleButton.alpha = 1;
        self.closeButton.alpha = 1;
    }];
}

- (void)moveToLeft
{
    [self.calendarView moveToLeft];
}

- (void)moveToRight
{
    [self.calendarView moveToRight];
}

- (void)readRule
{
    
}

- (void)closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
