//
//  IsLandView.m
//  mainLand
//
//  Created by 朱志先 on 16/6/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "IsLandView.h"
#import "ZXAnimationImageView.h"
#import "ZXRollingNumberView.h"
#import "UIView+AddGesture.h"
@interface IsLandView()
@property (nonatomic, strong) NSMutableArray<ZXAnimationImageView *> *animateImagaArray;
@end

@implementation IsLandView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (NSMutableArray<ZXAnimationImageView *> *)animateImagaArray
{
    if (!_animateImagaArray) {
        _animateImagaArray = [NSMutableArray array];
    }
    return _animateImagaArray;
}


- (void)setItem:(IsLandItem *)item
{
    _item = item;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (item) {
        NSInteger isLandType = item.islandDistance/500;
        switch (isLandType) {
            case 1:
                [self set500mIsland];
                break;
                
            case 2:
                [self set1000mIsland];
                break;
                
            case 4:
                [self set2000mIsland];
                break;
                
            case 10:
                [self set5000mIsland];
                break;
                
            case 11:
                [self set5500mIsland];
                break;
                
            default:
                break;
        }
    }
}

- (void)set500mIsland
{
    
    [self creatRegularImageViewWithImageName:@"500wood"];
    [self creatRegularImageViewWithImageName:@"500island"];
    [self creatDistanceImageViewViewWithImageName:@"500distance"];
    
    for (int i = 1; i <= 5; i++) {
        ZXAnimationImageView *leafView = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"500leaf%d",i]]];        
        [self addSubview:leafView];
        [self.animateImagaArray addObject:leafView];

        leafView.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);

        CGFloat delay = (arc4random()%5)/15.0;
        CGFloat angel = M_PI/(arc4random()%5+28);
        [leafView startRepeatRotationAnimationDuration:2 Delay:delay Angel:angel RotationCenter:CGPointMake(0.35 * CGRectGetWidth(self.frame), 0.25 * CGRectGetHeight(self.frame))];
        
    }

    [self creatCountingPlateImageView];

    
    
    
    
}

- (void)set1000mIsland
{
    for (int i = 1; i <= 2; i++) {
            ZXAnimationImageView *ballon = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"1000ballon%d",i]]];
        
        ballon.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameWidth(self));
        [self addSubview:ballon];
        [self.animateImagaArray addObject:ballon];
        if (i == 1) {
            [ballon startLinearAnimatonWithStartPoint:CGPointMake(0, -20) AndEndPoint:CGPointMake( 10, 0) IsBounce:YES duration:(CGFloat)7 delay:(CGFloat)0.1];
        }
        else
        {
           [ballon startLinearAnimatonWithStartPoint:CGPointMake(-20, -10) AndEndPoint:CGPointMake( -10, 4) IsBounce:YES duration:(CGFloat)6 delay:(CGFloat)0.1];
        }

    }

    [self creatRegularImageViewWithImageName:@"1000island"];
    [self creatRegularImageViewWithImageName:@"1000umbrella"];
    [self creatDistanceImageViewViewWithImageName:@"1000distance"];
    [self creatCountingPlateImageView];
}

- (void)set2000mIsland
{
    [self creatRegularImageViewWithImageName:@"2000island"];
    [self creatDistanceImageViewViewWithImageName:@"2000distance"];
    for (int i = 1; i <= 3; i++) {
        ZXAnimationImageView *bird = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"2000bird%d",i]]];
        bird.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameHeight(self));
        [self addSubview:bird];
        [self.animateImagaArray addObject:bird];
        switch (i) {
            case 1:
                [bird startLinearAnimatonWithStartPoint:CGPointMake(-10, 0) AndEndPoint:CGPointMake(20, 0) IsBounce:YES duration:(CGFloat)4 delay:(CGFloat)0.2];
                break;
            case 2:
                [bird startLinearAnimatonWithStartPoint:CGPointMake(10, -20) AndEndPoint:CGPointMake(30, -15) IsBounce:YES duration:(CGFloat)6 delay:(CGFloat)0.7];
                break;
            case 3:
                [bird startLinearAnimatonWithStartPoint:CGPointMake(0, -10) AndEndPoint:CGPointMake(20, 0) IsBounce:YES duration:(CGFloat)5 delay:(CGFloat)0.4];
                break;
                
            default:
                break;
        }
        
        
    };

    [self creatCountingPlateImageView];
}

