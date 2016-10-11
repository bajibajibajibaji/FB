//
//  FBCameraView.m
//  SignUp
//
//  Created by 朱志先 on 16/7/14.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBCameraView.h"
#import "UIImage+ImageRendering.h"


@interface FBCameraView ()
@property (nonatomic, strong) UIImageView *cameraClipedBackground;
@property (nonatomic, strong) UIImageView *cameraBackground;
@property (nonatomic, strong) UIImageView *cameraMiddleClipedPart;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *signUpButton;
@property (nonatomic, strong) UIImageView *flashImageView;
@property (nonatomic, strong) UILabel *signUpCountLable;
@property (nonatomic, strong) UIButton *calendarButton;
@property (nonatomic, strong) UIImageView *bigPhoto;
@property (nonatomic, strong) FBCameraCardView *cardOne;
@property (nonatomic, strong) FBCameraCardView *cardTwo;
@property (nonatomic, strong) FBCameraCardView *cardThree;
@property (nonatomic, strong) FBCameraCardView *cardFour;
@property (nonatomic, strong) FBCameraCardView *cardFive;
@property (nonatomic, strong) UIImageView *cardShadow;
@property (nonatomic, assign) NSInteger todaysCardNumber;
@property (nonatomic, assign) NSInteger todaysNumber;
@property (nonatomic, assign) FBCameraCardView *todaysCard;
@property (nonatomic, assign) CGFloat countLableFontSize;
@property (nonatomic, assign) BOOL allowLayoutSubviews;


@end

