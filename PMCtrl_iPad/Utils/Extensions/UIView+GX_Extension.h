//
//  UIView+GX_Extension.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/9/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(GX_Extension)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
//**centerX*/
@property (assign, nonatomic) CGFloat centerX;
//**centerY*/
@property (assign, nonatomic) CGFloat centerY;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;
@end
