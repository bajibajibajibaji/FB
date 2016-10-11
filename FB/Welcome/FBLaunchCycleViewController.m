//
//  FBLaunchCycleViewController.m
//  AdCircle
//
//  Created by cc on 16/7/1.
//  Copyright © 2016年 toyscloud. All rights reserved.
//

#import "FBLaunchCycleViewController.h"
#import "HomePageViewController.h"
#import "FBAdCircleView.h"
#import "constant.h"

@interface FBLaunchCycleViewController () <FBAdCircleViewDelegate>

@property (strong, nonatomic) FBAdCircleView *adCircleView;

// 1
@property (strong, nonatomic) CALayer *layer_laozi;
@property (strong, nonatomic) CALayer *layer_pingzilaozi;

@property (strong, nonatomic) CAAnimationGroup *laozi_animGroup;
@property (strong, nonatomic) CAAnimationGroup *laopingzi_animGroup;

// 2
@property (strong, nonatomic) UIImageView *iv_arrow1;
@property (strong, nonatomic) UIImageView *iv_arrow2;
@property (strong, nonatomic) NSMutableArray<CALayer *> *boatLays;
@property (strong, nonatomic) NSMutableArray<CALayer *> *boat2Lays;

@property (strong, nonatomic) CABasicAnimation *arrow_anim;
@property (strong, nonatomic) CABasicAnimation *arrow2_anim;
@property (strong, nonatomic) CAAnimationGroup *animOpacity_group;
@property (strong, nonatomic) CAAnimationGroup *animOpacity2_group;

// 3
@property (strong, nonatomic) UIImageView *iv_hook1;
@property (strong, nonatomic) UIImageView *iv_hook2;
@property (strong, nonatomic) UIImageView *iv_hook3;

@property (strong, nonatomic) CAAnimationGroup *hook_animGroup;
@property (strong, nonatomic) CAAnimationGroup *hook2_animGroup;
@property (strong, nonatomic) CAAnimationGroup *hook3_animGroup;


@end

@implementation FBLaunchCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self launchInit];
}

- (void)launchInit
{
    self.adCircleView = [[FBAdCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.adCircleView];
    
    UIView *adView0 = [self launchViewAnimal0];
    UIView *adView1 = [self launchViewAnimal1];
    UIView *adView2 = [self launchViewAnimal2];
    UIView *adView3 = [self launchViewAnimal3];
    
    self.adCircleView.adViews = @[adView0, adView1, adView2, adView3];
    
    self.adCircleView.pageImages = @[imageOfAutoScaleImage(@"kai2.png"),
                                     imageOfAutoScaleImage(@"xin2.png"),
                                     imageOfAutoScaleImage(@"qu2.png"),
                                     imageOfAutoScaleImage(@"wan2.png")];
    
    self.adCircleView.currentPageImages = @[imageOfAutoScaleImage(@"kai1.png"),
                                            imageOfAutoScaleImage(@"xin1.png"),
                                            imageOfAutoScaleImage(@"qu1.png"),
                                            imageOfAutoScaleImage(@"wan1.png")];
    
    self.adCircleView.pageControlCenter = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-45*RATIO);
    self.adCircleView.pageControlBounds = CGRectMake(0, 0, SCREEN_WIDTH, 71*RATIO);
    self.adCircleView.pageControlIndicatorMargin = 18;
    
    self.adCircleView.delegate = self;
    

}


- (void)doSomeThingWhileEndDecelerating:(NSInteger)index
{
    if (index == 0) {
        [self removeAnimal:1];
        [self removeAnimal:2];
        [self removeAnimal:3];
    } else if (index == 1) {
        [self addAnimal:   1];
        [self removeAnimal:2];
        [self removeAnimal:3];
    } else if (index == 2) {
        [self addAnimal:   2];
        [self removeAnimal:1];
        [self removeAnimal:3];
    } else if (index == 3) {
        [self addAnimal:   3];
        [self removeAnimal:1];
        [self removeAnimal:2];
    }
}

