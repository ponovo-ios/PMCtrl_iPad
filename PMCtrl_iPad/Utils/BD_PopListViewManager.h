//
//  BD_PopListViewManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/7.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_PopListView.h"
@interface BD_PopListViewManager : NSObject

/**
   -----popView下拉列表
 @param  arr 下啦列表数据
 @param sourceView 弹出框源View
 @param vc 弹出view的控制器
 @param complete 选择完成后回掉方法
 */

+(void)ShowPopViewWithlistDataSource:(NSArray *)arr textField:(UIView *)sourceView viewController:(UIViewController *)vc direction:(UIPopoverArrowDirection)direction complete:(void(^)(NSString *))complete;


/**
 -----alert弹出框

 @param vc 弹出alert的控制器
 @param title alert title
 @param message alert message
 @param okAction 选择ok的方法
 */

+(void)showAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)message okAction:(void(^)())okAction;

+(void)showRemindAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)message;
@end
