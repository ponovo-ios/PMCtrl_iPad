//
//  BD_TestDataParaVC.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/31.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_TestItemParamModel;
@interface BD_TestDataParaVC : UIViewController
@property(nonatomic,strong)NSMutableArray<BD_TestItemParamModel *> *testListDataSource;

-(void)reloadAllDatas;
@end
