//
//  FBNearByShopView.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/30.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBNearByShopView.h"
#import "FBNearByShopTableViewCell.h"
#import "UIImage+ImageRendering.h"

@interface FBNearByShopView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UILabel *distanceLable;
@property (nonatomic, strong) UITableView *tableview;

@end
@implementation FBNearByShopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLable = [UILabel new];
        self.shopImageView = [UIImageView new];
        self.distanceLable = [UILabel new];
        self.tableview = [UITableView new];
        
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.shopImageView];
        [self.contentView addSubview:self.distanceLable];
        [self.contentView addSubview:self.tableview];
        
        [self setSubviewsFrame:(CGRect)frame];
        [self setSubviewsContent];
        
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (self.titleLable) {
        [self setSubviewsFrame:frame];
    }
}


- (void)setSubviewsFrame:(CGRect)superViewFrame
{
    CGFloat WRatio = superViewFrame.size.width/969;
    CGFloat HRation = superViewFrame.size.height/1368;
    self.titleLable.frame = CGRectMake(87 * WRatio, 0, 780 * WRatio, 99 * HRation);
    self.shopImageView.frame = CGRectMake(87 * WRatio, 99 * HRation, 780 * WRatio, 540 * HRation);
    self.distanceLable.frame = CGRectMake(87 * WRatio, 660 * HRation, 780 * WRatio, 90 * HRation);
    self.tableview.frame = CGRectMake(87 * WRatio, 756 * HRation, 780 * WRatio, 440 * HRation);
}

- (void)setSubviewsContent
{
    self.titleLable.textColor = [UIColor colorWithRed:97/256.0 green:12/256.0 blue:15/256.0 alpha:1];
    self.titleLable.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:16];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.text = @"离我最近的漂流点";
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight = 37;

    [self setDistanceLableText:200];
    
}

- (void)setDistanceLableText:(CGFloat)distance
{
    self.distanceLable.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *distanceTextFront= [[NSMutableAttributedString alloc]initWithString:@"距离您"];
    distanceTextFront.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
    distanceTextFront.color = [UIColor colorWithRed:97/256.0 green:12/256.0 blue:15/256.0 alpha:1];
    NSMutableAttributedString *distanceText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.0fkm ",distance]];
    distanceText.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    distanceText.color = [UIColor redColor];


 
    NSMutableAttributedString *distanceTextBottom = [[NSMutableAttributedString alloc]initWithString:@"的距离"];
    distanceTextBottom.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];
    distanceTextBottom.color = [UIColor colorWithRed:97/256.0 green:12/256.0 blue:15/256.0 alpha:1];
    
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    [str appendAttributedString:distanceTextFront];
    [str appendAttributedString:distanceText];
    [str appendAttributedString:distanceTextBottom];
    self.distanceLable.attributedText = str;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBNearByShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FBNearByShopTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.image = kGetImage(@"nearshop.png");
            cell.text = @"玩具反斗城（世界城广场店）";
            break;
        case 1:
            cell.image = kGetImage(@"activity.png");
            cell.text = @"年中大促满100,送100现金券";
            break;
        case 2:
            cell.image = kGetImage(@"add.png");
            cell.text = @"洪山区武汉市东湖新技术开发区珞喻路766号世界城广场4楼401-406号商铺";
            cell.showArrowImage = YES;
            break;
        case 3:
            cell.image = kGetImage(@"shop_phone.png");
            cell.text = @"123-345-22331";
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)setShopImage:(UIImage *)shopImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [shopImage systhsisWithBorderImage:kGetImage(@"paperBoder.png") andSize:(CGSizeMake(260, 180)) andCornerRadius:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            _shopImage = shopImage;
            self.shopImageView.image = image;
        });
    });
 
}

@end
