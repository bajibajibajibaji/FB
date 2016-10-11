//
//  FBLevelUpView.h
//  mask
//
//  Created by 朱志先 on 16/7/22.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FBLevelUpPrizeModel;
@interface FBLevelUpView : UIView
@property (nonatomic, assign) NSInteger newLevel;
@property (nonatomic, assign) NSInteger exp;
@property (nonatomic, strong) NSArray<FBLevelUpPrizeModel *> *prizeArray;
- (void)startAnimation;
@end

@interface FBLevelUpPrizeView : UIView
@property (nonatomic, assign) NSInteger prizeNumberl;
@property (nonatomic, strong) UIImage *prizeImage;
@end

@interface FBLevelUpPrizeModel : NSObject
@property (nonatomic, strong) UIImage *prizeImage;
@property (nonatomic, assign) NSInteger prizeNumber;
@end


