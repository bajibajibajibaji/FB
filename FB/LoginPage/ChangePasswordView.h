//
//  ChangePasswordView.h
//  LARPage
//
//  Created by 朱志先 on 16/6/26.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChangePasswordView;
@protocol ChangePasswordViewDelegate <NSObject>

- (void) ChangePasswordViewChangePassword:(ChangePasswordView *)cpView WithNewPassWord:(NSString *)newPassword;

@end

@interface ChangePasswordView : UIView

@property (nonatomic, weak) id<ChangePasswordViewDelegate> delegate;
@property (nonatomic, weak, readonly) NSString *password;

@end
