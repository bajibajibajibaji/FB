//
//  FBSignCalendarView.m
//  SignUp
//
//  Created by 张丹 on 16/7/17.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBSignCalendarView.h"
@class FBPrize;

@interface FBSignCalendarView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSMutableArray<FBCalendarCardView*> *cardArray;

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *signDayLabe;
@property (nonatomic, strong) UIButton *signButton;
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation FBSignCalendarView
- (NSMutableArray<FBCalendarCardView *> *)cardArray
{
    if (!_cardArray) {
        _cardArray = [NSMutableArray arrayWithCapacity:31];
    }
    return _cardArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundImageView = [UIImageView new];
        self.backgroundImageView.image = kGetImage(@"sign paper.png");
        [self addSubview:self.backgroundImageView];
        
        self.titleLable = [UILabel new];
        [self addSubview:self.titleLable];
        self.titleLable.textColor = [UIColor getColor:@"640a0a"];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.text = @"本月签到";
        self.titleLable.font = [UIFont systemFontOfSize:17 weight:1];
        
        self.signDayLabe = [UILabel new];
        [self addSubview:self.signDayLabe];
        
        self.signButton = [UIButton new];
        [self addSubview:self.signButton];
        [self.signButton setBackgroundImage:kGetImage(@"fill2.png") forState:(UIControlStateNormal)];
        
        
        self.scrollView = [UIScrollView new];
        [self addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;


        
        [self setDayCard:self.days];
        
        [self setSubviewsLayoutWithFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setSubviewsLayoutWithFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self setSubviewsLayoutWithFrame:bounds];
}
//设置子视图布局
- (void)setSubviewsLayoutWithFrame:(CGRect)frame
{
    CGFloat widthRatio = frame.size.width/951;
    CGFloat heightRatio = frame.size.height/1320;
    
    self.backgroundImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.titleLable.frame = CGRectMake(0, 25 * heightRatio , frame.size.width, 139 * heightRatio);
    self.scrollView.frame = CGRectMake(85 * widthRatio, -240 * heightRatio, 784 * widthRatio, 1336 * heightRatio);
    self.scrollView.contentSize = CGSizeMake(1568 * widthRatio, 1236 * heightRatio);

    self.signDayLabe.frame = CGRectMake(87 * widthRatio, 1157 * heightRatio, 500 * widthRatio, 50 * heightRatio);
    self.signButton.frame = CGRectMake(558 * widthRatio, 1137 * heightRatio, 300 * widthRatio, 93 * heightRatio);
    
    for (int i = 0; i < self.cardArray.count; i ++) {
        FBCalendarCardView *card = self.cardArray[i];
        if (i < 20)
        {
            card.frame = CGRectMake((7 + (i % 5) * 154) *widthRatio,(400 + (i / 5) * 239) * heightRatio, 154 * widthRatio, 219 * heightRatio);
        }
        else
        {
            card.frame = CGRectMake((21 + 154 * 5 + (i % 5) * 154) * widthRatio,(400 + ((i / 5) - 4)* 239) *heightRatio, 154 * widthRatio, 219 * heightRatio);
        }
    }

}
//左划日历
- (void)moveToLeft
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
//右划日历
- (void)moveToRight
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
}
//创建日历卡片
- (void)setDayCard:(NSInteger)days
{
    for (int i = 0; i < days; i ++) {
        FBCalendarCardView *card = [FBCalendarCardView new];
        [self.cardArray addObject:card];
        card.dayNumber = i + 1;
        card.isSign = 0;
        card.prizeNumber = i < 5 ? 5 : 10;
        
        if(i % 7 == 6)
        {
            NSString *imageName = [NSString stringWithFormat:@"sign bottle%d.png",(arc4random()%4) +1];
            card.prizeImage = kGetImage(imageName);
            card.prizeNumber = 1;
        }
        else
        {
            card.prizeImage = kGetImage(@"sign coin1.png");
        }
        if (i == days - 1 || i % 5 == 4) {
            card.showDivision = NO;
        }
        [self.scrollView addSubview:card];
        FBPrizeModel *prize = [FBPrizeModel new];
        prize.prizeImage = kGetImage(@"sign coin1.png");
        prize.prizeNumber = 0;
        
        FBPrizeModel *prize1 = [FBPrizeModel new];
        prize1.prizeImage = kGetImage(@"sign coin1.png");
        prize1.prizeNumber = 5;
        
        card.isSign = arc4random()%2;
        card.prizeArray = @[prize,prize1];
    }
}
//设置签到天数
- (void)setSignUpDayNumber:(NSInteger)signUpDayNumber
{
    _signUpDayNumber = signUpDayNumber;
    UIColor *red = [UIColor getColor:@"882911"];
    UIColor *brown = [UIColor getColor:@"88552b"];
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    UIFont *bigFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:@"累计签到 " attributes:@{NSForegroundColorAttributeName:brown,NSFontAttributeName : font}];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",signUpDayNumber] attributes:@{NSForegroundColorAttributeName:red,NSFontAttributeName : bigFont}];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:@" 天" attributes:@{NSForegroundColorAttributeName:brown,NSFontAttributeName : font}];
    [str1 appendAttributedString:str2];
    [str1 appendAttributedString:str3];
    self.signDayLabe.attributedText = str1;
    
}
//获取当月天数
- (NSInteger)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}



@end
