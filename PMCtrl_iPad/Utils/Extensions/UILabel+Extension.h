//
//  UILabel+Extension.h
//  yunbaoan
//
//  Created by 杨博宇 on 16/11/20.
//  Copyright © 2016年 杨博宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment sizeToFit:(BOOL)sizeToFit;

@end
