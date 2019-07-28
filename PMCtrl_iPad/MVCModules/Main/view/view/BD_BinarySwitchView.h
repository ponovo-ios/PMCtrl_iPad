//
//  BD_HarmSwitchView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  底部开关量视图

#import <UIKit/UIKit.h>

@interface BD_BinarySwitchView : UIView
@property(nonatomic,strong)NSMutableArray<UIButton *> *switchBtnArr;
/**
 根据指示灯名称数组新建指示灯view
 */
 
-(instancetype)initWithTitleArray:(NSArray *)array;
/**根据分组的情况，添加电流指示灯情况*/
-(void)addCurrentLightWithGroup:(NSInteger)groupNum;
@end
