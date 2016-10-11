//
//  UIView+AddGesture.m
//  ZXtouchView
//
//  Created by 朱志先 on 16/6/13.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "UIView+AddGesture.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, copy) void(^myTapBlock)(void);

@end

@implementation UIView (AddGesture)

static void *tapBlockKey = &tapBlockKey;

- (void)setMyTapBlock:(void (^)(void))myTapBlock
{
    objc_setAssociatedObject(self, & tapBlockKey, myTapBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))myBlock
{
    return objc_getAssociatedObject(self, &tapBlockKey);
}



- (void)AddTapGestureWithBlock:(void (^)(void))tapBlock
{
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:recongnizer];
    
    self.myTapBlock = tapBlock;
}

- (void)tap{
    self.myBlock();
}

-(void)AddTapGestureWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:recognizer];
}





@end
