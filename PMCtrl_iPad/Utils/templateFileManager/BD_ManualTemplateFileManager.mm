//
//  BD_ManualTemplateFileManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ManualTemplateFileManager.h"
#import "BD_QuickTestParamModel.h"
#import "BD_TestDataParamModel.h"
#import "manuTest.pb.h"
#import "BD_ProtobufStructCommonManager.h"
@implementation BD_ManualTemplateFileManager
#pragma mark - 保存模版文件
-(bool)saveTemplateFile:(NSArray *)values fileName:(NSString *)fileName{
    //1.定义消息变量
    ManuTestPara::TestItem oiTem;
    
    //2级
    /*
     oiTem.set_otesttype(hqyPudPara::para_type::manual_type);//设置测试类型
     hqyPudPara::manualpara* manualPara = oiTem.mutable_omanual();//配置
     */
    //2级别 TestItem
    ManuTestPara::CommonPara* commonPara = oiTem.mutable_ocommonpara();//通用参数
    OutPutCommon::acanalogpara* oacanlogpara = oiTem.mutable_oacanlogpara();//模拟量电流电压通道
    OutPutCommon::acanalogpara* oacdigitalpara = oiTem.mutable_oacdigitalpara();//数字量电流电压通道
    OutPutCommon::GradientPara* oanaGradientpara = oiTem.mutable_oanagradientpara();//模拟量递变参数
    OutPutCommon::GradientPara* odigRadientpara = oiTem.mutable_odiggradientpara();//数字量递变参数
    ManuTestPara::SwitchPara* owitchpara = oiTem.mutable_oswitchpara();//开入变位
    
    /*
     //3级
     manualpara下级
     hqyPudPara::acpara *oacpara = manualPara->mutable_oacpara();
     manualPara->set_sendzeroafterstop(2);
     */
    //3级别
    //CommonPara组装
    BD_QuickTestComSetModel *model;
    if (values.count>=3) {
        model = (BD_QuickTestComSetModel *)values[values.count-1][0];
    }
    
    commonPara->set_ftrigdelay([model.delayTime floatValue]);//触发延时
    commonPara->set_bagingtest([@(model.isAgingTest) intValue]);//是否老化试验
    commonPara->set_bdctest([@(model.isCocurrent) intValue]);//是否直流试验
    commonPara->set_block([@(model.isLock) intValue]);//是否锁定
    commonPara->set_itesttype(model.autoChangeStyle);
    
    //oacanlogpara模拟量通道 oacdigitalpara数字量通道 oanaGradientpara模拟量递变参数 odigRadientpara数字量递变参数组装
    //如果模拟 oacanlogpara组装 oanaGradientpara组装 如果数字oacdigitalpara odigRadientpara 组装
    if ([BD_PMCtrlSingleton shared].deviceType==BDDeviceType_Imitate) {
        
        [BD_ProtobufStructCommonManager messageData:values object:oacanlogpara];
        //模拟变量
        oanaGradientpara->set_ivar([BD_ProtobufStructCommonManager varTypeStringToProbuf:model.varlabel]);
        oanaGradientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//模拟变量类型
        oanaGradientpara->set_fstep([model.stepValue floatValue]);//模拟变量步长
        oanaGradientpara->set_fsteptime([model.changeTime floatValue]);//模拟变量变化时间
        oanaGradientpara->set_fstart([model.startValue floatValue]);//模拟变量变化初始值
        oanaGradientpara->set_fend([model.endValue floatValue]);//模拟变量变化终值
        
    } else if ([BD_PMCtrlSingleton shared].deviceType==BDDeviceType_Digit){
        
        [BD_ProtobufStructCommonManager messageData:values object:oacdigitalpara];
        //数字变量
        odigRadientpara->set_ivar([BD_ProtobufStructCommonManager varTypeStringToProbuf:model.varlabel]);
        odigRadientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//数字变量类型
        odigRadientpara ->set_fstep([model.stepValue floatValue]);//数字变量步长
        odigRadientpara->set_fsteptime([model.changeTime floatValue]);//数字变量变化时间
        odigRadientpara->set_fstart([model.startValue floatValue]);//数字变量变化初始值
        odigRadientpara->set_fend([model.endValue floatValue]);//数字变量变化终值
    } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_ImitateDigit){
         //数模一体，前6路是模拟，后6路是数字，将前6路添加到模拟对应的通道参数，将后6路添加到数字对应的通道参数
        NSMutableArray *anlogArr = [[NSMutableArray  alloc]init];
        NSMutableArray *digitalArr = [[NSMutableArray  alloc]init];
        
        if (values.count>=2) {
            NSArray * voltages = (NSArray *)values[0];
            NSArray *currents = (NSArray *)values[1];
            NSMutableArray *vol = [[NSMutableArray alloc]init];
            NSMutableArray *cur = [[NSMutableArray alloc]init];
            for (NSInteger i = 0; i<6; i++) {
                [vol addObject:voltages[i]];
                [cur addObject:currents[i]];
            }
            [anlogArr addObject:[vol copy]];
            [anlogArr addObject:[cur copy]];
            NSMutableArray *dvol = [[NSMutableArray alloc]init];
            NSMutableArray *dcur = [[NSMutableArray alloc]init];
            for (NSInteger i = 6; i<voltages.count; i++) {
                [dvol addObject:voltages[i]];
               
            }
            for (NSInteger i = 6; i<currents.count; i++) {
               [dcur addObject:currents[i]];
            }
            [digitalArr addObject:[dvol copy]];
            [digitalArr addObject:[dcur copy]];
        }
        [BD_ProtobufStructCommonManager messageData:[anlogArr copy] object:oacanlogpara];
        [BD_ProtobufStructCommonManager messageData:[digitalArr copy] object:oacdigitalpara];
        //模拟变量
        oanaGradientpara->set_ivar([BD_ProtobufStructCommonManager varTypeStringToProbuf:model.varlabel]);
        oanaGradientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//模拟变量类型
        oanaGradientpara->set_fstep([model.stepValue floatValue]);//模拟变量步长
        oanaGradientpara->set_fsteptime([model.changeTime floatValue]);//模拟变量变化时间
        oanaGradientpara->set_fstart([model.startValue floatValue]);//模拟变量变化初始值
        oanaGradientpara->set_fend([model.endValue floatValue]);//模拟变量变化终值
        //数字变量
        odigRadientpara->set_ivar([BD_ProtobufStructCommonManager varTypeStringToProbuf:model.varlabel]);
        odigRadientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//数字变量类型
        odigRadientpara ->set_fstep([model.stepValue floatValue]);//数字变量步长
        odigRadientpara->set_fsteptime([model.changeTime floatValue]);//数字变量变化时间
        odigRadientpara->set_fstart([model.startValue floatValue]);//数字变量变化初始值
        odigRadientpara->set_fend([model.endValue floatValue]);//数字变量变化终值
    }
    
    //开入量组装
    owitchpara->set_iinput([model.binaryIn intValue]);
    owitchpara->set_ilogic([@(model.binaryLogic) intValue]);
    owitchpara->set_ioutput([model.binaryOut intValue]);
    
    
    
    /*   manualPara->set_ndelaytime([model.delayTime floatValue]);   //接收到开入后延时多长时间停止
     manualPara->set_nisstopbichanged([@(YES) intValue]); //开入变位后是否停止
     
     //4级
     //oacpara下级
     hqyPudPara::acanalogpara *pacanalogpara = oacpara->mutable_oacanlogpara();
     oacpara->set_nbinaryout([model.binaryIn floatValue]); //开入量
     //5级
     //pacanalogpara下级
     */
    
    int size = oiTem.ByteSize();
    
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    oiTem.SerializePartialToArray(pchar, size);
    NSData *pdata = [NSData dataWithBytes:pchar length:size];
    if ([FileUtil writeDataToFileName:[fileName stringByAppendingString:@".properties"] data:pdata]) {
        free(pchar);
        return true;
    } else {
        free(pchar);
        return  false;
    }
    
}

