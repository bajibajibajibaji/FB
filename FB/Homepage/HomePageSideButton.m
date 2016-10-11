//
//  HomePageSideButton.m
//  ResizeButton
//
//  Created by 朱志先 on 16/7/5.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "HomePageSideButton.h"

@interface HomePageSideButton ()
@property (nonatomic, strong) UIButton * titleimageView;
@property (nonatomic, strong) UIButton *lable;
@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) UILabel *badgeLable;

@end

@implementation HomePageSideButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setLableText:(NSString *)lableText
{
    _lableText = lableText;
    if (self.lable) {
        [self.lable setTitle:lableText forState:(UIControlStateNormal)];
    }
}


- (void)setTitleImage:(UIImage *)titleImage
{
    _titleImage = titleImage;
    if (self.titleimageView) {
        [self.titleimageView setBackgroundImage:titleImage forState:(UIControlStateNormal)];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleimageView = [UIButton new];
        self.lable = [UIButton new];
        self.badgeView = [UIView new];
        self.badgeImageView = [UIImageView new];
        self.badgeLable = [UILabel new];
        
        self.lable.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.lable.titleLabel.textColor = [UIColor whiteColor];
        [self.titleimageView addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.lable addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
        self.badgeLable.textColor = [UIColor redColor];
        self.badgeLable.textAlignment = NSTextAlignmentCenter;
        self.badgeLable.userInteractionEnabled = YES;
        self.badgeImageView.image = [UIImage imageNamed:@"mylandstar"];
        self.badgeImageView.userInteractionEnabled = YES;
        
        [self addSubview:self.lable];
        [self addSubview:self.titleimageView];
        
        self.badgeView.hidden = YES;
        [self addSubview:self.badgeView];
        [self.badgeView addSubview:self.badgeImageView];
        [self.badgeView addSubview:self.badgeLable];

        
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (!self.titleimageView) {
        return;
    }
    self.badgeView.frame = CGRectMake(0.575 * CGRectGetWidth(frame), 0, 0.425 * CGRectGetWidth(frame), 0.425 * CGRectGetWidth(frame));
    self.badgeImageView.frame = CGRectMake(0, 0, 0.425 * CGRectGetWidth(frame), 0.425 * CGRectGetWidth(frame));
    self.badgeLable.frame = CGRectMake(0, 0, 0.425 * CGRectGetWidth(frame), 0.425 * CGRectGetWidth(frame));
    self.badgeLable.font = [UIFont systemFontOfSize: 0.245 * CGRectGetWidth(frame) weight:0.5];
    
    if (CGRectGetHeight(frame) > CGRectGetWidth(frame))
    {
        self.titleimageView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame));
        self.lable.frame = CGRectMake(0, CGRectGetWidth(frame), CGRectGetWidth(frame),(CGRectGetHeight(frame)-CGRectGetWidth(frame)));
        if (!_font) {
            self.lable.titleLabel.font = [UIFont systemFontOfSize:(CGRectGetHeight(frame)-CGRectGetWidth(frame)) * 0.7 weight:4];
        }
        
    }
    else
    {
        NSInteger i = 3;
        if (self.inset != 0) {
            i = self.inset;
        }
        self.titleimageView.frame = CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        self.lable.frame = CGRectMake(CGRectGetHeight(frame) + i, 0, CGRectGetWidth(frame) - CGRectGetHeight(frame) - i, CGRectGetHeight(frame));
        self.lable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        if (!_font) {
            self.lable.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(frame)*0.8  weight:0.7];
        }
        
        
    }
    
}

- (void)setInset:(NSInteger)inset
{
    if (CGRectGetWidth(self.frame) > CGRectGetHeight(self.frame)) {
        self.lable.frame = CGRectMake(CGRectGetHeight(self.frame) + inset, 0, CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) - inset, CGRectGetHeight(self.frame));
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self.lable setTitleColor:textColor forState:(UIControlStateNormal)];
    [self.lable setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.lable.titleLabel.font = font;
}

-(void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    if (badgeNumber <= 0) {
        self.badgeView.hidden = YES;
    }
    if (badgeNumber > 0) {
        self.badgeView.hidden = NO;
        self.badgeLable.text = [NSString stringWithFormat:@"%ld",_badgeNumber];
    }
}


- (void)tap:(UIButton*)button
{
    !self.clickBlock?:self.clickBlock();
}


@end

