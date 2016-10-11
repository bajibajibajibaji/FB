//
//  ListViewController.m
//  mainLand3
//
//  Created by 朱志先 on 16/6/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "ListViewController.h"
#import "ZXAnimationImageView.h"
@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(40, 164, 200, 200);
    [self.view addSubview:view];
//    ZXAnimationImageView *ima = [[ZXAnimationImageView alloc]initWithFrame:CGRectMake(40, 164, 100, 100)];
//    ima.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:ima];
//    [ima startRepeatRotationAnimationDuration:0.01 Delay:0 Angel:9 * M_PI RotationCenter:CGPointMake(40, 40)];
//    // Do any additional setup after loading the view.
//    UIView *view1 = [UIView new];
//    view1.backgroundColor = [UIColor grayColor];
//    view1.frame = CGRectMake(79, 203 ,2, 2);
//    [self.view addSubview:view1];
//    
    
    for (int i = 1; i <= 5; i++) {
        ZXAnimationImageView *leafView = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"500leaf%d",i]]];
        [view addSubview:leafView];
        leafView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        CGFloat delay = (arc4random()%5)/15.0;
        CGFloat angel = M_PI/(arc4random()%5+28);
        [leafView startRepeatRotationAnimationDuration:2 Delay:delay Angel:angel RotationCenter:CGPointMake(70, 50)];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
