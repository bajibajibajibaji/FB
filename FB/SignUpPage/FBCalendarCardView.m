//
//  FBCalendarCardView.m
//  SignUp
//
//  Created by 朱志先 on 16/7/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBCalendarCardView.h"
@interface FBCalendarCardView()
@property (nonatomic, strong) UIImageView *cardPaperImageView;
@property (nonatomic, strong) UILabel *dayNumberLable;
@property (nonatomic, strong) UIImageView *prizeImageView;
@property (nonatomic, strong) UIImageView *checkMarkImageView;
@property (nonatomic, strong) UILabel *prizeNumberLable;
@property (nonatomic, strong) UIImageView *divisionImageView;
@property (nonatomic, strong) FBPrizePreviewView *priviewView;

@end

@implementation FBCalendarCardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cardPaperImageView = [UIImageView new];
        [self addSubview:self.cardPaperImageView];
        self.cardPaperImageView.image = kGetImage(@"calendar2.png");
        
        self.dayNumberLable = [UILabel new];
        self.dayNumberLable.adjustsFontSizeToFitWidth = YES;
        self.dayNumberLable.textColor = [UIColor colorWithRed:100/255.0 green:11/255.0 blue:11/255.0 alpha:1];
        self.dayNumberLable.textAlignment = NSTextAlignmentCenter;
        self.dayNumberLable.numberOfLines = 0;
        self.dayNumberLable.font = [UIFont systemFontOfSize:12 weight:0.4];
        [self addSubview:self.dayNumberLable];
        
        self.prizeImageView = [UIImageView new];
        self.prizeImageView.image = kGetImage(@"sign bottle3.png");
        [self addSubview:self.prizeImageView];
        
        self.checkMarkImageView = [UIImageView new];
        [self addSubview:self.checkMarkImageView];
        self.checkMarkImageView.image = kGetImage(@"Have punch.png");
        
        self.prizeNumberLable = [UILabel new];
        self.prizeNumberLable.adjustsFontSizeToFitWidth = YES;
        self.prizeNumberLable.textColor = [UIColor colorWithRed:255/255.0 green:103/255.0 blue:31/255.0 alpha:1];
        self.prizeNumberLable.textAlignment = NSTextAlignmentCenter;
        self.prizeNumberLable.numberOfLines = 0;
        self.prizeNumberLable.font = [UIFont systemFontOfSize:12 weight:0.2];
        [self addSubview:self.prizeNumberLable];
        self.prizeNumberLable.text = @"x 5";
        
        self.divisionImageView = [UIImageView new];
        self.divisionImageView.image = kGetImage(@"Division.png");
        [self addSubview:self.divisionImageView];
        
        [self addTarget:self action:@selector(showPreview) forControlEvents:(UIControlEventTouchDown)];
        [self addTarget:self action:@selector(hidePreview) forControlEvents:(UIControlEventTouchCancel|UIControlEventTouchUpInside|UIControlEventTouchUpOutside)];
        
        [self setSubViewsLayoutWithFrame:frame];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setSubViewsLayoutWithFrame:frame];
}

- (void)setSubViewsLayoutWithFrame:(CGRect)frame
{
    CGFloat widthRatio = frame.size.width/154;
    CGFloat heightRatio = frame.size.height/219;
    
    self.dayNumberLable.frame = CGRectMake(0, 4 * heightRatio , frame.size.width, 46 * heightRatio);
    
    self.cardPaperImageView.frame = CGRectMake(-3 * widthRatio, 0, 162 * widthRatio, 219 * heightRatio);
    
    self.checkMarkImageView.frame = CGRectMake(114 *widthRatio, 57 * heightRatio, 30 * widthRatio, 30 * heightRatio);
    
    self.prizeImageView.frame = CGRectMake(27 * widthRatio, 66 * heightRatio, 96 * widthRatio, 96 * heightRatio);
    
    self.prizeNumberLable.frame = CGRectMake(0, 165 * heightRatio, frame.size.width, 40 * heightRatio);
    
    self.divisionImageView.frame = CGRectMake(150 * widthRatio, 0, 4 * widthRatio, 210 * heightRatio);
    
}

- (void)setShowDivision:(BOOL)showDivision
{
    _showDivision = showDivision;
    self.divisionImageView.hidden = !showDivision;
}

