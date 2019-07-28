//
//  BD_QuickTestParamSetView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2017/10/15.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestParamSetView.h"
#import "BD_QuickTestComParamCell.h"
#import "BD_QuickTestComParamSwitchSetCell.h"
#import "BD_QuickTestComParamVarCell.h"
#import "BD_BinaryInSetVC.h"
#import "BD_DirecCurrentCell.h"
#import "BD_QuickTestParamModel.h"
#import "UIImage+Extension.h"

#define VariateNameArray_V  [[NSMutableArray alloc]initWithObjects:@"Ua",@"Ub",@"Uc",@"Ua,Ub",@"Ua,Uc",@"Ub,Uc",@"Ua,Ub,Uc", nil]
#define VariateNameArray_C [[NSMutableArray alloc]initWithObjects:@"Ia",@"Ib",@"Ic",@"Ia,Ib",@"Ia,Ic",@"Ib,Ic",@"Ia,Ib,Ic", nil]
#define HeaderViewTitles [[NSMutableArray alloc]initWithObjects:@"整定值",@"测试参数",@"通用参数",@"开关量设置",@"开入量设置", nil]
@interface BD_QuickTestParamSetView()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>{
    int pickerColumSelectedNum;
    int pickerRowSelectedNum;
    NSMutableArray *binaryInArr;
    NSMutableArray *binaryOutArr;
    bool isBtnScroll;
    int passagewayGroupIndex;
    NSMutableArray<NSMutableArray *> *cellTitles;
    
    NSString *exchangeVoltageLimit;
    NSString *exchangeCurrentLimit;
    NSString *directVoltageLimit;
    NSString *directCurrentLimit;
    
}
@property (weak, nonatomic) IBOutlet UIView *btnView;

@property(nonatomic,strong)UIScrollView *btnScrollView;

@property(nonatomic,strong)NSMutableArray<UIButton *> *paraBtnArr;
@property (nonatomic, copy) UIPickerView * picker;
@property (nonatomic,strong)UIButton *varParamBtn;
@property (nonatomic, copy) NSArray * columnData;
@property (nonatomic,strong)UIViewController *pickerVC;

@property (nonatomic, strong) NSMutableArray  * rowArr;
@property (nonatomic, strong) NSMutableArray * columnArr;
@property (nonatomic, copy) NSArray * rowData;
@property (nonatomic, strong) NSMutableArray<NSString *> * passageGroupArr;
@property (nonatomic, strong) NSMutableArray<NSString *> *variateNameArr;

@property(nonatomic,strong)BD_BinaryInSetVC *binaryInVC;
@end



@implementation BD_QuickTestParamSetView



-(void)awakeFromNib{
    [super awakeFromNib];
    
    _btnView.backgroundColor = MainBgColor;
    [_btnView setCorenerRadius:10.0 borderColor:Black borderWidth:2.0];
    self.tableView.backgroundColor = MainBgColor;
    self.backgroundColor = MainBgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestComParamCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestComParamCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestComParamSwitchSetCell" bundle:nil] forCellReuseIdentifier:@"BD_QuickTestComParamSwitchSetCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestComParamVarCell" bundle:nil] forCellReuseIdentifier:@"BD_QuickTestComParamVarCellID"];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_DirecCurrentCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_DirecCurrentCellID"];
    
    //初始化就使用，设置默认参数
    _pickerModel = [[BD_QuickTestPickerModel alloc]initWithTitle:@"Ua" row:@[@10] column:1 group:0];
    
    
    isBtnScroll = NO;
    passagewayGroupIndex = 0;
    _passageGroupArr = [[NSMutableArray alloc]initWithObjects:@"G1", nil];
    _variateNameArr = [[VariateNameArray_V arrayByAddingObjectsFromArray:VariateNameArray_C]mutableCopy];
    //初始化开入量数据
    if (!binaryInArr) {
        binaryInArr = [[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES)]];
    }
        int kcl_in =
        [binaryInArr[0] intValue] *pow(2 ,0) +
        [binaryInArr[1] intValue] *pow(2, 1) +
        [binaryInArr[2] intValue] *pow(2, 2) +
        [binaryInArr[3] intValue] *pow(2, 3) +
        [binaryInArr[4] intValue] *pow(2, 4) +
        [binaryInArr[5] intValue] *pow(2, 5) +
        [binaryInArr[6] intValue] *pow(2, 6) +
        [binaryInArr[7] intValue] *pow(2, 7) +
        [binaryInArr[8] intValue] *pow(2, 8) +
        [binaryInArr[9] intValue] *pow(2, 9);
        
    self.comParam.binaryIn = @(kcl_in);
   
    if (!binaryOutArr) {
        binaryOutArr = [[NSMutableArray alloc]initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)]];
    }
    int kcl_out =
    ![binaryOutArr[0] boolValue] *pow(2 ,0) +
    ![binaryOutArr[1] boolValue] *pow(2, 1) +
    ![binaryOutArr[2] boolValue] *pow(2, 2) +
    ![binaryOutArr[3] boolValue] *pow(2, 3) +
    ![binaryOutArr[4] boolValue] *pow(2, 4) +
    ![binaryOutArr[5] boolValue] *pow(2, 5) +
    ![binaryOutArr[6] boolValue] *pow(2, 6) +
    ![binaryOutArr[7] boolValue] *pow(2, 7);
    
    self.comParam.binaryOut = @(kcl_out);
    
    [self.passagewayNum addObserver:self forKeyPath:@"voltagePassageNum" options:NSKeyValueObservingOptionNew context:nil];
    [self.passagewayNum addObserver:self forKeyPath:@"currentPassageNum" options:NSKeyValueObservingOptionNew context:nil];
    cellTitles  = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObjects:@"整定动作值",@"整定动作时间(s)", nil],[NSMutableArray arrayWithObjects:@"变量",@"始值(V)",@"终值(V)",@"变化步长(V)",@"变化时间(s)",@"自动递变",@"自动递变方式",@"直流",@"老化试验",@"触发后延时(s)", nil],[NSMutableArray arrayWithObjects:@"额定线电压(V)",@"额定电流(A)",@"额定频率(Hz)", nil], nil];

    [self createParaBtnView];
    
    [kNotificationCenter addObserver:self selector:@selector(changeOutputLimitValue:) name:BD_OutPutLimitNotifi object:nil];
    
    //设置直流电压 交流电压 直流电流 交流电流
    exchangeVoltageLimit = @"120.000";
    exchangeCurrentLimit = @"20.000";
    directVoltageLimit = @"169.706";
    directCurrentLimit = @"10.000";
    
}


