//
//  BD_QuickTestIECView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_QuickTestIECParamModel.h"
/**
 *手动测试 IEC 参数设置页面
 */
@interface BD_QuickTestIECView : UIView
@property (weak, nonatomic) IBOutlet UIView *btncontentView;
@property (weak, nonatomic) IBOutlet UIView *paramContentView;
@property (nonatomic,strong)NSMutableArray <BD_QuickTestIECParam_ChangeRateModel *>  *iecParamDS;
@end
