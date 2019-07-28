//
//  BD_QuickTestParamTBView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BD_QuickTestParamCell.h"
@class BD_TestDataParamModel;


@interface BD_QuickTestParamTBView : UITableView

@property(nonatomic,strong)NSMutableArray<BD_TestDataParamModel *> *datasource;
@property(nonatomic,strong)void(^quickTBParaBlack)(BD_TestDataParamModel *,NSInteger);
@property(nonatomic,assign)BOOL isBegin;
@property(nonatomic,assign)BOOL isLock;
@property (nonatomic,assign)BD_CellType type;
@property (nonatomic,strong)NSArray<NSString *> *headerTitleArr;
@property(nonatomic,assign)BOOL isDirectCurrent;

@end
