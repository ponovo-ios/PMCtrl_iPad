//
//  BD_HarmDataController.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataController.h"
#import "BD_HarmDataTableView.h"
#import "UIImage+Extension.h"

@interface BD_HarmDataController ()<UIScrollViewDelegate>
{
    UIButton *_tempBtn;
    BDDeviceType _type;
    BDHarmPassageType _passageway;
    BD_HarmDataTableView *_currentTableView;
}

/**头部滚动视图*/
@property (nonatomic, weak) UIScrollView *headerView;

/**内容滚动视图*/
@property (nonatomic, weak) UIScrollView *contentView;

/**数据视图数组*/
@property (nonatomic, strong) NSMutableArray *tableViewArray;

@end

@implementation BD_HarmDataController

-(NSMutableArray *)tableViewArray
{
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = Marge;
    
    self.view.layer.borderWidth = 1.5;
    
    self.view.layer.borderColor = ClearColor.CGColor;
    
    self.view.layer.masksToBounds = YES;
    
    [self configureUI];
    
    //注册监听
    [kNotificationCenter addObserver:self selector:@selector(changeValue:) name:BD_HarmValueChange object:nil];
    [kNotificationCenter addObserver:self selector:@selector(dataSet:) name:BD_HarmDataSet object:nil];
    [kNotificationCenter addObserver:self selector:@selector(dcSettingValueChanged:) name:BD_HarmDCSettingChanged object:nil];
}