-(void)createParaBtnView{
    if (!_btnScrollView) {
        _btnScrollView = [[UIScrollView alloc]init];

        [_btnView addSubview:_btnScrollView];
        [_btnScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.and.bottom.mas_equalTo(_btnView);
            make.centerX.mas_equalTo(_btnView.mas_centerX);
        }];
        CGFloat btnHeight = 45;
        CGFloat btny = 10;
        CGFloat btnWidth = _btnView.width-20.0;
        for (NSInteger i=0;i<HeaderViewTitles.count;i++) {

            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 50+(btny+btnHeight)*i, btnWidth, btnHeight)];
            [btn setBackgroundImage:[UIImage imageWithColor:MainBgColor width:btn.width height:btn.height title:HeaderViewTitles[i]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:BDThemeColor width:btn.width height:btn.height title: HeaderViewTitles[i]] forState:UIControlStateSelected];
            [btn setTitle:HeaderViewTitles[i] forState:UIControlStateNormal];
            [btn setCorenerRadius:6.0 borderColor:BtnViewBorderColor borderWidth:2.0];
            [btn addTarget:self action:@selector(btnViewAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                [btn setSelected:YES];
            } else {
                [btn setSelected:NO];
            }
            [_btnScrollView addSubview:btn];
            [self.paraBtnArr addObject:btn];
            
        }
        _btnScrollView.contentSize = CGSizeMake(_btnScrollView.width,(btnHeight+btny)*_paraBtnArr.count);
     
    }
    
    
}

-(void)btnViewAction:(UIButton *)sender{
    isBtnScroll = YES;
    [self changeClickBtnState:sender];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[_paraBtnArr indexOfObject:sender]] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}



