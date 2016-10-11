//
//  FBSignCalendarView.h
//  SignUp
//
//  Created by 张丹 on 16/7/17.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBCalendarCardView.h"

@interface FBSignCalendarView : UIView
@property (nonatomic, assign, readonly) NSInteger days;
@property (nonatomic, assign) NSInteger signUpDayNumber;

- (void)moveToLeft;
- (void)moveToRight;



@end
