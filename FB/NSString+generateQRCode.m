//
//  NSString+generateQRCode.m
//  QRCodeImageRender
//
//  Created by 朱志先 on 16/7/7.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "NSString+generateQRCode.h"

@implementation NSString (generateQRCode)


- (UIImage *)generateQRCodeImageWithLengthOfSide:(CGFloat)length
{
    return [UIImage generateQRCodeImageWithString:self withLengthOfSide:length];
}

- (UIImage *)generateQRCodeImageWithBackgroundImage:(UIImage *)backgroundImage
{
    return [UIImage generateQRCodeImageWithString:self andBackgroundImage:backgroundImage];
}






@end