//修改按钮状态
-(void)changeClickBtnState:(UIButton *)clickBtn{

    [_paraBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:clickBtn]) {
            [obj setSelected:YES];
        } else {
            [obj setSelected:NO];
        }
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return HeaderViewTitles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0://整定值
            return cellTitles[section].count;
            break;
        case 1://测试参数
            return cellTitles[section].count;
            break;
        case 2://通用参数
            return 3;
            break;
        case 3://开关量设置
            return 11;
            break;
        case 4://开入量设置
             return 1;
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row
         == 0) {
        return 100;
    } else {
        return 60;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
        return 40;
    
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    UITableViewCell *cell;
    if (indexPath.section == 0 || (indexPath.section == 1 && indexPath.row != 0) || indexPath.section == 2) {
         BD_QuickTestComParamCell *paramCell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestComParamCellID" forIndexPath:indexPath];
        
        paramCell.celltitle.text = cellTitles[indexPath.section][indexPath.row];
        paramCell.cellvalue.text = @[@[_comParam.integervalue,_comParam.integerActionTime],@[_comParam.varlabel,_comParam.startValue,_comParam.endValue,_comParam.stepValue,_comParam.changeTime,_comParam.isAuto?@"是":@"否",_comParam.autoChangeStyle == 0?@"始值-终值":@"始值-终值-始值",_comParam.isCocurrent?@"是":@"否",_comParam.isAgingTest?@"是":@"否",_comParam.delayTime],@[_comParam.rateVoltage,_comParam.rateCurrent,_comParam.rateFrequency]][indexPath.section][indexPath.row];
        //在设置页面数据赋值的时候，单例中的是否直流也赋值 
        if ((indexPath.section == 1 && indexPath.row == 5) || (indexPath.section == 1 &&indexPath.row == 6 ) || (indexPath.section == 1 &&indexPath.row == 7 ) || (indexPath.section == 1 &&indexPath.row == 8 )){
            paramCell.cellBtn.hidden = NO;
            paramCell.cellvalue.clearButtonMode = UITextFieldViewModeNever;
        } else {
            paramCell.cellBtn.hidden = YES;
            paramCell.cellvalue.clearButtonMode = UITextFieldViewModeAlways;
        }
        
        paramCell.ratedVoltageMax = _ratedVoltageMax;
        paramCell.ratedCurrentMax = _ratedCurrentMax;
        //实验开始期间，不可以用户修改
        
        if (_isBegin == 1) {
            if (indexPath.section == 1 && indexPath.row == 3 &&!_comParam.isAuto) {
                [[BD_Utils shared]setViewState:YES view:paramCell.cellvalue];
                [[BD_Utils shared]setViewState:YES view:paramCell.celltitle];
                
            } else {
                [[BD_Utils shared]setViewState:NO view:paramCell.cellvalue];
                [[BD_Utils shared]setViewState:NO view:paramCell.celltitle];
            }
           
        } else {
            [[BD_Utils shared]setViewState:YES view:paramCell.cellvalue];
            [[BD_Utils shared]setViewState:YES view:paramCell.celltitle];
        }
        
        if ((indexPath.section == 1 && indexPath.row == 6) ||(indexPath.section == 1 && indexPath.row == 1) ||(indexPath.section == 1 && indexPath.row == 2) ||(indexPath.section == 1 && indexPath.row == 4)){
            if (_comParam.isAuto == NO) {
                
                [[BD_Utils shared]setViewState:NO view:paramCell.cellvalue];
                [[BD_Utils shared]setViewState:NO view:paramCell.celltitle];
                
            } else {
                if(_isBegin==1){
              
                    [[BD_Utils shared]setViewState:NO view:paramCell.cellvalue];
                    [[BD_Utils shared]setViewState:NO view:paramCell.celltitle];
                } else {
                    
                    [[BD_Utils shared]setViewState:YES view:paramCell.cellvalue];
                    [[BD_Utils shared]setViewState:YES view:paramCell.celltitle];
                }
            }
            
        }
        
        paramCell.cellIndex = indexPath;
        paramCell.isDirectCurr = _comParam.isCocurrent;
        paramCell.exchangeCurrentLimit = exchangeCurrentLimit;
        paramCell.exchangeVoltageLimit = exchangeVoltageLimit;
        paramCell.directCurrentLimit = directCurrentLimit;
        paramCell.directVoltageLimit = directVoltageLimit;
        
        __weak typeof(paramCell) weakcell = paramCell;
        paramCell.textFieldChangedBlock = ^(NSIndexPath *cellpath, NSString *fieldText) {
            if (cellpath.section == 1) {
                switch (cellpath.row) {
                    case 0:
                        
                        break;
                    case 1:
                        weakself.comParam.startValue = fieldText;
                        break;
                    case 2:
                        weakself.comParam.endValue = fieldText;
                        break;
                    case 3:
                        weakself.comParam.stepValue = fieldText;
                        break;
                    case 4:
                        if ([fieldText isEqualToString:@"0.000"]) {
                            weakcell.cellvalue.text = weakself.comParam.changeTime;
                        } else {
                            weakself.comParam.changeTime = fieldText;
                        }
                        
                        break;
                    case 5:
                      
                        break;
                    case 6:
                     
                        break;
                    case 7:
                        
                        break;
                    case 8:
                    
                        break;
                    case 9:
                        weakself.comParam.delayTime = fieldText;
                        break;
                    default:
                        break;
                }
            } else if (cellpath.section == 0){
                switch (cellpath.row) {
                    case 0:
                        weakself.comParam.integervalue = fieldText;
                        break;
                    case 1:
                        weakself.comParam.integerActionTime = fieldText;
                        break;
                    default:
                        break;
                }
            } else if(cellpath.section == 2){
                switch (cellpath.row) {
                    case 0:
                        weakself.comParam.rateVoltage = fieldText;
                        break;
                    case 1:
                        weakself.comParam.rateCurrent = fieldText;
                        break;
                    case 2:
                        weakself.comParam.rateFrequency = fieldText;
                        break;
                    default:
                        break;
                }
                //将额定电压 额定电流 额定频率与数据列表页面关联
                if (self.binaryDelegate && [self.binaryDelegate respondsToSelector:@selector(changeRateVolCurrFre)]) {
//                    [self.binaryDelegate changeRateVolCurrFre];
                }
            }
        };
        
        
        
        paramCell.popViewBlock = ^(NSIndexPath * cellPath,UITextField *cellfield) {
            switch (cellPath.row) {
                case 0:
                    //                    [self changeRowData:@[@"Va",@"Vb",@"Vc",@"Vz",@"Va,Vb",@"Va,Vc",@"Vb,Vc",@"Va,Vb,Vc",@"Ia",@"Ib",@"Ic",@"Ia,Ib",@"Ia,Ic",@"Ib,Ic",@"Ia,Ib,Ic",@"Ia'",@"Ib'",@"Ic'",@"Ia',Ib'",@"Ia',Ic'",@"Ib',Ic'",@"Ia',Ib',Ic'"] textField:cellfield];
//                    weakself.varParamTF = cellfield;
//                    [weakself showPickerView:cellfield];
                    
                    break;
                case 5:
                    
                    [weakself changeRowData:@[@"是",@"否"] textField:cellfield index:5];
                    
                    
                    break;
                case 6:
                    
                   
                     [weakself changeRowData:@[@"始值-终值",@"始值-终值-始值"] textField:cellfield index:6];
                    break;
                case 7:
                    
                    [weakself changeRowData:@[@"是",@"否"] textField:cellfield index:7];
                    
                    break;
                case 8:
                     [weakself changeRowData:@[@"是",@"否"] textField:cellfield index:8];
                    break;
                default:
                    break;
            }
            
        };
        cell = paramCell;
    } else if (indexPath.section == 1 && indexPath.row == 0){
         BD_QuickTestComParamVarCell *varCell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestComParamVarCellID" forIndexPath:indexPath];
        varCell.cellLabel.text = @"变量";
        [varCell.valueBtn2 setTitle:_comParam.varlabel forState:UIControlStateNormal];
        if (_comParam.isAuto == YES && _isBegin) {
            [[BD_Utils shared]setViewState:NO view:varCell.cellLabel];
            [[BD_Utils shared]setViewState:NO view:varCell.valueBtn1];
            [[BD_Utils shared]setViewState:NO view:varCell.valueBtn2];
        } else {
            [[BD_Utils shared]setViewState:YES view:varCell.cellLabel];
            [[BD_Utils shared]setViewState:YES view:varCell.valueBtn1];
            [[BD_Utils shared]setViewState:YES view:varCell.valueBtn2];
        }
        varCell.passagewayGroupBlock = ^(UIButton *groupBtn) {
            [weakself passagewayChange:weakself.passageGroupArr button:groupBtn];
            
        };
        varCell.passagewayVarValueBlock = ^(UIButton *varValue) {
             weakself.varParamBtn = varValue;
            
            [weakself showPickerView:varValue columnData:[self updateVariateArrDataWithG:passagewayGroupIndex]];
        };
  
        cell = varCell;
        
    }else if (indexPath.section ==3 ) {
        BD_QuickTestComParamSwitchSetCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestComParamSwitchSetCellID" forIndexPath:indexPath];
        switchCell.makeInTitle.text = @[@"开入量A",@"开入量B",@"开入量C",@"开入量D",@"开入量E",@"开入量F",@"开入量G",@"开入量H",@"开入量I",@"开入量J",@"开入逻辑"][indexPath.row];
        switchCell.makeOutTitle.text = @[@"开出量1",@"开出量2",@"开出量3",@"开出量4",@"开出量5",@"开出量6",@"开出量7",@"开出量8",@"",@"",@"开出逻辑"][indexPath.row];
        switchCell.cellindex = indexPath;
        if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            switchCell.makeOutTitle.hidden = YES;
            switchCell.lineView.hidden = YES;
        } else {
            switchCell.makeOutTitle.hidden = NO;
            switchCell.lineView.hidden = NO;
        }
        
        if (_isBegin==1) {
            [[BD_Utils shared]setViewState:NO view:switchCell.makeInTitle];
            [[BD_Utils shared]setViewState:NO view:switchCell.makeInSwitch];
            [[BD_Utils shared]setControlState:NO control:switchCell.makeInsegment];
        } else {
            [[BD_Utils shared]setViewState:YES view:switchCell.makeInTitle];
            [[BD_Utils shared]setViewState:YES view:switchCell.makeInSwitch];
            [[BD_Utils shared]setControlState:YES control:switchCell.makeInsegment];
        }
        if (_isBegin == 1 && self.comParam.isAuto) {
            [[BD_Utils shared]setViewState:NO view:switchCell.makeOutTitle];
            [[BD_Utils shared]setViewState:NO view:switchCell.makeOutSwitch];
        } else {
            [[BD_Utils shared]setViewState:YES view:switchCell.makeOutTitle];
            [[BD_Utils shared]setViewState:YES view:switchCell.makeOutSwitch];
        }
        
        long binaryIn = [_comParam.binaryIn intValue];
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
        
        if (indexPath.row<10) {
            if (ch[indexPath.row]==0) {
                [binaryInArr replaceObjectAtIndex:indexPath.row withObject:@(NO)];
            } else {
                [binaryInArr replaceObjectAtIndex:indexPath.row withObject:@(YES)];
            }
        }

        int binaryOut = [_comParam.binaryOut intValue];
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
        
        if (indexPath.row<8) {
            if (ch2[indexPath.row]==0) {
                [binaryOutArr replaceObjectAtIndex:indexPath.row withObject:@(YES)];
            } else {
                [binaryOutArr replaceObjectAtIndex:indexPath.row withObject:@(NO)];
            }
        }
       
        if (indexPath.row<10) {
            [switchCell.makeInSwitch setOn:[binaryInArr[indexPath.row] boolValue]];
        }
 
        if (indexPath.row<8) {
            [switchCell.makeOutSwitch setOn:[binaryOutArr[indexPath.row] boolValue]];
        }
        
        switchCell.makeInsegment.selectedSegmentIndex = _comParam.binaryLogic;
        
        
        switchCell.binaryInChangedBlock = ^(NSNumber *switchState, NSIndexPath *cellIndex) {
            DLog(@"%@ -- %@", switchState, cellIndex);
            [binaryInArr replaceObjectAtIndex:cellIndex.row withObject:switchState];
            int kcl =
            [binaryInArr[0] intValue] *pow(2 ,0) +
            [binaryInArr[1] intValue] *pow(2, 1) +
            [binaryInArr[2] intValue] *pow(2, 2) +
            [binaryInArr[3] intValue] *pow(2, 3) +
            [binaryInArr[4] intValue] *pow(2, 4) +
            [binaryInArr[5] intValue] *pow(2, 5) +
            [binaryInArr[6] intValue] *pow(2, 6) +
            [binaryInArr[7] intValue] *pow(2, 7) +
            [binaryInArr[8] intValue] *pow(2, 8) +
            [binaryInArr[9] intValue] *pow(2, 9);
            weakself.comParam.binaryIn = @(kcl);
            if (self.binaryDelegate && [self.binaryDelegate respondsToSelector:@selector(changeBinaryState:)]) {
                [self.binaryDelegate changeBinaryState:kcl];
            }
        };
        
        switchCell.binaryOutChangedBlock = ^(NSNumber *state, NSIndexPath *index) {
            DLog(@"%@ -- %@", state, index);
            [binaryOutArr replaceObjectAtIndex:index.row withObject:state];
            int kcl_out =
            ![binaryOutArr[0] boolValue] *pow(2 ,0) +
            ![binaryOutArr[1] boolValue] *pow(2, 1) +
            ![binaryOutArr[2] boolValue] *pow(2, 2) +
            ![binaryOutArr[3] boolValue] *pow(2, 3) +
            ![binaryOutArr[4] boolValue] *pow(2, 4) +
            ![binaryOutArr[5] boolValue] *pow(2, 5) +
            ![binaryOutArr[6] boolValue] *pow(2, 6) +
            ![binaryOutArr[7] boolValue] *pow(2, 7);
            weakself.comParam.binaryOut = @(kcl_out);
            if (self.binaryDelegate && [self.binaryDelegate respondsToSelector:@selector(changeBinaryoutStateOntimer:)]) {
                [self.binaryDelegate changeBinaryoutStateOntimer:kcl_out];
            }
        };
        
        
        switchCell.binaryLogicChangedBlock = ^(int segmentIndex) {
            weakself.comParam.binaryLogic = segmentIndex;
        };
        
        
        if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-2||indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-3) {
            switchCell.makeInsegment.hidden = YES;
            switchCell.makeInSwitch.hidden = NO;
            switchCell.makeOutSwitch.hidden = YES;
        }  else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            switchCell.makeInsegment.hidden = NO;
            switchCell.makeInSwitch.hidden = YES;
            switchCell.makeOutSwitch.hidden = YES;
        } else {
            switchCell.makeInsegment.hidden = YES;
            switchCell.makeInSwitch.hidden = NO;
            switchCell.makeOutSwitch.hidden = NO;
        }
        
        cell = switchCell;
    } else if (indexPath.section == 4){
        UITableViewCell *binaryInCell ;
        if (binaryInCell) {
            binaryInCell = [tableView dequeueReusableCellWithIdentifier:@"binaryInCellID" forIndexPath:indexPath];
        } else {
            binaryInCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"binaryInCellID"];
            UIView *bgview = [[UIView alloc]init];
            binaryInCell.backgroundColor = MainBgColor;
            binaryInCell.contentView.backgroundColor = MainBgColor;
            [binaryInCell.contentView addSubview:bgview];
            [bgview setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
            [bgview setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
            [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(5);
                make.bottom.mas_equalTo(-5);
                make.left.mas_equalTo(10);
            }];
            UILabel *label = [[UILabel alloc]init];
            label.text = @"开入量设置";
            [bgview addSubview:label];
            label.textColor = White;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(bgview.centerY);
            }];
            UIButton *action = [[UIButton alloc]init];
            [bgview addSubview: action];
            action.tag = 6;
            [action addTarget:self action:@selector(cellBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [action mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
            }];
        }
        cell = binaryInCell;
        
    }
    /**辅助直流和报告设置*/
