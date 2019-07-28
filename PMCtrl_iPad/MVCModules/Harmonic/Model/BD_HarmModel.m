//
//  BD_HarmModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmModel.h"

@implementation BD_HarmModel

-(NSMutableArray *)passagewayArray
{
    if (!_passagewayArray) {
        _passagewayArray = [NSMutableArray arrayWithCapacity:31];
        for (NSInteger i = 1; i < 32; i++) {
            if (i == 1) {
                 [_passagewayArray addObject:@"基波"];
            }else{
                 [_passagewayArray addObject:[NSString stringWithFormat:@"%ld", i]];
            }
           
        }
    }
    return _passagewayArray;
}

//初始化模型
-(instancetype)init
{
    if (self = [super init]) {
        self.paramsModel = [[BD_HarmParamsSettingModel alloc]init];
        self.switchModel = [[BD_HarmSwitchSettingModel alloc]init];
        self.dataModel = [[BD_HarmDataSettingModel alloc]init];
        self.dcSettingModel = [[BD_HarmDCSettingModel alloc]init];
    }
    return self;
}

/**通过 修改某一项 改变总有效值 */
-(BOOL)changeValueWithTableData:(BD_HarmTableDataModel *)tableDataModel index:(NSInteger)index view:(UIView *)view
{
    //计算头部总有效值
    double allValidValues = 0.f;
    double p = 0.f;
    //最大值
    NSString *maxValue;
    
    
    //遍历选中行
    for (NSInteger i = 0; i < self.passagewayArray.count; i++) {
        
        //table contentDataArray 的 index
        NSInteger cellIndex = 0;
        
        if (i != 0) {
            cellIndex = [self.passagewayArray[i] integerValue] - 1;
        }
        
        BD_HarmCellModel *cellModel = tableDataModel.contentDataArray[cellIndex];
        BD_HarmItem *itemModel = cellModel.itemArray[index];
        
        p += pow(itemModel.validValues.doubleValue, 2);
    }
    
    allValidValues = sqrt(p);
    
    //计算最大值
    switch (tableDataModel.itemType) {
        case  S_V://模拟电压
            maxValue = self.paramsModel.acVoltage;
            break;
       case S_C://模拟电流
            maxValue = self.paramsModel.acCurrent;
            break;
       case N_V://数字电压
            maxValue = self.paramsModel.acVoltage;
            break;
       case N_C://数字电流
            maxValue = self.paramsModel.acCurrent;
            break;
       case S_V1://模拟电压1
            maxValue = self.paramsModel.acVoltage;
            break;
       case S_C1://模拟电流1
            maxValue = self.paramsModel.acCurrent;
            break;
       case N_V1://数字电压1
            maxValue = self.paramsModel.acVoltage;
            break;
       case N_C1://数字电流1
            maxValue = self.paramsModel.acCurrent;
            break;
       case S_V2://模拟电压2
            maxValue = self.paramsModel.acVoltage;
            break;
       case S_C2://模拟电流2
            maxValue = self.paramsModel.acCurrent;
            break;
       case N_V2://数字电压2
            maxValue = self.paramsModel.acVoltage;
            break;
       case N_C2://数字电流2
            maxValue = self.paramsModel.acCurrent;
            break;
    }
    
    //如果超过最大值
    if (allValidValues > maxValue.floatValue) {
        [MBProgressHUDUtil showMessage:[NSString stringWithFormat:@"总有效值大于%@", maxValue] toView:view];
        //通知返回上一操作
        
        return NO;
    }
    
    //正则匹配替换字符串
    NSString *searchStr = tableDataModel.headerDataArray[index];
    NSString *regExpStr = @"[0-9]*\\.[0-9]+";
    NSString *replacement = [NSString stringWithFormat:@"%.3f", allValidValues];
    
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    NSString *resultStr = searchStr;
    // 替换匹配的字符串为 searchStr
    resultStr = [regExp stringByReplacingMatchesInString:searchStr
                                                 options:NSMatchingReportProgress
                                                   range:NSMakeRange(0, searchStr.length)
                                            withTemplate:replacement];
    
    tableDataModel.headerDataArray[index] = resultStr;
    
    //发送修改数值
    BOOL isChange = [[OCCenter shareCenter] harmTestChange:self];
    DLog(@"%@", isChange ? @"成功" : @"失败");
    
    return YES;
}

