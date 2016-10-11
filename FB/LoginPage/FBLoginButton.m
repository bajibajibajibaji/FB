//
//  FBLoginButton.m
//  buttontest
//
//  Created by 朱志先 on 16/7/10.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBLoginButton.h"
#import "Masonry.h"
#import "CALayer+FBAnimation.h"
@interface FBLoginButton()
@property (nonatomic, strong) UIImageView *background1;
@property (nonatomic, strong) UIImageView *background2;
@property (nonatomic, strong) UIButton *buttonBackground;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, assign) CGFloat ratio;

@end

@implementation FBLoginButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ratio = [UIScreen mainScreen].bounds.size.width > 320 ? 1 : 320/375.0;

        self.background1 = [UIImageView new];
        self.background2 = [UIImageView new];
        self.buttonBackground = [UIButton new];
        self.titleImage = [UIImageView new];
        
        [self addSubview:self.background1];
        [self addSubview:self.background2];
        [self addSubview:self.buttonBackground];
        [self addSubview:self.titleImage];
        
        self.background1.image = kGetImage(@"Sign in3.png");
        [self.background1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.background1.layer startBounceAnimationDuration:0.3 firstStepHeightRatio:1.1 secondStepWidthRatio:1.1];
        
        CGFloat edge = 6.5 * self.ratio;
        
        self.background2.image = kGetImage(@"Sign in2.png");
        [self.background2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(edge, edge, edge, edge));
        }];
        [self.background2.layer startBounceAnimationDuration:0.2 firstStepHeightRatio:1.1 secondStepWidthRatio:1.1];
        
        
        [self.buttonBackground setBackgroundImage:kGetImage(@"home button1.png") forState:(UIControlStateNormal)];
        [self.buttonBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(2 * edge, 2 * edge, 2 * edge, 2 * edge));
        }];
        
        self.titleImage.userInteractionEnabled = NO;
        self.titleImage.image = kGetImage(@"sign in4.png");
        [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.equalTo(70 * self.ratio);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [self.buttonBackground addTarget:self action:@selector(tapButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)setButtonType:(FBLoginButtonType)buttonType
{
    _buttonType = buttonType;
    switch (buttonType) {
        case FBLoginButtonTypeLogin:
            self.titleImage.image = kGetImage(@"sign in4.png");
            break;
            
        case FBLoginButtonTypeDone:
            self.titleImage.image = kGetImage(@"ok1.png");
            break;
            
        case FBLoginButtonTypeNext:
            self.titleImage.image = kGetImage(@"next1.png");
            break;
            
        default:
            break;
    }
}

- (void)compressButtonWithTime:(CGFloat)time;
{
    
    if (self.frame.size.width < 100 ) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(47);
        }];
        [self.buttonBackground mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(40);
        }];
        [UIView animateWithDuration:time animations:^{
            [self layoutIfNeeded];
            self.background1.alpha = 0;
            self.titleImage.alpha = 0.3;
            self.background2.alpha = 0;
        } completion:^(BOOL finished) {
            [self.buttonBackground setBackgroundImage:[kGetImage(@"home button2.png") resizableImageWithCapInsets:UIEdgeInsetsMake(23, 23, 23, 23) resizingMode:(UIImageResizingModeTile)] forState:(UIControlStateNormal)];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(150 * self.ratio);
            }];
            [self.titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(70 * self.ratio);
            }];
            [UIView animateWithDuration:time animations:^{
                [self layoutIfNeeded];
                self.titleImage.alpha = 1;
            } completion:^(BOOL finished){
                nil;
            }];
        }];
    }

}

- (void)stretchButtonWithTime:(CGFloat)time
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(47);
    }];

    [self.titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(40);
    }];
    [UIView animateWithDuration:time animations:^{
        [self layoutIfNeeded];
        self.background1.alpha = 1;
        self.background2.alpha = 1;
        self.titleImage.alpha = 0.3;
    } completion:^(BOOL finished) {
        
        [self.buttonBackground mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(13 * self.ratio, 13 * self.ratio, 13 * self.ratio, 13 * self.ratio));
        }];
        [self.buttonBackground setBackgroundImage:kGetImage(@"home button1.png") forState:(UIControlStateNormal)];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(93 * self.ratio);
        }];
        [self.titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(70 * self.ratio);
        }];
        [UIView animateWithDuration:time animations:^{
            [self layoutIfNeeded];
            self.titleImage.alpha = 1;
        } completion:^(BOOL finished){
            nil;
        }];
    }];
    
}

- (void)tapButton:(UIButton*)button
{
    !_buttonBlock?:_buttonBlock();
}



- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    //    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self compressButtonWithTime:animationDuration];

    
    
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    [self stretchButtonWithTime:animationDuration];
    

    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