#pragma mark 通知
//改变数据
-(void)changeValue:(NSNotification *)sender
{
    NSDictionary *userInfo = sender.userInfo;
    NSInteger tag = [userInfo[@"name"] integerValue];
    NSString *param1 = userInfo[@"param1"];
    NSString *param2 = userInfo[@"param2"];
    CGFloat length = [userInfo[@"length"] floatValue];
    DLog(@"%ld -- %@ -- %@ -- %f", tag, param1, param2, length);
    //最大值
    NSString *maxValue;
    
    //分割待修改属性为数组
    NSArray *paramsArray = [param1 componentsSeparatedByString:@","];
    
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
    
    NSInteger cellIndex;
    //计算需要改变的行
    if ([param2 isEqualToString:@"基波"]) {
        cellIndex = 0;
    }else{
        cellIndex = param2.integerValue - 1;
    }
    
    DLog(@"%@ -- %zd", selTableModel, index);
    BD_HarmCellModel *cellModel = selTableModel.contentDataArray[cellIndex];
    
    //基波cell
    BD_HarmCellModel *baseCellModel = selTableModel.contentDataArray.firstObject;
    
    //计算需要改变的item  并计算含有率
    for (NSInteger i = 0; i < paramsArray.count; i++) {
        NSInteger index = [selTableModel.itemArray indexOfObject:paramsArray[i]];
        BD_HarmItem *itemModel = cellModel.itemArray[index];
        BD_HarmItem *baseItemModel = baseCellModel.itemArray[index];
        
        if (tag == 1) {//加
            itemModel.validValues = [NSString stringWithFormat:@"%.3f", itemModel.validValues.floatValue + length];
        }else if (tag == 2) {//减
            itemModel.validValues = [NSString stringWithFormat:@"%.3f", itemModel.validValues.floatValue - length];
        }
        
        //计算含有率
        itemModel.containingRate = [NSString stringWithFormat:@"%.2f", baseItemModel.validValues.floatValue==0.00?0.00:itemModel.validValues.floatValue * 100 / baseItemModel.validValues.floatValue];
        
        //计算头部总有效值
        double allValidValues = 0.0f;
        double p = 0.f;
        for (BD_HarmCellModel *cellModel in selTableModel.contentDataArray) {
            BD_HarmItem *itemModel = cellModel.itemArray[index];
            p += pow(itemModel.validValues.doubleValue, 2);
            allValidValues = sqrt(p);
        }
      
        
        if (allValidValues > maxValue.floatValue) {
            [MBProgressHUDUtil showMessage:[NSString stringWithFormat:@"总有效值大于%@", maxValue] toView:self.view];
            //超出最大值退回上一步
            if (tag == 1) {//加
                itemModel.validValues = [NSString stringWithFormat:@"%.3f", itemModel.validValues.floatValue - length];
            }else if (tag == 2) {//减
                itemModel.validValues = [NSString stringWithFormat:@"%.3f", itemModel.validValues.floatValue + length];
            }
            
            //计算含有率
            itemModel.containingRate = [NSString stringWithFormat:@"%.2f", baseItemModel.validValues.floatValue==0.00?0.00:itemModel.validValues.floatValue * 100 / baseItemModel.validValues.floatValue];
            
            continue;
        }
        
        //正则匹配替换字符串
        NSString *searchStr = selTableModel.headerDataArray[index];
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
        
        selTableModel.headerDataArray[index] = resultStr;
        
    }
    
    //刷新视图
    BD_HarmDataTableView *tableView = self.tableViewArray[_idx];
    [tableView reloadData];
    
    //刷新波形
    [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
    //发送修改数值
    BOOL isChange = [[OCCenter shareCenter] harmTestChange:self.harmModel];
    DLog(@"%@", isChange ? @"成功" : @"失败");
}

//批量设置谐波数据 ，清零，集体操作数据页面
-(void)dataSet:(NSNotification *)sender
{
    NSDictionary *userInfo = sender.userInfo;
    NSInteger tag = [userInfo[@"name"] integerValue];
    NSString *param1 = userInfo[@"param1"];
    CGFloat value = [userInfo[@"text"] floatValue];
    DLog(@"%ld -- %@ -- %f", tag, param1, value);
    //最大值
    NSString *maxValue;
    
    //分割待修改属性为数组
    NSArray *paramsArray = [param1 componentsSeparatedByString:@","];
    
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
    
    for (NSInteger i = 0; i < paramsArray.count; i++) {
        
        NSInteger index = [selTableModel.itemArray indexOfObject:paramsArray[i]];
        BD_HarmItem *baseItemModel = baseCellModel.itemArray[index];
        
        //输出范围-基波有效值-叠加辅助直流
        CGFloat allHarmValidValues = maxValue.floatValue-baseItemModel.validValues.floatValue-dcValues[i].floatValue;
        //选中基波的个数
        NSInteger selItemCount = self.harmModel.passagewayArray.count-1;
        //基波可以设置的最大值范围
        CGFloat averageValidValue = allHarmValidValues/selItemCount;
        
        //计算头部总有效值
        double allValidValues = 0.0f;
        double p = 0.f;
        
        //记录原有数据幅值数组
        NSMutableArray *validValuesArray = [NSMutableArray array];
        //记录原有数据含有率数组
        NSMutableArray *containingRateArray = [NSMutableArray array];
        
        //改变数值
        for (NSInteger i = 0; i < selTableModel.contentDataArray.count; i++) {
            //不为基波
            BD_HarmCellModel *cellModel = selTableModel.contentDataArray[i];
            BD_HarmItem *itemModel = cellModel.itemArray[index];
            if (cellModel != baseCellModel) {
                //记录原有数据
                [validValuesArray addObject:itemModel.validValues];
                [containingRateArray addObject:itemModel.containingRate];
                //赋值操作
                if (tag == 0) {//幅值
                    
                    itemModel.validValues = value<averageValidValue?[NSString stringWithFormat:@"%.3f", value]:[NSString stringWithFormat:@"%.3f", averageValidValue];
                    itemModel.containingRate = [NSString stringWithFormat:@"%.2f", itemModel.validValues.floatValue * 100 / baseItemModel.validValues.floatValue];
                }else if (tag == 1){//含有率
                    itemModel.containingRate = [NSString stringWithFormat:@"%.2f", value];
                    
                    if (baseItemModel.validValues.floatValue * value * 0.01<averageValidValue) {
                        itemModel.validValues = [NSString stringWithFormat:@"%.3f", baseItemModel.validValues.floatValue * value * 0.01];
                        itemModel.containingRate = [NSString stringWithFormat:@"%.2f", value];
                    } else {
                        itemModel.validValues = [NSString stringWithFormat:@"%.3f", averageValidValue];
                        itemModel.containingRate = [NSString stringWithFormat:@"%.2f", itemModel.validValues.floatValue * 100 / baseItemModel.validValues.floatValue];
                    }
                    
                    
                }else if (tag == 2){//相位
                    itemModel.phase = [NSString stringWithFormat:@"%.1f", value];
                }else{//清零
                    itemModel.validValues = @"0.000";
                    itemModel.containingRate = @"0.00";
                    itemModel.phase = @"0.0";
                }
                
                if ([self.harmModel.passagewayArray containsObject:[NSString stringWithFormat:@"%zd", i]]) {
                    p += pow(itemModel.validValues.doubleValue, 2);
                }
                
            }else{//基波
                
                p += pow(itemModel.validValues.doubleValue, 2);
            }
            
            allValidValues = sqrt(p);
        }
        
        
        //判断总有效值
        if (allValidValues > maxValue.floatValue) {
            [MBProgressHUDUtil showMessage:[NSString stringWithFormat:@"总有效值大于%@", maxValue] toView:self.view];
            //超出最大值退回上一步
            for (NSInteger i = 0; i < selTableModel.contentDataArray.count; i++) {
                
                BD_HarmCellModel *cellModel = selTableModel.contentDataArray[i];
                BD_HarmItem *itemModel = cellModel.itemArray[index];
                //不为基波
                if (cellModel != baseCellModel) {
                    itemModel.validValues = validValuesArray[i - 1];
                    itemModel.containingRate = containingRateArray[i - 1];
                }
            }
            
        } else {
            //正则匹配替换字符串
            NSString *searchStr = selTableModel.headerDataArray[index];
            
            //[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*
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
            
            selTableModel.headerDataArray[index] = resultStr;
        }
        
    }
    
    //刷新视图
    BD_HarmDataTableView *tableView = self.tableViewArray[_idx];
    [tableView reloadData];
    
    //刷新波形
   [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
    //发送修改数值
    BOOL isChange = [[OCCenter shareCenter] harmTestChange:self.harmModel];
    DLog(@"%@", isChange ? @"成功" : @"失败");
}

#pragma mark - 叠加直流设置
-(void)dcSettingValueChanged:(NSNotification *)noti{
    WeakSelf;
    for (int i = 0; i<self.harmModel.allDataArray.count; i++) {
         BD_HarmTableDataModel *tableModel = self.harmModel.allDataArray[i];
        switch (i) {
            case 0:
            {
                NSArray<NSString *> *dcValues = @[weakself.harmModel.dcSettingModel.ua,weakself.harmModel.dcSettingModel.ub,weakself.harmModel.dcSettingModel.uc,weakself.harmModel.dcSettingModel.uz];
                BD_HarmCellModel *baseModel = tableModel.contentDataArray[0];
                NSMutableArray *newArr = [[NSMutableArray alloc]init];
                [tableModel.headerDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   NSString *effectiveStr = ((BD_HarmItem *)baseModel.itemArray[idx]).validValues;
                    NSString * newValue= [NSString stringWithFormat:@"%@(总有效值 = %.3fV)",tableModel.itemArray[idx],[effectiveStr floatValue]+[dcValues[idx] floatValue]];
                    [newArr addObject:newValue];
                }];
                tableModel.headerDataArray = newArr;
            }
                break;
            case 1:
            {
                NSArray<NSString *> *dcValues = @[weakself.harmModel.dcSettingModel.ia,weakself.harmModel.dcSettingModel.ib,weakself.harmModel.dcSettingModel.ic];
                 BD_HarmCellModel *baseModel = tableModel.contentDataArray[0];
                for (int i = 0;i<tableModel.headerDataArray.count;i++) {
                    NSString *headerstr = tableModel.headerDataArray[i];
                    NSString *effectiveStr = ((BD_HarmItem *)baseModel.itemArray[i]).validValues;
                    NSString * newValue= [NSString stringWithFormat:@"%@(总有效值 = %.3fA)",tableModel.itemArray[i],[effectiveStr floatValue]+[dcValues[i] floatValue]];
                    [tableModel.headerDataArray replaceObjectAtIndex:i withObject:newValue];
                }
            }
                break;
            case 2:
            {
                NSArray<NSString *> *dcValues = @[weakself.harmModel.dcSettingModel.ua2,weakself.harmModel.dcSettingModel.ub2,weakself.harmModel.dcSettingModel.uc2];
                   BD_HarmCellModel *baseModel = tableModel.contentDataArray[0];
                for (int i = 0;i<tableModel.headerDataArray.count;i++) {
                    NSString *headerstr = tableModel.headerDataArray[i];
                    NSString *effectiveStr = ((BD_HarmItem *)baseModel.itemArray[i]).validValues;
                    NSString * newValue= [NSString stringWithFormat:@"%@(总有效值 = %.3fA)",tableModel.itemArray[i],[effectiveStr floatValue]+[dcValues[i] floatValue]];
                    [tableModel.headerDataArray replaceObjectAtIndex:i withObject:newValue];
                }
                
            }
                break;
            case 3:
            {
                NSArray<NSString *> *dcValues = @[weakself.harmModel.dcSettingModel.ia2,weakself.harmModel.dcSettingModel.ib2,weakself.harmModel.dcSettingModel.ic2];
                   BD_HarmCellModel *baseModel = tableModel.contentDataArray[0];
                for (int i = 0;i<tableModel.headerDataArray.count;i++) {
                    NSString *headerstr = tableModel.headerDataArray[i];
                    NSString *effectiveStr = ((BD_HarmItem *)baseModel.itemArray[i]).validValues;
                    NSString * newValue= [NSString stringWithFormat:@"%@(总有效值 = %.3fA)",tableModel.itemArray[i],[effectiveStr floatValue]+[dcValues[i] floatValue]];
                    [tableModel.headerDataArray replaceObjectAtIndex:i withObject:newValue];
                }
            }
                break;
            default:
                break;
        }
    }
    
    //刷新视图
   
    [self.tableViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BD_HarmDataTableView *tableView = weakself.tableViewArray[idx];
        tableView.tableModel = self.harmModel.allDataArray[idx];
        [tableView updateDataView];
    }];
 
    //刷新波形
    [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
    
}

#pragma mark 初始化布局设置
-(void)configureUI
{
    //添加头部滚动视图   选中按钮颜色 RGB(219, 219, 219)
    UIScrollView *headerView = [[UIScrollView alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.headerView = headerView;
    
    UIButton *allSel = [[UIButton alloc]init];
    [allSel setTitle:@"全选" forState:UIControlStateNormal];
    [allSel setCorenerRadius:6 borderColor:White borderWidth:1.0];
    allSel.tag =100;
    [allSel addTarget:self action:@selector(dataVCBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    allSel.backgroundColor = BDThemeColor;
    [self.view addSubview:allSel];
    [allSel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(150);
    }];
    
    UIButton *unSel = [[UIButton alloc]init];
    [unSel setTitle:@"全不选" forState:UIControlStateNormal];
    [unSel setCorenerRadius:6 borderColor:White borderWidth:1.0];
    unSel.backgroundColor = BDThemeColor;
    unSel.tag =101;
    [unSel addTarget:self action:@selector(dataVCBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unSel];
    [unSel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(allSel.mas_right).mas_offset(10);
        make.width.mas_equalTo(150);
    }];
    UIButton *clearBtn = [[UIButton alloc]init];
    [clearBtn setCorenerRadius:6 borderColor:White borderWidth:1.0];
    clearBtn.tag =102;
    [clearBtn addTarget:self action:@selector(dataVCBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.backgroundColor = BDThemeColor;
    [clearBtn setTitle:@"清零" forState:UIControlStateNormal];
    [self.view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(unSel.mas_right).mas_offset(10);
        make.width.mas_equalTo(150);
    }];
    
    //添加内容视图
    UIScrollView *contentView = [[UIScrollView alloc] init];
//    contentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(allSel.mas_top).mas_offset(-5);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    self.contentView = contentView;
    
    
}

//根据谐波类型创建子视图
-(void)loadSubViewType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway
{
    
    //先清除在添加
    [self clearSubViews];
    
    BOOL creatNewView = NO;
    
    //如果谐波数据类型变化则清除数据视图数组
    if (_type!=type || _passageway!=passageway) {
        _type = type;
        _passageway = passageway;
        //清空数组
        [self.tableViewArray removeAllObjects];
        creatNewView = YES;
    }
    
    NSArray *titleArray;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 150;
    CGFloat btnH = 50;
    NSString *numStr;
    NSString *countStr;
    
    if (type==BDDeviceType_Imitate) {
        numStr = @"";
    }else{
        numStr = @"`";
    }
    
    if (passageway==BDHarmPassageType_FUTI) {
        titleArray = @[@"电压谐波", @"电流谐波"];
    }else{
        titleArray = @[@"电压谐波一组", @"电流谐波一组", @"电压谐波二组", @"电流谐波二组"];
    }
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        //添加头部按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:RGB(219, 219, 219) width:btnW height:btnH title:@""] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:MainBgColor width:btnW height:btnH title:@""] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(btnX + btnW * i, btnY, btnW, btnH);
        [self.headerView addSubview:button];
        [button addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i < 2) {
            countStr = @"";
        }else{
            countStr = @"2";
        }
        
        BD_HarmTableDataModel *tableModel = self.harmModel.allDataArray[i];
        
        //如果谐波类型变化则重新创建数据视图，添加到数组中
        if (creatNewView) {
            
            BD_HarmDataTableView *tableView = [[BD_HarmDataTableView alloc] initWithFrame:CGRectMake(self.contentView.width * i, 0, self.contentView.width, self.contentView.height) style:UITableViewStylePlain tableModel:tableModel];
            
            //添加视图到数组中
            [self.tableViewArray addObject:tableView];
            tableView.harmModel = self.harmModel;
            
        }
        
        if (i == 0) {//默认点击第一项
            [self headerBtnClick:button];
        }
    }
    
    
}

//移除子视图
-(void)clearSubViews
{
    [self.headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

//头部按钮点击
-(void)headerBtnClick:(UIButton *)sender
{
    _tempBtn.selected = NO;
    sender.selected = YES;
    _tempBtn = sender;
    
    //拿到对应视图
    _currentTableView = self.tableViewArray[sender.tag];
    //判断是否添加到contentView中  不包含则添加
    if (![self.contentView.subviews containsObject:_currentTableView]) {
        [self.contentView addSubview:_currentTableView];
    }else{//包含则刷新视图
        [_currentTableView reloadData];
    }
    
    //切换视图
    [self.contentView setContentOffset:CGPointMake(sender.tag * self.contentView.width, 0) animated:NO];
}

-(void)updateDataView{
    WeakSelf;
    [self.tableViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ((BD_HarmDataTableView *)obj).tableModel = weakself.harmModel.allDataArray[idx];
        [((BD_HarmDataTableView *)obj) updateDataView];
    }];
     
}
     
-(void)dataVCBtnAction:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            //全选
        {
            
            [_currentTableView selectAllCell];
            //刷新波形
            [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
            //发送修改数值
            BOOL isChange = [[OCCenter shareCenter] harmTestChange:self.harmModel];
            DLog(@"%@", isChange ? @"成功" : @"失败");
        }
            break;
        case 101:
            //全不选
        {
            [_currentTableView deSelectAllCell];
            //刷新波形
           [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
            
            //发送修改数值
            BOOL isChange = [[OCCenter shareCenter] harmTestChange:self.harmModel];
            DLog(@"%@", isChange ? @"成功" : @"失败");
        }
        
            break;
        case 102:
            //清零
            [kNotificationCenter postNotificationName:BD_HarmDataSet object:nil userInfo:@{@"name" : @(4), @"param1" : self.harmModel.dataModel.channelPort, @"text" : @"0.0"}];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{

    [kNotificationCenter removeObserver:self name:BD_HarmValueChange object:nil];
    [kNotificationCenter removeObserver:self name:BD_HarmDataSet object:nil];
}

@end
