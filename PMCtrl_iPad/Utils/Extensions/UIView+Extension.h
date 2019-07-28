//
//  UIView+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(Extension)


@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property NSTimeInterval* duration;


//对指定角设置默认圆角
-(void)setDefaultRadiuWithCorners:(UIRectCorner)corners;
//对指定角设置圆角，并指定圆角弧度
-(void)setRadiuWithCorners:(UIRectCorner)corners radiu:(CGFloat)radiu;

/**
*设置边框和圆角
 *radiu  圆角的大小
 *borderColor 边框的颜色
 *borderWidth 边框宽度
*/
-(void)setCorenerRadius:(CGFloat)radiu borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 *设置默认的圆角
 param borderColor 边框颜色
 */

-(void)setDefaultCornerRadiusWithColor:(UIColor *)borderColor;


-(UIImage *)toImage;

//设置view的阴影

-(void)setShadowColor;

/**
 *  获取视图所在的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)GetSubordinateControllerForSelf;
/**
 *  视图添加动画
 *
 *  @param type  kCATransitionPush
 *  @param subType  kCATransitionFromRight
 *  @param duration animation time 
 */

-(void)transitionWithType:(NSString *)type withSubType:(NSString *)subType withDuration:(CGFloat)duration;
/**根据tag获取button*/
-(UIButton *)viewWithTagToBtn:(NSInteger)tag;
/**根据tag获取label*/
-(UILabel *)viewWithTagToLabel:(NSInteger)tag;
/**根据tag获取textField*/
-(UITextField *)viewWithTagToTF:(NSInteger)tag;
/**将view转换为同等大小的image进行保存*/
-(UIImage *)saveToImage;
/**将view保存为pdf文件
 @param fileName 沙盒中文件的地址，是完整的地址
 */
-(void)saveToPDfInFileName:(NSString *)fileName;
@end
