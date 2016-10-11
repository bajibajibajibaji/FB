//
//  FBLevelUpView.m
//  mask
//
//  Created by 朱志先 on 16/7/22.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBLevelUpView.h"
@interface FBLevelUpView()
@property (nonatomic, strong) UIImageView *backbroundImage;
@property (nonatomic, strong) UIView *maskedView;
@property (nonatomic, strong) UIImageView *levelEmblem;
@property (nonatomic, strong) UILabel *LevelLable;
@property (nonatomic, strong) UILabel *levelUpLable;
@property (nonatomic, strong) UILabel *levelDetailLable;
@property (nonatomic, strong) UILabel *gifLabel;
@property (nonatomic, strong) UIImageView *levelUpEmblem;
@property (nonatomic, strong) UIScrollView * scollView;
@property (nonatomic, strong) NSMutableArray<FBLevelUpPrizeView *> *prizeViewArray;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CALayer *visualShapeLayer;
@property (nonatomic, assign) BOOL isInAnimation;
@end
@implementation FBLevelUpView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isInAnimation = NO;
        
        self.backbroundImage = [UIImageView new];
        self.backbroundImage.image = kGetImage(@"up background.png");
        self.backbroundImage.layer.contentsCenter = CGRectMake(0, 22.5/400, 1, 345.0/400);
        [self addSubview:self.backbroundImage];
        
        self.maskView = [UIView new];
        [self addSubview:self.maskView];
        
        self.maskLayer = [CALayer layer];
        self.maskView.layer.mask = self.maskLayer;
        
        self.visualShapeLayer = [CALayer layer];
        self.visualShapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
        [self.maskLayer addSublayer:self.visualShapeLayer];
        
        self.levelEmblem = [UIImageView new];
        self.levelEmblem.image = kGetImage(@"up badge.png");
        [self.maskView addSubview:self.levelEmblem];
        
        self.LevelLable = [UILabel new];
        self.LevelLable.numberOfLines = 0;
       // self.LevelLable.backgroundColor = [UIColor whiteColor];
        self.LevelLable.adjustsFontSizeToFitWidth = YES;
        self.LevelLable.textColor = [UIColor UIColorFromHex:0xE83C3C andAlpha:1];
        self.LevelLable.textAlignment = NSTextAlignmentCenter;
        [self.maskView addSubview:self.LevelLable];
        
        self.levelUpLable = [UILabel new];
        self.levelUpLable.textColor = [UIColor whiteColor];
        self.levelUpLable.textAlignment = NSTextAlignmentCenter;
        [self.maskView addSubview:self.levelUpLable];
        
        self.levelDetailLable = [UILabel new];
        self.levelDetailLable.textColor = [UIColor whiteColor];
        self.levelDetailLable.textAlignment = NSTextAlignmentCenter;
        [self.maskView addSubview:self.levelDetailLable];
        
        self.gifLabel = [UILabel new];
        self.gifLabel.textAlignment = NSTextAlignmentLeft;
        self.gifLabel.textColor = [UIColor whiteColor];
        [self.maskView addSubview:self.gifLabel];
        
        self.levelUpEmblem = [UIImageView new];
        self.levelUpEmblem.image = kGetImage(@"up.png");
        [self.maskView addSubview:self.levelUpEmblem];
        
        self.scollView = [UIScrollView new];
        self.scollView.showsVerticalScrollIndicator = NO;
        self.scollView.showsHorizontalScrollIndicator = NO;
        [self.maskView addSubview:self.scollView];
        
        self.prizeViewArray = [NSMutableArray array];
        
        self.levelUpLable.text = @"LV  4 > 5";
        self.LevelLable.text = @"50";
        self.levelDetailLable.text = @"距离下一等级666经验";
        self.gifLabel.text = @"获得奖励";
    }
    return self;
}

- (void)layoutSubviews
{
    if (!_isInAnimation) {
        
        CGFloat widthRatio = self.bounds.size.width / 750;
        CGFloat heightRatio = self.bounds.size.height / 1200;
        
        self.maskView.frame = self.bounds;
        
        self.backbroundImage.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 45 / 400);
        self.backbroundImage.center = self.maskView.center;
        
        self.maskLayer.frame = self.maskView.bounds;
        
        self.visualShapeLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, 0);
        self.visualShapeLayer.position = self.maskLayer.position;
        
        self.levelEmblem.frame = CGRectMake(168 * widthRatio, 108 * heightRatio, 414 * widthRatio, 384 * heightRatio);
        
        self.LevelLable.bounds = CGRectMake(0, 0, 190 * heightRatio, 170 * heightRatio);
        self.LevelLable.center = CGPointMake(self.levelEmblem.center.x, 356 * heightRatio);
        self.LevelLable.font = [UIFont fontWithName:@"Avenir-Black" size:self.LevelLable.bounds.size.height * 1.2];
        
        self.levelUpLable.frame = CGRectMake(0, 506 * heightRatio, self.bounds.size.width, 55 * heightRatio);
        self.levelUpLable.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:self.levelUpLable.bounds.size.height * 0.9];
        
        self.levelDetailLable.frame = CGRectMake(0, 566 * heightRatio, self.bounds.size.width, 45 * heightRatio);
        self.levelDetailLable.font = [UIFont systemFontOfSize:self.levelDetailLable.bounds.size.height * 0.82];
        
        self.levelUpEmblem.frame = CGRectMake(0, 618 * heightRatio, self.bounds.size.width, 150 * heightRatio);
        
        self.gifLabel.frame = CGRectMake(78 * widthRatio, 810 *heightRatio, 300 * widthRatio, 55 * heightRatio);
        self.gifLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:self.gifLabel.bounds.size.height * 0.8];
        
        self.scollView.frame = CGRectMake(390 * widthRatio, 807 * heightRatio, 280 * widthRatio, 255 * heightRatio);
        
        if (self.prizeViewArray.count > 0) {
            [self setPrizeViewsLayout];
        }
    }

}