//    else if (indexPath.section == 4){
//        BD_DirecCurrentCell *dccell = [tableView dequeueReusableCellWithIdentifier:@"BD_DirecCurrentCellID" forIndexPath:indexPath];
//
//        cell = dccell;
//    } else {
//        UITableViewCell *reportCell ;
//        if (reportCell) {
//            reportCell = [tableView dequeueReusableCellWithIdentifier:@"reportCellID" forIndexPath:indexPath];
//        } else {
//            reportCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reportCellID"];
//            UIView *bgview = [[UIView alloc]init];
//            reportCell.backgroundColor = MainBgColor;
//            reportCell.contentView.backgroundColor = MainBgColor;
//            [reportCell.contentView addSubview:bgview];
//            [bgview setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
//            [bgview setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
//            [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(-10);
//                make.top.mas_equalTo(5);
//                make.bottom.mas_equalTo(-5);
//                make.left.mas_equalTo(10);
//            }];
//            UILabel *label = [[UILabel alloc]init];
//            label.text = @"报告列表";
//            [bgview addSubview:label];
//            label.textColor = White;
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(10);
//                make.centerY.mas_equalTo(bgview.centerY);
//            }];
//            UIButton *action = [[UIButton alloc]init];
//            [bgview addSubview: action];
//            action.tag = 5;
//            [action addTarget:self action:@selector(cellBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [action mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(0);
//                make.right.mas_equalTo(0);
//                make.top.mas_equalTo(0);
//                make.bottom.mas_equalTo(0);
//            }];
//        }
//        cell = reportCell;
//    }
//
    
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0,0, self.tableView.frame.size.width, 40);
    
    UILabel *title  = [[UILabel alloc]init];
    [headerView addSubview:title];
    
    title.textColor = BtnViewBorderColor;
    headerView.backgroundColor = MainBgColor;
    title.text = HeaderViewTitles[section];
//    if (section == 6) {
//
//        [title mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10.0);
//            make.top.mas_equalTo(10);
//        }];
//
//
//        UILabel *binaryL  = [[UILabel alloc]init];
//        [headerView addSubview:binaryL];
//        [binaryL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.bottom.mas_equalTo(-10);
//        }];
//        binaryL.textColor = White;
//        binaryL.text = @"开入量";
//
//
//
//        UILabel *thresholdL  = [[UILabel alloc]init];
//        [headerView addSubview:thresholdL];
//        [thresholdL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-90.0);
//            make.centerY.mas_equalTo(binaryL);
//        }];
//        thresholdL.textColor = White;
//        thresholdL.text = @"翻转门槛";
//
//
//
//
//        UILabel *blankNodeL  = [[UILabel alloc]init];
//        [headerView addSubview:blankNodeL];
//        [blankNodeL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(binaryL.mas_right).mas_offset(30);
//            make.centerY.mas_equalTo(binaryL);
//        }];
//        blankNodeL.textColor = White;
//        blankNodeL.text = @"空节点";
//
//
//    } else {
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0);
            [make centerYWithinMargins];
        }];
        
//    }
    return headerView;
}

