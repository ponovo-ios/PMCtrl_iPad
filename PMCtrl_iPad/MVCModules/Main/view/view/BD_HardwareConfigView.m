//
//  BD_HardwareConfigView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2017/11/19.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HardwareConfigView.h"
#import "UIImage+Extension.h"
#import "BD_PassagewayNamedCell.h"
#import "BD_PassagewayNamedHeaderView.h"
#import "BD_DevicePassagewayModel.h"
#import "BD_HardwarkConfigModel.h"
//#define PassagewayNameBtnSelected COLOR(83.0, 141.0, 233.0, 1.0)
#define PassagewayNameBtnSelected White
#define PassagewayNameBtnUnselected [UIColor lightGrayColor]
#define PassagewayNameArr_V [NSArray arrayWithObjects:@"Ua",@"Ub",@"Uc",@"Uz",nil]
#define PassagewayNameArr_C [NSArray arrayWithObjects:@"Ia",@"Ib",@"Ic",nil]
@interface BD_HardwareConfigView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    int voltagePasswaySelectedIndex;//电压通道配置，选择的行
    int currentPasswaySelectedIndex;//电流通道配置，选择的行
    int passagewayNamedTBViewShowData;//电压通道命名 0 电流通道命名 1
//    BDDeviceType deviceType;   //设备型号 模拟 0 数字1 数模一体 2
    
}
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIView *deviceTypeView;
@property (weak, nonatomic) IBOutlet UIView *passagewayConfig;

@property (weak, nonatomic) IBOutlet UIView *outPutLimit;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *passagewayNameView;
@property (weak, nonatomic) IBOutlet UIButton *CurrentwayNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *VoltagewayNameBtn;

@property (weak, nonatomic) IBOutlet UIButton *imitateBtn;
@property (weak, nonatomic) IBOutlet UIButton *digitBtn;
@property (weak, nonatomic) IBOutlet UIButton *imitate_digitBtn;

@property (weak, nonatomic) IBOutlet UIButton *fourThreeUIBtn;
@property (weak, nonatomic) IBOutlet UIButton *voltagePassagewayBtn;
@property (weak, nonatomic) IBOutlet UILabel *imitate_digitLabel;

@property (weak, nonatomic) IBOutlet UIButton *currentPassagewayBtn;
@property (weak, nonatomic) IBOutlet UILabel *voltagePassagewayLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentPassagewayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourThreeUILabel;


@property (weak, nonatomic) IBOutlet UITextField *exchangeVoltage;
@property (weak, nonatomic) IBOutlet UITextField *exchangeCurrent;
@property (weak, nonatomic) IBOutlet UITextField *directFVoltage;
@property (weak, nonatomic) IBOutlet UITextField *directCurrent;
@property (weak, nonatomic) IBOutlet UITextField *assistCurrent;

@property (weak, nonatomic) IBOutlet UILabel *deviceTypeSubText;

@property (weak, nonatomic) IBOutlet UIButton *sixUIBtn;

@property (weak, nonatomic) IBOutlet UILabel *sixUILabel;

@end

@implementation BD_HardwareConfigView

