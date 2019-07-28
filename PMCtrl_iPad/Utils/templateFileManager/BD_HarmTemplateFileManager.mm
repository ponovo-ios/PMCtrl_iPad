//
//  BD_HarmTemplateFileManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmTemplateFileManager.h"
#import "BD_HarmModel.h"
#import "Harm.pb.h"
#import "BD_ServiceManage.h"
@interface BD_HarmTemplateFileManager()
@property(nonatomic,strong)BD_ServiceManage *servicManager;
@end

@implementation BD_HarmTemplateFileManager

-(BD_ServiceManage *)servicManager{
    if (!_servicManager) {
        _servicManager = [[BD_ServiceManage alloc]init];
    }
    return _servicManager;
}
-(bool)saveTemplateFile:( BD_HarmModel * _Nonnull )model fileName:(NSString *_Nonnull)fileName{
    //创建模型
    Harm::HarmAnalog harmAnalog;
    //设置开入量
    unsigned int tempBits = 0;
    
    for (NSInteger i = 0; i < model.switchModel.switchInArray.count; i++) {
        if ([model.switchModel.switchInArray[i] intValue]==1)
        {
            tempBits |= (1<<i);
        }
    }
    
    DLog(@"开入量:%zd", tempBits);
    harmAnalog.set_iinput(tempBits);
    
    //设置开出量
    tempBits = 0;
    for (NSInteger i = 0; i < model.switchModel.switchOutArray.count; i++) {
        if ([model.switchModel.switchOutArray[i] intValue]==1)
        {
            tempBits |= (1<<i);
        }
    }
    
    DLog(@"开出量:%zd", tempBits);
    harmAnalog.set_ioutput(tempBits);
    
    //设置是否自动
    bool isAuto = model.dataModel.isAuto;
    harmAnalog.set_bisauto(isAuto);
    
    //设置是否锁定
    bool isLock = model.isLock;
    harmAnalog.set_block(isLock);
    
    //设置开入逻辑
    harmAnalog.set_ilogic((int)model.switchModel.switchLogic);
    
    

    if ([model.paramsModel.type isEqualToString:@"模拟"]) {
        /**------设置模拟参数-------*/
        //设置直流参数
        Harm::DCPara *oAnalogDC = harmAnalog.mutable_oanalogdc();
        [self.servicManager harmSetDCPara:oAnalogDC viewModel:model];
        //设置递变参数
        OutPutCommon::GradientPara *oGradientPara = harmAnalog.mutable_ogradientpara();
        [self.servicManager harmsetGradientPara:oGradientPara viewModel:model];
        //添加电压设置
        //遍历列表数据
        if (model.allDataArray.count==2) {
            [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:NO];
        } else if (model.allDataArray.count==4){
            [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:NO];
            [self.servicManager harmSetVolCurPara:model.allDataArray[2] curData:model.allDataArray[3] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:
             &harmAnalog isDigi:NO];
        }
   
    } else {
        /**------设置数字参数-------*/
        //设置直流参数
        Harm::DCPara *oDigitalDC = harmAnalog.mutable_odigitaldc();
        [self.servicManager harmSetDCPara:oDigitalDC viewModel:model];
        //设置递变参数
        OutPutCommon::GradientPara *oDigitalGradientPara = harmAnalog.mutable_odigitalgradientpara();
        [self.servicManager harmsetGradientPara:oDigitalGradientPara viewModel:model];
        //添加电压设置
        //遍历列表数据
        if (model.allDataArray.count==2) {
         [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:YES];
        } else if (model.allDataArray.count==4){
            [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:YES];
            [self.servicManager harmSetVolCurPara:model.allDataArray[2] curData:model.allDataArray[3] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:YES];
        }
    }
    
    DLog(@"%@", model.dataModel);
    
    int size = harmAnalog.ByteSize();
    
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    harmAnalog.SerializePartialToArray(pchar, size);
    
    NSData *pdata = [NSData dataWithBytes:pchar length:size];
    
    if ([FileUtil writeDataToFileName:[fileName stringByAppendingString:@".properties"] data:pdata]) {
        free(pchar);
        return  true;
    } else {
        free(pchar);
        return  false;
    }
}
-(BD_HarmModel * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName{
    NSData *result = [FileUtil readDataToFileName:fileName];
    Harm::HarmAnalog harmResult;
    bool bRet = harmResult.ParsePartialFromArray([result bytes],(int)[result length]);//将读取到的二进制串进行反序列化
    BD_HarmModel *resultModel = [[BD_HarmModel alloc]init];
    if (bRet) {
        //将protobuf结构的内容转换为对应试验的模型数组
        int binaryIn = harmResult.iinput();
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
        for (NSInteger i = 0; i<10; i++) {
            if (ch[i] == 0) {
                [resultModel.switchModel.switchInArray replaceObjectAtIndex:i withObject:@(NO)];
            } else {
                [resultModel.switchModel.switchInArray replaceObjectAtIndex:i withObject:@(YES)];
            }
           
        }
        //开出量
        int binaryOut = harmResult.ioutput();
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
        for (NSInteger i = 0; i<8; i++) {
            if (ch2[i] == 0) {
                [resultModel.switchModel.switchOutArray replaceObjectAtIndex:i withObject:@(NO)];
            } else {
                [resultModel.switchModel.switchOutArray replaceObjectAtIndex:i withObject:@(YES)];
            }
            
        }
        
        resultModel.dataModel.isAuto = harmResult.bisauto();
        resultModel.isLock = harmResult.block();
        resultModel.switchModel.switchLogic = harmResult.ilogic();
        
        if (harmResult.oanalogdc().analogvolt_size()!=0) {
            Harm::DCPara oanalogDC = harmResult.oanalogdc();
            if (oanalogDC.analogvolt_size()==4) {
                //设置直流电压
                resultModel.dcSettingModel.ua = kTStrings(oanalogDC.analogvolt(0));
                resultModel.dcSettingModel.ub = kTStrings(oanalogDC.analogvolt(1));
                resultModel.dcSettingModel.uc = kTStrings(oanalogDC.analogvolt(2));
                resultModel.dcSettingModel.uz = kTStrings(oanalogDC.analogvolt(3));
                //设置直流电流
                resultModel.dcSettingModel.ia = kTStrings(oanalogDC.analogcurrent(0));
                resultModel.dcSettingModel.ib = kTStrings(oanalogDC.analogcurrent(1));
                resultModel.dcSettingModel.ic = kTStrings(oanalogDC.analogcurrent(2));
            } else if (oanalogDC.analogvolt_size()==6){
                resultModel.dcSettingModel.ua = kTStrings(oanalogDC.analogvolt(0));
                resultModel.dcSettingModel.ub = kTStrings(oanalogDC.analogvolt(1));
                resultModel.dcSettingModel.uc = kTStrings(oanalogDC.analogvolt(2));
                resultModel.dcSettingModel.ua2 = kTStrings(oanalogDC.analogvolt(3));
                resultModel.dcSettingModel.ub2 = kTStrings(oanalogDC.analogvolt(4));
                resultModel.dcSettingModel.uc2 = kTStrings(oanalogDC.analogvolt(5));
                //设置直流电流
                resultModel.dcSettingModel.ia = kTStrings(oanalogDC.analogcurrent(0));
                resultModel.dcSettingModel.ib = kTStrings(oanalogDC.analogcurrent(1));
                resultModel.dcSettingModel.ic = kTStrings(oanalogDC.analogcurrent(2));
                resultModel.dcSettingModel.ia2 = kTStrings(oanalogDC.analogcurrent(3));
                resultModel.dcSettingModel.ib2 = kTStrings(oanalogDC.analogcurrent(4));
                resultModel.dcSettingModel.ic2 = kTStrings(oanalogDC.analogcurrent(5));
            }
        }
        if (harmResult.odigitaldc().analogvolt_size()!=0){
            Harm::DCPara odigitalDc = harmResult.odigitaldc();
            if (odigitalDc.analogvolt_size()==4) {
                //设置直流电压
                resultModel.dcSettingModel.ua = kTStrings(odigitalDc.analogvolt(0));
                resultModel.dcSettingModel.ub = kTStrings(odigitalDc.analogvolt(1));
                resultModel.dcSettingModel.uc = kTStrings(odigitalDc.analogvolt(2));
                resultModel.dcSettingModel.uz = kTStrings(odigitalDc.analogvolt(3));
                //设置直流电流
                resultModel.dcSettingModel.ia = kTStrings(odigitalDc.analogcurrent(0));
                resultModel.dcSettingModel.ib = kTStrings(odigitalDc.analogcurrent(1));
                resultModel.dcSettingModel.ic = kTStrings(odigitalDc.analogcurrent(2));
            } else if (odigitalDc.analogvolt_size()==6){
                resultModel.dcSettingModel.ua = kTStrings(odigitalDc.analogvolt(0));
                resultModel.dcSettingModel.ub = kTStrings(odigitalDc.analogvolt(1));
                resultModel.dcSettingModel.uc = kTStrings(odigitalDc.analogvolt(2));
                resultModel.dcSettingModel.ua2 = kTStrings(odigitalDc.analogvolt(3));
                resultModel.dcSettingModel.ub2 = kTStrings(odigitalDc.analogvolt(4));
                resultModel.dcSettingModel.uc2 = kTStrings(odigitalDc.analogvolt(5));
                //设置直流电流
                resultModel.dcSettingModel.ia = kTStrings(odigitalDc.analogcurrent(0));
                resultModel.dcSettingModel.ib = kTStrings(odigitalDc.analogcurrent(1));
                resultModel.dcSettingModel.ic = kTStrings(odigitalDc.analogcurrent(2));
                resultModel.dcSettingModel.ia2 = kTStrings(odigitalDc.analogcurrent(3));
                resultModel.dcSettingModel.ib2 = kTStrings(odigitalDc.analogcurrent(4));
                resultModel.dcSettingModel.ic2 = kTStrings(odigitalDc.analogcurrent(5));
            }
        }
     
        if (harmResult.ogradientpara().ivar()) {
            
            OutPutCommon::GradientPara gradientPara =  harmResult.ogradientpara();
            resultModel.dataModel.channelPort = [self ProtoparaTypeToStr:gradientPara.ivar() isDigi:NO];
            resultModel.dataModel.step = kTStrings(gradientPara.fstep());
            resultModel.dataModel.time = kTStrings(gradientPara.fsteptime());
            resultModel.dataModel.start = kTStrings(gradientPara.fstart());
            resultModel.dataModel.end = kTStrings(gradientPara.fend());
            if (gradientPara.nharm()==0) {
                resultModel.dataModel.passagewayIndex = @"基波";
            } else {
                resultModel.dataModel.passagewayIndex = [NSString stringWithFormat:@"%d",gradientPara.nharm()+1];
            }
        }
        if (harmResult.odigitalgradientpara().ivar()) {
            OutPutCommon::GradientPara gradientPara =  harmResult.odigitalgradientpara();
            resultModel.dataModel.channelPort = [self ProtoparaTypeToStr:gradientPara.ivar() isDigi:YES];
            resultModel.dataModel.step = kTStrings(gradientPara.fstep());
            resultModel.dataModel.time = kTStrings(gradientPara.fsteptime());
            resultModel.dataModel.start = kTStrings(gradientPara.fstart());
            resultModel.dataModel.end = kTStrings(gradientPara.fend());
            if (gradientPara.nharm()==0) {
                resultModel.dataModel.passagewayIndex = @"基波";
            } else {
                resultModel.dataModel.passagewayIndex = [NSString stringWithFormat:@"%d",gradientPara.nharm()+1];
            }
        }
        //模拟
       
        if (harmResult.oacanlogpara_size()!=0) {
             NSMutableArray *datas = [[NSMutableArray alloc]init];
            int tableGroup = harmResult.oacanlogpara_size()/3;//表示页面一共有几组
            
            if (tableGroup==1) {
                BD_HarmTableDataModel *volData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:S_V];
                BD_HarmTableDataModel *curData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:S_C1];
                int column = 4;
                [self setVolCurData:volData curData:curData columnNum:4 harmResult:harmResult resultModel:resultModel isDigi:NO];
                [datas addObject:volData];
                [datas addObject:curData];
            
                
                
            } else {
                BD_HarmTableDataModel *volData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:S_V1];
                BD_HarmTableDataModel *curData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:S_C1];
                BD_HarmTableDataModel *volData1 = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:S_V2];
                BD_HarmTableDataModel *curData1 = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:S_C2];

               
                [self setVolCurData:volData curData:curData columnNum:3 harmResult:harmResult resultModel:resultModel isDigi:NO];
                
                [datas addObject:volData];
                [datas addObject:curData];
        
                [self setVolCurData:volData1 curData:curData1 columnNum:6 harmResult:harmResult resultModel:resultModel isDigi:NO];
                
                [datas addObject:volData1];
                [datas addObject:curData1];
                
            }
            resultModel.allDataArray = datas;
        }
        //数字
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        if (harmResult.oacdigitalpara_size()!=0) {
            int tableGroup = harmResult.oacdigitalpara_size()/2;//表示页面一共有几组
            
            if (tableGroup==1) {
                BD_HarmTableDataModel *volData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:N_V1];
                BD_HarmTableDataModel *curData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:N_C1];
                int column = 4;
                
              
                [self setVolCurData:volData curData:curData columnNum:4 harmResult:harmResult resultModel:resultModel isDigi:YES];
                
                [datas addObject:volData];
                [datas addObject:curData];
                
            } else {
                BD_HarmTableDataModel *volData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:N_V1];
                BD_HarmTableDataModel *curData = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:N_C1];
                BD_HarmTableDataModel *volData1 = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:N_V2];
                BD_HarmTableDataModel *curData1 = [[BD_HarmTableDataModel alloc]initWithHarmParamsType:N_C2];
                
              
                    [self setVolCurData:volData curData:curData columnNum:3 harmResult:harmResult resultModel:resultModel isDigi:YES];
                
                [datas addObject:volData];
                [datas addObject:curData];
                
                
              
                [self setVolCurData:volData1 curData:curData1 columnNum:6 harmResult:harmResult resultModel:resultModel isDigi:YES];
                
                [datas addObject:volData1];
                [datas addObject:curData1];
                
            }
            resultModel.allDataArray = datas;
        }
 
        return resultModel;
    } else {
        return nil;
    }
}

