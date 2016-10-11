//
//  FBCameraView.h
//  SignUp
//
//  Created by 朱志先 on 16/7/14.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonBLOCK)(void);
@interface FBCameraView : UIView
@property (nonatomic, assign) NSInteger signUpDayNumber;
@property (nonatomic, strong) NSArray *prize;
@property (nonatomic, assign) BOOL isSignUpToday;
- (void)setTodayIsSignUpWithAnimation:(BOOL)isSignUpToday;
@property (nonatomic, copy) ButtonBLOCK closeButtonBlock;
@property (nonatomic, copy) ButtonBLOCK signUpButtonBlock;
@property (nonatomic, copy) ButtonBLOCK calendarButtonBlock;
@end


@interface FBCameraCardView : UIView
@property (nonatomic, assign) NSInteger dayNumber;
@property (nonatomic, assign) NSInteger prizeNumber;
@property (nonatomic, strong) UIImage *prizeImage;
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, assign) BOOL isSign;
- (void)setIsSignUpWithAnimation:(BOOL)isSign;

@end
