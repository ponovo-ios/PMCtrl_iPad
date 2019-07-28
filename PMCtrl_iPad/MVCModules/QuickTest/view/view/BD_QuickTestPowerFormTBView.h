//
//  BD_QuickTestPowerFormTBView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_FormTBViewBaseModel;
@interface BD_QuickTestPowerFormTBView : UITableView
@property(nonatomic,strong)NSArray<NSArray<BD_FormTBViewBaseModel *> *> *powerDatasource;
@end
