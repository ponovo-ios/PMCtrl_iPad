//
//  BD_DifferentialSetTBView.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/8/29.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingValueModel.h"
@interface BD_DifferentialSetTBView : UITableView
@property (nonatomic, copy) NSMutableArray * modelArr;
@property (nonatomic,strong)NSMutableArray<SettingValueModel *> *setResultArr;
@property (nonatomic,copy)void (^settingResultBlock)(NSMutableArray *resultArr);
@property (nonatomic,copy) void(^showSettingBlock)(UIButton *btn);
-(void)endEditing;
@end