/**通过tableDataModel改变总有效值*/
-(void)changeAllValueOnView:(UIView *)view
{
    
    for (BD_HarmTableDataModel *tableDataModel in self.allDataArray) {
        
        //遍历头部数据数组
        for (NSInteger i = 0; i < tableDataModel.headerDataArray.count; i++) {
            
            //计算头部总有效值
            double allValidValues = 0.f;
            double p = 0.f;
            //最大值
            NSString *maxValue;
            
            //遍历选中行
            for (NSInteger j = 0; j < self.passagewayArray.count; j++) {
                
                //table contentDataArray 的 index
                NSInteger index = 0;
                
                if (j != 0) {
                    index = [self.passagewayArray[j] integerValue] - 1;
                }
                
                BD_HarmCellModel *cellModel = tableDataModel.contentDataArray[index];
                BD_HarmItem *itemModel = cellModel.itemArray[i];
                
                p += pow(itemModel.validValues.doubleValue, 2);
            }
            
            allValidValues = sqrt(p);
            
            //计算最大值
            switch (tableDataModel.itemType) {
                case  S_V://模拟电压
                    maxValue = self.paramsModel.acVoltage;
                    break;
                case S_C://模拟电流
                    maxValue = self.paramsModel.acCurrent;
                    break;
                case N_V://数字电压
                    maxValue = self.paramsModel.acVoltage;
                    break;
                case N_C://数字电流
                    maxValue = self.paramsModel.acCurrent;
                    break;
                case S_V1://模拟电压1
                    maxValue = self.paramsModel.acVoltage;
                    break;
                case S_C1://模拟电流1
                    maxValue = self.paramsModel.acCurrent;
                    break;
                case N_V1://数字电压1
                    maxValue = self.paramsModel.acVoltage;
                    break;
                case N_C1://数字电流1
                    maxValue = self.paramsModel.acCurrent;
                    break;
                case S_V2://模拟电压2
                    maxValue = self.paramsModel.acVoltage;
                    break;
                case S_C2://模拟电流2
                    maxValue = self.paramsModel.acCurrent;
                    break;
                case N_V2://数字电压2
                    maxValue = self.paramsModel.acVoltage;
                    break;
                case N_C2://数字电流2
                    maxValue = self.paramsModel.acCurrent;
                    break;
            }
            
            
            //如果超过最大值
            if (allValidValues > maxValue.floatValue) {
                [MBProgressHUDUtil showMessage:[NSString stringWithFormat:@"总有效值大于%@", maxValue] toView:view];
            }
            
            //正则匹配替换字符串
            NSString *searchStr = tableDataModel.headerDataArray[i];
            NSString *regExpStr = @"[0-9]*\\.[0-9]+";
            NSString *replacement = [NSString stringWithFormat:@"%.3f", allValidValues];
            
            NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
            NSString *resultStr = searchStr;
            // 替换匹配的字符串为 searchStr
            resultStr = [regExp stringByReplacingMatchesInString:searchStr
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, searchStr.length)
                                                    withTemplate:replacement];
            
            tableDataModel.headerDataArray[i] = resultStr;
        }
        
    }
    
}

-(NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        //初始化模型数组
        _allDataArray = [NSMutableArray array];
        BD_HarmTableDataModel *firstTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_V1];
        [_allDataArray addObject:firstTable];
        BD_HarmTableDataModel *secondTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_C1];
        [_allDataArray addObject:secondTable];
        BD_HarmTableDataModel *threeTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_V2];
        [_allDataArray addObject:threeTable];
        BD_HarmTableDataModel *fourTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_C2];
        [_allDataArray addObject:fourTable];
    }
    return _allDataArray;
}

//懒加载
//系统设置
-(BD_HarmParamsSettingModel *)paramsModel
{
    if (!_paramsModel) {
        _paramsModel = [[BD_HarmParamsSettingModel alloc] init];
    }
    return _paramsModel;
}

-(BD_HarmDataSettingModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[BD_HarmDataSettingModel alloc] init];
    }
    return _dataModel;
}

//开关量设置
-(BD_HarmSwitchSettingModel *)switchModel
{
    if (!_switchModel) {
        _switchModel = [[BD_HarmSwitchSettingModel alloc] init];
    }
    return _switchModel;
}
//直流设置
-(BD_HarmDCSettingModel *)dcSettingModel
{
    if (!_dcSettingModel) {
        _dcSettingModel = [[BD_HarmDCSettingModel alloc] init];
    }
    return _dcSettingModel;
}

//切换谐波通道
-(void)changedType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway
{
    //清空数组
    [self.allDataArray removeAllObjects];
    
    if (type==BDDeviceType_Imitate) {//模拟
        
        if (passageway==BDHarmPassageType_FUTI) {//4U3I
            BD_HarmTableDataModel *firstTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_V];
            [self.allDataArray addObject:firstTable];
            BD_HarmTableDataModel *secondTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_C];
            [self.allDataArray addObject:secondTable];
            
            self.testChannel = F_U_T_I;
        }else{//6U6I
            BD_HarmTableDataModel *firstTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_V1];
            [self.allDataArray addObject:firstTable];
            BD_HarmTableDataModel *secondTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_C1];
            [self.allDataArray addObject:secondTable];
            BD_HarmTableDataModel *thirdTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_V2];
            [self.allDataArray addObject:thirdTable];
            BD_HarmTableDataModel *fourthTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:S_C2];
            [self.allDataArray addObject:fourthTable];
            
            self.testChannel = S_U_S_I;
        }
        
        self.testType = SIMULATION_TYPE;
    }else{//数字
        
        if (passageway==BDHarmPassageType_FUTI) {//4U3I
            BD_HarmTableDataModel *firstTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:N_V];
            [self.allDataArray addObject:firstTable];
            BD_HarmTableDataModel *secondTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:N_C];
            [self.allDataArray addObject:secondTable];
            
            self.testChannel = F_U_T_I;
        }else{//6U6I
            BD_HarmTableDataModel *firstTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:N_V1];
            [self.allDataArray addObject:firstTable];
            BD_HarmTableDataModel *secondTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:N_C1];
            [self.allDataArray addObject:secondTable];
            BD_HarmTableDataModel *thirdTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:N_V2];
            [self.allDataArray addObject:thirdTable];
            BD_HarmTableDataModel *fourthTable = [[BD_HarmTableDataModel alloc] initWithHarmParamsType:N_C2];
            [self.allDataArray addObject:fourthTable];
            
            self.testChannel = S_U_S_I;
        }
        
        self.testType = DIGITAL_TYPE;
    }
    
}

-(void)dealloc
{

}

@end
