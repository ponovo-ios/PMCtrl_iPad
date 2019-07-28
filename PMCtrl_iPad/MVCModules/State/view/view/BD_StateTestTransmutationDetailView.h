//
//  BD_StateTestTransmutationDetailView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/7.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_StateTestTransmutationDetailModel.h"


@interface BD_StateTestTransmutationDetailView : UIView
@property(nonatomic,strong)UITableView *tableView;
//递变设置数据模型
@property(nonatomic,strong)BD_StateTestTransmutationDetailModel *transmutationDataModel;
//递变设置类型
@property(nonatomic,assign)BDGradientType gradientType;
//变量类型数组
@property(nonatomic,strong)NSArray *paraTypeArr;

-(void)showView;
@property (nonatomic,strong)void(^trandmutationEndEditBlock)();
@property(nonatomic,assign)BOOL isDirectCurr ;
@end
