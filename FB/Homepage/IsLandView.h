//
//  IsLandView.h
//  mainLand
//
//  Created by 朱志先 on 16/6/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AddGesture.h"
#import "IsLandItem.h"



@interface IsLandView : UIView

@property (nonatomic, strong) IsLandItem *item;
- (void)stopAnimate;
- (void)startAnimate;

@end