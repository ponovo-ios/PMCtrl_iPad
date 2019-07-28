//
//  BD_StateTemplateFileManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTemplateFileManager.h"
#import "BD_StateTestCommonParamModel.h"
#import "BD_StateTestParamModel.h"
#import "BD_StateTestTransmutationDetailModel.h"
#import "BD_StateTestItemModel.h"
#import "BD_ProtobufStructCommonManager.h"
#import "BD_UtcTime.h"


@implementation BD_StateTemplateFileManager
#pragma mark - 保存模版文件
-(bool)saveTemplateFile:(NSArray<BD_TestDataParamModel *> *)testListDatas commonPara:(BD_StateTestCommonParamModel *)comparam deviceGPSTime:(BD_UtcTime *)deviceGPSTime fileName:(NSString *_Nullable)fileName{
    //一级
    StatePara::states oitem;
    //一级通用参数设置
    StatePara::CommonPara* commonPara = oitem.mutable_ocommon();
    
    commonPara->set_njudgecondition(comparam.binaryChangeState);//开入翻转参考状态 0:第一个状态 1 上一个状态
    commonPara->set_ndcoffset([@(comparam.reduceCocurrent) intValue]);//是否叠加直流分量
    commonPara->set_ftou([comparam.reduceTime floatValue]);//衰减时间常数
    commonPara->set_nloopnum([comparam.cycleIndex intValue]);//循环次数
    //一级 测试项参数组装
    for (int i = 0; i < testListDatas.count; i ++) {
        
        BD_StateTestItemModel *model = (BD_StateTestItemModel *)testListDatas[i];
        if(model.itemSelect){
            StatePara::state *ostates = oitem.add_ostates();
            
            ostates->set_nindex((int)model.itemNum);
            ostates->set_bdc(model.itemParam.stateParam.isDirectCurrent);//是否直流
            ostates->set_ntrigertype([model.itemParam.triggerParam.TriggerType intValue]);//0: 手动触发 1:时间触发单位ms 2:开入变位触发 3:GPS触发 4:开关量或时间触发 5:低电压触发
            ostates->set_foutputtime([model.itemParam.triggerParam.TriggerTime floatValue]);//输出时间
            //gps时间传入，是通过仪器gps时间的年月日+触发条件设置的时：分：秒，为gps触发的时间，从1970到该时间到秒值为protobuf文件中需要的nGPSTime值；
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat: @"HH:mm:ss"];
            NSString *gpsDatestr = [[NSString stringWithFormat:@"%d/%d/%d ",deviceGPSTime.year,deviceGPSTime.month,deviceGPSTime.day] stringByAppendingString:model.itemParam.triggerParam.Gpstime];
            
            NSDateFormatter *formatter_g = [[NSDateFormatter alloc]init];
            [formatter_g setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
            NSDate *gpsDate = [formatter_g dateFromString:gpsDatestr];
    
            NSTimeInterval ss = [gpsDate timeIntervalSince1970];
            float nGPSTime = (float)ss;
            float nsGPSTime = 0.0;
            ostates->set_sgpstime(nGPSTime); //sGpstime
            ostates->set_nsgpstime(nsGPSTime);//GPS时间 hour:minute:second.ns
            
            ostates->set_ftrigerholdtime([model.itemParam.triggerParam.trigerHoldTime floatValue]);//触发后保持时间
            //       OutPutCommon::acanalogpara* oacAnalogpara = ostates->mutable_oacanalogpara(); //模拟通道
            //        OutPutCommon::acanalogpara* oacDigitalpara = ostates->mutable_oacdigitalpara();//数字通道
            
            StatePara::GradientPara* oanaGradientpara = ostates->mutable_oanagradientpara();//模拟递变参数
            StatePara::GradientPara* odigGradientpara = ostates->mutable_odiggradientpara();//数字递变参数
            
            //模拟和数字组装不同的参数
            if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_Imitate) {
                ostates->set_nbivalide([model.itemParam.triggerParam.nBiValide intValue]);//开入有效位
                ostates->set_nbilogic([model.itemParam.triggerParam.TriggerLogic intValue]);//开入逻辑
                ostates->set_nbovalide([model.itemParam.triggerParam.nbinaryout intValue]);//开出有效位
                //模拟电压电流通道
                
                OutPutCommon::acanalogpara* oacAnalogpara = ostates->mutable_oacanalogpara();
                
                
                [BD_ProtobufStructCommonManager  messageData:@[model.itemParam.stateParam.voltageOutputDatas,model.itemParam.stateParam.currentOutputDatas] object:oacAnalogpara];
                
                //模拟递变参数
                
                [self setStateTestTransmutationPara:oanaGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
            } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_Digit){
                ostates->set_nbidigitalvalide([model.itemParam.triggerParam.nBiValide intValue]);//数字开入变位有效位
                //数字电压电流通道
                
                OutPutCommon::acanalogpara* oacDigitalpara = ostates->mutable_oacdigitalpara();
                
                [BD_ProtobufStructCommonManager messageData:@[model.itemParam.stateParam.voltageOutputDatas,model.itemParam.stateParam.currentOutputDatas] object:oacDigitalpara];
                
                //数字递变参数
                
                [self setStateTestTransmutationPara:odigGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
            } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_ImitateDigit){
                ostates->set_nbivalide([model.itemParam.triggerParam.nBiValide intValue]);//开入有效位
                ostates->set_nbilogic([model.itemParam.triggerParam.TriggerLogic intValue]);//开入逻辑
                ostates->set_nbovalide([model.itemParam.triggerParam.nbinaryout intValue]);//开出有效位
                ostates->set_nbidigitalvalide([model.itemParam.triggerParam.nBiValide intValue]);//数字开入变位有效位
                
                //模拟电压电流通道
                OutPutCommon::acanalogpara* oacAnalogpara = ostates->mutable_oacanalogpara();
                
                NSMutableArray *anlogArr = [[NSMutableArray  alloc]init];
                NSMutableArray *digitalArr = [[NSMutableArray  alloc]init];
                
                NSMutableArray *vol = [[NSMutableArray alloc]init];
                NSMutableArray *cur = [[NSMutableArray alloc]init];
                for (NSInteger i = 0; i<6; i++) {
                    [vol addObject:model.itemParam.stateParam.voltageOutputDatas[i]];
                    [cur addObject:model.itemParam.stateParam.currentOutputDatas[i]];
                }
                [anlogArr addObject:[vol copy]];
                
                [anlogArr addObject:[cur copy]];
                NSMutableArray *dvol = [[NSMutableArray alloc]init];
                NSMutableArray *dcur = [[NSMutableArray alloc]init];
                for (NSInteger i = 6; i<model.itemParam.stateParam.voltageOutputDatas.count; i++) {
                    [dvol addObject:model.itemParam.stateParam.voltageOutputDatas[i]];
                }
                for (NSInteger i = 6; i<model.itemParam.stateParam.currentOutputDatas.count; i++) {
                    [dcur addObject:model.itemParam.stateParam.currentOutputDatas[i]];
                }
                [digitalArr addObject:[dvol copy]];
                [digitalArr addObject:[dcur copy]];
                
                
                [BD_ProtobufStructCommonManager messageData:[anlogArr copy] object:oacAnalogpara];
                
                //模拟递变参数
                
                [self setStateTestTransmutationPara:oanaGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
                //数字电压电流通道
                OutPutCommon::acanalogpara* oacDigitalpara = ostates->mutable_oacdigitalpara();
                [BD_ProtobufStructCommonManager messageData:[digitalArr copy] object:oacDigitalpara];
                
                //数字递变参数
                
                [self setStateTestTransmutationPara:odigGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
                
            }
            ostates->set_bboinvert([@(model.itemParam.triggerParam.isBinaryOutStateInvert) intValue]);//是否开出状态翻转
            ostates->set_fboholdtime([model.itemParam.triggerParam.binaryOutStateInvertHoldTime floatValue]);//开出状态翻转保持时间
            
        }
    }
    
    //转字节流
    //计算对象大小
    int size = oitem.ByteSize();
    
    //开辟内存空间
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    //序列化到内存中
    oitem.SerializePartialToArray(pchar, size);
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
-(NSMutableArray * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName{
    NSData *result = [FileUtil readDataToFileName:fileName];
    StatePara::states oitem;
    bool bRet = oitem.ParsePartialFromArray([result bytes],(int)[result length]);//将读取到的二进制串进行反序列化
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    NSMutableArray<BD_StateTestItemModel *> *testListDatas = [[NSMutableArray alloc]init];
    BD_StateTestCommonParamModel *comparam = [[BD_StateTestCommonParamModel alloc]init];
    if (bRet) {
        //将protobuf结构的内容转换为对应试验的模型数组
        comparam.binaryChangeState = oitem.ocommon().njudgecondition();
        comparam.reduceCocurrent = (BOOL)oitem.ocommon().ndcoffset();
        comparam.reduceTime = [NSString stringWithFormat:@"%.3f",oitem.ocommon().ftou()];
        comparam.cycleIndex = [NSString stringWithFormat:@"%d",oitem.ocommon().nloopnum()];
        
        int size = oitem.ostates_size();
        for (int i = 0; i<size; i++) {
            BD_StateTestItemModel *itemModel = [[BD_StateTestItemModel alloc]init];
            StatePara::state ostate = oitem.ostates(i);
            itemModel.itemNum = ostate.nindex();
            itemModel.itemParam.stateParam.isDirectCurrent = ostate.bdc();
            itemModel.itemParam.triggerParam.TriggerType = [NSNumber numberWithUnsignedInt:ostate.ntrigertype()];
            itemModel.itemParam.triggerParam.TriggerTime = [NSNumber numberWithUnsignedInt:ostate.foutputtime()];
            //根据二进制文件中存储的数据，是float类型，表示距离1970年到保存模版文件时的数据，读取后转化为保存模版文件时的NSDate,通过设置formatter的dateFormat为HH:mm:ss来获取记录的时分秒，就是触发条件设置的时分秒；
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:ostate.sgpstime()];
            NSDateFormatter *formater = [[NSDateFormatter alloc]init];
            formater.dateFormat = @"HH:mm:ss";
            NSString *str = [formater stringFromDate:date];
            itemModel.itemParam.triggerParam.Gpstime = str;
            
            itemModel.itemParam.triggerParam.trigerHoldTime = [NSNumber numberWithUnsignedInt:ostate.ftrigerholdtime()];
           
            OutPutCommon::acanalogpara oacAnalogpara = ostate.oacanalogpara();
            OutPutCommon::acanalogpara oacDigitalpara = ostate.oacdigitalpara();
            if (oacAnalogpara.analogvoltchangelvalue_size()!=0 && oacDigitalpara.analogvoltchangelvalue_size()==0) {
                //模拟
                itemModel.itemParam.triggerParam.nBiValide = [NSNumber numberWithUnsignedInt:ostate.nbivalide()];
                itemModel.itemParam.triggerParam.TriggerLogic = [NSNumber numberWithUnsignedInt:ostate.nbilogic()];
                itemModel.itemParam.triggerParam.nbinaryout = [NSNumber numberWithUnsignedInt:ostate.nbovalide()];
                
                int channel_V = oacAnalogpara.analogvoltchangelvalue_size();//电压通道个数
                for (int i = 0; i<channel_V; i++) {
                    BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacAnalogpara.analogvoltchangelvalue(i);
                    channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.voltageOutputDatas addObject:channel_V];
                }
                
                int channel_C = oacAnalogpara.analogcurrentchanelvalue_size();//电流通道个数
                for (int i = 0; i<channel_C; i++) {
                    BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacAnalogpara.analogcurrentchanelvalue(i);
                    channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.currentOutputDatas addObject:channel_C];
                }
                //递变参数
                itemModel.itemParam.triggerParam.isdfdt = ostate.oanagradientpara().bdfdt();
                itemModel.itemParam.triggerParam.isdvdt = ostate.oanagradientpara().bdvdt();
                itemModel.itemParam.triggerParam.isComGradient = ostate.oanagradientpara().bcomgradient();
                itemModel.itemParam.transmutationParam.paramType = [BD_ProtobufStructCommonManager protobufTypeToStrvarType:ostate.oanagradientpara().ivar()];
                itemModel.itemParam.transmutationParam.dfdtValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fdfdt()];
                
                itemModel.itemParam.transmutationParam.dvdtValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fdvdt()];
                itemModel.itemParam.transmutationParam.startVValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstartv()];
                itemModel.itemParam.transmutationParam.startHzValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstarthz()];
                itemModel.itemParam.transmutationParam.endHzValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fendhz()];
                itemModel.itemParam.transmutationParam.endVValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fendv()];
                
                itemModel.itemParam.transmutationParam.changeStepValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstep()];
                itemModel.itemParam.transmutationParam.stepTimeValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fsteptime()];
                itemModel.itemParam.transmutationParam.changeEndValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fend()];
                itemModel.itemParam.transmutationParam.changeStartValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstart()];
            
                
            } else if(oacAnalogpara.analogvoltchangelvalue_size()==0 && oacDigitalpara.analogvoltchangelvalue_size()!=0){
                //数字
                itemModel.itemParam.triggerParam.nBiValide = [NSNumber numberWithUnsignedInt:ostate.nbidigitalvalide()];//数字开入有效位
                itemModel.itemParam.triggerParam.TriggerLogic = [NSNumber numberWithUnsignedInt:ostate.nbilogic()];
                itemModel.itemParam.triggerParam.nbinaryout = [NSNumber numberWithUnsignedInt:ostate.nbovalide()];
                
                int channel_V = oacDigitalpara.analogvoltchangelvalue_size();//电压通道个数
                for (int i = 0; i<channel_V; i++) {
                    BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacDigitalpara.analogvoltchangelvalue(i);
                    channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.voltageOutputDatas addObject:channel_V];
                }
                
                int channel_C = oacDigitalpara.analogcurrentchanelvalue_size();//电流通道个数
                for (int i = 0; i<channel_C; i++) {
                    BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacDigitalpara.analogcurrentchanelvalue(i);
                    channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.currentOutputDatas addObject:channel_C];
                }
                //递变参数
                itemModel.itemParam.triggerParam.isdfdt = ostate.oanagradientpara().bdfdt();
                itemModel.itemParam.triggerParam.isdvdt = ostate.oanagradientpara().bdvdt();
                itemModel.itemParam.triggerParam.isComGradient = ostate.oanagradientpara().bcomgradient();
                itemModel.itemParam.transmutationParam.paramType = [BD_ProtobufStructCommonManager protobufTypeToStrvarType:ostate.oanagradientpara().ivar()];
                itemModel.itemParam.transmutationParam.dfdtValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fdfdt()];
                
                itemModel.itemParam.transmutationParam.dvdtValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fdvdt()];
                itemModel.itemParam.transmutationParam.startVValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstartv()];
                itemModel.itemParam.transmutationParam.startHzValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstarthz()];
                itemModel.itemParam.transmutationParam.endHzValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fendhz()];
                itemModel.itemParam.transmutationParam.endVValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fendv()];
                
                itemModel.itemParam.transmutationParam.changeStepValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstep()];
                itemModel.itemParam.transmutationParam.stepTimeValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fsteptime()];
                itemModel.itemParam.transmutationParam.changeEndValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fend()];
                itemModel.itemParam.transmutationParam.changeStartValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstart()];
                
            } else if(oacAnalogpara.analogvoltchangelvalue_size()!=0 && oacDigitalpara.analogvoltchangelvalue_size()!=0){
                //数模一体
                //模拟
                itemModel.itemParam.triggerParam.nBiValide = [NSNumber numberWithUnsignedInt:ostate.nbivalide()];
                itemModel.itemParam.triggerParam.TriggerLogic = [NSNumber numberWithUnsignedInt:ostate.nbilogic()];
                itemModel.itemParam.triggerParam.nbinaryout = [NSNumber numberWithUnsignedInt:ostate.nbovalide()];
                //数模一体,12U,12I,前6个模拟，后6个数字
               //模拟
                int channel_V = oacAnalogpara.analogvoltchangelvalue_size();//电压通道个数
                for (int i = 0; i<channel_V; i++) {
                    BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacAnalogpara.analogvoltchangelvalue(i);
                    channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.voltageOutputDatas addObject:channel_V];
                }
                
                int channel_C = oacAnalogpara.analogcurrentchanelvalue_size();//电流通道个数
                for (int i = 0; i<channel_C; i++) {
                    BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacAnalogpara.analogcurrentchanelvalue(i);
                    channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.currentOutputDatas addObject:channel_C];
                }
                //数字
                int channel_V2 = oacDigitalpara.analogvoltchangelvalue_size();//电压通道个数
                for (int i = 0; i<channel_V2; i++) {
                    BD_TestDataParamModel *channel_V = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacDigitalpara.analogvoltchangelvalue(i);
                    channel_V.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_V.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_V.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.voltageOutputDatas addObject:channel_V];
                }
                
                int channel_C2 = oacDigitalpara.analogcurrentchanelvalue_size();//电流通道个数
                for (int i = 0; i<channel_C2; i++) {
                    BD_TestDataParamModel *channel_C = [[BD_TestDataParamModel alloc]init];
                    OutPutCommon::chanelpara oitem = oacDigitalpara.analogcurrentchanelvalue(i);
                    channel_C.amplitude = [NSString stringWithFormat:@"%.3f",oitem.famptitude()];
                    channel_C.phase = [NSString stringWithFormat:@"%.3f",oitem.fphase()];
                    channel_C.frequency = [NSString stringWithFormat:@"%.3f",oitem.ffre()];
                    [itemModel.itemParam.stateParam.currentOutputDatas addObject:channel_C];
                }
                
                //递变参数
                itemModel.itemParam.triggerParam.isdfdt = ostate.oanagradientpara().bdfdt();
                itemModel.itemParam.triggerParam.isdvdt = ostate.oanagradientpara().bdvdt();
                itemModel.itemParam.triggerParam.isComGradient = ostate.oanagradientpara().bcomgradient();
                itemModel.itemParam.transmutationParam.paramType = [BD_ProtobufStructCommonManager protobufTypeToStrvarType:ostate.oanagradientpara().ivar()];
                itemModel.itemParam.transmutationParam.dfdtValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fdfdt()];
                
                itemModel.itemParam.transmutationParam.dvdtValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fdvdt()];
                itemModel.itemParam.transmutationParam.startVValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstartv()];
                itemModel.itemParam.transmutationParam.startHzValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstarthz()];
                itemModel.itemParam.transmutationParam.endHzValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fendhz()];
                itemModel.itemParam.transmutationParam.endVValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fendv()];
                itemModel.itemParam.transmutationParam.changeStepValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstep()];
                itemModel.itemParam.transmutationParam.stepTimeValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fsteptime()];
                itemModel.itemParam.transmutationParam.changeEndValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fend()];
                itemModel.itemParam.transmutationParam.changeStartValue = [NSNumber numberWithFloat:ostate.oanagradientpara().fstart()];
            }
            itemModel.itemParam.triggerParam.isBinaryOutStateInvert = ostate.bboinvert();
            itemModel.itemParam.triggerParam.binaryOutStateInvertHoldTime = [NSNumber numberWithFloat:ostate.fboholdtime()];
            
            int binaryIn = [itemModel.itemParam.triggerParam.nBiValide intValue];
            int ch[32];
            for (int k=0;k<32;k++)
            {
                ch[k] = -1;
            }
            
            for ( int k=31; k>=0; k-- )
            {
                ch[k] = (binaryIn&0x80000000)==0?0:1;
                binaryIn = binaryIn<<1;
            }
            NSMutableArray *binary_In = [[NSMutableArray alloc]init];
          
            for (NSInteger i = 0; i<10; i++) {
                [binary_In addObject:@(ch[i])];
            }
            itemModel.itemParam.triggerParam.BArr = [binary_In copy];
            
            int binaryOut = [itemModel.itemParam.triggerParam.nbinaryout intValue];
            int ch2[32];
            for (int k=0;k<32;k++)
            {
                ch2[k] = -1;
            }
            
            for ( int k=31; k>=0; k-- )
            {
                ch2[k] = (binaryOut&0x80000000)==0?0:1;
                binaryOut = binaryOut<<1;
            }
            NSMutableArray *binary_Out = [[NSMutableArray alloc]init];
            for (NSInteger i = 0; i<8; i++) {
                [binary_Out addObject:@(ch2[i])];
            }
            itemModel.itemParam.triggerParam.BoArr = [binary_Out copy];
            [testListDatas addObject:itemModel];
        }
        
    
        
        [resultArr addObject:testListDatas];
        [resultArr addObject:comparam];
        return resultArr;
    } else {
        return nil;
    }
}