-(void)setVolCurData:(BD_HarmTableDataModel *)volData curData:(BD_HarmTableDataModel *)curData columnNum:(int)columnNum  harmResult:(Harm::HarmAnalog)harmResult resultModel:(BD_HarmModel *)resultModel isDigi:(BOOL)isDigi{
    NSMutableArray *volDatas = [[NSMutableArray alloc]init];
    NSMutableArray *curDatas = [[NSMutableArray alloc]init];
    int start = 0;
    if (columnNum !=6) {
        start = 0;
    } else {
        start = 3;
    }
   
        OutPutCommon::acanalogpara oacanlogpara;
        if (!isDigi) {
            if (harmResult.oacanlogpara_size()!=0 ) {
                oacanlogpara  = harmResult.oacanlogpara(0);
            }
            
        } else {
            if (harmResult.oacdigitalpara_size()!=0) {
                   oacanlogpara  = harmResult.oacdigitalpara(0);
            }
        }
        for (int j = 0; j<oacanlogpara.analogcurrentchanelvalue_size(); j++) {
            OutPutCommon::chanelpara analogvoltchangelvalue = oacanlogpara.analogvoltchangelvalue(j);
            OutPutCommon::chanelpara analogcurrentchanelvalue;
            if (j!=3) {
                analogcurrentchanelvalue = oacanlogpara.analogcurrentchanelvalue(j);
            }
            
            BD_HarmCellModel *cellModel0;
            if (columnNum==4) {
                cellModel0 = [[BD_HarmCellModel alloc]init];
            } else {
                cellModel0 = [[BD_HarmCellModel alloc]init];
            }
            
            BD_HarmCellModel *cellModel1;
            
            cellModel1 = [[BD_HarmCellModel alloc]init];
            
            for (int i = start;i<columnNum;i++) {
                
                //                //item模型
                BD_HarmItem *item = [[BD_HarmItem alloc]init];
                item.validValues = kTStrings(analogvoltchangelvalue.famptitude());
                item.phase = kTStrings(analogvoltchangelvalue.fphase());
                resultModel.dataModel.fre = kTStrings(analogvoltchangelvalue.ffre());
                
                [cellModel0.itemArray addObject:item];
                
                //                //item模型
                BD_HarmItem *item1 = [[BD_HarmItem alloc]init];
                item1.validValues = kTStrings(analogcurrentchanelvalue.famptitude());
                item1.phase = kTStrings(analogcurrentchanelvalue.fphase());
                resultModel.dataModel.fre = kTStrings(analogcurrentchanelvalue.ffre());
                [cellModel1.itemArray addObject:item1];
                
            }
            [volDatas addObject:cellModel0];
            [curDatas addObject:cellModel1];
            
        }

    volData.contentDataArray = volDatas;
    curData.contentDataArray = curDatas;
}
-(NSString *)ProtoparaTypeToStr:(OutPutCommon::para_type)type isDigi:(BOOL)isDigi{
    switch (type) {
        case OutPutCommon::para_type::va1_type:
            return !isDigi?@"Va":@"Va`";
            break;
        case OutPutCommon::para_type::vb1_type:
            return !isDigi?@"Vb":@"Vb`";
            break;
        case OutPutCommon::para_type::vc1_type:
            return !isDigi?@"Vc":@"Vc`";
            break;
        case OutPutCommon::para_type::vz_type:
            return !isDigi?@"Vz":@"Vz`";
            break;
        case OutPutCommon::para_type::va2_type:
            return !isDigi?@"Va2":@"Va2`";
            break;
        case OutPutCommon::para_type::vb2_type:
             return !isDigi?@"Vb2":@"Vb2`";
            break;
        case OutPutCommon::para_type::vc2_type:
             return !isDigi?@"Vc2":@"Vc2`";
            break;
        case OutPutCommon::para_type::vab1_type:
             return @"Va,Vb";;
            break;
        case OutPutCommon::para_type::vbc1_type:
            return @"Vb,Vc";
            break;
        case OutPutCommon::para_type::vca1_type:
            return @"Vc,Va";
            break;
        case OutPutCommon::para_type::vabc1_type:
            return !isDigi?@"Va,Vb,Vc":@"Va`,Vb`,Vc`";
            break;
        case OutPutCommon::para_type::vabc2_type:
            return !isDigi?@"Va2,Vb2,Vc2":@"Va2`,Vb2`,Vc2`";
            break;
        case OutPutCommon::para_type::ia1_type:
            return !isDigi?@"Ia":@"Ia`";
            break;
        case OutPutCommon::para_type::ib1_type:
            return !isDigi?@"Ib":@"Ib`";
            break;
        case OutPutCommon::para_type::ic1_type:
            return !isDigi?@"Ic":@"Ic`";
            break;
        case OutPutCommon::para_type::ia2_type:
            return !isDigi?@"Ia2":@"Ia2`";
            break;
        case OutPutCommon::para_type::ib2_type:
            return !isDigi?@"Ib2":@"Ib2`";
            break;
        case OutPutCommon::para_type::ic2_type:
            return !isDigi?@"Ic2":@"Ic2`";
            break;
        case OutPutCommon::para_type::iab1_type:
            return @"Ia,Ib";
            break;
        case OutPutCommon::para_type::ibc1_type:
            return @"Ib,Ic";
            break;
        case OutPutCommon::para_type::ica1_type:
            return @"Ic,Ia";
            break;
        case OutPutCommon::para_type::iabc1_type:
            return isDigi?@"Ia,Ib,Ic":@"Ia`,Ib`,Ic`";
            break;
        case OutPutCommon::para_type::iabc2_type:
            return isDigi?@"Ia2,Ib2,Ic2":@"Ia2`,Ib2`,Ic2`";
            break;
        case OutPutCommon::para_type::vall_type:
            return isDigi?@"Va,Vb,Vc,Vz":@"Va`,Vb`,Vc`,Vz`";
            break;
       
        default:
            return @"";
            break;
    }
}
@end