- (void)addAnimal:(NSInteger)index
{
    if (index == 1) {
        [self.layer_laozi       addAnimation: self.laozi_animGroup          forKey:@"layer_laozi"];
        [self.layer_pingzilaozi addAnimation: self.laopingzi_animGroup      forKey:@"layer_pingzilaozi"];
    } else if (index == 2) {
        [self.iv_arrow1.layer   addAnimation: self.arrow_anim               forKey:@"iv_arrow1"];
        [self.iv_arrow2.layer   addAnimation: self.arrow2_anim              forKey:@"iv_arrow2"];
        [self.boatLays[0]       addAnimation: self.animOpacity_group        forKey:@"boatlays0"];
        [self.boatLays[1]       addAnimation:[self.animOpacity_group copy]  forKey:@"boatlays1"];
        [self.boat2Lays[0]      addAnimation: self.animOpacity2_group       forKey:@"boat2lays0"];
        [self.boat2Lays[1]      addAnimation:[self.animOpacity2_group copy] forKey:@"boat2lays1"];
    } else if (index == 3) {
        [self.iv_hook1.layer    addAnimation: self.hook_animGroup           forKey:@"iv_hook1"];
        [self.iv_hook2.layer    addAnimation: self.hook2_animGroup          forKey:@"iv_hook2"];
        [self.iv_hook3.layer    addAnimation: self.hook3_animGroup          forKey:@"iv_hook3"];
    }
}

- (void)removeAnimal:(NSInteger)index
{
    if (index == 1) {
        [self.layer_laozi       removeAnimationForKey:@"layer_laozi"];
        [self.layer_pingzilaozi removeAnimationForKey:@"layer_pingzilaozi"];
    } else if (index == 2) {
        [self.iv_arrow1.layer   removeAnimationForKey:@"iv_arrow1"];
        [self.iv_arrow2.layer   removeAnimationForKey:@"iv_arrow2"];
        [self.boatLays[0]       removeAnimationForKey:@"boatlays0"];
        [self.boatLays[1]       removeAnimationForKey:@"boatlays1"];
        [self.boat2Lays[0]      removeAnimationForKey:@"boat2lays0"];
        [self.boat2Lays[1]      removeAnimationForKey:@"boat2lays1"];
    } else if (index == 3) {
        [self.iv_hook1.layer    removeAnimationForKey:@"iv_hook1"];
        [self.iv_hook2.layer    removeAnimationForKey:@"iv_hook2"];
        [self.iv_hook3.layer    removeAnimationForKey:@"iv_hook3"];
    }
}

