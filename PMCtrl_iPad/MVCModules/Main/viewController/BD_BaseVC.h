//
//  BD_BaseVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_BaseVC : UIViewController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>


-(void)configureUI;
-(void)configNavi;
@end
