//
//  BD_IECParamSettingVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_QuickTestIECParamModel.h"
@interface BD_IECParamSettingVC : BD_BaseVC
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray <BD_QuickTestIECParam_ChangeRateModel *>  *iecParamDS;
@end