- (void)setPrizeArray:(NSArray<FBLevelUpPrizeModel *> *)prizeArray
{
    _prizeArray = prizeArray;
    for (int i = 0; i < prizeArray.count; i++) {
        FBLevelUpPrizeModel *prize = prizeArray[i];
        FBLevelUpPrizeView *prizeView = [FBLevelUpPrizeView new];
        prizeView.prizeImage = prize.prizeImage;
        prizeView.prizeNumberl = prize.prizeNumber;
        [self.prizeViewArray addObject:prizeView];
        [self.scollView addSubview:prizeView];
    }
    if (prizeArray.count > 0) {
        [self setPrizeViewsLayout];
    }
    
}

- (void)setPrizeViewsLayout
{
    unsigned long count = self.prizeViewArray.count;
    CGFloat height = self.scollView.bounds.size.height;
    CGFloat width = self.scollView.bounds.size.width;
    for (int i = 0; i < count; i++) {
        FBLevelUpPrizeView *prizeView = self.prizeViewArray[i];
        prizeView.frame = CGRectMake(0, 147 / 255.0 * i * height, width, 108 / 255.0 * height);
    }
    self.scollView.contentSize = CGSizeMake(width, count * 108 / 255.0 * height + (count -1) * 39 / 255.0 * height);
}

- (void)startAnimation
{
    self.isInAnimation = YES;
    CGRect fromBounds = CGRectMake(0, 0, self.bounds.size.width, 0);
    CGRect toBounds = CGRectMake(0, 0, self.bounds.size.width, 355);
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"bounds"];
    aniamtion.fromValue = [NSValue valueWithCGRect:fromBounds];
    aniamtion.toValue = [NSValue valueWithCGRect:toBounds];
    aniamtion.duration = 0.3;
    aniamtion.removedOnCompletion = NO;
    aniamtion.fillMode = kCAFillModeForwards;
    aniamtion.repeatCount = 1;
    aniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.visualShapeLayer addAnimation:aniamtion forKey:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backbroundImage.bounds = self.bounds;
    } completion:^(BOOL finished) {
        self.isInAnimation = NO;
        self.visualShapeLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, 355);
    }];
    

}


@end
@interface FBLevelUpPrizeView()
@property (nonatomic, strong) UIImageView *prizeImageView;
@property (nonatomic, strong) UILabel *plusLabel;
@property (nonatomic, strong) UILabel *prizeNumberLabel;

@end


@implementation FBLevelUpPrizeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.prizeImageView = [UIImageView new];
        [self addSubview:self.prizeImageView];
        
        self.plusLabel = [UILabel new];
        self.plusLabel.textColor = [UIColor whiteColor];
        self.plusLabel.adjustsFontSizeToFitWidth = YES;
        self.plusLabel.numberOfLines = 0;
        self.plusLabel.text = @"+";
        self.plusLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.plusLabel];
        
        self.prizeNumberLabel = [UILabel new];
        self.prizeNumberLabel.textColor = [UIColor whiteColor];
        self.prizeNumberLabel.numberOfLines = 0;
        self.prizeNumberLabel.adjustsFontSizeToFitWidth = YES;
        self.prizeNumberLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.prizeNumberLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    self.prizeImageView.frame = CGRectMake(0, 0, height, height);
    self.plusLabel.frame = CGRectMake(height, 0, 0.5 * height, height);
    self.prizeNumberLabel.frame = CGRectMake(height * 1.5, 0, width - height * 1.5, height);
}

- (void)setPrizeNumberl:(NSInteger)prizeNumberl
{
    _prizeNumberl = prizeNumberl;
    self.prizeNumberLabel.text = [NSString stringWithFormat:@"%ld",prizeNumberl];
}

- (void)setPrizeImage:(UIImage *)prizeImage
{
    _prizeImage = prizeImage;
    self.prizeImageView.image = prizeImage;
}

@end


@implementation FBLevelUpPrizeModel



@end
