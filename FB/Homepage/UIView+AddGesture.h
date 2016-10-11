//
//  UIView+AddGesture.h
//  ZXtouchView
//
//  Created by 朱志先 on 16/6/13.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddGesture)
- (void)AddTapGestureWithBlock:(void(^)(void))tapBlock;
- (void)AddTapGestureWithTarget:(id)target action:(SEL)action;
@end
