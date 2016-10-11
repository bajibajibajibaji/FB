//
//  ZXAnimationImageView.h
//  ZZXRollingNumberView
//
//  Created by 朱志先 on 16/6/12.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXAnimationImageViewAnimationType) {
    ZXAnimationImageViewAnimationTypeLinear,
    ZXAnimationImageViewAnimationTypeRotation,
};


@interface ZXAnimationImageView : UIImageView
@property (nonatomic ,assign) CGPoint rotaionCenter;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;
@property (nonatomic ,assign) ZXAnimationImageViewAnimationType animationType;

- (void)stopAnimation;
- (void)startRepeatRotationAnimationDuration:(CFTimeInterval)duration Delay:(CFTimeInterval)delay Angel:(CGFloat)angel RotationCenter:(CGPoint)rotationCenter;
- (void)startLinearAnimatonWithStartPoint:(CGPoint)startPoint AndEndPoint:(CGPoint)endPoint IsBounce:(BOOL)isBounce duration:(CGFloat)duration delay:(CGFloat)delay;

- (void)startBounceAnimationDuration:(CFTimeInterval)duration firstStepHeightRatio:(CGFloat)heightRatio secondStepWidthRatio:(CGFloat)widthRatio;
- (void)startChangeAlpha;
@end
