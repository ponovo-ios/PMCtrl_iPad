//
//  BD_HarmDataSettingTableView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataSettingTableView.h"
#import "BD_HarmPassagewaySelCell.h"
#import "BD_HarmDataChangeCell.h"
#import "BD_HarmDataSettingCell.h"
#import "BD_HarmOtherSettingCell.h"

@interface BD_HarmDataSettingTableView()<UITableViewDelegate, UITableViewDataSource, BD_HarmOtherSettingCellDelegate, BD_HarmDataSettingCellDelegate>
{
    BD_HarmOtherSettingCell *_tempCell;
    BD_HarmDataChangeCell *_dataChangeCell;
    BD_HarmPassagewaySelCell *_passagewaySelCell;
}

/**参数数组*/
@property (nonatomic, strong) NSArray *paramsArray;
@property (nonatomic,strong)NSArray *limitArr;
@end

static NSString * const PassagewaySelCell = @"HarmPassagewaySelCell";
static NSString * const DataChangeCell = @"HarmDataChangeCell";
static NSString * const DataSettingCell = @"HarmDataSettingCell";
static NSString * const OtherSettingCell = @"HarmOtherSettingCell";

@implementation BD_HarmDataSettingTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
   
    self.backgroundColor = MainBgColor;
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    //默认6U6I
    self.paramsArray = @[@"Ua", @"Ub", @"Uc", @"Ua,Ub", @"Ub,Uc", @"Uc,Ua", @"Ua,Ub,Uc", @"Ia", @"Ib", @"Ic", @"Ia,Ib", @"Ib,Ic", @"Ic,Ia", @"Ia,Ib,Ic", @"Ua2", @"Ub2", @"Uc2", @"Ua2,Ub2", @"Ub2,Uc2", @"Uc2,Ua2", @"Ua2,Ub2,Uc2", @"Ia2", @"Ib2", @"Ic2", @"Ia2,Ib2", @"Ib2,Ic2", @"Ic2,Ia2", @"Ia2,Ib2,Ic2"];
    
    //注册
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([BD_HarmPassagewaySelCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PassagewaySelCell];
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([BD_HarmDataChangeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DataChangeCell];
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([BD_HarmDataSettingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DataSettingCell];
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([BD_HarmOtherSettingCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:OtherSettingCell];
    
    self.tableFooterView = [UIView new];
    
    [kNotificationCenter addObserver:self selector:@selector(changePassageBtn:) name:BD_HarmUnselectedItem object:nil];
    _limitArr = [[NSArray alloc]init];
}

-(void)changedType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway
{
    
    if (type==BDDeviceType_Imitate) {
        if (passageway==BDHarmPassageType_FUTI) {//模拟 4U3I
            self.paramsArray = @[@"Ua", @"Ub", @"Uc", @"Uz", @"Ua,Ub", @"Ub,Uc", @"Uc,Ua", @"Ua,Ub,Uc", @"Ua,Ub,Uc,Uz", @"Ia", @"Ib", @"Ic", @"Ia,Ib", @"Ib,Ic", @"Ic,Ia", @"Ia,Ib,Ic"];
        }else{//模拟 6U6I
            self.paramsArray = @[@"Ua", @"Ub", @"Uc", @"Ua,Ub", @"Ub,Uc", @"Uc,Ua", @"Ua,Ub,Uc", @"Ia", @"Ib", @"Ic", @"Ia,Ib", @"Ib,Ic", @"Ic,Ia", @"Ia,Ib,Ic", @"Ua2", @"Ub2", @"Uc2", @"Ua2,Ub2", @"Ub2,Uc2", @"Uc2,Ua2", @"Ua2,Ub2,Uc2", @"Ia2", @"Ib2", @"Ic2", @"Ia2,Ib2", @"Ib2,Ic2", @"Ic2,Ia2", @"Ia2,Ib2,Ic2"];
        }
    }else{
        if (passageway==BDHarmPassageType_FUTI) {//数字 4U3I
            self.paramsArray = @[@"Ua`", @"Ub`", @"Uc`", @"Uz`", @"Ua`,Ub`", @"Ub`,Uc`", @"Uc`,Ua`", @"Ua`,Ub`,Uc`", @"Ua`,Ub`,Uc`,Uz`", @"Ia`", @"Ib`", @"Ic`", @"Ia`,Ib`", @"Ib`,Ic`", @"Ic`,Ia`", @"Ia`,Ib`,Ic`"];
        }else{//数字 6U6I
            self.paramsArray = @[@"Ua`", @"Ub`", @"Uc`", @"Ua`,Ub`", @"Ub`,Uc`", @"Uc`,Ua`", @"Ua`,Ub`,Uc`", @"Ia`", @"Ib`", @"Ic`", @"Ia`,Ib`", @"Ib`,Ic`", @"Ic`,Ia`", @"Ia`,Ib`,Ic`", @"Ua2`", @"Ub2`", @"Uc2`", @"Ua2`,Ub2`", @"Ub2`,Uc2`", @"Uc2`,Ua2`", @"Ua2`,Ub2`,Uc2`", @"Ia2`", @"Ib2`", @"Ic2`", @"Ia2`,Ib2`", @"Ib2`,Ic2`", @"Ic2`,Ia2`", @"Ia2`,Ib2`,Ic2`"];
        }
    }
    
    //刷新cell
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark BD_HarmDataSettingCellDelegate
//谐波数据设置
-(void)changeValue:(NSInteger)tag text:(NSString *)text
{
    //发送改变数据通知
    [kNotificationCenter postNotificationName:BD_HarmDataSet object:nil userInfo:@{@"name" : @(tag), @"param1" : _passagewaySelCell.firstPickerBtn.titleLabel.text, @"text" : text}];
    
}

#pragma mark UITableViewDelegate, UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.height * 0.25 - 40;
    }else if (indexPath.row == 1){
        return self.height * 0.25 + 40;
    }else{
        return self.height * 0.25;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {//通道选择
        WeakSelf;
        BD_HarmPassagewaySelCell *cell = [tableView dequeueReusableCellWithIdentifier:PassagewaySelCell];
        cell.passagewayArray = self.harmModel.passagewayArray;
        
        cell.paramsArray = self.paramsArray;
        [cell.firstPickerBtn setTitle:self.paramsArray.firstObject forState:UIControlStateNormal];
        self.harmModel.dataModel.channelPort = self.paramsArray.firstObject;
        cell.dataModel = self.harmModel.dataModel;
        cell.changePassageBlock = ^{
             //修改了变量通道
            _dataChangeCell.limitValueArr = [weakself caculateLimitValueWithVarparamValue:weakself.harmModel.dataModel.channelPort];
            _dataChangeCell.voltageMax = [weakself caculateMaxLimitWithvarParam:weakself.harmModel.dataModel.channelPort];
            [_dataChangeCell limitValueChangedSetViewData];
        };
        _passagewaySelCell = cell;
        return cell;
    }else if (indexPath.row == 1){//变化设置
        __weak typeof(self) weakSelf = self;
        BD_HarmDataChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:DataChangeCell];
        cell.dataModel = self.harmModel.dataModel;
        cell.limitValueArr = [self caculateLimitValueWithVarparamValue:self.harmModel.dataModel.channelPort];
        cell.voltageMax = [self caculateMaxLimitWithvarParam:self.harmModel.dataModel.channelPort];
        cell.autoBtnClick = ^(BOOL isOn) {
            weakSelf.harmModel.dataModel.isAuto = isOn;
            _tempCell.addBtn.enabled = !isOn;
            _tempCell.subtractionBtn.enabled = !isOn;
        };
        [cell changePassageWay:self.harmModel.dataModel.channelPort];
        _dataChangeCell = cell;
        return cell;
    }else{//谐波数据设置
        BD_HarmDataSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:DataSettingCell];
        cell.delegate = self;
        [cell changePassageWay:self.harmModel.dataModel.channelPort];
        
        return cell;
    }
    
}

/**获取最大值，交流电压最大值或交流电流最大值*/
-(CGFloat)caculateMaxLimitWithvarParam:(NSString *)varParam{
    NSString *maxValue;
    
    //分割待修改属性为数组
    NSArray *paramsArray = [varParam componentsSeparatedByString:@","];
    NSArray *harmNumArr = [[BD_Utils shared] buddleSort:[self.harmModel.passagewayArray copy]];
    //筛选出是哪个模型
    __block BD_HarmTableDataModel *selTableModel;
    __block NSInteger _idx;
    [self.harmModel.allDataArray enumerateObjectsUsingBlock:^(BD_HarmTableDataModel *tableModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([tableModel.itemArray containsObject:paramsArray.firstObject]) {
            selTableModel = tableModel;
            _idx = idx;
            *stop = YES;
        }
    }];
    NSArray<NSString *> *dcValues;
    switch (_idx) {
        case 0:
            dcValues = @[self.harmModel.dcSettingModel.ua,self.harmModel.dcSettingModel.ub,self.harmModel.dcSettingModel.uc,self.harmModel.dcSettingModel.uz];
            
            break;
        case 1:
            
            dcValues = @[self.harmModel.dcSettingModel.ia,self.harmModel.dcSettingModel.ib,self.harmModel.dcSettingModel.ic];
            break;
        case 2:
            dcValues = @[self.harmModel.dcSettingModel.ua2,self.harmModel.dcSettingModel.ub2,self.harmModel.dcSettingModel.uc2];
            break;
        case 3:
            dcValues = @[self.harmModel.dcSettingModel.ia2,self.harmModel.dcSettingModel.ib2,self.harmModel.dcSettingModel.ic2];
            break;
        default:
            break;
    }
    //计算最大值
    switch (selTableModel.itemType) {
        case  S_V://模拟电压
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case S_C://模拟电流
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case N_V://数字电压
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case N_C://数字电流
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case S_V1://模拟电压1
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case S_C1://模拟电流1
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case N_V1://数字电压1
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case N_C1://数字电流1
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case S_V2://模拟电压2
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case S_C2://模拟电流2
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case N_V2://数字电压2
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case N_C2://数字电流2
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
    }
    return [maxValue floatValue];
}

//根据选择的变量类型输出可以变化的最大最大范围=最大值-基波-叠加直流
-(NSArray *)caculateLimitValueWithVarparamValue:(NSString *)varParam{
    //最大值
    NSString *maxValue;
    
    //分割待修改属性为数组
    NSArray *paramsArray = [varParam componentsSeparatedByString:@","];
    NSArray *harmNumArr = [[BD_Utils shared] buddleSort:[self.harmModel.passagewayArray copy]];
    //筛选出是哪个模型
    __block BD_HarmTableDataModel *selTableModel;
    __block NSInteger _idx;
    [self.harmModel.allDataArray enumerateObjectsUsingBlock:^(BD_HarmTableDataModel *tableModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([tableModel.itemArray containsObject:paramsArray.firstObject]) {
            selTableModel = tableModel;
            _idx = idx;
            *stop = YES;
        }
    }];
    NSArray<NSString *> *dcValues;
    switch (_idx) {
        case 0:
            dcValues = @[self.harmModel.dcSettingModel.ua,self.harmModel.dcSettingModel.ub,self.harmModel.dcSettingModel.uc,self.harmModel.dcSettingModel.uz];
            break;
        case 1:
            
            dcValues = @[self.harmModel.dcSettingModel.ia,self.harmModel.dcSettingModel.ib,self.harmModel.dcSettingModel.ic];
            break;
        case 2:
            dcValues = @[self.harmModel.dcSettingModel.ua2,self.harmModel.dcSettingModel.ub2,self.harmModel.dcSettingModel.uc2];
            break;
        case 3:
            dcValues = @[self.harmModel.dcSettingModel.ia2,self.harmModel.dcSettingModel.ib2,self.harmModel.dcSettingModel.ic2];
            break;
        default:
            break;
    }
    //计算最大值
    switch (selTableModel.itemType) {
        case  S_V://模拟电压
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case S_C://模拟电流
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case N_V://数字电压
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case N_C://数字电流
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case S_V1://模拟电压1
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case S_C1://模拟电流1
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case N_V1://数字电压1
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case N_C1://数字电流1
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case S_V2://模拟电压2
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case S_C2://模拟电流2
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
        case N_V2://数字电压2
            maxValue = self.harmModel.paramsModel.acVoltage;
            break;
        case N_C2://数字电流2
            maxValue = self.harmModel.paramsModel.acCurrent;
            break;
    }
    
    
    //基波cell
    BD_HarmCellModel *baseCellModel = selTableModel.contentDataArray.firstObject;
    NSMutableArray *limitArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < paramsArray.count; i++) {
        
        NSInteger index = [selTableModel.itemArray indexOfObject:paramsArray[i]];
        BD_HarmItem *baseItemModel = baseCellModel.itemArray[index];
        
        //输出范围-基波有效值-叠加辅助直流
        CGFloat allHarmValidValues = maxValue.floatValue-baseItemModel.validValues.floatValue-dcValues[i].floatValue;
//        //选中基波有效值的总和
//        CGFloat selItemAllValue = 0.00;
//
//        for (int n = 1; n<harmNumArr.count;n++) {
//            int harmIndex = [harmNumArr[n] intValue];
//            BD_HarmCellModel *cellModel = selTableModel.contentDataArray[harmIndex];
//            selItemAllValue +=((BD_HarmItem *)cellModel.itemArray[i]).validValues.floatValue;
//        }
//        CGFloat passageLimit = allHarmValidValues-selItemAllValue;
        [limitArr addObject:@(allHarmValidValues)];
    }
    
    return [limitArr copy];
    
}


#pragma mark - 通知
-(void)changePassageBtn:(NSNotification *)noti{
    [_passagewaySelCell.secondPickerBtn setTitle:@"基波" forState:UIControlStateNormal];
    
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_HarmUnselectedItem object:nil];
}

@end
