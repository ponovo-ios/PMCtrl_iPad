//
//  BD_StateTestVectorgraphVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/15.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_QuickTestVectorgraphTBView.h"
#import "BD_QuickTestVactorgraphModel.h"
#import "BD_TestDataParamModel.h"

@interface BD_StateTestVectorgraphVC : UIViewController
@property(nonatomic,strong)BD_QuickTestVectorgraphTBView  *vectorgraphView;
@property(nonatomic,strong)NSMutableArray *vectorgraphDataArr;
/** 配置矢量图数据源*/
-(void)computationsVectorgraphViewData:(NSMutableArray<BD_TestDataParamModel *> *)voltageArr currentArr:(NSMutableArray<BD_TestDataParamModel *> *)currentArr;
@end
