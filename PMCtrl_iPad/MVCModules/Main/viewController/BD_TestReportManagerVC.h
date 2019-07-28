//
//  BD_TestReportManagerVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/23.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_ReportInfoModel;
@interface BD_TestReportManagerVC : UIViewController
@property(nonatomic,strong)NSArray <BD_ReportInfoModel *> *reportListDatas;
@end