- (void)showPreview
{
    CGFloat widthRatio = self.frame.size.width/154;
    CGFloat heightRatio = self.frame.size.height/219;
    self.priviewView = [FBPrizePreviewView new];
    [self addSubview:self.priviewView];
    self.priviewView.prizeArray = self.prizeArray;
    NSInteger prizeNumber = self.prizeArray.count;
    CGFloat height = 96.0 + prizeNumber * 60;
    self.priviewView.frame = CGRectMake(0, (- height + 9) * heightRatio, 150 * widthRatio, height * heightRatio);
}

- (void)hidePreview
{
    [self.priviewView removeFromSuperview];
}

- (void)setDayNumber:(NSInteger)dayNumber
{
    _dayNumber = dayNumber;
    self.dayNumberLable.text = [NSString stringWithFormat:@"第%ld天",dayNumber];
}

- (void)setPrizeImage:(UIImage *)prizeImage
{
    _prizeImage = prizeImage;
    self.prizeImageView.image = prizeImage;
}

- (void)setPrizeNumber:(NSInteger)prizeNumber
{
    _prizeNumber = prizeNumber;
    self.prizeNumberLable.text = [NSString stringWithFormat:@"x %ld",prizeNumber];
}

- (void)setIsSign:(BOOL)isSign
{
    _isSign = isSign;
    self.checkMarkImageView.hidden = !isSign;
}




@end


@interface FBPrizePreviewView ()
@property (nonatomic, strong) NSMutableArray<FBPrizeView *> *prizeViewArray;
@end

@implementation FBPrizePreviewView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImageView new];
        [self addSubview:self.background];
        self.background.layer.contentsCenter = CGRectMake(0, 0.3, 1, 0.1);
        self.background.image = kGetImage(@"sign reward1.png");
        self.prizeViewArray = [NSMutableArray array];
        [self setPrizeViewsFrameWithFrame:frame];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.background.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self setPrizeViewsFrameWithFrame:frame];
}

- (void)setPrizeArray:(NSArray *)prizeArray
{
    _prizeArray = prizeArray;
    for (int i = 0; i < prizeArray.count; i++) {
        FBPrizeModel *prize = prizeArray[i];
        FBPrizeView *prizeView = [FBPrizeView new];
        prizeView.prizeNumber = prize.prizeNumber;
        prizeView.prizeImage = prize.prizeImage;
        [self.prizeViewArray addObject:prizeView];
        [self addSubview:prizeView];
    }
    [self setPrizeViewsFrameWithFrame:self.frame];
}

- (void)setPrizeViewsFrameWithFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    for (int i  = 0; i < self.prizeViewArray.count; i++) {
        FBPrizeView *prizeView = self.prizeViewArray[i];
        prizeView.frame = CGRectMake(width * 21/156.0, width * (30 + i * 60)/156.0, width * 114/156.0, width * 45/156.0);
    }
}

@end

@interface FBPrizeView ()
@property (nonatomic, strong) UIImageView *prizeImageView;
@property (nonatomic, strong) UILabel *prizeNumberLable;
@end

@implementation FBPrizeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.prizeNumberLable = [UILabel new];
        self.prizeNumberLable.adjustsFontSizeToFitWidth = YES;
        self.prizeNumberLable.numberOfLines = 0;
        self.prizeNumberLable.textAlignment = NSTextAlignmentCenter;
        self.prizeNumberLable.textColor = [UIColor whiteColor];
        [self addSubview:self.prizeNumberLable];
        
        self.prizeImageView = [UIImageView new];
        [self addSubview:self.prizeImageView];
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
    [self setSubviewsLayoutWithFrame:self.frame];
}

- (void)setSubviewsLayoutWithFrame:(CGRect)frame
{
    self.prizeImageView.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
    self.prizeNumberLable.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height);
}


- (void)setPrizeImage:(UIImage *)prizeImage
{
    _prizeImage = prizeImage;
    self.prizeImageView.image = prizeImage;
}

- (void)setPrizeNumber:(NSInteger)prizeNumber
{
    _prizeNumber = prizeNumber;
    NSString *str = [NSString stringWithFormat:@"x %ld",prizeNumber];
    self.prizeNumberLable.text = str;
}


@end

@implementation FBPrizeModel


@end