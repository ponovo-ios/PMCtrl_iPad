//
//  BD_TabbarUtil.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_TabbarUtil : NSObject
/**设置背景图片*/
-(void)setBackgroundImage:(UITabBar *)tabbar imageName:(NSString *)imageName;
/**设置barItem未选中标题的颜色*/
-(void)setBarItemTitleNormalColor:(UITabBarItem *)barItem color:(UIColor *)color;
/**设置barItem选中标题的颜色*/
-(void)setBarItemTitleSelectedColor:(UITabBarItem *)barItem color:(UIColor *)color;
/**设置baritem未选中时的图片*/
-(void)setBarItemNormalImage:(UITabBarItem *)barItem imageName:(NSString *)imageName;
/**设置baritem未选中时的图片*/
-(void)setBarItemSelectedImage:(UITabBarItem *)barItem imageName:(NSString *)imageName;
@end