-(void)awakeFromNib{
  [super awakeFromNib];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BD_PassagewayNamedCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_PassagewayNamedCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"BD_PassagewayNamedHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"BD_PassagewayNamedHeaderViewID"];
    [self.sixUIBtn addTarget:self action:@selector(sixUsixIClick:) forControlEvents:UIControlEventTouchUpInside];
    //默认为6U6i
    voltagePasswaySelectedIndex = 2;
    currentPasswaySelectedIndex = 1;
    //设置输出限制不可编辑
    [[BD_Utils shared]setViewState:NO view:_exchangeVoltage];
    [[BD_Utils shared]setViewState:NO view:_exchangeCurrent];
    [[BD_Utils shared]setViewState:NO view:_directFVoltage];
    [[BD_Utils shared]setViewState:NO view:_directCurrent];
    [[BD_Utils shared]setViewState:NO view:_assistCurrent];
    _viewModel = [[BD_HardwarkConfigModel alloc]init];
    
    [self setViewData];
    [self setViewStyle];
    _moduletype = BD_TestModuleType_Manual;
    
}
#pragma mark - 页面UI配置
-(void)setViewStyle{
    [_okBtn setCorenerRadius:10.0 borderColor:ClearColor borderWidth:2.0];
    _deviceTypeView.backgroundColor = ClearColor;
    [_deviceTypeView setCorenerRadius:10 borderColor:BtnViewBorderColor borderWidth:2.0];
    _passagewayConfig.backgroundColor = ClearColor;
    [_passagewayConfig setCorenerRadius:10 borderColor:BtnViewBorderColor borderWidth:2.0];
    _outPutLimit.backgroundColor = ClearColor;
    [_outPutLimit setCorenerRadius:10 borderColor:BtnViewBorderColor borderWidth:2.0];
    [_passagewayNameView setCorenerRadius:10 borderColor:ClearColor borderWidth:2.0];
    [_VoltagewayNameBtn setBackgroundColor:PassagewayNameBtnSelected];
    [_CurrentwayNameBtn setBackgroundColor:PassagewayNameBtnUnselected];

    
    [_imitateBtn setBackgroundImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
      [_imitateBtn setBackgroundImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    [_digitBtn setBackgroundImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [_digitBtn setBackgroundImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    [_imitate_digitBtn setBackgroundImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [_imitate_digitBtn setBackgroundImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
 
    
    
    _voltagePassagewayBtn.layer.cornerRadius = 6;
    _voltagePassagewayBtn.layer.masksToBounds = YES;
    [_voltagePassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
    
    _currentPassagewayBtn.layer.cornerRadius = 6;
    _currentPassagewayBtn.layer.masksToBounds = YES;
    [_currentPassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _exchangeVoltage.delegate = self;
    _exchangeCurrent.delegate = self;
    
   
}

#pragma mark - 懒加载

-(NSMutableArray<BD_DevicePassagewayModel *> *)passagewayNameArr_V{
    if (!_passagewayNameArr_V) {
        _passagewayNameArr_V = [[NSMutableArray alloc]init];
    }
    return _passagewayNameArr_V;
}

-(NSMutableArray<BD_DevicePassagewayModel *> *)passagewayNameArr_C{
    if (!_passagewayNameArr_C) {
        _passagewayNameArr_C = [[NSMutableArray alloc]init];
    }
    return _passagewayNameArr_C;
}


#pragma  mark - 关闭
- (IBAction)closeBtnClick:(id)sender {
    if ([_dissdelegate respondsToSelector:@selector(disMissHardwareView)]) {
        [self setViewData];
        [self.dissdelegate disMissHardwareView];
    }
}

#pragma  mark - 选择电压通道
- (IBAction)voltagePassagewayClick:(id)sender {
    //选中电压通道命名,刷新tableVIew
   
    [_VoltagewayNameBtn setBackgroundColor:PassagewayNameBtnSelected];
    [_CurrentwayNameBtn setBackgroundColor:PassagewayNameBtnUnselected];
    passagewayNamedTBViewShowData = 0;
    [_tableView reloadData];
}
#pragma  mark - 选择电流通道
- (IBAction)currentPassagewayClick:(id)sender {
     //选中电流通道命名,刷新tableVIew
    
    [_VoltagewayNameBtn setBackgroundColor:PassagewayNameBtnUnselected];
    [_CurrentwayNameBtn setBackgroundColor:PassagewayNameBtnSelected];
    passagewayNamedTBViewShowData = 1;
    [_tableView reloadData];
}

//测试仪类型-模拟
- (IBAction)imitateClick:(id)sender {
    
    [self setdeviceType:YES digit:NO imitate_digit:NO];
    [BD_PMCtrlSingleton shared].deviceType = BDDeviceType_Imitate;
    if (_moduletype == BD_TestModuleType_Diff) {
         _deviceTypeSubText.text = @"通道固定为6U,6I";
         [self makeViewUnUsed];
    } else if (_moduletype==BD_TestModuleType_Harm){
        _deviceTypeSubText.text = @"可选择4U3I和6U6I两种模式";
       
    } else {
        _deviceTypeSubText.text = @"通道可根据仪器灵活配置";
        [self makeViewUsed];
    }
   
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
}
//测试仪类型-数字
- (IBAction)digitClick:(id)sender {
   
    [self setdeviceType:NO digit:YES imitate_digit:NO];
    [BD_PMCtrlSingleton shared].deviceType = BDDeviceType_Digit;
    if (_moduletype == BD_TestModuleType_Diff) {
        _deviceTypeSubText.text = @"通道固定为6U,6I";
        [self.voltagePassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
        [self.currentPassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
        voltagePasswaySelectedIndex = 2;
        currentPasswaySelectedIndex = 1;
         [self makeViewUnUsed];
    } else if(_moduletype == BD_TestModuleType_Harm){
        //谐波数据添加一个`
      
    } else  {
        _deviceTypeSubText.text = @"通道固定为12U,12I";
        [self.voltagePassagewayBtn setTitle:@"12" forState:UIControlStateNormal];
        [self.currentPassagewayBtn setTitle:@"12" forState:UIControlStateNormal];
        voltagePasswaySelectedIndex = 4;
        currentPasswaySelectedIndex = 3;
         [self makeViewUnUsed];
    }
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
   
}
//测试仪类型-数模一体
- (IBAction)imitate_digitClick:(id)sender {
    [self setdeviceType:NO digit:NO imitate_digit:YES];
    [BD_PMCtrlSingleton shared].deviceType = BDDeviceType_ImitateDigit;
    _deviceTypeSubText.text = @"通道固定为12U,12I,顺序为模拟（前6)-数字(后6)";
    [self.voltagePassagewayBtn setTitle:@"12" forState:UIControlStateNormal];
    [self.currentPassagewayBtn setTitle:@"12" forState:UIControlStateNormal];
    voltagePasswaySelectedIndex = 4;
    currentPasswaySelectedIndex = 3;
    [self makeViewUnUsed];
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
}
//选择4u3i
- (IBAction)fourThreeClick:(id)sender {
    
   
    if (_moduletype==BD_TestModuleType_Harm) {
        self.sixUIBtn.selected = NO;
        self.fourThreeUIBtn.selected = YES;
        [self.voltagePassagewayBtn setTitle:@"4" forState:UIControlStateNormal];
        [self.currentPassagewayBtn setTitle:@"3" forState:UIControlStateNormal];
        [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.voltagePassagewayBtn.userInteractionEnabled = NO;
        self.currentPassagewayBtn.userInteractionEnabled = NO;
        voltagePasswaySelectedIndex = 1;
        currentPasswaySelectedIndex = 0;
        [self setTBDataSource:YES];
        [self setTBDataSource:NO];
    } else {
         [self.fourThreeUIBtn setSelected:!_fourThreeUIBtn.isSelected];
        if (self.fourThreeUIBtn.isSelected==YES) {
            [self.voltagePassagewayBtn setTitle:@"4" forState:UIControlStateNormal];
            [self.currentPassagewayBtn setTitle:@"3" forState:UIControlStateNormal];
            [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
            [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.voltagePassagewayBtn.userInteractionEnabled = NO;
            self.currentPassagewayBtn.userInteractionEnabled = NO;
            voltagePasswaySelectedIndex = 1;
            currentPasswaySelectedIndex = 0;
            [self setTBDataSource:YES];
            [self setTBDataSource:NO];
        } else {
            [self.voltagePassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
            [self.currentPassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
            self.voltagePassagewayBtn.userInteractionEnabled = YES;
            self.currentPassagewayBtn.userInteractionEnabled = YES;
        }
    }
 
}

-(void)sixUsixIClick:(UIButton *)sender{
    self.sixUIBtn.selected = YES;
    self.fourThreeUIBtn.selected = NO;
    [self.voltagePassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
    [self.currentPassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
    [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.voltagePassagewayBtn.userInteractionEnabled = NO;
    self.currentPassagewayBtn.userInteractionEnabled = NO;
    voltagePasswaySelectedIndex = 2;
    currentPasswaySelectedIndex = 1;
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
  
}
- (IBAction)setvoltagePassageway:(id)sender {
    
    [self changeRowData:@[@"3",@"4",@"6"] textField:_voltagePassagewayBtn complete:^(int index) {
        voltagePasswaySelectedIndex = index;
        [self setTBDataSource:NO];
    }];
}
- (IBAction)setcurrentPassageway:(id)sender {
    [self changeRowData:@[@"3",@"6"] textField:_currentPassagewayBtn complete:^(int index) {
        currentPasswaySelectedIndex = index;
        [self setTBDataSource:YES];
    }];
}
- (IBAction)configCompleteOKClick:(id)sender {
    
    _viewModel.deviceType = [BD_PMCtrlSingleton shared].deviceType;
    _viewModel.voltagePassNum = [_voltagePassagewayBtn.titleLabel.text intValue];
    _viewModel.currentPassNum = [_currentPassagewayBtn.titleLabel.text intValue];
    _viewModel.exchangeVoltage = _exchangeVoltage.text;
    
    _viewModel.exchangeCurrent = _exchangeCurrent.text;
    
    _viewModel.directVoltage = _directFVoltage.text;
    
    _viewModel.directCurrent = _directCurrent.text;
    _viewModel.assistCurrent = _assistCurrent.text;
    
    [kNotificationCenter postNotificationName:BD_OutPutLimitNotifi object:_viewModel userInfo:nil];//发送修改输出限制的通知
    self.hardwareConfigComplete(_viewModel);
}
-(void)setViewData{
    switch (_viewModel.deviceType) {
        case BDDeviceType_Digit:
             [self setdeviceType:NO digit:YES imitate_digit:NO];
            break;
        case BDDeviceType_Imitate:
            [self setdeviceType:YES digit:NO imitate_digit:NO];
            break;
        case BDDeviceType_ImitateDigit:
            [self setdeviceType:NO digit:NO imitate_digit:YES];
            break;
        default:
            break;
    }
   
    
    
    [_voltagePassagewayBtn setTitle:[NSString stringWithFormat:@"%d",_viewModel.voltagePassNum] forState:UIControlStateNormal];
    [_currentPassagewayBtn setTitle:[NSString stringWithFormat:@"%d",_viewModel.currentPassNum] forState:UIControlStateNormal];
    if (_moduletype==BD_TestModuleType_Harm) {
        if (_viewModel.voltagePassNum == 4 && _viewModel.currentPassNum == 3) {
             [self.fourThreeUIBtn setSelected:YES];
            [self.sixUIBtn setSelected:NO];
        } else {
            [self.fourThreeUIBtn setSelected:NO];
            [self.sixUIBtn setSelected:YES];
        }
        [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.voltagePassagewayBtn.userInteractionEnabled = NO;
        self.currentPassagewayBtn.userInteractionEnabled = NO;
    } else {
        if (_viewModel.voltagePassNum == 4 && _viewModel.currentPassNum == 3) {
            [self.fourThreeUIBtn setSelected:YES];
            [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
            [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.voltagePassagewayBtn.userInteractionEnabled = NO;
            self.currentPassagewayBtn.userInteractionEnabled = NO;
        } else {
            [self.fourThreeUIBtn setSelected:NO];
            [self.voltagePassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
            [self.currentPassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
            self.voltagePassagewayBtn.userInteractionEnabled = YES;
            self.currentPassagewayBtn.userInteractionEnabled = YES;
        }
    }
    
    _exchangeVoltage.text = _viewModel.exchangeVoltage;
    _exchangeCurrent.text = _viewModel.exchangeCurrent;
    _directFVoltage.text = _viewModel.directVoltage;
    _directCurrent.text = _viewModel.directCurrent;
    _assistCurrent.text = _viewModel.assistCurrent;
    
    switch (_viewModel.voltagePassNum) {
        case 3:
            voltagePasswaySelectedIndex = 0;
            break;
        case 4:
            voltagePasswaySelectedIndex = 1;
            break;
        case 6:
            voltagePasswaySelectedIndex = 2;
            break;
        case 12:
            voltagePasswaySelectedIndex = 4;
            break;
        default:
            break;
    }
    switch (_viewModel.currentPassNum) {
        case 3:
            currentPasswaySelectedIndex = 0;
            break;
        case 6:
            currentPasswaySelectedIndex = 1;
            break;
        case 12:
            currentPasswaySelectedIndex = 3;
            break;
        default:
            break;
    }
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
}

-(void)setdeviceType:(BOOL)imitate digit:(BOOL)digit imitate_digit:(BOOL)imitate_digit{
    [_imitateBtn setSelected:imitate];
    [_digitBtn setSelected:digit];
    [_imitate_digitBtn setSelected:imitate_digit];
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (passagewayNamedTBViewShowData == 0) {
        return self.passagewayNameArr_V.count;
    } else {
        return self.passagewayNameArr_C.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_PassagewayNamedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_PassagewayNamedCellID" forIndexPath:indexPath];
    if (passagewayNamedTBViewShowData == 0) {
        cell.passagewayNum.text = _passagewayNameArr_V[indexPath.row].passagewayNum;
        cell.passagewayName.text = _passagewayNameArr_V[indexPath.row].passagewayName;
    } else {
        cell.passagewayNum.text = _passagewayNameArr_C[indexPath.row].passagewayNum;
        cell.passagewayName.text = _passagewayNameArr_C[indexPath.row].passagewayName;
    }
 
    return cell;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    BD_PassagewayNamedHeaderView * header = [[NSBundle mainBundle]loadNibNamed:@"BD_PassagewayNamedHeaderView" owner:nil options:nil].lastObject;
    return header;
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.text = [NSString stringWithFormat:@"%.3f",[textField.text floatValue]];
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}

#pragma mark - 设置通道配置tableView数据源
-(void)setTBDataSource:(BOOL)isCurrent{
    
   
    
        if (isCurrent) {
            [self.passagewayNameArr_C removeAllObjects];
            for (int i =0; i<(currentPasswaySelectedIndex+1)*3; i++) {
                if (currentPasswaySelectedIndex == 0) {
                    BD_DevicePassagewayModel *model = [[BD_DevicePassagewayModel alloc]initWithpassagewayNum:[NSString stringWithFormat:@"%d",i] passagewayName:PassagewayNameArr_C[i%3]];
                    [self.passagewayNameArr_C addObject:model];
                } else {
                    BD_DevicePassagewayModel *model = [[BD_DevicePassagewayModel alloc]initWithpassagewayNum:[NSString stringWithFormat:@"%d",i] passagewayName:[PassagewayNameArr_C[i%3]stringByAppendingString:[NSString stringWithFormat:@"%d",i/3+1]]];
                    [self.passagewayNameArr_C addObject:model];
                }
                
            }
            
        } else {
            [self.passagewayNameArr_V removeAllObjects];
            if (voltagePasswaySelectedIndex == 0) {
                for (int i =0; i<3; i++) {
                    BD_DevicePassagewayModel *model = [[BD_DevicePassagewayModel alloc]initWithpassagewayNum:[NSString stringWithFormat:@"%d",i] passagewayName:PassagewayNameArr_V[i]];
                    [self.passagewayNameArr_V addObject:model];
                }
            } else if (voltagePasswaySelectedIndex == 1) {
                for (int i =0; i<4; i++) {
                    BD_DevicePassagewayModel *model = [[BD_DevicePassagewayModel alloc]initWithpassagewayNum:[NSString stringWithFormat:@"%d",i] passagewayName:PassagewayNameArr_V[i]];
                    [self.passagewayNameArr_V addObject:model];
                }
            } else {
                for (int i =0; i<voltagePasswaySelectedIndex*3; i++) {
                    BD_DevicePassagewayModel *model = [[BD_DevicePassagewayModel alloc]initWithpassagewayNum:[NSString stringWithFormat:@"%d",i] passagewayName:[PassagewayNameArr_V[i%3]stringByAppendingString:[NSString stringWithFormat:@"%d",i/3+1]]];//从宏定义中取数，用i%3，获取余数
                    [self.passagewayNameArr_V addObject:model];
                }
            }
            
        }
        
        if ([BD_PMCtrlSingleton shared].deviceType==BDDeviceType_Digit) {
        
            [self.passagewayNameArr_V enumerateObjectsUsingBlock:^(BD_DevicePassagewayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj.passagewayName hasSuffix:@"`"]) {
                     obj.passagewayName = [NSString stringWithFormat:@"%@`",obj.passagewayName];
                }
               
            }];
            [self.passagewayNameArr_C enumerateObjectsUsingBlock:^(BD_DevicePassagewayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj.passagewayName hasSuffix:@"`"]) {
                    obj.passagewayName = [NSString stringWithFormat:@"%@`",obj.passagewayName];
                }
            }];
            
        } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_Imitate){
            
        } else {
            [self.passagewayNameArr_V enumerateObjectsUsingBlock:^(BD_DevicePassagewayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx<6) {
                   
                } else {
                    if (![obj.passagewayName hasSuffix:@"`"]) {
                    
                        obj.passagewayName = [[obj.passagewayName substringToIndex:2] stringByAppendingString:[NSString stringWithFormat:@"%d`",[obj.passagewayNum intValue]/3-1]];
                    }
                  
                }
            }];
            [self.passagewayNameArr_C enumerateObjectsUsingBlock:^(BD_DevicePassagewayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx<6) {
                    
                } else {
                    if (![obj.passagewayName hasSuffix:@"`"]) {
                       
                        obj.passagewayName = [[obj.passagewayName substringToIndex:2] stringByAppendingString:[NSString stringWithFormat:@"%d`",[obj.passagewayNum intValue]/3-1]];
                    }
                   
                }
            }];
        }
       
    
             [_tableView reloadData];
 
  
   
}
- (void)changeRowData:(NSArray *)arr textField:(UIButton *)btn complete:(void(^)(int))complete{
    
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i<arr.count; i++) {
        UIAlertAction *PointAction = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            complete(i);
        }];
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

//选择数字和数模一体的时候，通道设置固定，不可用
-(void)makeViewUnUsed{
    [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.voltagePassagewayBtn.userInteractionEnabled = NO;
    self.currentPassagewayBtn.userInteractionEnabled = NO;
    _voltagePassagewayLabel.textColor = [UIColor lightGrayColor];
    _currentPassagewayLabel.textColor = [UIColor lightGrayColor];
    _fourThreeUILabel.textColor = [UIColor lightGrayColor];
    _fourThreeUIBtn.userInteractionEnabled = NO;
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
}
-(void)makeViewUsed{
    [self.voltagePassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
    [self.currentPassagewayBtn setBackgroundColor:PassagewayNameBtnSelected];
    self.voltagePassagewayBtn.userInteractionEnabled = YES;
    self.currentPassagewayBtn.userInteractionEnabled = YES;
    _voltagePassagewayLabel.textColor = White;
    _currentPassagewayLabel.textColor = White;
    _fourThreeUILabel.textColor = White;
    _fourThreeUIBtn.userInteractionEnabled = YES;
}

//从测试仪读取到通道数据后，修改硬件配置页的默认显示
-(void)setViewDataFromRead{
    if (self.viewModel.voltagePassNum==3) {
        voltagePasswaySelectedIndex = 0;
    } else if (self.viewModel.voltagePassNum==4){
        voltagePasswaySelectedIndex = 1;
    } else {
        voltagePasswaySelectedIndex =self.viewModel.voltagePassNum/3 ;
    }
    
    if (self.viewModel.currentPassNum==3) {
        currentPasswaySelectedIndex = 0;
    } else{
        currentPasswaySelectedIndex =self.viewModel.currentPassNum/3 ;
    }
    
    [self setViewData];
    //读取到测试仪的数据之后，发出修改限制的通知
    [kNotificationCenter postNotificationName:BD_OutPutLimitNotifi object:_viewModel userInfo:nil];//发送修改输出限制的通知
}
-(void)SUSUViewConfig{
    _deviceTypeSubText.text = @"通道固定为6U,6I";
    [self.fourThreeUIBtn setSelected:NO];
    [self.voltagePassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
    [self.currentPassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
    [self makeViewUnUsed];
    voltagePasswaySelectedIndex = 2;
    currentPasswaySelectedIndex = 1;
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
    self.imitate_digitBtn.hidden = YES;
    self.imitate_digitLabel.hidden = YES;
}
-(void)SixUIViewConfig{
    _deviceTypeSubText.text = @"可选择4U3I和6U6I两种模式";
    self.sixUIBtn.hidden = NO;
    self.sixUILabel.hidden = NO;
    [self.fourThreeUIBtn setSelected:NO];
    [self.sixUIBtn setSelected:YES];
    [self.voltagePassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
    [self.currentPassagewayBtn setTitle:@"6" forState:UIControlStateNormal];
    [self.voltagePassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.currentPassagewayBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.voltagePassagewayBtn.userInteractionEnabled = NO;
    self.currentPassagewayBtn.userInteractionEnabled = NO;
    voltagePasswaySelectedIndex = 2;
    currentPasswaySelectedIndex = 1;
    [self setTBDataSource:YES];
    [self setTBDataSource:NO];
    self.imitate_digitBtn.hidden = YES;
    self.imitate_digitLabel.hidden = YES;
}

/*// Only over
ride drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
