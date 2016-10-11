//
//  ForgetPasswordView.h
//  LARPage
//
//  Created by 朱志先 on 16/6/26.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ForgetPasswordViewState) {
    ForgetPasswordViewStateUsePhone = 1,
    ForgetPasswordViewStateUseEmail  = 2,
};
@class ForgetPasswordView;
@protocol ForgetPasswordViewDelegate <NSObject>

- (void)ForgetPasswordViewGetDynamicPassWord:(ForgetPasswordView *)fpView WithPhoneNumber:(NSString *)phoneNumber;
- (void)ForgetPasswordViewGetDynamicPassWord:(ForgetPasswordView *)fpView WithEmail:(NSString *)email;

- (void)ForgetPasswordViewPrepareToVerify:(ForgetPasswordView *)fpView WithEmail:(NSString *)email AndPassword:(NSString *)password;

- (void)ForgetPasswordViewPrepareToVerify:(ForgetPasswordView *)fpView WithPhoneNumber:(NSString *)phoneNumber AndPassword:(NSString *)password;

@end


@interface ForgetPasswordView : UIView

@property (nonatomic, weak) id<ForgetPasswordViewDelegate> delegate;
@property (nonatomic, assign, readonly) ForgetPasswordViewState fpState;
@property (nonatomic, weak, readonly) NSString *phoneNumber;
@property (nonatomic, weak, readonly) NSString *password;


@end
