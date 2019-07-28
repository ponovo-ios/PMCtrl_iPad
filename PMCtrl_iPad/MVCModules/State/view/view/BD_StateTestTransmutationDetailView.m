//
//  BD_StateTestTransmutationDetailView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/7.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestTransmutationDetailView.h"
#import "BD_QuickTestComParamCell.h"
#import "BD_PopListViewManager.h"
#define CellDataArr [[NSArray alloc]initWithObjects:@"变量",@"df/dt(Hz/s)",@"dv/dt(V/s)",@"起始频率(Hz)",@"终止频率(Hz)",@"起始电压(V)",@"终止电压(V)",@"变化步长(V)",@"变化时间(s)",@"变化始值(V)",@"变化终值(V)", nil]
@interface BD_StateTestTransmutationDetailView()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *exchangeVoltageLimit;
    NSString *exchangeCurrentLimit;
    NSString *directVoltageLimit;
    NSString *directCurrentLimit;
}
@property(nonatomic,weak)UIView *mainView;
@property(nonatomic,strong)BD_StateTestTransmutationDetailModel *transmuData;
@end
@implementation BD_StateTestTransmutationDetailView

-(instancetype)init{
    if (self=[super init]) {
        [self confitViews];
        _gradientType = BDGradientType_null;
   
//        [self addObserver:self forKeyPath:@"transmutationDataModel" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


-(void)confitViews{
    self.backgroundColor = [Black colorWithAlphaComponent:0.5];
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(self.width-50,10, 35.0, 35.0);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectZero];
    mainView.backgroundColor = BDThemeColor;
    mainView.center = self.center;
    _mainView = mainView;
    [self addSubview:mainView];
    
    
  
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:okBtn];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    cancelBtn.tag = 102;
    [cancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
  
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView setCorenerRadius:6 borderColor:ClearColor borderWidth:0];
    [mainView addSubview:_tableView];
    _tableView.frame = CGRectZero;
    _tableView.backgroundColor = BDThemeColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_QuickTestComParamCell class]) bundle:nil] forCellReuseIdentifier:@"BD_QuickTestComParamCellID"];
    
      [kNotificationCenter addObserver:self selector:@selector(changeDCurrState:) name:BD_IsCocurrentNoti object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(changeOutputLimitValue:) name:BD_OutPutLimitNotifi object:nil];
    
    //设置直流电压 交流电压 直流电流 交流电流
    exchangeVoltageLimit = @"120.000";
    exchangeCurrentLimit = @"20.000";
    directVoltageLimit = @"169.706";
    directCurrentLimit = @"10.000";
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return CellDataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_QuickTestComParamCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestComParamCellID" forIndexPath:indexPath];
   
    cell.celltitle.text = CellDataArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.cellBtn.hidden = NO;
        
    } else {
        cell.cellBtn.hidden = YES;
    }
    cell.cellIndex = indexPath;
    cell.isDirectCurr = _isDirectCurr;
    cell.exchangeCurrentLimit = exchangeCurrentLimit;
    cell.exchangeVoltageLimit = exchangeVoltageLimit;
    cell.directCurrentLimit = directCurrentLimit;
    cell.directVoltageLimit = directVoltageLimit;
    
    [self setParaViewsEnabled:_gradientType cell:cell cellindex:indexPath.row];//根据递变类型，设置参数是否可用
    if (self.transmutationDataModel) {
    
        cell.cellvalue.text = @[_transmutationDataModel.paramType,[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.dfdtValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.dvdtValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.startHzValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.endHzValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.startVValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.endVValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.changeStepValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.stepTimeValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.changeStartValue floatValue]],[NSString stringWithFormat:@"%.3f",[_transmutationDataModel.changeEndValue floatValue]]][indexPath.row];
    }
    
    __weak typeof(cell) weakcell = cell;
    __weak typeof(tableView) weakTB = tableView;
    WeakSelf;
    cell.popViewBlock = ^(NSIndexPath *cellindexpath, UITextField *tf) {
        [BD_PopListViewManager ShowPopViewWithlistDataSource:self.paraTypeArr textField:tf viewController:[self GetSubordinateControllerForSelf] direction:UIPopoverArrowDirectionUp complete:^(NSString *selecteStr) {
            _transmutationDataModel.paramType = selecteStr;
            tf.text = selecteStr;
                [weakTB reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                 [weakTB reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:9 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                 [weakTB reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

        }];
    };
    if (indexPath.row==7|| indexPath.row ==9||indexPath.row ==10) {
        if ([_transmutationDataModel.paramType containsString:@"I"]) {
            cell.celltitle.text = @[@"变量",@"df/dt(Hz/s)",@"dv/dt(V/s)",@"起始频率(Hz)",@"终止频率(Hz)",@"起始电压(V)",@"终止电压(V)",@"变化步长(A)",@"变化时间(s)",@"变化始值(A)",@"变化终值(A)"][indexPath.row];
            if (!self.isDirectCurr) {
                if ([self.transmutationDataModel.changeStartValue floatValue]>[exchangeCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStartValue = @([exchangeCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeEndValue floatValue]>[exchangeCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeEndValue = @([exchangeCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeStepValue floatValue]>[exchangeCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStepValue = @([exchangeCurrentLimit floatValue]);
                }
            } else {
                if ([self.transmutationDataModel.changeStartValue floatValue]>[directCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStartValue = @([directCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeEndValue floatValue]>[directCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeEndValue = @([directCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeStepValue floatValue]>[directCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStepValue = @([directCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeStartValue floatValue]<-[directCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStartValue = @(-[directCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeEndValue floatValue]<-[directCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeEndValue = @(-[directCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeStepValue floatValue]<-[directCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStepValue = @(-[directCurrentLimit floatValue]);
                }
                
                
            }
            
        } else {
            cell.celltitle.text = CellDataArr[indexPath.row];
        }
        switch (indexPath.row) {
            case 7:
                cell.cellvalue.text = [NSString stringWithFormat:@"%.3f",[_transmutationDataModel.changeStepValue floatValue]];
                break;
            case 9:
                cell.cellvalue.text = [NSString stringWithFormat:@"%.3f",[_transmutationDataModel.changeStartValue floatValue]];
                break;
            case 10:
                cell.cellvalue.text = [NSString stringWithFormat:@"%.3f",[_transmutationDataModel.changeEndValue floatValue]];
                break;
            default:
                break;
        }
    }
    cell.textFieldChangedBlock = ^(NSIndexPath *cellindexpath, NSString *TFtext) {
        switch (cellindexpath.row) {
            case 1:
                _transmutationDataModel.dfdtValue = @([TFtext floatValue]);
                break;
            case 2:
                _transmutationDataModel.dvdtValue = @([TFtext floatValue]);
                break;
            case 3:
                _transmutationDataModel.startHzValue = @([TFtext floatValue]);
                break;
            case 4:
                _transmutationDataModel.endHzValue = @([TFtext floatValue]);
                break;
            case 5:
                _transmutationDataModel.startVValue = @([TFtext floatValue]);
                break;
            case 6:
                _transmutationDataModel.endVValue = @([TFtext floatValue]);
                break;
            case 7:
                _transmutationDataModel.changeStepValue = @([TFtext floatValue]);
                break;
            case 8:
                _transmutationDataModel.stepTimeValue = @([TFtext floatValue]);
                break;
            case 9:
                _transmutationDataModel.changeStartValue = @([TFtext floatValue]);
                break;
            case 10:
                _transmutationDataModel.changeEndValue = @([TFtext floatValue]);
                break;
           
                break;
            default:
                break;
        }
    };
    cell.backgroundColor = ClearColor;
    cell.contentView.layer.borderColor = ClearColor.CGColor;
    
    return cell;
}

//根据递变类型不同，设置参数设置是否可用
-(void)setParaViewsEnabled:(BDGradientType)gradientType cell:(BD_QuickTestComParamCell  *)cell cellindex:(NSInteger)cellindex{
    if (gradientType == BDGradientType_comGradient) {
        if ((cellindex >= 7 && cellindex<=10)||cellindex == 0) {
            cell.userInteractionEnabled = YES;
            cell.celltitle.textColor = White;
            cell.cellvalue.layer.borderColor = White.CGColor;
            cell.cellvalue.textColor = White;
        } else {
            cell.userInteractionEnabled = NO;
            cell.celltitle.textColor = [UIColor lightGrayColor];
            cell.cellvalue.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.cellvalue.textColor = [UIColor lightGrayColor];
        }
    } else if (gradientType == BDGradientType_dfdt){
        if (cellindex == 0 || cellindex == 1 || cellindex == 3 || cellindex == 4) {
            cell.userInteractionEnabled = YES;
            cell.celltitle.textColor = White;
            cell.cellvalue.layer.borderColor = White.CGColor;
            cell.cellvalue.textColor = White;
        } else {
            cell.userInteractionEnabled = NO;
            cell.celltitle.textColor = [UIColor lightGrayColor];
            cell.cellvalue.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.cellvalue.textColor = [UIColor lightGrayColor];
        }
    } else if (gradientType == BDGradientType_dvdt){
        if (cellindex == 0 || cellindex == 2 || cellindex == 5 || cellindex == 6) {
            cell.userInteractionEnabled = YES;
            cell.celltitle.textColor = White;
            cell.cellvalue.layer.borderColor = White.CGColor;
            cell.cellvalue.textColor = White;
        } else {
            cell.userInteractionEnabled = NO;
            cell.celltitle.textColor = [UIColor lightGrayColor];
            cell.cellvalue.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.cellvalue.textColor = [UIColor lightGrayColor];
        }
    } else if (gradientType == BDGradientType_dfdvdt){
        if (cellindex <=6) {
            cell.userInteractionEnabled = YES;
            cell.celltitle.textColor = White;
            cell.cellvalue.layer.borderColor = White.CGColor;
            cell.cellvalue.textColor = White;
        } else {
            cell.userInteractionEnabled = NO;
            cell.celltitle.textColor = [UIColor lightGrayColor];
            cell.cellvalue.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.cellvalue.textColor = [UIColor lightGrayColor];
        }
    } else {
        cell.userInteractionEnabled = YES;
        cell.celltitle.textColor = White;
        cell.cellvalue.layer.borderColor = White.CGColor;
        cell.cellvalue.textColor = White;
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
//    [UIView animateWithDuration:0.3 animations:^{
//        _tableView.frame = CGRectZero;
//        _tableView.center = self.center;
//        self.trandmutationEndEditBlock();
//        [self setNeedsLayout];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

-(void)showView{
    WeakSelf;
    
    _transmuData = [_transmutationDataModel copy];
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self];
//    [UIView animateWithDuration:0.3 animations:^{
    
        weakself.mainView.frame = CGRectMake(0, 0, self.width*0.5,self.height*0.8);
        weakself.mainView.center = weakself.center;
        weakself.tableView.center = weakself.mainView.center;
        [weakself.mainView layoutIfNeeded];
//    } completion:^(BOOL finished) {
//
//
//    }];
}

-(void)closeView{
    WeakSelf;
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self];
//    [UIView animateWithDuration:0.3 animations:^{
//
        weakself.mainView.frame = CGRectZero;
        weakself.mainView.center = weakself.center;
        weakself.tableView.center = weakself.mainView.center;
        [weakself.mainView layoutIfNeeded];
//    } completion:^(BOOL finished) {
//
        [self removeFromSuperview];
//    }];
}



-(void)closeView:(UIButton *)sender{
    [self closeView];
}

-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        //确定
        [self closeView];
    } else if(sender.tag == 102) {
        self.transmutationDataModel.paramType = _transmuData.paramType;
        self.transmutationDataModel.dfdtValue = _transmuData.dfdtValue;
        self.transmutationDataModel.dvdtValue = _transmuData.dvdtValue;
        self.transmutationDataModel.startHzValue = _transmuData.startHzValue;
        self.transmutationDataModel.endHzValue = _transmuData.endHzValue;
        self.transmutationDataModel.startVValue = _transmuData.startVValue;
        self.transmutationDataModel.endVValue = _transmuData.endVValue;
        self.transmutationDataModel.changeStepValue = _transmuData.changeStepValue;
        self.transmutationDataModel.stepTimeValue = _transmuData.stepTimeValue;
        self.transmutationDataModel.changeStartValue = _transmuData.changeStartValue;
        self.transmutationDataModel.changeEndValue = _transmuData.changeEndValue;
        
        [self.tableView reloadData];
        [self closeView];
    }
}



-(BD_StateTestTransmutationDetailModel *)transmutationDataModel{
    if (!_transmutationDataModel) {
       _transmutationDataModel = [[BD_StateTestTransmutationDetailModel alloc] init];
    }
    return  _transmutationDataModel;
}
-(BD_StateTestTransmutationDetailModel *)transmuData{
    if (!_transmuData) {
           _transmuData = [[BD_StateTestTransmutationDetailModel alloc] init];
    }
    return _transmuData;
}

-(void)setParaTypeArr:(NSArray *)paraTypeArr{
    _paraTypeArr = paraTypeArr;
    if ([_transmutationDataModel.paramType isEqualToString:@"0"]) {
        _transmutationDataModel.paramType = self.paraTypeArr[0];
    }
    
}
-(void)changeDCurrState:(NSNotification *)noti{
    BOOL isCocurrent = [(NSNumber *)noti.object boolValue];
    _isDirectCurr = isCocurrent;
    if (!isCocurrent) {
        //交流限制
       
            if ([self.transmutationDataModel.paramType containsString:@"U"]) {
                if ([self.transmutationDataModel.startVValue floatValue]>[exchangeVoltageLimit floatValue]) {
                    self.transmutationDataModel.startVValue = @([exchangeVoltageLimit floatValue]);
                }
                if ([self.transmutationDataModel.endVValue floatValue]>[exchangeVoltageLimit floatValue]) {
                    self.transmutationDataModel.endVValue = @([exchangeVoltageLimit floatValue]);
                }
                
                if ([self.transmutationDataModel.endVValue floatValue]<0) {
                    self.transmutationDataModel.endVValue = @(0.000);
                }
                if ([self.transmutationDataModel.startVValue floatValue]<0) {
                    self.transmutationDataModel.startVValue = @(0.000);
                }
                if ([self.transmutationDataModel.changeStartValue floatValue]>[exchangeVoltageLimit floatValue]) {
                    self.transmutationDataModel.changeStartValue = @([exchangeVoltageLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeEndValue floatValue]>[exchangeVoltageLimit floatValue]) {
                    self.transmutationDataModel.changeEndValue = @([exchangeVoltageLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeStepValue floatValue]>[exchangeVoltageLimit floatValue]) {
                    self.transmutationDataModel.changeStepValue = @([exchangeVoltageLimit floatValue]);
                }
                if ([self.transmutationDataModel.endVValue floatValue]<0) {
                    self.transmutationDataModel.endVValue = @(0.000);
                }
                if ([self.transmutationDataModel.startVValue floatValue]<0) {
                    self.transmutationDataModel.startVValue = @(0.000);
                }
            } else if ([self.transmutationDataModel.paramType containsString:@"I"]){
                if ([self.transmutationDataModel.changeStartValue floatValue]>[exchangeCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStartValue = @([exchangeCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeEndValue floatValue]>[exchangeCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeEndValue = @([exchangeCurrentLimit floatValue]);
                }
                if ([self.transmutationDataModel.changeStepValue floatValue]>[exchangeCurrentLimit floatValue]) {
                    self.transmutationDataModel.changeStepValue = @([exchangeCurrentLimit floatValue]);
                }
               
            }
        if ([self.transmutationDataModel.endVValue floatValue]<0) {
            self.transmutationDataModel.endVValue = @(0.000);
        }
        if ([self.transmutationDataModel.startVValue floatValue]<0) {
            self.transmutationDataModel.startVValue = @(0.000);
        }
        if ([self.transmutationDataModel.changeStartValue floatValue]<0) {
            self.transmutationDataModel.changeStartValue = @(0.000);
        }
        if ([self.transmutationDataModel.changeEndValue floatValue]<0) {
            self.transmutationDataModel.changeEndValue = @(0.000);
        }
    } else {
        //直流限制
        
        if ([self.transmutationDataModel.paramType containsString:@"U"]) {
            if ([self.transmutationDataModel.startVValue floatValue]>[directVoltageLimit floatValue]) {
                self.transmutationDataModel.startVValue = @([directVoltageLimit floatValue]);
            }
            if ([self.transmutationDataModel.endVValue floatValue]>[directVoltageLimit floatValue]) {
                self.transmutationDataModel.endVValue = @([directVoltageLimit floatValue]);
            }
            
            if ([self.transmutationDataModel.changeStartValue floatValue]>[directVoltageLimit floatValue]) {
                self.transmutationDataModel.changeStartValue = @([directVoltageLimit floatValue]);
            }
            if ([self.transmutationDataModel.changeEndValue floatValue]>[directVoltageLimit floatValue]) {
                self.transmutationDataModel.changeEndValue = @([directVoltageLimit floatValue]);
            }
            if ([self.transmutationDataModel.changeStepValue floatValue]>[directVoltageLimit floatValue]) {
                self.transmutationDataModel.changeStepValue = @([directVoltageLimit floatValue]);
            }
            
        } else if ([self.transmutationDataModel.paramType containsString:@"I"]){
            if ([self.transmutationDataModel.changeStartValue floatValue]>[directCurrentLimit floatValue]) {
                self.transmutationDataModel.changeStartValue = @([directCurrentLimit floatValue]);
            }
            if ([self.transmutationDataModel.changeEndValue floatValue]>[directCurrentLimit floatValue]) {
                self.transmutationDataModel.changeEndValue = @([directCurrentLimit floatValue]);
            }
            if ([self.transmutationDataModel.changeStepValue floatValue]>[directCurrentLimit floatValue]) {
                self.transmutationDataModel.changeStepValue = @([directCurrentLimit floatValue]);
            }
            
        }
       
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)changeOutputLimitValue:(NSNotification *)noti{
    BD_HardwarkConfigModel *hardworakModel = (BD_HardwarkConfigModel *)noti.object;
    exchangeVoltageLimit = hardworakModel.exchangeVoltage;
    exchangeCurrentLimit = hardworakModel.exchangeCurrent;
    directCurrentLimit = hardworakModel.directCurrent;
    directVoltageLimit = hardworakModel.directVoltage;
}


////kvo监听
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"transmutationDataModel"]) {
//        [_tableView reloadData];
//    }
//}
-(void)dealloc{
//    [self removeObserver:self forKeyPath:@"transmutationDataModel" context:nil];
    [kNotificationCenter removeObserver:self name:BD_IsCocurrentNoti object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