@implementation FBCameraView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.allowLayoutSubviews = YES;
        /**TODO: 当在此界面转点的处理*/
        unsigned units  = NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear;
        NSDateComponents *com = [[NSCalendar currentCalendar] components:units fromDate:[NSDate date]];
        self.todaysNumber = com.day;
        self.todaysCardNumber = (com.day%5 )?(com.day%5):5;

        
        self.cameraBackground = [UIImageView new];
        self.cameraBackground.image = kGetImage(@"camera3.png");
        [self addSubview:self.cameraBackground];
        
        self.bigPhoto = [UIImageView new];
        [self addSubview:self.bigPhoto];
        NSString *photoName = [NSString stringWithFormat:@"photo%ld.png",self.todaysCardNumber];
        self.bigPhoto.image = kGetImage(photoName);

        
        
        self.cameraClipedBackground = [UIImageView new];
        self.cameraClipedBackground.image = kGetImage(@"camera2.png");
        [self addSubview:self.cameraClipedBackground];
        
        self.closeButton = [UIButton new];
        [self.closeButton setBackgroundImage:kGetImage(@"sign close.png") forState:(UIControlStateNormal)];
        [self addSubview:self.closeButton];
        [self.closeButton addTarget:self action:@selector(tapCloseButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.signUpButton = [UIButton new];
        self.signUpButton.enabled = NO;
        UIImage *image = kGetImage(@"Sign button.png");
        [self.signUpButton setTitle:@"今日签到" forState:(UIControlStateNormal)];
        [self.signUpButton setBackgroundImage:image forState:(UIControlStateNormal)];
        [self.signUpButton setBackgroundImage:image forState:(UIControlStateDisabled)];
        [self addSubview:self.signUpButton];
        [self.signUpButton addTarget:self action:@selector(tapSignUpButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.calendarButton = [UIButton new];
        [self.calendarButton setBackgroundImage:kGetImage(@"calendar1.png") forState:(UIControlStateNormal)];
        [self addSubview:self.calendarButton];
        [self.calendarButton addTarget:self action:@selector(tapCalendar) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        self.signUpCountLable = [UILabel new];
        self.signUpCountLable.textAlignment = NSTextAlignmentCenter;
        self.signUpDayNumber = 0;
        
        [self addSubview:self.signUpCountLable];
        
        [self setCameraCards];
        
        self.cardShadow = [UIImageView new];
        self.cardShadow.image = kGetImage(@"shade.png");
        self.cardShadow.layer.contentsCenter = CGRectMake(0.45, 0, 0.1, 1);
        [self addSubview:self.cardShadow];
        
        self.cameraMiddleClipedPart = [UIImageView new];
        self.cameraMiddleClipedPart.image = kGetImage(@"camera4.png");
        [self addSubview:self.cameraMiddleClipedPart];
        
        self.flashImageView = [UIImageView new];
        self.flashImageView.image = kGetImage(@"light.png");
        [self addSubview:self.flashImageView];
        self.flashImageView.hidden = YES;
    
        [self determineTodaysCard];
        [self setSubViewsLayoutWithFrame:frame];
        
    }
    return self;
}


- (void)setSubViewsLayoutWithFrame:(CGRect)frame
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat widthRatio = width/1038.0;
    CGFloat heightRatio = height/831.0;
    CGSize size = CGSizeMake(width, height);
    //设置相机
    self.cameraBackground.frame = (CGRect){0, 0, width, 129 * heightRatio};
    self.cameraClipedBackground.frame = (CGRect){0, 0, size};
    self.cameraMiddleClipedPart.frame = (CGRect){0, 466 * heightRatio, width, 180 * heightRatio};
    //设置关闭按钮
    self.closeButton.frame = (CGRect){width - 150 * widthRatio, 0, 63 * widthRatio, 63 * heightRatio};
    //设置注册按钮
    self.signUpButton.frame = (CGRect){141 * widthRatio, 246 * heightRatio, 210 * widthRatio, 90 * heightRatio};
    self.signUpButton.titleLabel.font = [UIFont systemFontOfSize:(90 * heightRatio * 0.45) weight:2];
    //设置累计签到标签
    self.signUpCountLable.frame = (CGRect){130 * widthRatio, 340 * heightRatio, 232 * widthRatio, 42 * heightRatio};
    self.countLableFontSize = 42 * heightRatio * 0.63;
    //设置闪光灯
    self.flashImageView.bounds = (CGRect){0, 0, 1623 * widthRatio, 1470 * heightRatio};
    self.flashImageView.center = CGPointMake(770 * widthRatio, 239 * heightRatio);
    self.flashImageView.layer.anchorPoint = CGPointMake(910/1623.0, 685/1470.0);
    //设置大照片
    self.bigPhoto.frame = (CGRect){203 * widthRatio, 95 * heightRatio, 594 * widthRatio, 477 * heightRatio};
 
    //设置日历按钮
    self.calendarButton.frame = (CGRect){966 * widthRatio,680 * heightRatio,63 * widthRatio, 63 * heightRatio};
    //设置阴影遮罩
    self.cardShadow.frame = (CGRect){47 * widthRatio, 646 * heightRatio, 909 * widthRatio, 187 * heightRatio};

    //设置卡片
    CGSize cardSize = CGSizeMake(162 * widthRatio, 129 * heightRatio);
    CGFloat cardY = 659 * heightRatio;
    self.cardOne.frame = (CGRect){57 * widthRatio, cardY, cardSize};
    self.cardTwo.frame = (CGRect){(57 + 179 * 1) * widthRatio, cardY, cardSize};
    self.cardThree.frame = (CGRect){(57 + 179 * 2) * widthRatio, cardY, cardSize};
    self.cardFour.frame = (CGRect){(57 + 179 * 3) * widthRatio, cardY, cardSize};
    self.cardFive.frame = (CGRect){(57 + 179 * 4) * widthRatio, cardY, cardSize};

    
}



- (void)layoutSubviews
{
    if(_allowLayoutSubviews)
    {
        [self setSubViewsLayoutWithFrame:self.frame];
    }
}

- (void)setCameraCards
{
    NSInteger dayUnit = self.todaysNumber/5;
    if(self.todaysNumber%5 < 1)
    {
        dayUnit -= 1;
    }
    
    
    self.cardOne = [FBCameraCardView new];
    self.cardOne.photoImage = kGetImage(@"photo1.png");
    self.cardOne.dayNumber = dayUnit * 5 + 1;
    [self addSubview:self.cardOne];
    
    self.cardTwo = [FBCameraCardView new];
    self.cardTwo.photoImage = kGetImage(@"photo2.png");
    self.cardTwo.dayNumber = dayUnit * 5 + 2;
    [self addSubview:self.cardTwo];
    
    self.cardThree = [FBCameraCardView new];
    self.cardThree.photoImage = kGetImage(@"photo3.png");
    self.cardThree.dayNumber = dayUnit * 5 + 3;
    [self addSubview:self.cardThree];
    
    self.cardFour = [FBCameraCardView new];
    self.cardFour.photoImage = kGetImage(@"photo4.png");
    self.cardFour.dayNumber = dayUnit * 5 + 4;
    [self addSubview:self.cardFour];
    
    self.cardFive = [FBCameraCardView new];
    self.cardFive.photoImage = kGetImage(@"photo5.png");
    self.cardFive.dayNumber = dayUnit * 5 + 5;
    [self addSubview:self.cardFive];
}

- (void)tapCloseButton:(UIButton *)button
{
    !_closeButtonBlock?:_closeButtonBlock();
}

- (void)tapSignUpButton:(UIButton *)button
{
    !_signUpButtonBlock?:_signUpButtonBlock();
}

- (void)tapCalendar
{
    !_calendarButtonBlock?:_calendarButtonBlock();
}

- (void)setIsSignUpToday:(BOOL)isSignUpToday
{
    self.signUpButton.enabled = NO;
    _isSignUpToday = isSignUpToday;
    if (isSignUpToday)
    {
        [self.signUpButton setTitle:@"已签到" forState:(UIControlStateNormal)];
        self.todaysCard.isSign = YES;
        self.bigPhoto.hidden = YES;
    }
    else
    {
        self.signUpButton.enabled = YES;
        [self.signUpButton setTitle:@"今日签到" forState:(UIControlStateNormal)];
        self.todaysCard.isSign = NO;
    }
    
    /** TODO:未签到 */
}

- (void)setTodayIsSignUpWithAnimation:(BOOL)isSignUpToday
{
    
    _isSignUpToday = isSignUpToday;
    _allowLayoutSubviews = NO;
    
    CGFloat flashWidth = self.flashImageView.bounds.size.width;
    CGFloat flashHeight = self.flashImageView.bounds.size.height;
    if (isSignUpToday)
    {
        self.signUpButton.enabled = NO;
        [self.signUpButton setTitle:@"已签到" forState:(UIControlStateNormal)];
        self.signUpDayNumber = self.signUpDayNumber + 1;
        self.bigPhoto.hidden = NO;
        self.flashImageView.hidden = NO;
        /** 闪光灯旋转动画 */
        self.flashImageView.bounds = CGRectMake(0, 0, 0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            self.flashImageView.bounds = CGRectMake(0, 0, flashWidth, flashHeight);
            self.flashImageView.transform = CGAffineTransformMakeRotation(15 *M_PI / 180.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0.1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
                self.flashImageView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            } completion:^(BOOL finished) {
                self.flashImageView.transform = CGAffineTransformMakeRotation(0);
                self.flashImageView.hidden = YES;
            }];
        }];
        

        
        /** 照片弹出动画 */
        CGFloat heightRatio = self.frame.size.height/831.0;
        [UIView animateWithDuration:1.2 delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:1.1 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            self.bigPhoto.frame = CGRectMake(self.bigPhoto.frame.origin.x, self.bigPhoto.frame.origin.y - 477 * heightRatio, self.bigPhoto.frame.size.width, self.bigPhoto.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:1.1 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                self.bigPhoto.frame = CGRectMake(self.bigPhoto.frame.origin.x, self.bigPhoto.frame.origin.y + 477 * heightRatio, self.bigPhoto.frame.size.width, self.bigPhoto.frame.size.height);
            } completion:^(BOOL finished) {
                self.bigPhoto.hidden = YES;
                [self.todaysCard setIsSignUpWithAnimation:YES];
                self.allowLayoutSubviews = YES;
            }];
        }];
    }
  
}

