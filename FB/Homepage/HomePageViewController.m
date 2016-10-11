//
//  HomePageViewController.m
//  mainLand3
//
//  Created by 朱志先 on 16/6/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "HomePageViewController.h"
#import "IsLandView.h"
#import "UIView+AddGesture.h"
#import "ListViewController.h"
#import "HomePageSideButton.h"
#import "HomePageMyIslandView.h"

#import "LoginViewController.h"
#import "FBMyQRCodeViewController.h"
#import "FBNearByShopViewController.h"
#import "FBSignUpCameraViewController.h"
#import "FBMyBoxViewController.h"
#import "FBLevelUpViewController.h"

@interface HomePageViewController ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) NSMutableArray<IsLandItem *> *islandItems;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     __weak HomePageViewController *weakSelf = self;
    
    float width = [UIScreen mainScreen].bounds.size.width;
    int layoutType = 1;
    if (width > 330) {
        layoutType = 2;
    }
    if (width >385) {
        layoutType = 3;
    }
    self.title = @"分贝";
    self.islandItems = [NSMutableArray array];
    
    
    
    
    
    IsLandItem * item1 = [IsLandItem new];
    item1.toyNumber = 1234;
    item1.islandDistance = 5500;
    [self.islandItems addObject:item1];
    
    IsLandItem * item2 = [IsLandItem new];
    item2.toyNumber = 34134;
    item2.islandDistance = 5000;
    [self.islandItems addObject:item2];
    
    IsLandItem * item3 = [IsLandItem new];
    item3.toyNumber = 234;
    item3.islandDistance = 2000;
    [self.islandItems addObject:item3];
    
    IsLandItem * item4 = [IsLandItem new];
    item4.toyNumber = 3112;
    item4.islandDistance = 1000;
    [self.islandItems addObject:item4];
    
    IsLandItem * item5 = [IsLandItem new];
    item5.toyNumber = 1334;
    item5.islandDistance = 500;
    [self.islandItems addObject:item5];
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:35/256.0 green:204/256.0 blue:252/256.0 alpha:1];
    //设置scollerview
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollerView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    
    
    //创建岛屿视图
    for (int i = 0; i <5 ; i++) {
        IsLandView *island = [[IsLandView alloc]init];
        
        //根据屏幕尺寸适配岛屿布局
        switch (layoutType) {
            case 1:
                island.frame = CGRectMake((56 + 128 *(i % 2)), i * 70
                                          , 128, 128);
                //iPhone4S调整岛屿的frame
                if(kScreenHeight == 480)
                {
                    island.frame = CGRectMake((56 + 120 *(i % 2)), i * 60 - 10 , 120, 120);
                }
                break;
                
            case 3:
                island.frame = CGRectMake((75 + 170 *(i % 2)), i * 95
                                          , 160, 160);
                break;
            default:
                island.frame = CGRectMake((60 + 150 *(i % 2)), i * 85
                                          , 150, 150);
                break;
        }
        
        [self.scrollerView addSubview:island];
        island.item = self.islandItems[i];
        
       
        [island AddTapGestureWithBlock:^{
            ListViewController *vc = [[ListViewController alloc]init];
            vc.view.backgroundColor = [UIColor yellowColor];
            vc.navigationController.navigationBarHidden = NO;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [self.scrollerView addSubview:island];
        
    }
    
    [self.view addSubview:self.scrollerView];
    
    
    HomePageSideButton *myBoxButton = [[HomePageSideButton alloc]init];
    myBoxButton.titleImage = [UIImage imageNamed:@"box"];
    myBoxButton.lableText = @"我的宝箱";
    myBoxButton.badgeNumber = 0;
    [self.view addSubview:myBoxButton];
    myBoxButton.clickBlock = ^(){
        FBMyBoxViewController *boxVC = [FBMyBoxViewController new];
        boxVC.modalPresentationStyle = UIModalPresentationPopover;
        [weakSelf presentViewController:boxVC animated:YES completion:nil];
    };
    
    HomePageSideButton *buoyButton = [[HomePageSideButton alloc]init];
    buoyButton.titleImage = [UIImage imageNamed:@"buoy"];
    buoyButton.lableText = @"漂流圈";
    buoyButton.badgeNumber = 10;
    [self.view addSubview:buoyButton];
    buoyButton.clickBlock = ^(){
        FBLevelUpViewController *levelUpVC = [FBLevelUpViewController new];
        [self presentViewController:levelUpVC animated:YES completion:nil];
    };
    
    HomePageSideButton *nearByShopButton = [[HomePageSideButton alloc]init];
    nearByShopButton.titleImage = [UIImage imageNamed:@"shop"];
    nearByShopButton.lableText = @"离我最近";
    [self.view addSubview:nearByShopButton];
    nearByShopButton.clickBlock = ^(){
        FBNearByShopViewController *vc = [FBNearByShopViewController new];
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    HomePageSideButton *scanQRCodeButton = [[HomePageSideButton alloc]init];
    scanQRCodeButton.titleImage = [UIImage imageNamed:@"scanQR"];
    scanQRCodeButton.lableText = @"扫一扫";
    [self.view addSubview:scanQRCodeButton];
    
    HomePageSideButton *myQRCodeButton = [[HomePageSideButton alloc]init];
    myQRCodeButton.titleImage = [UIImage imageNamed:@"QR"];
    myQRCodeButton.lableText = @"二维码";
    [self.view addSubview:myQRCodeButton];
    myQRCodeButton.clickBlock = ^(){
        FBMyQRCodeViewController *vc = [FBMyQRCodeViewController new];
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    //根据屏幕尺寸适配按钮布局
    switch (layoutType) {
        case 1:
            myBoxButton.frame = CGRectMake(8, 35, 34, 46);
            buoyButton.frame = CGRectMake(8, 89, 34, 46);
            nearByShopButton.frame = CGRectMake(8, 143, 34, 46);
            scanQRCodeButton.frame = CGRectMake(8, 197, 34, 46);
            myQRCodeButton.frame = CGRectMake(8, 251, 34, 46);
            break;
        case 3:
            myBoxButton.frame = CGRectMake(15, 35, 40, 54);
            buoyButton.frame = CGRectMake(15, 100, 40, 54);
            nearByShopButton.frame = CGRectMake(15, 165, 40, 54);
            scanQRCodeButton.frame = CGRectMake(15, 230, 40, 54);
            myQRCodeButton.frame = CGRectMake(15, 295, 40, 54);
            break;
        default:
            myBoxButton.frame = CGRectMake(10, 35, 40, 54);
            buoyButton.frame = CGRectMake(10, 100, 40, 54);
            nearByShopButton.frame = CGRectMake(10, 165, 40, 54);
            scanQRCodeButton.frame = CGRectMake(10, 230, 40, 54);
            myQRCodeButton.frame = CGRectMake(10, 295, 40, 54);
            
            break;
    }
    
    
    
    UIImageView *wave1= [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"home wave3"] resizableImageWithCapInsets:UIEdgeInsetsMake(35, 0.5, 0.5, 0.5) resizingMode:(UIImageResizingModeTile)]];
    wave1.frame = CGRectMake(0, kScreenHeight - 105, kScreenWidth, 105);
    [self.view addSubview:wave1];
    
    UIImageView *boat = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"boat"]];
    boat.frame = CGRectMake(20, kScreenHeight - 100, 105, 70);
    if (layoutType == 1) {
        boat.frame = CGRectMake(15, kScreenHeight -  90, 90, 60);
    }
    [self.view addSubview:boat];
    
    UIImageView *wave2= [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"home wave2"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 0.5, 0.5, 0.5) resizingMode:(UIImageResizingModeTile)]];
    wave2.frame = CGRectMake(0, kScreenHeight - 57, kScreenWidth, 57);
    [self.view addSubview:wave2];
    
    
    UIImageView *quant = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quant"]];
    quant.frame = CGRectMake(20, kScreenHeight - 100, 105, 70);
    if (layoutType == 1) {
        boat.frame = CGRectMake(15, kScreenHeight -  90, 90, 60);
    }
    [self.view addSubview:quant];
    
    UIImageView *wave3= [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"home wave1"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 0.5, 0.5, 0.5) resizingMode:(UIImageResizingModeTile)]];
    wave3.frame = CGRectMake(-14, kScreenHeight - 55, kScreenWidth, 55);
    [self.view addSubview:wave3];
    
    
    

    
    
    
    
    //创建我的岛屿视图,并适配不同屏幕
    HomePageMyIslandView * view = [[HomePageMyIslandView alloc]init];
    if (layoutType == 1) {
        
        view.frame = CGRectMake(kScreenWidth - 196, kScreenHeight - 153 , 196, 153);
        view.coinAndRankLableFont = [UIFont systemFontOfSize:16];
        view.nickNameFont = [UIFont systemFontOfSize:12];
    }
    else
    {
        view.frame = CGRectMake(kScreenWidth - 230, kScreenHeight - 180 , 230, 180);
    }
    view.messageNumber = 9;
    view.rank = 120;
    view.coinNumber = 1233;
    view.level = 10;
#pragma mark - TODO:我的岛按钮的回调
    view.messageButtonBlock = ^(){
        LoginViewController *loginView = [[LoginViewController alloc]init];
        [weakSelf presentViewController:loginView animated:YES completion:nil];
    };
    view.signUpButtonBlock = ^(){
        FBSignUpCameraViewController *cameraViewVC = [FBSignUpCameraViewController new];
        [weakSelf presentViewController:cameraViewVC animated:YES completion:nil];
        
    };
    [self.view addSubview:view];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
