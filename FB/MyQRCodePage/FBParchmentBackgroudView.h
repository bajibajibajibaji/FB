//
//  FBParchmentBackgroudView.h
//  RQCode0629
//
//  Created by 朱志先 on 16/6/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapCloseButtonBlock)();

@interface FBParchmentBackgroudView : UIView
@property (nonatomic, weak, readonly) UIView *contentView;
@property (nonatomic, copy) TapCloseButtonBlock closeButtonHandler;



@end