- (void)determineTodaysCard
{
    switch (self.todaysCardNumber) {
        case 1:
            self.todaysCard = self.cardOne;
            break;
        case 2:
            self.todaysCard = self.cardTwo;
            break;
        case 3:
            self.todaysCard = self.cardThree;
            break;
        case 4:
            self.todaysCard = self.cardFour;
            break;
        case 5:
            self.todaysCard = self.cardFive;
            break;
            
        default:
            break;
    }
}

- (void)setSignUpDayNumber:(NSInteger)signUpDayNumber
{
    _signUpDayNumber = signUpDayNumber;
    UIColor *red = [UIColor colorWithRed:96/255.0 green:0 blue:0 alpha:1];
    UIColor *brown = [UIColor colorWithRed:56/255.0 green:17/255.0 blue:17/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Medium" size:self.countLableFontSize];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:@"累计签到 " attributes:@{NSForegroundColorAttributeName:brown,NSFontAttributeName : font}];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",signUpDayNumber] attributes:@{NSForegroundColorAttributeName:red,NSFontAttributeName : font}];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:@" 天" attributes:@{NSForegroundColorAttributeName:brown,NSFontAttributeName : font}];
    [str1 appendAttributedString:str2];
    [str1 appendAttributedString:str3];
    self.signUpCountLable.attributedText = str1;
    
}

