//
//  BD_ServiceManage.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/29.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ServiceManage.h"
#import "BD_HarmModel.h"


@implementation BD_ServiceManage
#pragma mark - 谐波设置直流参数
-(void)harmSetDCPara:(Harm::DCPara *)dcParam viewModel:(BD_HarmModel *)model{
    
    if (model.testChannel == F_U_T_I) {//4U3I
        //设置直流电压
        dcParam -> add_analogvolt(model.dcSettingModel.ua.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.ub.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.uc.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.uz.floatValue);
        //设置直流电流
        dcParam -> add_analogcurrent(model.dcSettingModel.ia.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ib.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ic.floatValue);
    }else{//6U6I
        //设置直流电压
        dcParam -> add_analogvolt(model.dcSettingModel.ua.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.ub.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.uc.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.ua2.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.ub2.floatValue);
        dcParam -> add_analogvolt(model.dcSettingModel.uc2.floatValue);
        //设置直流电流
        dcParam -> add_analogcurrent(model.dcSettingModel.ia.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ib.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ic.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ia2.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ib2.floatValue);
        dcParam -> add_analogcurrent(model.dcSettingModel.ic2.floatValue);
    }
    
}

//谐波设置递变参数
-(void)harmsetGradientPara:(OutPutCommon::GradientPara *)gradientPara viewModel:(BD_HarmModel *)model{
    //创建输出模型参数设置
    
    //模拟变量
    if ([model.dataModel.channelPort isEqualToString:@"Va"] || [model.dataModel.channelPort isEqualToString:@"Va`"]) {
        gradientPara -> set_ivar(::OutPutCommon::para_type::va1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vb"] || [model.dataModel.channelPort isEqualToString:@"Vb`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vb1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vc"] || [model.dataModel.channelPort isEqualToString:@"Vc`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vc1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vz"] || [model.dataModel.channelPort isEqualToString:@"Vz`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vz_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Va2"] || [model.dataModel.channelPort isEqualToString:@"Va2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::va2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vb2"] || [model.dataModel.channelPort isEqualToString:@"Vb2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vb2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vc2"] || [model.dataModel.channelPort isEqualToString:@"Vc2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vc2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Va,Vb"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vab1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vb,Vc"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vbc1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Vc,Va"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vca1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Va,Vb,Vc"] || [model.dataModel.channelPort isEqualToString:@"Va`,Vb`,Vc`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vabc1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Va2,Vb2,Vc2"] || [model.dataModel.channelPort isEqualToString:@"Va2`,Vb2`,Vc2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vabc2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ia"] || [model.dataModel.channelPort isEqualToString:@"Ia`"]) {
        gradientPara -> set_ivar(::OutPutCommon::para_type::ia1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ib"] || [model.dataModel.channelPort isEqualToString:@"Ib`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ib1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ic"] || [model.dataModel.channelPort isEqualToString:@"Ic`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ic1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ia2"] || [model.dataModel.channelPort isEqualToString:@"Ia2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ia2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ib2"] || [model.dataModel.channelPort isEqualToString:@"Ib2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ib2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ic2"] || [model.dataModel.channelPort isEqualToString:@"Ic2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ic2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ia,Ib"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::iab1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ib,Ic"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ibc1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ic,Ia"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::ica1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ia,Ib,Ic"] || [model.dataModel.channelPort isEqualToString:@"Ia`,Ib`,Ic`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::iabc1_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Ia2,Ib2,Ic2"] || [model.dataModel.channelPort isEqualToString:@"Ia2`,Ib2`,Ic2`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::iabc2_type);
    } else if ([model.dataModel.channelPort isEqualToString:@"Va,Vb,Vc,Vz"] || [model.dataModel.channelPort isEqualToString:@"Va`,Vb`,Vc`,Vz`"]){
        gradientPara -> set_ivar(::OutPutCommon::para_type::vall_type);
    }
    
    //模拟变量类型
    gradientPara -> set_itype(OutPutCommon::changed_type::amplitude_type);
    //模拟变量步长
    gradientPara -> set_fstep(model.dataModel.step.floatValue);
    //模拟变量变化时间
    gradientPara -> set_fsteptime(model.dataModel.time.floatValue);
    //模拟变量变化初值
    gradientPara -> set_fstart(model.dataModel.start.floatValue);
    //模拟变量变化终值
    gradientPara -> set_fend(model.dataModel.end.floatValue);
    //0 base ,1:100Hz  谐波次数
    if ([model.dataModel.passagewayIndex isEqualToString:@"基波"]) {
        gradientPara -> set_nharm(0);
    }else{
        gradientPara -> set_nharm(model.dataModel.passagewayIndex.intValue - 1);
    }
}

#pragma mark - 谐波设置通道数据
-(void)harmSetVolCurPara:(BD_HarmTableDataModel *)volData curData:(BD_HarmTableDataModel *)curData fre:(float)fre passsagewayArr:(NSMutableArray *)passagewayArr harmAnalog:(Harm::HarmAnalog *) harmAnalog isDigi:(BOOL)isDigi{
    
    //遍历每列
    for (NSInteger m = 0; m <volData.headerDataArray.count; m++) {
        //添加输出模型数据设置
        OutPutCommon::acanalogpara *oacanlogpara;
        if (!isDigi) {
            oacanlogpara = harmAnalog->add_oacanlogpara();
        } else {
            oacanlogpara = harmAnalog->add_oacdigitalpara();
        }
        
        //遍历选中谐波次数
        for (NSInteger j = 0; j < passagewayArr.count; j++) {
            //选中行下标
            NSInteger index;
            if (j == 0) {
                index = 0;
            }else{
                index = [passagewayArr[j] integerValue] - 1;
            }
            //行数据模型
            BD_HarmCellModel *cellModel = volData.contentDataArray[index];
            //item模型
            BD_HarmItem *item = cellModel.itemArray[m];
            
            //电压
            OutPutCommon::chanelpara *analogvoltchangelvalue = oacanlogpara -> add_analogvoltchangelvalue();
            //幅值
            analogvoltchangelvalue -> set_famptitude(item.validValues.floatValue);
            //频率
            analogvoltchangelvalue -> set_ffre(fre);
            //相位
            analogvoltchangelvalue -> set_fphase(item.phase.floatValue);
            
            //电流
            //行数据模型
            BD_HarmCellModel *cellModel1 = curData.contentDataArray[index];
            //item模型
            if (m<cellModel1.itemArray.count) {
                BD_HarmItem *item1 = cellModel1.itemArray[m];
                //添加电流设置
                OutPutCommon::chanelpara *analogcurrentchanelvalue = oacanlogpara -> add_analogcurrentchanelvalue();
                //幅值
                analogcurrentchanelvalue -> set_famptitude(item1.validValues.floatValue);
                //频率
                analogcurrentchanelvalue -> set_ffre(fre);
                //相位
                analogcurrentchanelvalue -> set_fphase(item1.phase.floatValue);
            }
            
        }
    }
    
   DLog(@"结果")
}
@end