//状态序列设置递变参数
-(void)setStateTestTransmutationPara:(StatePara::GradientPara *)para triggerPara:(BD_StateTestTriggerParamModel *)triggerPara transmutationPara:(BD_StateTestTransmutationDetailModel *)transmutationPara{
    para->set_bdfdt(triggerPara.isdfdt);
    para->set_bdvdt(triggerPara.isdvdt);
    para->set_bcomgradient(triggerPara.isComGradient);
    para->set_ivar([BD_ProtobufStructCommonManager varTypeStringToProbuf:transmutationPara.paramType]);
   
    para->set_fdfdt([transmutationPara.dfdtValue floatValue]);
    para->set_fdvdt([transmutationPara.dvdtValue floatValue]);
    para->set_fstartv([transmutationPara.startVValue floatValue]);
    para->set_fstarthz([transmutationPara.startHzValue floatValue]);
    para->set_fendhz([transmutationPara.endHzValue floatValue]);
    para->set_fendv([transmutationPara.endVValue floatValue]);
    
    para->set_fstep([transmutationPara.changeStepValue floatValue]);
    para->set_fsteptime([transmutationPara.stepTimeValue floatValue]);
    para->set_fend([transmutationPara.changeEndValue floatValue]);
    para->set_fstart([transmutationPara.changeStartValue floatValue]);
    
}

@end
