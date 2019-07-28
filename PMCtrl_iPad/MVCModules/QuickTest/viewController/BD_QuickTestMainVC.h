//
//  BD_QuickTestMainVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BD_QuickTestCustomView;
@class BD_QuickTestResultModel;
@class BD_HardwareConfigView;

@interface BD_QuickTestMainVC : BD_BaseVC
@property(nonatomic,strong)NSMutableArray<NSMutableArray *>  *quickTestData;
@property(nonatomic,assign)BOOL isLock;
//@property(nonatomic,assign)BOOL isBegin;
@property(nonatomic,strong)BD_BeginTestModel *beginModel;
@property(nonatomic,strong)BD_QuickTestCustomView *startBtnView;
@property(nonatomic,strong)BD_HardwareConfigView *hardWareView;

@end