-(void)cellBtnAction:(UIButton *)sender{
    
    [self.binaryInVC showBinaryInView];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
   
    int a1 = 40+60*2;
    int b1 = a1+(40+100+60*9);
    int c1 = b1+(40+60*3);
    int d1 = c1+(40+60*9);
    int e1 = d1+(40+100);
    int f1 = e1+(40+60);
//    int g1 = f1+(70+60);
    
    if (!isBtnScroll) {
        if (scrollView.contentOffset.y<a1) {
            [self changeClickBtnState:_paraBtnArr[0]];
        } else if (scrollView.contentOffset.y>=a1 && scrollView.contentOffset.y<b1) {
            [self changeClickBtnState:_paraBtnArr[1]];
        } else if (scrollView.contentOffset.y>=b1 && scrollView.contentOffset.y<c1){
            [self changeClickBtnState:_paraBtnArr[2]];
        } else if (scrollView.contentOffset.y>=c1 && scrollView.contentOffset.y<d1){
            [self changeClickBtnState:_paraBtnArr[3]];
        } else if (scrollView.contentOffset.y>=d1 && scrollView.contentOffset.y<e1){
            [self changeClickBtnState:_paraBtnArr[4]];
        } else if (scrollView.contentOffset.y>=e1 && scrollView.contentOffset.y<f1){
            [self changeClickBtnState:_paraBtnArr[5]];
        }else{
          [self changeClickBtnState:_paraBtnArr[6]];
        }
      
    }
       isBtnScroll = NO;
}
- (void)changeRowData:(NSArray *)arr textField:(UITextField *)tf index:(int)index{
     [self endEditing:YES];
    
    WeakSelf;
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    for (int i = 0; i<arr.count; i++) {
        UIAlertAction *PointAction = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            tf.text = arr[i];
    
            if (index == 5) {
                if (i == 0) {
                    weakself.comParam.isAuto = YES;
                } else {
                    weakself.comParam.isAuto = NO;
                }
                [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                
            } else if (index == 7) {
                if (i == 0) {
                    weakself.comParam.isCocurrent = YES;
                    NSString *rowNum = @"幅值";
                    NSString *columnNum = [self.comParam.varlabel substringToIndex:self.comParam.varlabel.length-3];
                    weakself.selectedStr = [NSString stringWithFormat:@"%@,%@",columnNum,rowNum];
                    [weakself.varParamBtn setTitle:weakself.selectedStr forState:UIControlStateNormal];
                    weakself.comParam.varlabel = weakself.selectedStr;
                   
                } else {
                    weakself.comParam.isCocurrent = NO;
                }
               
                [weakself startEndValueLimit];
                 [weakself.tableView reloadData];
                [kNotificationCenter postNotificationName:BD_IsCocurrentNoti object:@(weakself.comParam.isCocurrent) userInfo:nil];
            } else if (index == 6){
                weakself.comParam.autoChangeStyle = i;
                if (weakself.binaryDelegate && [weakself.binaryDelegate respondsToSelector:@selector(changeResultViewBackViewShow:)]) {
                    [weakself.binaryDelegate changeResultViewBackViewShow:i];
                }
            } else if (index == 8){
                if (i==0) {
                    weakself.comParam.isAgingTest = YES;
                } else {
                    weakself.comParam.isAgingTest = NO;
                }
            }
            
        }];
        [PointAction setValue:Black forKey:@"_titleTextColor"];
        [alertController addAction:PointAction];
    }
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    
    
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    alertController.preferredContentSize = CGSizeMake(tf.bounds.size.width, 240);
    
    UIPopoverPresentationController *popPresenter = alertController.popoverPresentationController;
    popPresenter.sourceView = tf;
    popPresenter.sourceRect = tf.bounds;
    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
    
    [[self GetSubordinateControllerForSelf] presentViewController:alertController animated:NO completion:nil];
}

-(void)startEndValueLimit{
    if (! self.comParam.isCocurrent) {
        //交流
        if ([self.comParam.varlabel hasPrefix:@"U"]) {
            if ( self.comParam.startValue.floatValue>[exchangeVoltageLimit floatValue]) {
                self.comParam.startValue = exchangeVoltageLimit;
              
            } else if ( self.comParam.startValue.floatValue<0){
                self.comParam.startValue = @"0.000";
                
            }
            if ( self.comParam.endValue.floatValue>[exchangeVoltageLimit floatValue]) {
                self.comParam.endValue = exchangeVoltageLimit;
                
            } else if ( self.comParam.endValue.floatValue<0){
                self.comParam.endValue = @"0.000";
                
            }
            
        } else if([self.comParam.varlabel hasPrefix:@"I"]){
            if ( self.comParam.startValue.floatValue>[exchangeCurrentLimit floatValue]) {
                self.comParam.startValue = exchangeCurrentLimit;
               
            } else if (self.comParam.startValue.floatValue<0){
                self.comParam.startValue = @"0.000";
               
            }
            
            if ( self.comParam.endValue.floatValue>[exchangeCurrentLimit floatValue]) {
                self.comParam.endValue = exchangeCurrentLimit;
                
            } else if (self.comParam.endValue.floatValue<0){
                self.comParam.endValue = @"0.000";
                
            }
            
        }
    } else {
        //直流
        if ([self.comParam.varlabel hasPrefix:@"U"]) {
            if ( self.comParam.startValue.floatValue>[directVoltageLimit floatValue]) {
                self.comParam.startValue = directVoltageLimit;
            
            } else if (self.comParam.startValue.floatValue<-[directVoltageLimit floatValue]){
                self.comParam.startValue = kTStrings(-[directVoltageLimit floatValue]);
              
            }
            if ( self.comParam.endValue.floatValue>[directVoltageLimit floatValue]) {
                self.comParam.endValue = directVoltageLimit;
                
            } else if (self.comParam.endValue.floatValue<-[directVoltageLimit floatValue]){
                self.comParam.endValue = kTStrings(-[directVoltageLimit floatValue]);
                
            }
            
        } else if([self.comParam.varlabel hasPrefix:@"I"]){
            if ( self.comParam.startValue.floatValue>[directCurrentLimit floatValue]) {
                self.comParam.startValue = directCurrentLimit;
                
            } else if ( self.comParam.startValue.floatValue<-[directCurrentLimit floatValue]){
                self.comParam.startValue = kTStrings(-[directCurrentLimit floatValue]);
            }
            if ( self.comParam.endValue.floatValue>[directCurrentLimit floatValue]) {
                self.comParam.endValue = directCurrentLimit;
                
            } else if ( self.comParam.endValue.floatValue<-[directCurrentLimit floatValue]){
                self.comParam.endValue = kTStrings(-[directCurrentLimit floatValue]);
            }
        }
    }
}

- (void)passagewayChange:(NSArray *)arr button:(UIButton *)btn{
    [self endEditing:YES];
    WeakSelf;
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i<arr.count; i++) {
        UIAlertAction *PointAction = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            passagewayGroupIndex = i;
            weakself.pickerModel.group = passagewayGroupIndex;
         
            NSArray<NSString *> *comluArr = [[weakself.comParam.varlabel substringToIndex:weakself.comParam.varlabel.length-3] separatedWithString:@","];
            NSString *sufPrefix = [NSString stringWithFormat:@"%d",passagewayGroupIndex+1];
            NSString *column0Value = @"";
            for (NSString *str in comluArr) {
              
                column0Value = [NSString stringWithFormat:@"%@%@%@,",column0Value,[str substringToIndex:2],sufPrefix];
            }
            weakself.comParam.varlabel = [column0Value stringByAppendingFormat:@"%@", [weakself.comParam.varlabel substringFromIndex:weakself.comParam.varlabel.length-2]];
            [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [PointAction setValue:Black forKey:@"_titleTextColor"];
        [alertController addAction:PointAction];
    }
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    
    
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    alertController.preferredContentSize = CGSizeMake(btn.bounds.size.width, 240);
    
    UIPopoverPresentationController *popPresenter = alertController.popoverPresentationController;
    popPresenter.sourceView = btn;
    popPresenter.sourceRect = btn.bounds;
    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
    
    [[self GetSubordinateControllerForSelf] presentViewController:alertController animated:NO completion:nil];
}



