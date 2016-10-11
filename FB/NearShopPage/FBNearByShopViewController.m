//
//  FBNearByShopViewController.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBNearByShopViewController.h"
#import "FBNearByShopView.h"

@interface FBNearByShopViewController ()
@property (nonatomic, strong) FBNearByShopView *viewq;
@end

@implementation FBNearByShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewq = [[FBNearByShopView alloc]init];
    self.viewq.frame = CGRectMake(48, 85,0, 0);
    self.viewq.center = self.view.center;
    self.viewq.shopImage = [UIImage imageNamed:@"72bOOOPICc9"];
    __weak UIViewController *weakSelf = self;
    self.viewq.closeButtonHandler = ^(){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    

    [self.contentView addSubview:self.viewq];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.7 delay:0.05 usingSpringWithDamping:1.5 initialSpringVelocity:25 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.viewq.frame = CGRectMake(48, 85, 323, 470);
        self.viewq.center = self.view.center;
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
