//
//  FBLoginButton.h
//  buttontest
//
//  Created by 朱志先 on 16/7/10.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FBLoginButtonType) {
    FBLoginButtonTypeLogin,
    FBLoginButtonTypeNext,
    FBLoginButtonTypeDone,
};

typedef void(^ButtonBlock)(void);
@interface FBLoginButton : UIView
@property (nonatomic, assign) FBLoginButtonType buttonType;
@property (nonatomic, copy) ButtonBlock buttonBlock;


@end
