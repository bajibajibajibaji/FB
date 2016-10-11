//
//  FBCalendarCardView.h
//  SignUp
//
//  Created by 朱志先 on 16/7/15.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBPrizeModel : NSObject
@property (nonatomic, strong) UIImage *prizeImage;
@property (nonatomic, assign) NSInteger prizeNumber;
@end

@interface FBCalendarCardView : UIControl
@property (nonatomic, assign) BOOL showDivision;
@property (nonatomic, assign) NSInteger dayNumber;
@property (nonatomic, assign) BOOL isSign;
@property (nonatomic, assign) NSInteger prizeNumber;
@property (nonatomic, strong) UIImage *prizeImage;
@property (nonatomic, strong) NSArray<FBPrizeModel*> *prizeArray;
@end

@interface FBPrizePreviewView : UIView
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) NSArray<FBPrizeModel*> *prizeArray;
@end

@interface FBPrizeView : UIView
@property (nonatomic, strong) UIImage *prizeImage;
@property (nonatomic, assign) NSInteger prizeNumber;

@end

