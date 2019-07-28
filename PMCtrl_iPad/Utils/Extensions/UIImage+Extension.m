//
//  UIImage+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage(Extension)
- (UIImage *)circleImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}



+(UIImage*)imageWithColor:(UIColor*) color width:(CGFloat)width height:(CGFloat)height title:(nullable NSString *)title;
{
    CGRect rect=CGRectMake(0.0f, 0.0f,width,height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
