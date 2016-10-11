//
//  UIImage+BlurImage.h
//  LARPage
//
//  Created by 朱志先 on 16/6/24.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (BlurImage)
- (UIImage*)gaussBlur:(CGFloat)blurLevel;
@end