- (void)set5000mIsland
{
 
    [self creatRegularImageViewWithImageName:@"5000island"];
    [self creatDistanceImageViewViewWithImageName:@"5000distance"];
    
    for (int i = 1; i <= 3; i++) {
        [self creatRegularImageViewWithImageName:[NSString stringWithFormat:@"5000flower%d",i]];
    }
    
    [self creatCountingPlateImageView];
    
    ZXAnimationImageView *light = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:@"5000light"]];
    light.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameHeight(self));
    [light startChangeAlpha];
    [self.animateImagaArray addObject:light];
    [self addSubview:light];
}

- (void)set5500mIsland
{
    
    [self creatRegularImageViewWithImageName:@"5500island"];
    [self creatDistanceImageViewViewWithImageName:@"5500distance"];

    for (int i = 1; i <= 3; i++) {
        ZXAnimationImageView *cloud = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"5500clould%d",i]]];
        cloud.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameHeight(self));
        [self addSubview:cloud];
        [self.animateImagaArray addObject:cloud];
        switch (i) {
            case 1:
                [cloud startLinearAnimatonWithStartPoint:CGPointMake(-30, 0) AndEndPoint:CGPointMake(20, 0) IsBounce:NO duration:(CGFloat)10 delay:(CGFloat)0.1];
                
                break;
            case 2:
                [cloud startLinearAnimatonWithStartPoint:CGPointMake(35, 0) AndEndPoint:CGPointMake(-20, 0) IsBounce:NO duration:(CGFloat)13 delay:(CGFloat)0.3];
                
                break;
            case 3:
                [cloud startLinearAnimatonWithStartPoint:CGPointMake(-25, 0) AndEndPoint:CGPointMake(20, 0) IsBounce:NO duration:(CGFloat)9 delay:(CGFloat)0.5];
                break;
                
            default:
                break;
        }
    };

    [self creatRegularImageViewWithImageName:@"5500Grass1"];
    [self creatRegularImageViewWithImageName:@"5500Grass2"];

    [self creatCountingPlateImageView];
}






- (void)creatRegularImageViewWithImageName:(NSString*)imageName
{
    UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imv.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameHeight(self));
    [self addSubview:imv];
}

- (void)creatDistanceImageViewViewWithImageName:(NSString*)imageName
{
    ZXAnimationImageView *imv = [[ZXAnimationImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imv.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameHeight(self));
    [self addSubview:imv];
    [imv startBounceAnimationDuration:0.6 firstStepHeightRatio:1.06 secondStepWidthRatio:1.06];
    [self addSubview:imv];
    [self.animateImagaArray addObject:imv];

}

- (void)creatCountingPlateImageView
{
    UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"board"]];
    imv.frame = CGRectMake(0, 0, kGetFrameWidth(self), kGetFrameHeight(self));
    
    ZXRollingNumberView *numberView = [[ZXRollingNumberView alloc]init];
    numberView.value = [NSNumber numberWithInteger:self.item.toyNumber];
    
    numberView.frame = CGRectMake(kGetFrameWidth(self) * 0.25, kGetFrameHeight(self) * 0.725, kGetFrameWidth(self) * 0.3, kGetFrameHeight(self) * 0.1);
    numberView.textColor = [UIColor colorWithRed:110/256.0 green:64/256.0 blue:28/256.0 alpha:1];
    numberView.minLength = 4;
    numberView.font = [UIFont systemFontOfSize:0.1 * kGetFrameHeight(self) weight:8];
    [imv addSubview:numberView];
    [numberView startAnimation];
    
    [self addSubview:imv];
}

- (void)stopAnimate
{
    
}

- (void)startAnimate
{
    
}
@end
