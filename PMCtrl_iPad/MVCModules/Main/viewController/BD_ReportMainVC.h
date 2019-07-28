//
//  BD_ReportMainVC.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_ReportBaseModel;
@interface BD_ReportMainVC : UIViewController
@property(nonatomic,strong)NSString *moduleTestName;
@property(nonatomic,strong)NSString *objectMessageNum;
@property(nonatomic,strong)NSArray <BD_ReportBaseModel *> *reportDatas;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,assign)BD_TestModuleType moduleType;
//添加各个测试项报告数据；
-(void)loadReportViews;
@end
