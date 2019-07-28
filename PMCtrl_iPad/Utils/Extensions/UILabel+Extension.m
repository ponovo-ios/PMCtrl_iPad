//
//  UILabel+Extension.m
//  yunbaoan
//
//  Created by 杨博宇 on 16/11/20.
//  Copyright © 2016年 杨博宇. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment sizeToFit:(BOOL)sizeToFit{

    UILabel *label = [[UILabel alloc] init];
    
    label.text = text;
    
    label.textColor = textColor;
    
    label.font = [UIFont systemFontOfSize:fontSize];
    
    label.textAlignment = alignment;
    
    label.numberOfLines = 0; //设置自动换行
    
    if (sizeToFit) {
        [label sizeToFit];
    }
    
    return label;
}

@end
