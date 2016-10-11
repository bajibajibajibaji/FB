//
//  HomePageSideButton.h
//  ResizeButton
//
//  Created by 朱志先 on 16/7/5.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageSideButton : UIView
@property (nonatomic, strong) NSString *lableText;
@property (nonatomic, strong) UIImage *titleImage;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSInteger inset;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSInteger badgeNumber;
@property (nonatomic, copy) void(^clickBlock)(void);
@end
