//
//  ZXRollingNumberView.h
//  ZZXRollingNumberView
//
//  Created by 朱志先 on 16/6/12.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXRollingNumberView : UIView

@property (strong, nonatomic) NSNumber *value;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;
@property (assign, nonatomic) NSUInteger density;
@property (assign, nonatomic) NSUInteger minLength;
@property (assign, nonatomic) BOOL isAscending;

- (void)startAnimation;
- (void)stopAnimation;

@end
