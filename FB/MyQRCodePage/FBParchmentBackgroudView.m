//
//  FBParchmentBackgroudView.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBParchmentBackgroudView.h"

@interface FBParchmentBackgroudView()
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIImageView *backgroudImage;
@property (nonatomic, strong) UIView *backView;
@end
@implementation FBParchmentBackgroudView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 14, frame.size.width, frame.size.height - 14)];

        
        self.backgroudImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, frame.size.width, frame.size.height - 14)];
        self.backgroudImage.image = kGetImage(@"paper.png");
        self.backgroudImage.userInteractionEnabled = YES;

        
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 21, 0, 21, 21)];
        [self.closeButton setBackgroundImage:kGetImage(@"close QR.png") forState:(UIControlStateNormal)];
        
        [self.closeButton addTarget:self action:@selector(tapCloseButton) forControlEvents:(UIControlEventTouchUpInside)];
        
      
        [self addSubview:self.backgroudImage];
        [self addSubview:self.backView];
        [self addSubview:self.closeButton];
    }
    return self;
}

-(UIView *)contentView
{
    return self.backView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.closeButton.frame = CGRectMake(frame.size.width - 21, 0, 21, 21);
    self.backgroudImage.frame = CGRectMake(0, 14, frame.size.width, frame.size.height - 14);
    self.backView.frame = CGRectMake(0, 14, frame.size.width, frame.size.height - 14);
}




- (void)tapCloseButton
{
    !_closeButtonHandler?:_closeButtonHandler();
}
@end
