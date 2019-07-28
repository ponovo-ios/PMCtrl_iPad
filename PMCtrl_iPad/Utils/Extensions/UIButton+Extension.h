//
//  UIButton+Extension.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    ButtonImgViewStyleTop,
    ButtonImgViewStyleLeft,
    ButtonImgViewStyleBottom,
    ButtonImgViewStyleRight,
} ButtonImgViewStyle;
@interface UIButton(Extension)



/**
 设置 按钮 图片所在的位置
 
 @param style   图片位置类型（上、左、下、右）
 @param size    图片的大小
 @param space 图片跟文字间的间距
 */
- (void)setImgViewStyle:(ButtonImgViewStyle)style imageSize:(CGSize)size space:(CGFloat)space;

-(instancetype)initWithTitle:(NSString *)title action:(SEL)action;
-(instancetype)initWithTitle:(NSString *)title target:(nonnull id )target radius:(CGFloat)radius borderColor:(UIColor *)borderColor titleColor:(UIColor *)titleColor action:(SEL)action;

-(void)setBtnUserUserInteractionState:(BOOL)state;
@end