#pragma mark - 设置视图的内容

- (void)setPrize:(NSArray *)prize
{
    _prize = prize;
    self.signUpDayNumber = 123;
    self.isSignUpToday = YES;
    self.cardOne.prizeImage = kGetImage(@"Mini bottle1.png");
    self.cardTwo.prizeImage = kGetImage(@"Mini bottle2.png");
    self.cardThree.prizeImage = kGetImage(@"Mini bottle3.png");
    self.cardFour.prizeImage = kGetImage(@"Mini bottle2.png");
    self.cardFive.prizeImage = kGetImage(@"Mini bottle4.png");
    self.cardOne.isSign = YES;
    

}
@end


@interface FBCameraCardView ()
@property (nonatomic, strong) UILabel *dayLable;
@property (nonatomic, strong) UIImageView *dayLableBackground;
@property (nonatomic, strong) UIImageView *prizeImageView;
@property (nonatomic, strong) UILabel *prizeNumberLable;
@property (nonatomic, strong) UIImageView *smallPhoto;
@property (nonatomic, strong) UIView *smallPhotoView;
@property (nonatomic, strong) UIImageView *smallPhotoShadow;
@property (nonatomic, assign) BOOL allowLayoutSubviews;
@end

@implementation FBCameraCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.allowLayoutSubviews = YES;

        self.dayLableBackground = [UIImageView new];
        self.dayLableBackground.image = kGetImage(@"reward.png");
        self.dayLableBackground.layer.contentsCenter = CGRectMake(0.45, 0.45, 0.1, 0.1);
        [self addSubview:self.dayLableBackground];
        
        self.dayLable = [UILabel new];
        self.dayLable.textAlignment = NSTextAlignmentCenter;
        self.dayLable.textColor = [UIColor colorWithRed:185/255.0 green:181/255.0 blue:185/255.0 alpha:1];
        [self addSubview:self.dayLable];
        
        self.prizeImageView = [UIImageView new];
        [self addSubview:self.prizeImageView];
        self.prizeImageView.image = kGetImage(@"sign bottle2.png");
        
        self.prizeNumberLable =[UILabel new];
        self.prizeNumberLable.textColor =  [UIColor colorWithRed:185/255.0 green:181/255.0 blue:185/255.0 alpha:1];
        self.prizeNumberLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.prizeNumberLable];
        self.prizeNumberLable.text = @"x24";
        

        
        self.smallPhotoView = [UIView new];
        [self addSubview:self.smallPhotoView];
        
        self.smallPhotoShadow = [UIImageView new];
        self.smallPhotoShadow.image = kGetImage(@"camara shade.png");
        [self.smallPhotoView addSubview:self.smallPhotoShadow];
        self.smallPhotoShadow.hidden = YES;
        
        self.smallPhoto = [UIImageView new];
        [self.smallPhotoView addSubview:self.smallPhoto];
        
         self.isSign = NO;
        [self setSubViewsLayoutWithFrame:frame];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    if (self.allowLayoutSubviews) {
        [self setSubViewsLayoutWithFrame:self.frame];
    }
}

