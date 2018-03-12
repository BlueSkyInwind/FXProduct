//
//  UIImage+extention.m
//  fengxianProduct
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "UIImage+extention.h"

@implementation UIImage (extention)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