- (void)pressSkipButton
{
    NSLog(@"skip button");
    HomePageViewController *vc = [HomePageViewController new];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)pressStartButton
{
    NSLog(@"start button");
    HomePageViewController *vc = [HomePageViewController new];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (UIView *)launchViewAnimal0
{
    UIView *view = [[UIView alloc] init];
    
    
    UIImageView *iv_background2 = imageViewOfAutoScaleImage(@"wel_background4.png");
    iv_background2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [view addSubview:iv_background2];
    
    
    UIButton *button_skip = [[UIButton alloc] init];
    button_skip.frame = CGRectMake(346*RATIO, 25*RATIO, 43*RATIO, 43*RATIO);
    [button_skip setBackgroundImage:imageOfAutoScaleImage(@"skip.png") forState:UIControlStateNormal];
    [button_skip addTarget:self action:@selector(pressSkipButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_skip];
    
    UIImageView *iv_sun = imageViewOfAutoScaleImage(@"sun.png");
    iv_sun.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = iv_sun.center;
        center.y -= 40;
        iv_sun.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        iv_sun.center = center;
    }
    [view addSubview:iv_sun];
    
    NSMutableArray <CALayer *> *waveLays = [NSMutableArray arrayWithCapacity:12];
    NSMutableArray <CALayer *> *bottleLays = [NSMutableArray arrayWithCapacity:5];
    for (int i = 12; i >= 1; --i) { // 12层波浪
        CALayer *layer_wave = [[CALayer alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"wave%d.png", i];
        layer_wave.contents = (__bridge id)imageOfAutoScaleImage(imgName).CGImage;
        layer_wave.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
        
        [view.layer addSublayer:layer_wave];
        
        [waveLays addObject:layer_wave];
        
        
        if (i == 12 || i == 10 || i == 7 || i == 5 || i == 3) { // 5各瓶子
            NSString *bottleImgName = nil;
            
            if (i == 12) {
                bottleImgName = @"bottle5.png";
            } else if (i == 10) {
                bottleImgName = @"bottle4.png";
            } else if (i == 7) {
                bottleImgName = @"bottle2.png";
            } else if (i == 5) {
                bottleImgName = @"bottle1.png";
            } else if (i == 3) {
                bottleImgName = @"bottle3.png";
            }
            
            CALayer *layer_bottle = [[CALayer alloc] init];
            layer_bottle.contents = (__bridge id)imageOfAutoScaleImage(bottleImgName).CGImage;
            layer_bottle.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
            if (i == 3) {
                layer_bottle.frame = CGRectMake((43+6)*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
            }
            [view.layer addSublayer:layer_bottle];
            
            [bottleLays addObject:layer_bottle];
        }
    }
    
    if (IS_IPHONE_4_OR_LESS) { //iphone4,3gs调整
        for (CALayer *layer in waveLays) {
            CGPoint layPos = layer.position;
            layPos.y -= 40;
            layer.bounds = CGRectMake(0, 0, 337*RATIO*0.9, 337*RATIO*0.9);
            layer.position = layPos;
        }
        
        for (CALayer *layer in bottleLays) {
            CGPoint layPos = layer.position;
            layPos.y -= 40;
            layer.bounds = CGRectMake(0, 0, 337*RATIO*0.9, 337*RATIO*0.9);
            layer.position = layPos;
        }
    }
    
    // animaling
    for (int i = 0; i < bottleLays.count; ++i) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
        anim.duration = 1.3;
        anim.beginTime = CACurrentMediaTime() + 0.4 * i;
        anim.repeatCount = CGFLOAT_MAX;
        anim.autoreverses = YES;
        anim.toValue = [NSNumber numberWithFloat:bottleLays[i].position.y + 2.5*(i+1)];
        if (i == 4) {
            anim.toValue = [NSNumber numberWithFloat:bottleLays[4].position.y + 5];
        }
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        
        
        [bottleLays[i] addAnimation:anim forKey:nil];
    }
    
    return view;
}

- (UIView *)launchViewAnimal1
{
    UIView *view = [[UIView alloc] init];
    
    UIImageView *iv_background2 = imageViewOfAutoScaleImage(@"wel_background3.png");
    iv_background2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [view addSubview:iv_background2];
    
    UIButton *button_skip = [[UIButton alloc] init];
    button_skip.frame = CGRectMake(346*RATIO, 25*RATIO, 43*RATIO, 43*RATIO);
    [button_skip setBackgroundImage:imageOfAutoScaleImage(@"skip.png") forState:UIControlStateNormal];
    [button_skip addTarget:self action:@selector(pressSkipButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_skip];
    
    UIImageView *iv_sun = imageViewOfAutoScaleImage(@"sun.png");
    iv_sun.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = iv_sun.center;
        center.y -= 40;
        iv_sun.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        iv_sun.center = center;
    }
    [view addSubview:iv_sun];
    
    NSMutableArray <CALayer *> *waveLays = [NSMutableArray arrayWithCapacity:12];
    CALayer *roomLayer = nil;
    for (int i = 12; i >= 1; --i) { // 12层波浪
        CALayer *layer_wave = [[CALayer alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"wave%d.png", i];
        layer_wave.contents = (__bridge id)imageOfAutoScaleImage(imgName).CGImage;
        layer_wave.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
        
        [view.layer addSublayer:layer_wave];
        
        [waveLays addObject:layer_wave];
        
        if (i == 5) {
            CALayer *layer_room = [[CALayer alloc] init];
            layer_room.frame = CGRectMake(54*RATIO, (180.67-303)*RATIO, 303*RATIO, 303*2*RATIO);
            layer_room.cornerRadius = 303*RATIO/2;
            layer_room.masksToBounds = YES;
            
            [view.layer addSublayer:layer_room];
            roomLayer = layer_room;
        }
    }
    
    if (IS_IPHONE_4_OR_LESS) { //iphone4,3gs调整
        for (CALayer *layer in waveLays) {
            CGPoint layPos = layer.position;
            layPos.y -= 40;
            layer.bounds = CGRectMake(0, 0, 337*RATIO*0.9, 337*RATIO*0.9);
            layer.position = layPos;
        }
        
        CGPoint roomLayPos = roomLayer.position;
        roomLayPos.y -= 40;
        roomLayer.bounds = CGRectMake(0, 0, 303*RATIO*0.9, 303*2*RATIO*0.9);
        roomLayer.position = roomLayPos;
    }
    
    // 捞子
    self.layer_laozi = [[CALayer alloc] init];
    self.layer_laozi.contents = (__bridge id)imageOfAutoScaleImage(@"Scoop2.png").CGImage;
    self.layer_laozi.frame = CGRectMake(0, (120+303)*RATIO, 303*RATIO, 303*RATIO);
    [roomLayer addSublayer:self.layer_laozi];
    
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint pos = self.layer_laozi.position;
        pos.y -= 40;
        self.layer_laozi.bounds = CGRectMake(0, 0, 303*RATIO*0.9, 303*RATIO*0.9);
        self.layer_laozi.position = pos;
    }
    
    // 捞子和瓶子
    self.layer_pingzilaozi = [[CALayer alloc] init];
    self.layer_pingzilaozi.contents = (__bridge id)imageOfAutoScaleImage(@"Scoop1.png").CGImage;
    self.layer_pingzilaozi.frame = CGRectMake(0, (120+303)*RATIO, 303*RATIO, 303*RATIO);
    self.layer_pingzilaozi.opacity = 0;
    [roomLayer addSublayer:self.layer_pingzilaozi];
    
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint pos = self.layer_pingzilaozi.position;
        pos.y -= 40;
        self.layer_pingzilaozi.bounds = CGRectMake(0, 0, 303*RATIO*0.9, 303*RATIO*0.9);
        self.layer_pingzilaozi.position = pos;
    }
    
    // animaling
    CABasicAnimation *animLeft = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animLeft.duration = 0.25;
    animLeft.beginTime = 0;
    animLeft.autoreverses = YES;
    animLeft.toValue = [NSNumber numberWithFloat:self.layer_laozi.position.x - 20];
    animLeft.removedOnCompletion = NO;
    animLeft.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animRight.duration = 0.25;
    animRight.beginTime = 0.5;
    animRight.autoreverses = YES;
    animRight.toValue = [NSNumber numberWithFloat:self.layer_laozi.position.x + 20];
    animRight.removedOnCompletion = NO;
    animRight.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animLeft2 = [animLeft copy];
    animLeft2.beginTime = 1;
    
    CABasicAnimation *animUp = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animUp.duration = 1;
    animUp.beginTime = 1.5 + 0.15;
    animUp.autoreverses = NO;
    animUp.toValue = [NSNumber numberWithFloat:self.layer_laozi.position.y - 120 * RATIO];
    animUp.removedOnCompletion = NO;
    animUp.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animOpacity.duration = 0.001;
    animOpacity.beginTime = 1.25;
    animOpacity.autoreverses = NO;
    animOpacity.toValue = [NSNumber numberWithFloat:0];
    animOpacity.removedOnCompletion = NO;
    animOpacity.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animOpacity2 = [animOpacity copy];
    animOpacity2.toValue = [NSNumber numberWithFloat:1];
    
    self.laozi_animGroup = [CAAnimationGroup animation];
    self.laozi_animGroup.animations = @[animLeft, animRight, animLeft2, animUp, animOpacity];
    self.laozi_animGroup.beginTime = 0;
    self.laozi_animGroup.duration = 3.65;
    //    self.laozi_animGroup.repeatCount = CGFLOAT_MAX;
    self.laozi_animGroup.removedOnCompletion = NO;
    self.laozi_animGroup.fillMode = kCAFillModeForwards;
    self.laozi_animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    self.laopingzi_animGroup = [self.laozi_animGroup copy];
    self.laopingzi_animGroup.animations = @[animLeft, animRight, animLeft2, animUp, animOpacity2];
    
    return view;
}

- (UIView *)launchViewAnimal2
{
    UIView *view = [[UIView alloc] init];
    
    UIImageView *iv_background2 = imageViewOfAutoScaleImage(@"wel_background2.png");
    iv_background2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [view addSubview:iv_background2];
    
    UIButton *button_skip = [[UIButton alloc] init];
    button_skip.frame = CGRectMake(346*RATIO, 25*RATIO, 43*RATIO, 43*RATIO);
    [button_skip setBackgroundImage:imageOfAutoScaleImage(@"skip.png") forState:UIControlStateNormal];
    [button_skip addTarget:self action:@selector(pressSkipButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_skip];
    
    UIImageView *iv_sun = imageViewOfAutoScaleImage(@"sun.png");
    iv_sun.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = iv_sun.center;
        center.y -= 40;
        iv_sun.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        iv_sun.center = center;
    }
    [view addSubview:iv_sun];
    
    NSMutableArray<CALayer *> *waveLays = [NSMutableArray arrayWithCapacity:12];
    self.boatLays = [NSMutableArray arrayWithCapacity:2];
    self.boat2Lays = [NSMutableArray arrayWithCapacity:2];
    for (int i = 12; i >= 1; --i) { // 12层波浪
        CALayer *layer_wave = [[CALayer alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"wave%d.png", i];
        layer_wave.contents = (__bridge id)imageOfAutoScaleImage(imgName).CGImage;
        layer_wave.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
        
        [view.layer addSublayer:layer_wave];
        
        [waveLays addObject:layer_wave];
        
        if (i == 9) {
            CALayer *layer_boat = [[CALayer alloc] init];
            layer_boat.contents = (__bridge id)imageOfAutoScaleImage(@"ship2.png").CGImage;
            layer_boat.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
            [view.layer addSublayer:layer_boat];
            
            [self.boatLays addObject:layer_boat];
            
            CALayer *layer_boat2 = [[CALayer alloc] init];
            layer_boat2.contents = (__bridge id)imageOfAutoScaleImage(@"ship3.png").CGImage;
            layer_boat2.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
            layer_boat2.opacity = 0;
            [view.layer addSublayer:layer_boat2];
            
            [self.boat2Lays addObject:layer_boat2];
        } else if (i == 3) {
            CALayer *layer_boat = [[CALayer alloc] init];
            layer_boat.contents = (__bridge id)imageOfAutoScaleImage(@"ship6.png").CGImage;
            layer_boat.frame = CGRectMake((43+3.5)*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
            [view.layer addSublayer:layer_boat];
            
            [self.boatLays addObject:layer_boat];
            
            CALayer *layer_boat2 = [[CALayer alloc] init];
            layer_boat2.contents = (__bridge id)imageOfAutoScaleImage(@"ship5.png").CGImage;
            layer_boat2.frame = CGRectMake((43+3.5)*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
            layer_boat2.opacity = 0;
            [view.layer addSublayer:layer_boat2];
            
            [self.boat2Lays addObject:layer_boat2];
        }
    }
    
    if (IS_IPHONE_4_OR_LESS) { //iphone4,3gs调整
        for (CALayer *layer in waveLays) {
            CGPoint layPos = layer.position;
            layPos.y -= 40;
            layer.bounds = CGRectMake(0, 0, 337*RATIO*0.9, 337*RATIO*0.9);
            layer.position = layPos;
        }
        
        for (CALayer *layer in self.boatLays) {
            CGPoint layPos = layer.position;
            layPos.y -= 40;
            layer.bounds = CGRectMake(0, 0, 337*RATIO*0.9, 337*RATIO*0.9);
            layer.position = layPos;
        }
        
        for (CALayer *layer in self.boat2Lays) {
            CGPoint layPos = layer.position;
            layPos.y -= 40;
            layer.bounds = CGRectMake(0, 0, 337*RATIO*0.9, 337*RATIO*0.9);
            layer.position = layPos;
        }
    }
    
    // 箭头
    self.iv_arrow1 = imageViewOfAutoScaleImage(@"arrow1.png");
    self.iv_arrow1.center = CGPointMake(177*RATIO, 312*RATIO);
    [view addSubview:self.iv_arrow1];
    
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = self.iv_arrow1.center;
        center.x += 10;
        center.y -= 40;
        self.iv_arrow1.center = center;
    }
    
    self.iv_arrow2 = imageViewOfAutoScaleImage(@"arrow2.png");
    self.iv_arrow2.center = CGPointMake(237*RATIO, 325*RATIO);
    [view addSubview:self.iv_arrow2];
    
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = self.iv_arrow2.center;
        center.y -= 40;
        self.iv_arrow2.center = center;
    }
    
    // animaling
    // 船浮动
    for (int i = 0; i < 2; ++i) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
        anim.duration = 1.3;
        anim.beginTime = CACurrentMediaTime() + 0.5*i;
        anim.repeatCount = CGFLOAT_MAX;
        anim.autoreverses = YES;
        anim.toValue = [NSNumber numberWithFloat:self.boatLays[i].position.y + 3];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        
        [self.boatLays[i] addAnimation:anim forKey:nil];
        [self.boat2Lays[i] addAnimation:[anim copy] forKey:nil];
    }
    
    // 箭头动画
    self.arrow_anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    self.arrow_anim.duration = 1.0f;
    self.arrow_anim.beginTime = 0;
    self.arrow_anim.autoreverses = NO;
    self.arrow_anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(15*M_PI/180.0, 0, 0, 1)];
    self.arrow_anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(95*M_PI/180.0, 0, 0, 1)];
    self.arrow_anim.removedOnCompletion = NO;
    self.arrow_anim.fillMode = kCAFillModeForwards;
    
    self.arrow2_anim = [self.arrow_anim copy];
    self.arrow2_anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-15*M_PI/180.0, 0, 0, 1)];
    self.arrow2_anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(78*M_PI/180.0, 0, 0, 1)];
    
    
    // 船动画
    CABasicAnimation *animOpacity_pre = [CABasicAnimation animationWithKeyPath:@"transform"];
    animOpacity_pre.duration = 1;
    animOpacity_pre.beginTime = 0;
    animOpacity_pre.autoreverses = NO;
    animOpacity_pre.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    CABasicAnimation *animOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animOpacity.duration = 0.6;
    animOpacity.beginTime = 1;
    animOpacity.autoreverses = NO;
    animOpacity.toValue = [NSNumber numberWithFloat:0];
    
    CABasicAnimation *animOpacity2 = [animOpacity copy];
    animOpacity2.toValue = [NSNumber numberWithFloat:1];
    
    self.animOpacity_group = [CAAnimationGroup animation];
    self.animOpacity_group.animations = @[animOpacity_pre, animOpacity];
    self.animOpacity_group.beginTime = 0;
    self.animOpacity_group.duration = 1.6;
    self.animOpacity_group.removedOnCompletion = NO;
    self.animOpacity_group.fillMode = kCAFillModeForwards;
    self.animOpacity_group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    self.animOpacity2_group = [self.animOpacity_group copy];
    self.animOpacity2_group.animations = @[animOpacity_pre, animOpacity2];
    
    return view;
}

