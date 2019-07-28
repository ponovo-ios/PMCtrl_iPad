//
//  BD_StateTestStateDiagramVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/15.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_QuickTestOscillographTBView.h"
#import "BD_PMCtrlSingleton.h"
#import "BD_TestDataParamModel.h"

@interface BD_StateTestStateDiagramVC : UIViewController
@property(nonatomic,strong)BD_QuickTestOscillographTBView *stateDiagramView;

@property (nonatomic,strong)NSMutableArray<NSMutableArray<BD_TestDataParamModel *> *> *vcDatas;
@property (nonatomic,assign)int binaryInValue;
@property (nonatomic,assign)int binaryOutValue;
///**初始化状态图数据*/
//-(void)loadStateDiagramData:(void(^)(NSMutableArray *))complete;
-(void)reloadTBView;
@property(nonatomic,assign)BOOL isLock;
@property(nonatomic,strong)BD_BeginTestModel *beginModel;
-(void)setBeginState;
@end
