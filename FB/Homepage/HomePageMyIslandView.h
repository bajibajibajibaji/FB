//
//  HomePageMyIsland.h
//  mainLand3
//
//  Created by 朱志先 on 16/6/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageMyIslandView : UIView
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger coinNumber;
@property (nonatomic,assign) NSInteger messageNumber;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) UIFont *nickNameFont;
@property (nonatomic, strong) UIFont *coinAndRankLableFont;

@property (nonatomic, copy) void(^messageButtonBlock)(void);
@property (nonatomic, copy) void(^signUpButtonBlock)(void);

@end
