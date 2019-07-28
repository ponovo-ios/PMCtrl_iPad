//
//  BD_PopListViewManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/7.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_PopListViewManager.h"
#import "BD_PopListViewCell.h"
@interface BD_PopListViewManager()
@end

@implementation BD_PopListViewManager

+(void)ShowPopViewWithlistDataSource:(NSArray *)arr textField:(UIView *)sourceView viewController:(UIViewController *)vc direction:(UIPopoverArrowDirection)direction complete:(void(^)(NSString *))complete{
    UIViewController *listVC;
    if (arr.count<=5) {
        //1.创建控制器
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //2.创建选项
        for (int i = 0; i<arr.count; i++) {
            UIAlertAction *onePointAction = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                complete(arr[i]);
                
            }];
            [onePointAction setValue:Black forKey:@"_titleTextColor"];
            [alertController addAction:onePointAction];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        listVC = alertController;
    } else {
        BD_PopListView *pop = [[BD_PopListView alloc]init];
        
        [pop.view setFrame:CGRectMake(0, 0, 300, 300)];
        pop.listdatasource = arr;
        [pop.tableView reloadData];
       

        pop.selctedTitleAction = ^(NSString *title) {
            complete(title);
        };
        listVC = pop;
    }
    
    listVC.modalPresentationStyle = UIModalPresentationPopover;
    listVC.preferredContentSize = CGSizeMake(sourceView.width,200);
    UIPopoverPresentationController *popPresenter = listVC.popoverPresentationController;
    popPresenter.sourceView = sourceView;
    popPresenter.sourceRect = sourceView.bounds;
   
    popPresenter.permittedArrowDirections = direction; //设置向下弹出
    [vc presentViewController:listVC animated:NO completion:nil];
}

+(void)showAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)message okAction:(void(^)())okAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okAction();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
}

+(void)showRemindAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:alertAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

@end
