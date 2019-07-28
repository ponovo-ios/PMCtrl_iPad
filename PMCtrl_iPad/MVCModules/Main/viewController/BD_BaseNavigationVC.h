//
//  BD_BaseNavigationVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_BaseNavigationVC : UINavigationController<UINavigationControllerDelegate>
//获取前一个VC
@property(nonatomic,strong) UIBarButtonItem *backButtonItem;
-(UIViewController *)getPreviousViewController;
@end
