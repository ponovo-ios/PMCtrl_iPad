//
//  BD_TabbarUtil.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_TabbarUtil.h"

@implementation BD_TabbarUtil

-(void)setBackgroundImage:(UITabBar *)tabbar imageName:(NSString *)imageName{
    [tabbar setBackgroundImage:[[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch]];
}

-(void)setBarItemTitleNormalColor:(UITabBarItem *)barItem color:(UIColor *)color{
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
}

-(void)setBarItemTitleSelectedColor:(UITabBarItem *)barItem color:(UIColor *)color{
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
}

-(void)setBarItemNormalImage:(UITabBarItem *)barItem imageName:(NSString *)imageName{
    [barItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

-(void)setBarItemSelectedImage:(UITabBarItem *)barItem imageName:(NSString *)imageName{
    [barItem setSelectedImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
