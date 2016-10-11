//
//  FBNearByShopTableViewCell.m
//  RQCode0629
//
//  Created by 朱志先 on 16/6/30.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBNearByShopTableViewCell.h"
#import "Masonry.h"
@interface FBNearByShopTableViewCell()
@property (nonatomic, strong) UIImageView *FBImageView;
@property (nonatomic, strong) UILabel *FBLable;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIImageView *bottomImage;
@end
@implementation FBNearByShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bottomImage = [UIImageView new];
        self.bottomImage.image = [kGetImage(@"dot.png") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:(UIImageResizingModeTile)];
        [self.contentView addSubview:self.bottomImage];
        [self.bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(2);
            make.left.equalTo(self.contentView).offset(37);
            make.right.bottom.equalTo(self.contentView);
            
        }];
        
    }
    return self;
}

- (void)setShowArrowImage:(BOOL)showArrowImage
{
    _showArrowImage = showArrowImage;
    if (showArrowImage) {
        self.arrowImage = [UIImageView new];
        [self.contentView addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(6);
            make.height.equalTo(13);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-3);
        }];
        self.arrowImage.image = kGetImage(@"Jump nearby.png");

    }
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    if (!self.FBLable) {
        self.FBLable = [UILabel new];
        self.FBLable.numberOfLines = 2;
    }
    self.FBLable.text = text;
    self.FBLable.font = [UIFont systemFontOfSize:13];
    self.FBLable.textColor = [UIColor colorWithRed:97/256.0 green:12/256.0 blue:15/256.0 alpha:1];
    [self.contentView addSubview:self.FBLable];
    [self.FBLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(37);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(3);
        make.bottom.equalTo(self.bottomImage.top).offset(-2);
        
        make.height.greaterThanOrEqualTo(30);
    }];
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    if (!self.FBImageView) {
        self.FBImageView = [UIImageView new];
    }
    self.FBImageView.image = image;
    [self.contentView addSubview:self.FBImageView];
    [self.FBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

@end
