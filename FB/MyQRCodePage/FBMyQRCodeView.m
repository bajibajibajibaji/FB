//
//  FBMyQRCodeView.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//


#import "FBMyQRCodeView.h"
#import "UIImage+ImageRendering.h"
@interface FBMyQRCodeView()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *sayHiLable;
@property (nonatomic, strong) UILabel *nickNameLable;
@property (nonatomic, strong) UILabel *signatureLable;
@property (nonatomic, strong) UIImageView *qrCodeBackgroundImage;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UILabel *tipsLable;
@end

@implementation FBMyQRCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.avatarImageView = [UIImageView new];
        self.sayHiLable = [UILabel new];
        self.nickNameLable = [UILabel new];
        self.signatureLable = [UILabel new];
        self.qrCodeBackgroundImage = [UIImageView new];
        self.qrCodeImageView = [UIImageView new];
        self.tipsLable = [UILabel new];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.sayHiLable];
        [self.contentView addSubview:self.nickNameLable];
        [self.contentView addSubview:self.signatureLable];
        [self.contentView addSubview:self.qrCodeBackgroundImage];
        [self.contentView addSubview:self.qrCodeImageView];
        [self.contentView addSubview:self.tipsLable];
        [self setSubviewsFrame:frame];
        [self setSubviewsContent];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (self.sayHiLable) {
        [self setSubviewsFrame:frame];
    }
    
}


- (void)setSubviewsFrame:(CGRect)superViewFrame
{

    CGFloat WRatio = superViewFrame.size.width/969;
    CGFloat HRation = superViewFrame.size.height/1368;
    self.avatarImageView.frame = CGRectMake(87 * WRatio ,70 * HRation, 210 * WRatio, 210 *HRation);
    self.sayHiLable.frame = CGRectMake(333 * WRatio, 95 * HRation, 450 * WRatio, 39 * HRation);
    self.nickNameLable.frame = CGRectMake(333 * WRatio, 149 * HRation, 450 * WRatio, 50 *HRation);
    self.signatureLable.frame = CGRectMake(333 * WRatio, 235 * HRation, 450 *WRatio, 39 * HRation);
    self.qrCodeBackgroundImage.frame = CGRectMake(87 * WRatio, 314 *HRation, 780 * WRatio, 780 * HRation);
    self.qrCodeImageView.frame = CGRectMake(87 * WRatio, 314 *HRation, 780 * WRatio, 780 * HRation);
    self.tipsLable.frame = CGRectMake(0, 1140 * HRation, 969 * WRatio, 39 * HRation);
}

- (void) setSubviewsContent
{
    UIColor *infoTextColor = [UIColor colorWithRed:67/256.0 green:50/256.0 blue:23/256.0 alpha:1];
    UIColor *tipsTextColor = [UIColor colorWithRed:97/256.0 green:12/256.0 blue:15/256.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"ChalkboardSE-Regular" size:11];
//    Font Family: STHeiti TC
//    Font: STHeitiTC-Light
//    Font: STHeitiTC-Medium
    self.nickNameLable.textColor = infoTextColor;
    self.nickNameLable.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:16];
    self.sayHiLable.textColor = infoTextColor;
    self.sayHiLable.font = font;
    self.sayHiLable.text = @"Hi~ 我是:";
    self.signatureLable.textColor= infoTextColor;
    self.signatureLable.font = font;
    self.tipsLable.textColor = tipsTextColor;
    self.tipsLable.font = font;
    self.tipsLable.textAlignment = NSTextAlignmentCenter;
    self.tipsLable.text = @"扫一扫上面的二维码，和我一起漂流";
    self.qrCodeBackgroundImage.image = kGetImage(@"QR background.png");
    
}


- (void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
    self.nickNameLable.text = nickName;
}


- (void)setAvatarImage:(UIImage *)avatarImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [avatarImage systhsisWithBorderImage:kGetImage(@"edge.png") andSize:CGSizeMake(70, 70) andCornerRadius:5];
        dispatch_async(dispatch_get_main_queue(), ^{
            _avatarImage = image;
            self.avatarImageView.image = image;
        });
    });
}


- (void)setSignature:(NSString *)signature
{
    _signature = signature;
    self.signatureLable.text = signature;
}


- (void)setQrCodeImage:(UIImage *)qrCodeImage
{
    _qrCodeImage = qrCodeImage;
    self.qrCodeImageView.image = qrCodeImage;
}





@end