#pragma mark - 创建pikcerView
- (void)setUpPickerView:(NSArray *)columnData{
   _pickerVC = [[UIViewController alloc]init];
    //创建picker
    _columnData = columnData;
    NSString *column1Value = [self.comParam.varlabel substringFromIndex:self.comParam.varlabel.length-2];
    NSString *coluStr = [self.comParam.varlabel substringToIndex:self.comParam.varlabel.length-3];
    NSArray<NSString *> *comluArr = [coluStr separatedWithString:@","];
    NSString *sufPrefix = @"";
    if (columnData.count!=0) {
        if ([[BD_Utils shared] validateNumber:[((NSString *)columnData[0]) substringFromIndex:((NSString *)columnData[0]).length-1]]) {
            sufPrefix = [((NSString *)columnData[0]) substringFromIndex:((NSString *)columnData[0]).length-1];
        }
        
    }
    NSString *column0Value = @"";
    for (NSString *str in comluArr) {
        if (![str isEqualToString:comluArr.lastObject]) {
            column0Value = [NSString stringWithFormat:@"%@%@%@,",column0Value,[str substringToIndex:2],sufPrefix];
        } else {
            column0Value = [NSString stringWithFormat:@"%@%@%@",column0Value,[str substringToIndex:2],sufPrefix];
        }
    }
    
    _rowData = @[@"幅值",@"相位",@"频率"];
    NSInteger index0 = [_columnData indexOfObject:column0Value];
    NSInteger index1 = [_rowData indexOfObject:column1Value];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    picker.delegate = self;
    picker.dataSource = self;
    _picker = picker;
    if (!self.comParam.isCocurrent) {
        [_picker selectRow:index1 inComponent:1 animated:YES];
    } else {
        [_picker selectRow:0 inComponent:1 animated:YES];
    }
    if (index0>1000) {
        index0 = 0;
    }
    [_picker selectRow:index0 inComponent:0 animated:YES];
    
    [_pickerVC.view addSubview:_picker];

    
    [_picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(_pickerVC.view);
    }];
  
    
}
#pragma mark - 显示picker 设置变量类型
-(void)showPickerView:(UIView *)tf columnData:(NSArray *)columnData{
    [self endEditing:YES];
    [self setUpPickerView:columnData];
    _pickerVC.modalPresentationStyle = UIModalPresentationPopover;
    _pickerVC.preferredContentSize = CGSizeMake(300, 240);
    UIPopoverPresentationController *popPresenter = _pickerVC.popoverPresentationController;
    popPresenter.sourceView = tf;
    popPresenter.sourceRect = tf.bounds;
    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
    [[self GetSubordinateControllerForSelf] presentViewController:_pickerVC animated:NO completion:nil];
}

