//
//  HomePageMyIsland.m
//  mainLand3
//
//  Created by 朱志先 on 16/6/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "HomePageMyIslandView.h"
#import "HomePageSideButton.h"

@interface HomePageMyIslandView ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLable;
@property (nonatomic, strong) HomePageSideButton *coinButton;
@property (nonatomic, strong) HomePageSideButton *rankButton;
@property (nonatomic, strong) UIButton *signUpButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIImageView *LevelImage;
@property (nonatomic, strong) UILabel *levelLable;

@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) UILabel *badgeLable;


@property (nonatomic, strong) UIImageView *backgroundImage;



@end

@implementation HomePageMyIslandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.avatarImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"acatar"]];
        
        self.nickNameLable = [UILabel new];
        self.nickNameLable.numberOfLines = 2;
        self.nickNameLable.font = [UIFont systemFontOfSize:14];
 
        self.nickName = @"闯堂兔弟弟";
        
        
        self.coinButton = [HomePageSideButton new];
        self.coinButton.lableText = @"0";
        self.coinButton.font = [UIFont systemFontOfSize:20];
        self.coinButton.titleImage = [UIImage imageNamed:@"coin"];
        self.coinButton.textColor = [UIColor colorWithRed:70/255.0 green:50/255.0 blue:20/255.0 alpha:1];
        
        self.rankButton = [HomePageSideButton new];
        self.rankButton.lableText = @"0";
        self.rankButton.font = [UIFont systemFontOfSize:20];
        self.rankButton.textColor = [UIColor colorWithRed:70/255.0 green:50/255.0 blue:20/255.0 alpha:1];
        self.rankButton.titleImage = [UIImage imageNamed:@"rank"];
        
        self.signUpButton = [UIButton new];
        [self.signUpButton setImage:[UIImage imageNamed:@"signup"] forState:(UIControlStateNormal)];
        [self.signUpButton addTarget:self action:@selector(clickSignUp) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.messageButton = [UIButton new];
        [self.messageButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
        [self.messageButton addTarget:self action:@selector(clickMessageButton) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.LevelImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"level"]];
        self.levelLable = [UILabel new];
        self.levelLable.textAlignment = NSTextAlignmentCenter;
        self.levelLable.textColor = [UIColor redColor];
        
        self.backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"myisland"]];
        
        self.badgeView = [UIView new];
        self.badgeImageView = [UIImageView new];
        self.badgeLable = [UILabel new];
        
        self.badgeLable.textColor = [UIColor redColor];
        self.badgeLable.textAlignment = NSTextAlignmentCenter;
        self.badgeLable.userInteractionEnabled = YES;
        self.badgeImageView.image = [UIImage imageNamed:@"mylandstar"];
        self.badgeImageView.userInteractionEnabled = YES;
        

        
        [self addSubview:self.backgroundImage];
        [self addSubview:self.nickNameLable];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.coinButton];
        [self addSubview:self.rankButton];
        [self addSubview:self.signUpButton];
        [self addSubview:self.messageButton];
        [self addSubview:self.LevelImage];
        [self.LevelImage addSubview:self.levelLable];
        
        self.badgeView.hidden = YES;
        [self.messageButton addSubview:self.badgeView];
        [self.badgeView addSubview:self.badgeImageView];
        [self.badgeView addSubview:self.badgeLable];
        
        
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (!self.avatarImageView) {
        return;
    }
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    self.avatarImageView.frame = CGRectMake(width * 0.05, height * 0.22, width * 0.38, width * 0.38);
    self.backgroundImage.frame = CGRectMake(0, 0, width, height);
    self.nickNameLable.frame = CGRectMake(width * 0.05, height * 0.73, width * 0.32 , height * 0.19);
    self.LevelImage.frame = CGRectMake(width * 0.37, height * 0.75, width * 0.115, width * 0.13);
    
    self.levelLable.frame = CGRectMake(0, 0, self.LevelImage.frame.size.width, self.LevelImage.frame.size.width * 0.8);
    self.levelLable.font = [UIFont systemFontOfSize:self.LevelImage.frame.size.width * 0.5 weight:0.5];
    
    self.coinButton.frame = CGRectMake(width * 0.52, 0.22 * height, width * 0.43, height * 0.14);
    self.rankButton.frame = CGRectMake(width * 0.52, 0.39 * height, width * 0.43, height * 0.14);
    self.signUpButton.frame = CGRectMake(width * 0.52, 0.56 * height, width * 0.43, height * 0.16);
    self.messageButton.frame = CGRectMake(width * 0.52, 0.75 * height, width * 0.43, height * 0.16);
    
    CGFloat messageButtonWidth = CGRectGetWidth(self.messageButton.frame);
    CGFloat messageButtonheight = CGRectGetHeight(self.messageButton.frame);
    self.badgeView.frame = CGRectMake((messageButtonWidth - 0.37 * messageButtonheight), - 0.25 * messageButtonheight, 0.6 * messageButtonheight, 0.6 * messageButtonheight);
    self.badgeImageView.frame = CGRectMake(0, 0, 0.6 * messageButtonheight, 0.6 * messageButtonheight);
    self.badgeLable.frame = CGRectMake(0, 0, 0.6 * messageButtonheight, 0.6 * messageButtonheight);
    self.badgeLable.font = [UIFont systemFontOfSize:0.3 * messageButtonheight weight:0.5];
    
    

}

- (void)clickSignUp
{
    !_signUpButtonBlock?:_signUpButtonBlock();
}

- (void)clickMessageButton
{
    !_messageButtonBlock?:_messageButtonBlock();
}

-(void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
    NSMutableString *MuStr =[NSMutableString stringWithString: @"Hi~ 我是:\n"];
    NSString *str = [MuStr stringByAppendingString:nickName];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:70/255.0 green:50/255.0 blue:20/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    self.nickNameLable.attributedText = attrString;
}


- (void)setLevel:(NSInteger)level
{
    _level = level;
    self.levelLable.text = [NSString stringWithFormat:@"%ld",level];
}

- (void)setCoinNumber:(NSInteger)coinNumber
{
    _coinNumber = coinNumber;
    self.coinButton.lableText = [NSString stringWithFormat:@"%ld",(long)coinNumber];
    
}

- (void)setMessageNumber:(NSInteger)messageNumber
{
    _messageNumber = messageNumber;
    if (messageNumber <= 0) {
        self.badgeView.hidden = YES;
    }else
    {
        self.badgeLable.text = [NSString stringWithFormat:@"%ld",messageNumber];
        self.badgeView.hidden = NO;
    }
}

- (void)setRank:(NSInteger)rank
{
    _rank = rank;
    self.rankButton.lableText = [NSString stringWithFormat:@"%ld",(long)rank];
}

- (void)setAvatarImage:(UIImage *)avatarImage{
    if (!_avatarImage) {
        return;
    }
    _avatarImage = avatarImage;
    self.avatarImageView.image = avatarImage;
}

- (void)setNickNameFont:(UIFont *)nickNameFont
{
    _nickNameFont = nickNameFont;
    self.nickNameLable.font = nickNameFont;
}

- (void)setCoinAndRankLableFont:(UIFont *)coinAndRankLableFont
{
    _coinAndRankLableFont = coinAndRankLableFont;
    self.coinButton.font = coinAndRankLableFont;
    self.rankButton.font = coinAndRankLableFont;
}


@end
