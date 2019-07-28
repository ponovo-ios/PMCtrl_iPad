//
//  BD_HarmDataTableView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataTableView.h"
#import "BD_HarmDataHeaderView.h"
#import "BD_HarmDataCell.h"


@interface BD_HarmDataTableView()<UITableViewDelegate, UITableViewDataSource,BDHarmDataCellEditDelegate>
{
    NSArray *_titleArray;
    CGFloat _thirdTitleMarge;
    NSArray *_contentArray;
    BD_HarmDataCell *_tempCell;
}

/**头部视图*/
@property (nonatomic, weak) BD_HarmDataHeaderView *headerView;

@end

static NSString * const DataCell = @"HarmDataCell";

@implementation BD_HarmDataTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style tableModel:(BD_HarmTableDataModel *)tableModel
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
        
        _tableModel = tableModel;
        _titleArray = tableModel.headerDataArray;
        _contentArray = tableModel.contentDataArray;
        [kNotificationCenter addObserver:self selector:@selector(changeOutputLimitValue:) name:BD_OutPutLimitNotifi object:nil];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

//初始化设置
-(void)setup
{
    //初始化状态
    CGFloat subView4W = (self.width - 102) * 0.25;
    CGFloat subView3W = (self.width - 102) / 3;
    _thirdTitleMarge = -subView4W - (subView3W - subView4W);
    
    self.dataSource = self;
    self.delegate = self;
    self.bounces = NO;
    self.separatorColor = [UIColor darkGrayColor];
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([BD_HarmDataCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DataCell];
    
}

#pragma mark - 懒加载
-(BD_HarmModel *)harmModel{
    if (!_harmModel) {
        _harmModel = [[BD_HarmModel alloc]init];
    }
    return _harmModel;
}
#pragma mark 对外调用接口
//全选
-(void)selectAllCell
{
    //选择数组大于31返回
    if (self.harmModel.passagewayArray.count >= 31) {
        return;
    }
    
    NSInteger i = 2;
    while (self.harmModel.passagewayArray.count < 31) {
        //判断是否存在 不存在则添加
        if (![self.harmModel.passagewayArray containsObject:[NSString stringWithFormat:@"%zd", i]]) {
            [self.harmModel.passagewayArray insertObject:[NSString stringWithFormat:@"%zd", i] atIndex:i - 1];
        }
        
        i++;
    }
    
    //改变总有效值
    [self.harmModel changeAllValueOnView:self];
    
    [self reloadData];
}

//全不选
-(void)deSelectAllCell
{
    [self.harmModel.passagewayArray removeAllObjects];
    [self.harmModel.passagewayArray addObject:@"基波"];
    //改变总有效值
    [self.harmModel changeAllValueOnView:self];
    
    [self reloadData];
}

//是否通过勾选按钮刷新头部总有效值
-(void)headerViewReloadDataWithCheck:(BOOL)check index:(NSInteger)index
{
    if (check) {
        //改变总有效值
        [self.harmModel changeAllValueOnView:self];
    }else{
        //超出最大值则返回上一步更改值
        if (![self.harmModel changeValueWithTableData:self.tableModel index:index view:self]){
            
            [_tempCell goBack];

        }
    }
    
    //刷新显示头部数据
    self.headerView.titleArray = self.tableModel.headerDataArray;
    [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BD_HarmDataHeaderView *headerView = [BD_HarmDataHeaderView viewFromXib];
    self.headerView = headerView;
    
    //通道选择
    if (_titleArray.count == 3) {//6U6I  3标题栏
        headerView.viewZConstraint.constant = _thirdTitleMarge;
        
    }else{//4U3I 4标题栏
        headerView.viewZConstraint.constant = 0;
    }
    
    headerView.titleArray = _titleArray;
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BD_HarmDataCell *cell = [tableView dequeueReusableCellWithIdentifier:DataCell];
    
    //基波
    BD_HarmCellModel *baseCellModel = _contentArray.firstObject;
    //对应数据
    BD_HarmCellModel *cellModel = _contentArray[indexPath.row];
    
    cell.baseCellModel = baseCellModel;
    cell.cellModel = cellModel;
    
    cell.index = indexPath.row;
    cell.editDelegate  = self;
    __weak typeof(self) weakSelf = self;
    //勾选谐波次数
    cell.clickSelectBtn = ^(NSInteger index, UIButton *sender) {

        //添加选中谐波
        if (![weakSelf.harmModel.passagewayArray containsObject:[NSString stringWithFormat:@"%zd", index + 1]]) {
            
            if (weakSelf.harmModel.passagewayArray.count >= 31) {//数组数量小于31
                [MBProgressHUD showError:@"谐波次数大于31" toView:nil];
            }else{
                if (weakSelf.harmModel.passagewayArray.count < index) {//防止数组越界
                    [weakSelf.harmModel.passagewayArray addObject:[NSString stringWithFormat:@"%zd", index + 1]];
                }else{
                    [weakSelf.harmModel.passagewayArray insertObject:[NSString stringWithFormat:@"%zd", index + 1] atIndex:index];
                }
                sender.selected = YES;
            }
            
        }else if ([weakSelf.harmModel.passagewayArray containsObject:[NSString stringWithFormat:@"%zd", index + 1]]){//删除谐波
           
            [weakSelf.harmModel.passagewayArray removeObject:[NSString stringWithFormat:@"%zd", index + 1]];
            sender.selected = NO;
            
        }
        if (![weakSelf.harmModel.passagewayArray containsObject:weakSelf.harmModel.dataModel.passagewayIndex]) {
            [kNotificationCenter postNotificationName:BD_HarmUnselectedItem object:nil userInfo:nil];
        }
        //改变总有效值
        [weakSelf headerViewReloadDataWithCheck:YES index:0];
    };
    
    //修改某一值改变总有效值
    __weak typeof(cell) weakcell = cell;
    cell.changeValue = ^(NSInteger index) {
        _tempCell = cell;
        [weakSelf headerViewReloadDataWithCheck:NO index:index];
        if ([weakcell.harmNumLabel.text isEqualToString:@"基波"]) {
            
            BD_HarmCellModel *baseModel = _contentArray.firstObject;
            
            [_contentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BD_HarmCellModel *model = obj;
                [model.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BD_HarmItem *item = obj;
                    item.containingRate = ((BD_HarmItem *)baseModel.itemArray[idx]).validValues.floatValue==0? @"0":[NSString stringWithFormat:@"%.2f",item.validValues.floatValue*100/((BD_HarmItem *)baseModel.itemArray[idx]).validValues.floatValue];
                }];
            }];
            [weakSelf reloadData];
        }
    };
    
    if (indexPath.row == 0) {//基波 含有率不可修改
        cell.selectBtn.enabled = NO;
        cell.harmNumLabel.text = @"基波";
        cell.firstContainingRateTF.enabled = NO;
        cell.secondContainingRateTF.enabled = NO;
        cell.thirdContainingRateTF.enabled = NO;
        cell.fourthContainingRateTF.enabled = NO;
        cell.firstContainingRateTF.textColor = [UIColor darkGrayColor];
        cell.secondContainingRateTF.textColor = [UIColor darkGrayColor];
        cell.thirdContainingRateTF.textColor = [UIColor darkGrayColor];
        cell.fourthContainingRateTF.textColor = [UIColor darkGrayColor];
        
    }else{//其他谐波
        cell.selectBtn.enabled = YES;
        cell.firstContainingRateTF.enabled = YES;
        cell.secondContainingRateTF.enabled = YES;
        cell.thirdContainingRateTF.enabled = YES;
        cell.fourthContainingRateTF.enabled = YES;
        cell.firstContainingRateTF.textColor = Black;
        cell.secondContainingRateTF.textColor = Black;
        cell.thirdContainingRateTF.textColor = Black;
        cell.fourthContainingRateTF.textColor = Black;
        cell.harmNumLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
    }
    
    if ([self.harmModel.passagewayArray containsObject:[NSString stringWithFormat:@"%zd", indexPath.row + 1]]) {
        cell.selectBtn.selected = YES;
    }else{
        cell.selectBtn.selected = NO;
    }
    
    //cell类型
    if (_titleArray.count == 3) {
        cell.view4Constraint.constant = _thirdTitleMarge;
    }else{
        cell.view4Constraint.constant = 0;
    }
    
    return cell;
}