#pragma mark - pickerView代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rowNum = 0;
    switch (component) {
        case 0:
            rowNum = _columnData.count;
            break;
        case 1:
            rowNum = _rowData.count;
            break;
        default:
            break;
    }
    return rowNum;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowTitle;
    switch (component) {
        case 0:
            rowTitle = _columnData[row];
            break;
        case 1:
            rowTitle = _rowData[row];
            break;
            
        default:
            break;
    }
    return rowTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"row:%ld,component:%ld",(long)row,(long)component);
    
    
    //创建静态变量，进行数据暂时存储
     NSString *columnNum = _columnData[0];
     NSString *rowNum = _rowData[0];
    
    if (component == 0) {
        columnNum = _columnData[row];
        //计算行值
        [self calculateRowNumWithRow:row];
        
    }else{
        if (!self.comParam.isCocurrent) {
            rowNum = _rowData[row];
            [self calculateColumnNumWithRow:row];
        } else {
            [pickerView selectRow:0 inComponent:1 animated:YES];
            rowNum = _rowData[0];
            [self calculateColumnNumWithRow:0];
        }
        
        
    }
    
    _selectedStr = [NSString stringWithFormat:@"%@,%@",columnNum,rowNum];
    [_varParamBtn setTitle:_selectedStr forState:UIControlStateNormal];
    _comParam.varlabel = _selectedStr;
    if ([[_selectedStr substringToIndex:1] isEqualToString:@"U"]) {
        
       
        if ([rowNum isEqualToString:@"幅值"]) {
            cellTitles[1][1] = @"始值(V)";
            cellTitles[1][2] = @"终值(V)";
            cellTitles[1][3] = @"变化步长(V)";
            if (!_comParam.isCocurrent) {
                //交流
              self.comParam.startValue =  [self judgeMax_0Limit:self.comParam.startValue limitValue:exchangeVoltageLimit];
               self.comParam.endValue = [self judgeMax_0Limit:self.comParam.endValue limitValue:exchangeVoltageLimit];
              self.comParam.stepValue =  [self judgeMax_0Limit:self.comParam.stepValue limitValue:exchangeVoltageLimit];
                
            } else {
               self.comParam.startValue = [self judgeMax_NegtiveMaxLimit:self.comParam.startValue limitValue:directVoltageLimit];
               self.comParam.endValue = [self judgeMax_NegtiveMaxLimit:self.comParam.endValue limitValue:directVoltageLimit];
               self.comParam.stepValue = [self judgeMax_0Limit:self.comParam.stepValue limitValue:directVoltageLimit];
            }
           
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }
    } else if ([[_selectedStr substringToIndex:1] isEqualToString:@"I"]){
        if ([rowNum isEqualToString:@"幅值"]) {
            cellTitles[1][1] = @"始值(A)";
            cellTitles[1][2] = @"终值(A)";
            cellTitles[1][3] = @"变化步长(A)";
            if (!_comParam.isCocurrent) {
                //交流
               self.comParam.startValue = [self judgeMax_0Limit:self.comParam.startValue limitValue:exchangeCurrentLimit];
               self.comParam.endValue = [self judgeMax_0Limit:self.comParam.endValue limitValue:exchangeCurrentLimit];
               self.comParam.stepValue = [self judgeMax_0Limit:self.comParam.stepValue limitValue:exchangeCurrentLimit];
                
            } else {
              self.comParam.startValue = [self judgeMax_NegtiveMaxLimit:self.comParam.startValue limitValue:directCurrentLimit];
              self.comParam.endValue = [self judgeMax_NegtiveMaxLimit:self.comParam.endValue limitValue:directCurrentLimit];
             self.comParam.stepValue = [self judgeMax_0Limit:self.comParam.stepValue limitValue:directCurrentLimit];
            }
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
    if ([rowNum isEqualToString:@"相位"]) {
        cellTitles[1][1] = @"始值(°)";
        cellTitles[1][2] = @"终值(°)";
        cellTitles[1][3] = @"变化步长(°)";
        
     self.comParam.startValue = [self judgeMax_NegtiveMaxLimit:self.comParam.startValue limitValue:kTStrings(180.000)];
     self.comParam.endValue =  [self judgeMax_NegtiveMaxLimit:self.comParam.endValue limitValue:kTStrings(180.000)];
    self.comParam.stepValue =  [self judgeMax_0Limit:self.comParam.stepValue limitValue:kTStrings(180.000)];
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if ([rowNum isEqualToString:@"频率"]) {
        cellTitles[1][1] = @"始值(Hz)";
        cellTitles[1][2] = @"终值(Hz)";
        cellTitles[1][3] = @"变化步长(Hz)";
       self.comParam.startValue = [self judgeMax_1Limit:self.comParam.startValue limitValue:kTStrings(3000.000)];
       self.comParam.endValue =[self judgeMax_1Limit:self.comParam.endValue limitValue:kTStrings(3000.000)];
       self.comParam.stepValue =[self judgeMax_0Limit:self.comParam.stepValue limitValue:kTStrings(3000.000)];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}
//判断最大值 和最小值0
-(NSString *)judgeMax_0Limit:(NSString *)value limitValue:(NSString *)limitValue {
    NSString *newValue = value;
    if (newValue.floatValue>limitValue.floatValue) {
        newValue = limitValue;
    } else if (value.floatValue<0){
       newValue = kTStrings(0.000);
    }
    return newValue;
}
//判断最大值和最小值=-最大值
-(NSString *)judgeMax_NegtiveMaxLimit:(NSString *)value limitValue:(NSString *)limitValue {
    NSString *newValue = value;
    if (newValue.floatValue>limitValue.floatValue) {
        newValue = limitValue;
    } else if (value.floatValue<-limitValue.floatValue){
        newValue = [@"-" stringByAppendingString:limitValue];
    }
      return newValue;
}
//判断最大值 和最小值1-- 频率
-(NSString *)judgeMax_1Limit:(NSString *)value limitValue:(NSString *)limitValue {
    NSString *newValue = value;
    if (newValue.floatValue>limitValue.floatValue) {
        newValue = limitValue;
    } else if (value.floatValue<=0){
        newValue = kTStrings(1.000);
    }
      return newValue;
}


#pragma mark - 懒加载
- (NSMutableArray *)rowArr{
    if (!_rowArr) {
        _rowArr = [NSMutableArray array];
    }
    return _rowArr;
}

-(NSMutableArray *)columnArr{
    if (!_columnArr) {
        _columnArr = [NSMutableArray array];
    }
    return _columnArr;
}

-(BD_QuickTestComSetModel *)comParam{
    if (!_comParam) {
        _comParam = [[BD_QuickTestComSetModel alloc]init];
 
    }
    return _comParam;
}
-(BD_PassagewayNumModel *)passagewayNum{
    if (!_passagewayNum) {
        _passagewayNum = [[BD_PassagewayNumModel alloc]initWithNum:6 currentPassageNum:6];
    }
    return _passagewayNum;
}

-(NSMutableArray *)paraBtnArr{
    if (!_paraBtnArr) {
        _paraBtnArr = [[NSMutableArray alloc]init];
    }
    return _paraBtnArr;
}

-(BD_BinaryInSetVC *)binaryInVC{
    if (!_binaryInVC) {
        _binaryInVC = [[BD_BinaryInSetVC alloc]init];
    }
    return _binaryInVC;
}
- (void)calculateColumnNumWithRow:(NSInteger)row{
 
    switch (row) {
        case 0:
            self.pickerModel.column = 1;
            break;
        case 1:
            self.pickerModel.column = 2;
            break;
        case 2:
            self.pickerModel.column = 3;
            break;
        default:
            break;
    }
    _comParam.ParaType = (int)row;
    
}
- (void)calculateRowNumWithRow:(NSInteger)row{
    
    [self.rowArr removeAllObjects];
    if(_passagewayNum.voltagePassageNum == 4){
        switch (row) {
            case 0:
                [self.rowArr addObject:@10];
                break;
            case 1:
                [self.rowArr addObject:@11];
                break;
            case 2:
                [self.rowArr addObject:@12];
                break;
            case 3:
                [self.rowArr addObject:@13];
                break;
            case 4:
                [self.rowArr addObjectsFromArray:@[@10,@11]];
                break;
            case 5:
                [self.rowArr addObjectsFromArray:@[@10,@12]];
                break;
            case 6:
                [self.rowArr addObjectsFromArray:@[@11,@12]];
                break;
            case 7:
                [self.rowArr addObjectsFromArray:@[@10,@11,@12]];
                break;
            case 8:
                [self.rowArr addObjectsFromArray:@[@10,@11,@12,@13]];//Ua
                break;
            case 9:
                [self.rowArr addObject:@10];
                break;
            case 10:
                [self.rowArr addObject:@11];
                break;
            case 11:
                [self.rowArr addObject:@12];
                break;
            case 12:
                [self.rowArr addObjectsFromArray:@[@10,@11]];
                break;
            case 13:
                [self.rowArr addObjectsFromArray:@[@10,@12]];
                break;
            case 14:
                [self.rowArr addObjectsFromArray:@[@11,@12]];
                break;
            case 15:
                [self.rowArr addObjectsFromArray:@[@10,@11,@12]];//Ia
                break;
            
            default:
                break;
        }
        if (row<=8) {
            _pickerModel.title = @"Ua";
            //选择电压
        } else if (row>6 && row <14){
            _pickerModel.title = @"Ia";
            //选择电流
        }
        _pickerModel.row = self.rowArr;
    } else {
        switch (row) {
            case 0:
                [self.rowArr addObject:@10];
                break;
            case 1:
                [self.rowArr addObject:@11];
                break;
            case 2:
                [self.rowArr addObject:@12];
                break;
            case 3:
                [self.rowArr addObjectsFromArray:@[@10,@11]];
                break;
            case 4:
                [self.rowArr addObjectsFromArray:@[@10,@12]];
                break;
            case 5:
                [self.rowArr addObjectsFromArray:@[@11,@12]];
                break;
            case 6:
                [self.rowArr addObjectsFromArray:@[@10,@11,@12]];//Ua
                break;
            case 7:
                [self.rowArr addObject:@10];
                break;
            case 8:
                [self.rowArr addObject:@11];
                break;
            case 9:
                [self.rowArr addObject:@12];
                break;
            case 10:
                [self.rowArr addObjectsFromArray:@[@10,@11]];
                break;
            case 11:
                [self.rowArr addObjectsFromArray:@[@10,@12]];
                break;
            case 12:
                [self.rowArr addObjectsFromArray:@[@11,@12]];
                break;
            case 13:
                [self.rowArr addObjectsFromArray:@[@10,@11,@12]];//Ia
                break;
            default:
                break;
        }
        if (row<=6) {
            _pickerModel.title = @"Ua";
        } else if (row>6 && row <14){
            _pickerModel.title = @"Ia";
        }
        _pickerModel.row = self.rowArr;
    }
    
    
    
    
    //    NSLog(@"_rowArr-->:%@",_rowArr);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"voltagePassageNum"] || [keyPath isEqualToString:@"currentPassageNum"]) {
        [self.passageGroupArr removeAllObjects];
        if (self.passagewayNum.voltagePassageNum>self.passagewayNum.currentPassageNum) {
            for (int i = 1; i<= self.passagewayNum.voltagePassageNum/3; i++) {
                [self.passageGroupArr addObject:[NSString stringWithFormat:@"G%d",i]];
            }
        } else {
            for (int i = 1; i<= self.passagewayNum.currentPassageNum/3; i++) {
                [self.passageGroupArr addObject:[NSString stringWithFormat:@"G%d",i]];
            }
        }
        
    }
   
}


//根据硬件配置页面的通道个数设置，修改参数设置页变量的选择
-(NSMutableArray <NSString *>*)updateVariateArrDataWithG:(int)group{
    if (group != 0) {
        for (int i = 0; i<VariateNameArray_V.count; i++) {
            if (self.passagewayNum.voltagePassageNum/3 == 1) {
                
                if (self.passagewayNum.voltagePassageNum == 4) {
                    return  [[NSMutableArray alloc]initWithObjects:@"Ua",@"Ub",@"Uc",@"Uz",@"Ua,Ub",@"Ua,Uc",@"Ub,Uc",@"Ua,Ub,Uc",@"Ua,Ub,Uc,Uz",[NSString stringWithFormat:@"Ia%d",group+1],[NSString stringWithFormat:@"Ib%d",group+1],[NSString stringWithFormat:@"Ic%d",group+1],[NSString stringWithFormat:@"Ia%d,Ib%d",group+1,group+1],[NSString stringWithFormat:@"Ia%d,Ic%d",group+1,group+1],[NSString stringWithFormat:@"Ib%d,Ic%d",group+1,group+1],[NSString stringWithFormat:@"Ia%d,Ib%d,Ic%d",group+1,group+1,group+1], nil];
                } else {
                    [_variateNameArr replaceObjectAtIndex:i withObject:VariateNameArray_V[i]];
                }
            } else {
                
                [_variateNameArr replaceObjectAtIndex:i withObject:[self stringchangeIn:VariateNameArray_V[i] By:[NSString stringWithFormat:@"%d",[self optionChangeNamedindexWithNum:self.passagewayNum.voltagePassageNum group:group]]]];
                
            }
        }
        for (NSInteger n = VariateNameArray_V.count; n<_variateNameArr.count; n++) {
            if (self.passagewayNum.currentPassageNum/3 == 1) {
                [_variateNameArr replaceObjectAtIndex:n withObject:VariateNameArray_C[n-VariateNameArray_V.count]];
            } else {
                [_variateNameArr replaceObjectAtIndex:n withObject:[self stringchangeIn:VariateNameArray_C[n-VariateNameArray_V.count] By:[NSString stringWithFormat:@"%d",[self optionChangeNamedindexWithNum:self.passagewayNum.currentPassageNum group:group]]]];
            }
            
        }
    } else {
        
        for (int i = 0; i<VariateNameArray_V.count; i++) {
            if (self.passagewayNum.voltagePassageNum == 4) {
                
                if (self.passagewayNum.currentPassageNum == 3) {
                    return  [[NSMutableArray alloc]initWithObjects:@"Ua",@"Ub",@"Uc",@"Uz",@"Ua,Ub",@"Ua,Uc",@"Ub,Uc",@"Ua,Ub,Uc",@"Ua,Ub,Uc,Uz",@"Ia",@"Ib",@"Ic",@"Ia,Ib",@"Ia,Ic",@"Ib,Ic",@"Ia,Ib,Ic", nil];
                } else {
                    return  [[NSMutableArray alloc]initWithObjects:@"Ua",@"Ub",@"Uc",@"Uz",@"Ua,Ub",@"Ua,Uc",@"Ub,Uc",@"Ua,Ub,Uc",@"Ua,Ub,Uc,Uz",[NSString stringWithFormat:@"Ia%d",group+1],[NSString stringWithFormat:@"Ib%d",group+1],[NSString stringWithFormat:@"Ic%d",group+1],[NSString stringWithFormat:@"Ia%d,Ib%d",group+1,group+1],[NSString stringWithFormat:@"Ia%d,Ic%d",group+1,group+1],[NSString stringWithFormat:@"Ib%d,Ic%d",group+1,group+1],[NSString stringWithFormat:@"Ia%d,Ib%d,Ic%d",group+1,group+1,group+1], nil];
                }
            } else {
                if (self.passagewayNum.voltagePassageNum == 3) {
                    [_variateNameArr replaceObjectAtIndex:i withObject:VariateNameArray_V[i]];
                } else{
                    
                     [_variateNameArr replaceObjectAtIndex:i withObject:[self stringchangeIn:VariateNameArray_V[i] By:[NSString stringWithFormat:@"%d",[self optionChangeNamedindexWithNum:self.passagewayNum.voltagePassageNum group:group]]]];
                }
                
            }
            
        }
        for (NSInteger n = VariateNameArray_V.count; n<_variateNameArr.count; n++) {
            if (self.passagewayNum.currentPassageNum == 3) {
                [_variateNameArr replaceObjectAtIndex:n withObject:VariateNameArray_C[n-VariateNameArray_V.count]];
            } else {
                 [_variateNameArr replaceObjectAtIndex:n withObject:[self stringchangeIn:VariateNameArray_C[n-VariateNameArray_V.count] By:[NSString stringWithFormat:@"%d",[self optionChangeNamedindexWithNum:self.passagewayNum.currentPassageNum group:group]]]];
            }
            
        }
    }
    return _variateNameArr;
}

//传入字符串，添加编号
-(NSString *)stringchangeIn:(NSString *)supStr By:(NSString *)str{
    NSArray *strarr = [supStr componentsSeparatedByString:@","];
    NSString *result = @"";
    for (int i = 0 ; i<strarr.count;i++) {
       result = [result stringByAppendingString:[strarr[i] stringByAppendingString:str]];
        if (i!=strarr.count-1) {
           result = [result stringByAppendingString:@","];
        }
    }
    return result;
}
//判断 如果选择分组大于通道个数／3,最后一个命名号为通道个数／3
-(int)optionChangeNamedindexWithNum:(int)passagewayNum group:(int)group{
        if (passagewayNum/3<group+1) {
            return passagewayNum/3;
        } else {
            return group+1;
        }
}
//排列组合算法
-(void)subsetsHelper:(NSMutableArray<NSMutableArray *> *)result
                 list:(NSMutableArray *)list
                 nums:(NSArray *)nums
              postion:(int)pos {
    [result addObject:[list mutableCopy]];
    for (int i = pos; i < nums.count; i++) {
        [list addObject:nums[i]];
        [self subsetsHelper:result list:list nums:nums postion:i + 1];
        [list removeObjectAtIndex:list.count - 1];
    }
}


-(void)changeOutputLimitValue:(NSNotification *)noti{
    BD_HardwarkConfigModel *hardworakModel = (BD_HardwarkConfigModel *)noti.object;
    exchangeVoltageLimit = hardworakModel.exchangeVoltage;
    exchangeCurrentLimit = hardworakModel.exchangeCurrent;
    directCurrentLimit = hardworakModel.directCurrent;
    directVoltageLimit = hardworakModel.directVoltage;
    [self.tableView reloadData];
}


-(void)dealloc{
    
    //添加监听后，必须移除
    [kNotificationCenter removeObserver:self name:BD_OutPutLimitNotifi object:nil];
    [self removeObserver:self forKeyPath:@"voltagePassageNum"];
    [self removeObserver:self forKeyPath:@"currentPassageNum"];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