- (UIView *)launchViewAnimal3
{
    UIView *view = [[UIView alloc] init];
    
    UIImageView *iv_background2 = imageViewOfAutoScaleImage(@"wel_background5.png");
    iv_background2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [view addSubview:iv_background2];
    
    UIButton *button_skip = [[UIButton alloc] init];
    button_skip.frame = CGRectMake(346*RATIO, 25*RATIO, 43*RATIO, 43*RATIO);
    [button_skip setBackgroundImage:imageOfAutoScaleImage(@"skip.png") forState:UIControlStateNormal];
    [button_skip addTarget:self action:@selector(pressSkipButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_skip];
    
    /*
    UIImageView *iv_start = imageViewOfAutoScaleImage(@"start.png");
    iv_start.frame = CGRectMake(SCREEN_WIDTH/2 - 85*RATIO, SCREEN_HEIGHT - 112*RATIO, 170*RATIO, 41*RATIO);
    [view addSubview:iv_start];
     */
    UIButton *button_start = [[UIButton alloc] init];
    button_start.frame = CGRectMake(SCREEN_WIDTH/2 - 85*RATIO, SCREEN_HEIGHT - 112*RATIO, 170*RATIO, 41*RATIO);
    [button_start setBackgroundImage:imageOfAutoScaleImage(@"start.png") forState:UIControlStateNormal];
    [button_start addTarget:self action:@selector(pressStartButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_start];
    
    UIImageView *iv_sun = imageViewOfAutoScaleImage(@"sun.png");
    iv_sun.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = iv_sun.center;
        center.y -= 40;
        iv_sun.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        iv_sun.center = center;
    }
    [view addSubview:iv_sun];
    
    UIImageView *iv_islandBackground = imageViewOfAutoScaleImage(@"island background.png");
    iv_islandBackground.frame = CGRectMake(43*RATIO, 164*RATIO, 337*RATIO, 337*RATIO);
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = iv_islandBackground.center;
        center.y -= 40;
        iv_islandBackground.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        iv_islandBackground.center = center;
    }
    [view addSubview:iv_islandBackground];
    
    self.iv_hook1 = imageViewOfAutoScaleImage(@"Hook1.png");
    self.iv_hook1.layer.bounds = CGRectMake(0, 0, 337*RATIO, 337*RATIO);
    self.iv_hook1.layer.anchorPoint = CGPointMake(0.284, 0.530);
    self.iv_hook1.layer.position = CGPointMake(138.67*RATIO, 342.67*RATIO);
    self.iv_hook1.transform = CGAffineTransformMakeScale(0, 0);
    [view addSubview:self.iv_hook1];
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = self.iv_hook1.center;
        center.y -= 40;
        self.iv_hook1.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        self.iv_hook1.center = center;
    }
    
    self.iv_hook2 = imageViewOfAutoScaleImage(@"Hook2.png");
    self.iv_hook2.layer.bounds = CGRectMake(0, 0, 337*RATIO, 337*RATIO);
    self.iv_hook2.layer.anchorPoint = CGPointMake(0.765, 0.313);
    self.iv_hook2.layer.position = CGPointMake(300.67*RATIO, 269.33*RATIO);
    self.iv_hook2.transform = CGAffineTransformMakeScale(0, 0);
    [view addSubview:self.iv_hook2];
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = self.iv_hook2.center;
        center.x -= 20;
        center.y -= 40;
        self.iv_hook2.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        self.iv_hook2.center = center;
    }
    
    self.iv_hook3 = imageViewOfAutoScaleImage(@"Hook3.png");
    self.iv_hook3.layer.bounds = CGRectMake(0, 0, 337*RATIO, 337*RATIO);
    self.iv_hook3.layer.anchorPoint = CGPointMake(0.362, 0.119);
    self.iv_hook3.layer.position = CGPointMake(165*RATIO, 204*RATIO);
    self.iv_hook3.transform = CGAffineTransformMakeScale(0, 0);
    [view addSubview:self.iv_hook3];
    if (IS_IPHONE_4_OR_LESS) {
        CGPoint center = self.iv_hook3.center;
        center.y -= 30;
        self.iv_hook3.bounds = CGRectMake(0, 0, 337*RATIO *0.9, 337*RATIO*0.9);
        self.iv_hook3.center = center;
    }
    
    //animaling
    CGFloat oldY = self.iv_hook1.layer.position.y;
    CGFloat oldY2 = self.iv_hook2.layer.position.y;
    CGFloat oldY3 = self.iv_hook3.layer.position.y;
    
    // up
    CABasicAnimation *hookUp_anim= [CABasicAnimation animationWithKeyPath:@"position.y"];
    hookUp_anim.duration = 0.35;
    hookUp_anim.beginTime = 0;
    hookUp_anim.autoreverses = NO;
    hookUp_anim.fromValue = [NSNumber numberWithFloat:oldY + 100*RATIO];
    hookUp_anim.toValue = [NSNumber numberWithFloat:oldY - 20*RATIO];
    hookUp_anim.removedOnCompletion = NO;
    hookUp_anim.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *hookUp2_anim = [hookUp_anim copy];
    hookUp2_anim.beginTime = 0.6;
    hookUp2_anim.fromValue = [NSNumber numberWithFloat:oldY2 + 100*RATIO];
    hookUp2_anim.toValue = [NSNumber numberWithFloat:oldY2 - 20*RATIO];
    
    CABasicAnimation *hookUp3_anim = [hookUp_anim copy];
    hookUp3_anim.beginTime = 1.2;
    hookUp3_anim.fromValue = [NSNumber numberWithFloat:oldY3 + 100*RATIO];
    hookUp3_anim.toValue = [NSNumber numberWithFloat:oldY3 - 20*RATIO];
    
    // down
    CABasicAnimation *hookDown_anim = [hookUp_anim copy];
    hookDown_anim.duration = 0.1;
    hookDown_anim.beginTime = 0.35;
    hookDown_anim.autoreverses = NO;
    hookDown_anim.fromValue = [NSNumber numberWithFloat:oldY - 20*RATIO];
    hookDown_anim.toValue = [NSNumber numberWithFloat:oldY];
    hookDown_anim.removedOnCompletion = NO;
    hookDown_anim.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *hookDown2_anim = [hookDown_anim copy];
    hookDown2_anim.beginTime = 0.95;
    hookDown2_anim.fromValue = [NSNumber numberWithFloat:oldY2 - 20*RATIO];
    hookDown2_anim.toValue = [NSNumber numberWithFloat:oldY2];
    
    CABasicAnimation *hookDown3_anim = [hookDown_anim copy];
    hookDown3_anim.beginTime = 1.55;
    hookDown3_anim.fromValue = [NSNumber numberWithFloat:oldY3 - 20*RATIO];
    hookDown3_anim.toValue = [NSNumber numberWithFloat:oldY3];
    
    // scale
    CABasicAnimation *hookScale_anim= [CABasicAnimation animationWithKeyPath:@"transform"];
    hookScale_anim.duration = 0.45;
    hookScale_anim.beginTime = 0;
    hookScale_anim.autoreverses = NO;
    hookScale_anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    hookScale_anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    hookScale_anim.removedOnCompletion = NO;
    hookScale_anim.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *hookScale2_anim = [hookScale_anim copy];
    hookScale2_anim.beginTime = 0.6;
    
    CABasicAnimation *hookScale3_anim = [hookScale_anim copy];
    hookScale3_anim.beginTime = 1.2;
    
    self.hook_animGroup = [CAAnimationGroup animation];
    self.hook_animGroup.animations = @[hookUp_anim, hookDown_anim, hookScale_anim];
    self.hook_animGroup.beginTime = 0;
    self.hook_animGroup.duration = 0.45;
    self.hook_animGroup.removedOnCompletion = NO;
    self.hook_animGroup.fillMode = kCAFillModeForwards;
    self.hook_animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    self.hook2_animGroup = [self.hook_animGroup copy];
    self.hook2_animGroup.animations = @[hookUp2_anim, hookDown2_anim, hookScale2_anim];
    self.hook2_animGroup.beginTime = 0;
    self.hook2_animGroup.duration = 1.05;
    
    self.hook3_animGroup = [self.hook_animGroup copy];
    self.hook3_animGroup.animations = @[hookUp3_anim, hookDown3_anim, hookScale3_anim];
    self.hook3_animGroup.beginTime = 0;
    self.hook3_animGroup.duration = 1.65;
    
    return view;
}



@end