-(void)updateDataView{
    _contentArray = _tableModel.contentDataArray;
    _titleArray = _tableModel.headerDataArray;
    [self reloadData];
}
-(void)changeOutputLimitValue:(NSNotification *)noti{
    BD_HardwarkConfigModel *hardworakModel = (BD_HardwarkConfigModel *)noti.object;
    self.harmModel.paramsModel.acVoltage = hardworakModel.exchangeVoltage;
    self.harmModel.paramsModel.acCurrent = hardworakModel.exchangeCurrent;
    self.harmModel.paramsModel.dcVoltage = hardworakModel.directCurrent;
    self.harmModel.paramsModel.dcCurrent = hardworakModel.directVoltage;
}

#pragma mark - cell编辑代理
-(NSArray *)getLimitValues{
    return [self caculateLimitValueWithVarparamValue];
}
//根据选择的变量类型获取最大的可输入范围
-(NSArray *)caculateLimitValueWithVarparamValue{
    //最大值
    NSString *maxValue;
    
    NSArray *harmNumArr = [[BD_Utils shared] buddleSort:[self.harmModel.passagewayArray copy]];
    NSInteger idx = [self.harmModel.allDataArray indexOfObject:self.tableModel];
    NSArray<NSString *> *dcValues;
    switch (idx) {
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
    
        switch (self.tableModel.itemType) {
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
        BD_HarmCellModel *baseCellModel = self.tableModel.contentDataArray.firstObject;
        NSMutableArray *limitArr = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < self.tableModel.itemArray.count; i++) {
    
            BD_HarmItem *baseItemModel = baseCellModel.itemArray[i];
            
            //输出范围-基波有效值-叠加辅助直流
            CGFloat allHarmValidValues = maxValue.floatValue-baseItemModel.validValues.floatValue-dcValues[i].floatValue;
            //选中基波有效值的总和
            CGFloat selItemAllValue = 0.00;
            
            for (int n = 1; n<harmNumArr.count;n++) {
                int harmIndex = [harmNumArr[n] intValue];
                BD_HarmCellModel *cellModel = self.tableModel.contentDataArray[harmIndex-1];
                selItemAllValue +=((BD_HarmItem *)cellModel.itemArray[i]).validValues.floatValue;
            }
            CGFloat passageLimit = allHarmValidValues-selItemAllValue;
            [limitArr addObject:@(passageLimit)];
        }
 
    return [limitArr copy];
    
}


-(void)dealloc{
    
    //添加监听后，必须移除
    [kNotificationCenter removeObserver:self name:BD_OutPutLimitNotifi object:nil];
    
}
@end
