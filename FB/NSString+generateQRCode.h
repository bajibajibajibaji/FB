//
//  NSString+generateQRCode.h
//  QRCodeImageRender
//
//  Created by 朱志先 on 16/7/7.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+ImageRendering.h"
@import UIKit;
@interface NSString (generateQRCode)
- (UIImage *)generateQRCodeImageWithLengthOfSide:(CGFloat)length;
- (UIImage *)generateQRCodeImageWithBackgroundImage:(UIImage *)backgroundImage;

@end