#pragma mark - 读取模版文件
-(NSArray * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName{
    NSData *result = [FileUtil readDataToFileName:fileName];
     ManuTestPara::TestItem oiTem;
    bool bRet = oiTem.ParsePartialFromArray([result bytes],(int)[result length]);//将读取到的二进制串进行反序列化
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    BD_QuickTestComSetModel *model = [[BD_QuickTestComSetModel alloc]init];
    NSMutableArray<BD_TestDataParamModel *> *voltageChannel = [[NSMutableArray alloc]init];
    NSMutableArray<BD_TestDataParamModel *> *currentChannel = [[NSMutableArray alloc]init];
    if (bRet) {
        //将protobuf结构的内容转换为对应试验的模型数组:数组中应该包换三项内容，其中前两项为输出数据，分别为电压／电流输出数据，第三相为参数BD_QuickTestComSetModel类型的数据，
        model.delayTime = [NSString stringWithFormat:@"%.3f",oiTem.ocommonpara().ftrigdelay()];
        model.isAgingTest = oiTem.ocommonpara().bagingtest();
        model.isCocurrent = oiTem.ocommonpara().bdctest();
        model.isLock = oiTem.ocommonpara().block();
        model.autoChangeStyle = oiTem.ocommonpara().itesttype();
        if (oiTem.oacanlogpara().analogcurrentchanelvalue_size()==0 && oiTem.oacdigitalpara().analogcurrentchanelvalue_size() != 0) {
            //数字
            
            int channel_V = oiTem.oacdigitalpara().analogvoltchangelvalue_size();//电压通道个数
            for (int i = 0; i<channel_V; i++) {
                BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacdigitalpara().analogvoltchangelvalue(i);
                channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [voltageChannel addObject:channel_V];
            }
            
            int channel_C = oiTem.oacdigitalpara().analogcurrentchanelvalue_size();//电流通道个数
            for (int i = 0; i<channel_C; i++) {
                BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacdigitalpara().analogcurrentchanelvalue(i);
                channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [currentChannel addObject:channel_C];
            }
            [resultArr addObject:[voltageChannel copy]];//添加电压通道数据
            [resultArr addObject:[currentChannel copy]];//添加电流通道数据
            model.varlabel = [BD_ProtobufStructCommonManager protobufTypeToStrvarType:oiTem.odiggradientpara().ivar()];
            model.ParaType = [self probufChannelTypeToparamTypeInt:oiTem.odiggradientpara().itype()];
            model.stepValue = [NSString stringWithFormat:@"%.3f",oiTem.odiggradientpara().fstep()];
            model.changeTime = [NSString stringWithFormat:@"%.3f",oiTem.odiggradientpara().fsteptime()];
            model.startValue = [NSString stringWithFormat:@"%.3f",oiTem.odiggradientpara().fstart()];
            model.endValue = [NSString stringWithFormat:@"%.3f",oiTem.odiggradientpara().fend()];
            
        } else if (oiTem.oacdigitalpara().analogcurrentchanelvalue_size() == 0 && oiTem.oacanlogpara().analogcurrentchanelvalue_size()!=0){
            //模拟
            int channel_V = oiTem.oacanlogpara().analogvoltchangelvalue_size();//电压通道个数
            for (int i = 0; i<channel_V; i++) {
                BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacanlogpara().analogvoltchangelvalue(i);
                channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [voltageChannel addObject:channel_V];
            }
            
            int channel_C = oiTem.oacanlogpara().analogcurrentchanelvalue_size();//电流通道个数
            for (int i = 0; i<channel_C; i++) {
                BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacanlogpara().analogcurrentchanelvalue(i);
                channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [currentChannel addObject:channel_C];
            }
            [resultArr addObject:[voltageChannel copy]];//添加电压通道数据
            [resultArr addObject:[currentChannel copy]];//添加电流通道数据
            model.varlabel = [BD_ProtobufStructCommonManager protobufTypeToStrvarType:oiTem.oanagradientpara().ivar()];
            model.ParaType = [self probufChannelTypeToparamTypeInt:oiTem.oanagradientpara().itype()];
            model.stepValue = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fstep()];
            model.changeTime = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fsteptime()];
            model.startValue = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fstart()];
            model.endValue = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fend()];
        } else if(oiTem.oacdigitalpara().analogcurrentchanelvalue_size() != 0 && oiTem.oacanlogpara().analogcurrentchanelvalue_size()!=0){
         //数模一体,12U,12I,前6个模拟，后6个数字
            int channel_V1 = oiTem.oacanlogpara().analogvoltchangelvalue_size();//电压通道个数
            for (int i = 0; i<channel_V1; i++) {
                BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacanlogpara().analogvoltchangelvalue(i);
                channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [voltageChannel addObject:channel_V];
            }
            
            int channel_C1 = oiTem.oacanlogpara().analogcurrentchanelvalue_size();//电流通道个数
            for (int i = 0; i<channel_C1; i++) {
                BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacanlogpara().analogcurrentchanelvalue(i);
                channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [currentChannel addObject:channel_C];
            }
            int channel_V2 = oiTem.oacdigitalpara().analogvoltchangelvalue_size();//电压通道个数
            for (int i = 0; i<channel_V2; i++) {
                BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacdigitalpara().analogvoltchangelvalue(i);
                channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [voltageChannel addObject:channel_V];
            }
            
            int channel_C2 = oiTem.oacdigitalpara().analogcurrentchanelvalue_size();//电流通道个数
            for (int i = 0; i<channel_C2; i++) {
                BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                OutPutCommon::chanelpara oitem = oiTem.oacdigitalpara().analogcurrentchanelvalue(i);
                channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                [currentChannel addObject:channel_C];
            }
            
            [resultArr addObject:[voltageChannel copy]];//添加电压通道数据
            [resultArr addObject:[currentChannel copy]];//添加电流通道数据
            model.varlabel = [BD_ProtobufStructCommonManager protobufTypeToStrvarType:oiTem.oanagradientpara().ivar()];
            model.ParaType = [self probufChannelTypeToparamTypeInt:oiTem.oanagradientpara().itype()];
            model.stepValue = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fstep()];
            model.changeTime = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fsteptime()];
            model.startValue = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fstart()];
            model.endValue = [NSString stringWithFormat:@"%.3f",oiTem.oanagradientpara().fend()];
        }
        model.binaryIn = @(oiTem.oswitchpara().iinput());
        model.binaryLogic = oiTem.oswitchpara().ilogic();
        model.binaryOut = @(oiTem.oswitchpara().ioutput());
        [resultArr addObject:@[model]];
        return [resultArr copy];
    } else {
        return nil;
    }
}

//将int类型转换为OutPutCommon::changed_type类型
-(OutPutCommon::changed_type)paramTypeIntChangedToProbuf:(int)type{
    switch (type) {
        case 0:
            return OutPutCommon::changed_type::amplitude_type;
            break;
        case 1:
            return OutPutCommon::changed_type::phasor_type;
            break;
        case 2:
            return OutPutCommon::changed_type::fre_type;
            break;
        default:
            break;
    }
    return OutPutCommon::changed_type::amplitude_type;
}

//将OutPutCommon::changed_type类型转换为int类型
-(int)probufChannelTypeToparamTypeInt:(OutPutCommon::changed_type)type{
    switch (type) {
        case OutPutCommon::changed_type::amplitude_type:
            return 0;
            break;
        case OutPutCommon::changed_type::phasor_type:
            return 1;
            break;
        case OutPutCommon::changed_type::fre_type:
            return 2;
            break;
        default:
            break;
    }
    return 0;
    
}


@end
