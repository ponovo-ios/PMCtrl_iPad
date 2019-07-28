//
//  BD_ServiceManage.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/29.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Harm.pb.h"
@class BD_HarmModel;
@class BD_HarmTableDataModel;
@interface BD_ServiceManage : NSObject
/**谐波设置递变参数*/
-(void)harmsetGradientPara:(OutPutCommon::GradientPara *)gradientPara viewModel:(BD_HarmModel *)model;
/**谐波设置直流参数*/
-(void)harmSetDCPara:(Harm::DCPara *)dcParam viewModel:(BD_HarmModel *)model;
/**谐波设置通道数据*/
-(void)harmSetVolCurPara:(BD_HarmTableDataModel *)volData curData:(BD_HarmTableDataModel *)curData fre:(float)fre passsagewayArr:(NSMutableArray *)passagewayArr harmAnalog:(Harm::HarmAnalog *) harmAnalog isDigi:(BOOL)isDigi;
@end