- (void)setSubViewsLayoutWithFrame:(CGRect)frame
{
    CGFloat widthRatio = frame.size.width/162.0;
    CGFloat heightRatio = frame.size.height/129.0;
    
    self.dayLableBackground.frame = CGRectMake(13 * widthRatio, 3 * heightRatio, 136 * widthRatio, 42 * heightRatio);
    
    self.dayLable.frame = self.dayLableBackground.frame;
    self.dayLable.font = [UIFont systemFontOfSize:42 * heightRatio * 0.7 weight:1];
    
    self.prizeImageView.frame = CGRectMake(13 * widthRatio, 51 * heightRatio, 72 * widthRatio, 72 * heightRatio);
    
    self.prizeNumberLable.frame = CGRectMake(85 * widthRatio, 51 * heightRatio, 69 * widthRatio, 72 * heightRatio);
    self.prizeNumberLable.font = [UIFont systemFontOfSize:72 * heightRatio * 0.5];
    
    self.smallPhoto.frame = CGRectMake(0, 0, 162 * widthRatio, 129 * heightRatio);
    
    if(!self.isSign)
    {
        self.smallPhotoView.frame = CGRectMake(0, -143 * heightRatio, 162 * widthRatio, 129 * heightRatio);
    }
    else
    {
        self.smallPhotoView.frame = CGRectMake(0, 0 , 162 * widthRatio, 129 * heightRatio);
    }
    
    self.smallPhotoShadow.frame = CGRectMake(-1.5 * widthRatio, 126.5 * heightRatio, 165 * widthRatio, 9 * heightRatio);
}

- (void)setDayNumber:(NSInteger)dayNumber
{
    _dayNumber = dayNumber;
    if (dayNumber >= 10) {
        self.dayLable.text = [NSString stringWithFormat:@"第%ld天",dayNumber];
    }
    else
    {
        self.dayLable.text = [NSString stringWithFormat:@"第 %ld 天",dayNumber];
    }
}

- (void)setPrizeImage:(UIImage *)prizeImage
{
    _prizeImage = prizeImage;
    self.prizeImageView.image = prizeImage;
}

- (void)setPrizeNumber:(NSInteger)prizeNumber
{
    _prizeNumber = prizeNumber;
    self.prizeNumberLable.text = [NSString stringWithFormat:@"x%ld",prizeNumber];
}

- (void)setPhotoImage:(UIImage *)photoImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [photoImage imageWithRoundCornerAndSize:CGSizeMake(54, 43) andCornerRadius:0];
        _photoImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.smallPhoto.image = image;
        });
    });
}

- (void)setIsSignUpWithAnimation:(BOOL)isSign
{
    _isSign = isSign;
    if (isSign) {
        self.allowLayoutSubviews = YES;
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            self.smallPhotoView.frame = CGRectMake(0, 0 , self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            self.smallPhotoShadow.hidden = NO;
            self.allowLayoutSubviews = YES;
        }];
    }
    else
    {
        self.smallPhotoView.frame = CGRectMake(0, -143/129.0 * self.frame.size.height , self.frame.size.width, self.frame.size.height);
    }
}

- (void)setIsSign:(BOOL)isSign
{
    _isSign = isSign;
    CGFloat widthRatio = self.frame.size.width/162.0;
    CGFloat heightRatio = self.frame.size.height/129.0;
    if(!self.isSign)
    {
        self.smallPhotoView.frame = CGRectMake(0, -143 * heightRatio, 162 * widthRatio, 129 * heightRatio);
    }
    else
    {
        self.smallPhotoView.frame = CGRectMake(0, 0 , 162 * widthRatio, 129 * heightRatio);
    }

}


@end
