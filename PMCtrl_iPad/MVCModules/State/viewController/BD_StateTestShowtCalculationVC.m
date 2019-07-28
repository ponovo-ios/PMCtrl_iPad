//
//  BD_StateTestShowtCalculationVC.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/7.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestShowtCalculationVC.h"
#import "UITextField+Extension.h"
#import "BD_PopListViewManager.h"
@interface BD_StateTestShowtCalculationVC ()<UITextFieldDelegate>
{
    NSString *exchangeVoltageLimit;
    NSString *exchangeCurrentLimit;
}
/**故障类型*/
@property (weak, nonatomic) IBOutlet UIButton *faultTypeBtn;
/**z,phi选择button*/
@property (weak, nonatomic) IBOutlet UIButton *zPhiBtn;
/**R,X选择button*/
@property (weak, nonatomic) IBOutlet UIButton *RXBtn;
/**Z，Phi第一个TF*/
@property (weak, nonatomic) IBOutlet UITextField *ZPhiValue1;
/**Z，Phi第二个TF*/

@property (weak, nonatomic) IBOutlet UITextField *ZPhiValue2;
/**RX 第一个TF*/
@property (weak, nonatomic) IBOutlet UITextField *RXValue1;
/**RX 第二个TF*/
@property (weak, nonatomic) IBOutlet UITextField *RXValue2;
/**计算模型*/
@property (weak, nonatomic) IBOutlet UIButton *caculateModelBtn;
/**短路电流*/
@property (weak, nonatomic) IBOutlet UITextField *shortCurrentTF;
/**短路电压*/
@property (weak, nonatomic) IBOutlet UITextField *shortVoltageTF;
/**|ZS/ZL|*/
@property (weak, nonatomic) IBOutlet UITextField *ZSZLTF;
/**计算方式*/
@property (weak, nonatomic) IBOutlet UIButton *caculateStyleBtn;
/**幅值*/
@property (weak, nonatomic) IBOutlet UITextField *amplitudeTF;
/**相角*/
@property (weak, nonatomic) IBOutlet UITextField *phaseAngleTF;
@property (weak, nonatomic) IBOutlet UILabel *amplitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *phaseLabel;

/**负荷电流*/
@property (weak, nonatomic) IBOutlet UITextField *loadCurrentTF;
/**负荷功角*/
@property (weak, nonatomic) IBOutlet UITextField *loadPowerAngleTF;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectedGroupBtn;

@property(nonatomic,weak)UIView *markView;


@end

@implementation BD_StateTestShowtCalculationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_okBtn setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:2.0];
    [_cancelBtn setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:2.0];
    
    [self confitSubViews];
    [kNotificationCenter addObserver:self selector:@selector(changeOutputLimitValue:) name:BD_OutPutLimitNotifi object:nil];
    exchangeCurrentLimit = @"20.000";
    exchangeVoltageLimit = @"120.000";
    // Do any additional setup after loading the view from its nib.
}

-(void)confitSubViews{
    [_faultTypeBtn setCorenerRadius:0 borderColor:White borderWidth:1.0];
    [_caculateModelBtn setCorenerRadius:0 borderColor:White borderWidth:1.0];
    [_caculateStyleBtn setCorenerRadius:0 borderColor:White borderWidth:1.0];
    [_selectedGroupBtn setCorenerRadius:0 borderColor:White borderWidth:1.0];
    
    [_ZPhiValue1 setDefaultSetting];
    [_ZPhiValue2 setDefaultSetting];
    [_RXValue1 setDefaultSetting];
    [_RXValue2 setDefaultSetting];
    [_shortCurrentTF setDefaultSetting];
    [_shortVoltageTF setDefaultSetting];
    [_ZSZLTF setDefaultSetting];
    [_amplitudeTF setDefaultSetting];
    [_phaseAngleTF setDefaultSetting];
    [_loadCurrentTF setDefaultSetting];
    [_loadPowerAngleTF setDefaultSetting];
    
    [_faultTypeBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_caculateModelBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_caculateStyleBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_zPhiBtn setImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [_zPhiBtn setImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    [_RXBtn setImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [_RXBtn setImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    
    [_zPhiBtn addTarget:self action:@selector(radioBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_RXBtn addTarget:self action:@selector(radioBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_selectedGroupBtn addTarget:self action:@selector(selectedGroup:) forControlEvents:UIControlEventTouchUpInside];
    //初始设置
    [self setViewDatas];
    
    //设置textField代理
    _ZPhiValue1.delegate = self;
    _ZPhiValue2.delegate = self;
    _RXValue1.delegate = self;
    _RXValue2.delegate = self;
    _shortCurrentTF.delegate = self;
    _shortVoltageTF.delegate = self;
    _ZSZLTF.delegate = self;
    _amplitudeTF.delegate = self;
    _phaseAngleTF.delegate = self;
    _loadCurrentTF.delegate = self;
    _loadPowerAngleTF.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(BD_ShortCaculationModel *)cacultationModel{
    if (!_cacultationModel) {
        _cacultationModel = [[BD_ShortCaculationModel alloc]initWithFaultStyle:@"A相接地" ZPhiOrRx:0 ZPhi1:@"1.000" ZPhi2:@"90.000" Rx1:@"0.000" Rx2:@"1.000" caculationModel:@"电流不变" shortCurrent:@"5.000" shortVoltage:@"0.000" ZSZL:@"0.000" cacultationStyle:@"KL" ampletude:@"0.670" phase:@"0.000" loadCurrent:@"0.000" loadPowerPhase:@"0.000" selectedGroup:@"第1组"];
    }
    return _cacultationModel;
}

-(void)buttonClickAction:(UIButton *)sender{
    if ([sender isEqual:_faultTypeBtn]) {
        [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"A相接地",@"B相接地",@"C相接地",@"AB短路",@"BC短路",@"CA短路",@"AB接地短路",@"BC接地短路",@"AC接地短路",@"三相短路",@"单相系统"] textField:_faultTypeBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
            [_faultTypeBtn setTitle:str forState:UIControlStateNormal];
           
        }];
    } else if ([sender isEqual:_caculateModelBtn]){
        [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"电流不变",@"电压不变",@"系统阻抗不变"] textField:_caculateModelBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
            [_caculateModelBtn setTitle:str forState:UIControlStateNormal];
            if ([str isEqualToString:@"电流不变"]) {
                [self setCaculateModel:0];
            } else if ([str isEqualToString:@"电压不变"]){
                [self setCaculateModel:1];
            } else if ([str isEqualToString:@"系统阻抗不变"]){
                [self setCaculateModel:2];
            }
            
        }];
    } else if ([sender isEqual:_caculateStyleBtn]){
        WeakSelf;
        [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"KL",@"Kr,Kx",@"Z0/Z1"] textField:_caculateStyleBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
            [_caculateStyleBtn setTitle:str forState:UIControlStateNormal];
            if ([str isEqualToString:@"Kr,Kx"]) {
                weakself.amplitudeLabel.text = @"Kr:";
                weakself.phaseLabel.text = @"Kx:";
                //计算方式改为Kr／Kx的时候，判断一下Kx输入框的内容是否超过100，超过进行修改
                if ([weakself.phaseAngleTF.text floatValue]>100) {
                    weakself.phaseAngleTF.text = @"100.000";
                }
            } else {
                weakself.phaseLabel.text = @"相角(°):";
                weakself.amplitudeLabel.text = @"幅值:";
            }
   
        }];
    }
}

-(void)radioBtnClickAction:(UIButton *)sender{
    if ([sender isEqual:_zPhiBtn]) {
        [_zPhiBtn setSelected:YES];
        [_RXBtn setSelected:NO];
        [self setZPhiViewState:YES];
        [self setRXViewState:NO];
      
    } else if ([sender isEqual:_RXBtn]){
        [_zPhiBtn setSelected:NO];
        [_RXBtn setSelected:YES];
        [self setZPhiViewState:NO];
        [self setRXViewState:YES];
       
    }
}

-(void)selectedGroup:(UIButton *)sender{
    
    NSMutableArray *titles = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<_groupNum; i++) {
        [titles addObject:[NSString stringWithFormat:@"第%ld组",i+1]];
    }
    [BD_PopListViewManager ShowPopViewWithlistDataSource:[titles copy] textField:(UIButton *)sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
        [((UIButton *)sender) setTitle:str forState:UIControlStateNormal];
        
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//设置Z,Phi是否可用
-(void)setZPhiViewState:(BOOL)state{
    if (!state) {
        _ZPhiValue1.userInteractionEnabled = NO;
        _ZPhiValue2.userInteractionEnabled = NO;
        _ZPhiValue1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _ZPhiValue2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        ((UILabel *)[self.view viewWithTag:10]).textColor = [UIColor lightGrayColor];
    } else {
        _ZPhiValue1.userInteractionEnabled = YES;
        _ZPhiValue2.userInteractionEnabled = YES;
        _ZPhiValue1.layer.borderColor = White.CGColor;
        _ZPhiValue2.layer.borderColor = White.CGColor;
        ((UILabel *)[self.view viewWithTag:10]).textColor = White;
    }
}
//设置R，X 是否可用
-(void)setRXViewState:(BOOL)state{
    if (!state) {
        _RXValue1.userInteractionEnabled = NO;
        _RXValue2.userInteractionEnabled = NO;
        _RXValue1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _RXValue2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        ((UILabel *)[self.view viewWithTag:11]).textColor = [UIColor lightGrayColor];
    } else {
        _RXValue1.userInteractionEnabled = YES;
        _RXValue2.userInteractionEnabled = YES;
        _RXValue1.layer.borderColor = White.CGColor;
        _RXValue2.layer.borderColor = White.CGColor;
        ((UILabel *)[self.view viewWithTag:11]).textColor = White;
    }
}

//短路电流是否可用
-(void)setShortCurrentState:(BOOL)state{
    if (state) {
        _shortCurrentTF.userInteractionEnabled = YES;
        _shortCurrentTF.layer.borderColor = White.CGColor;
         ((UILabel *)[self.view viewWithTag:12]).textColor = White;
    } else {
        _shortCurrentTF.userInteractionEnabled = NO;
        _shortCurrentTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        ((UILabel *)[self.view viewWithTag:12]).textColor = [UIColor lightGrayColor];
    }
}
//短路电压是否可用
-(void)setShortVoltageState:(BOOL)state{
    if (state) {
        _shortVoltageTF.userInteractionEnabled = YES;
        _shortVoltageTF.layer.borderColor = White.CGColor;
        ((UILabel *)[self.view viewWithTag:13]).textColor = White;
    } else {
        _shortVoltageTF.userInteractionEnabled = NO;
        _shortVoltageTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        ((UILabel *)[self.view viewWithTag:13]).textColor = [UIColor lightGrayColor];
    }
}
//系统阻抗ZS／ZL是否可用
-(void)setZSZLState:(BOOL)state{
    if (state) {
        _ZSZLTF.userInteractionEnabled = YES;
        _ZSZLTF.layer.borderColor = White.CGColor;
        ((UILabel *)[self.view viewWithTag:14]).textColor = White;
    } else {
        _ZSZLTF.userInteractionEnabled = NO;
        _ZSZLTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        ((UILabel *)[self.view viewWithTag:14]).textColor = [UIColor lightGrayColor];
    }
}

//设置计算模型状态
-(void)setCaculateModel:(int)index{
    switch (index) {
        case 0:
            [self setShortCurrentState:YES];
            [self setShortVoltageState:NO];
            [self setZSZLState:NO];
            break;
        case 1:
            [self setShortCurrentState:NO];
            [self setShortVoltageState:YES];
            [self setZSZLState:NO];
            break;
        case 2:
            [self setShortCurrentState:NO];
            [self setShortVoltageState:NO];
            [self setZSZLState:YES];
            break;
        default:
            break;
    }
}

#pragma mark - 设置页面数据显示
-(void)setViewDatas{
    [self setZPhiViewState:YES];
    [self setRXViewState:NO];
    if (self.cacultationModel.ZPhiOrRx==0) {
       [_zPhiBtn setSelected:YES];
        [_RXBtn setSelected:NO];
        [self setZPhiViewState:YES];
        [self setRXViewState:NO];
    } else {
        [_zPhiBtn setSelected:NO];
        [_RXBtn setSelected:YES];
        [self setZPhiViewState:NO];
        [self setRXViewState:YES];
    }
    [_caculateModelBtn setTitle:self.cacultationModel.caculationModel forState:UIControlStateNormal];

    //根据计算模型，显示电流 电压 zs/zl哪个可用
    if ([self.cacultationModel.caculationModel isEqualToString:@"电流不变"]) {
        [self setCaculateModel:0];
    } else if ([self.cacultationModel.caculationModel isEqualToString:@"电压不变"]){
        [self setCaculateModel:1];
    } else if ([self.cacultationModel.caculationModel isEqualToString:@"系统阻抗不变"]){
        [self setCaculateModel:2];
    }
    
    [_faultTypeBtn setTitle:self.cacultationModel.faultStyle forState:UIControlStateNormal];
    _ZPhiValue1.text = self.cacultationModel.ZPhi1;
    _ZPhiValue2.text = self.cacultationModel.ZPhi2;
    _RXValue1.text = self.cacultationModel.Rx1;
    _RXValue2.text = self.cacultationModel.Rx2;
    _shortCurrentTF.text = self.cacultationModel.shortCurrent;
    _shortVoltageTF.text = self.cacultationModel.shortVoltage;
    _ZSZLTF.text = self.cacultationModel.ZSZL;
    [_caculateStyleBtn setTitle:self.cacultationModel.cacultationStyle forState:UIControlStateNormal];
    _amplitudeTF.text = self.cacultationModel.ampletude;
    _phaseAngleTF.text = self.cacultationModel.phase;
    _loadCurrentTF.text = self.cacultationModel.loadCurrent;
    _loadPowerAngleTF.text = self.cacultationModel.loadPowerPhase;
    [_selectedGroupBtn setTitle:self.cacultationModel.selectedGroup forState:UIControlStateNormal];
}
#pragma mark - textField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>");
    
    
    
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    //判断值
        if ([textField isEqual: self.ZPhiValue1] ||[textField isEqual: self.RXValue1]||[textField isEqual: self.RXValue2]) {
            
            if ([newText floatValue]<0) {
                textField.text = @"0.000";
                return NO;
            } else if (newText.floatValue>99999){
                textField.text = @"99999.000";
                return NO;
            }

        }
    if ([textField isEqual: self.shortVoltageTF]){
       //短路电压限制
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>exchangeVoltageLimit.floatValue){
            textField.text = exchangeVoltageLimit;
            return NO;
        }
    }else if([textField isEqual: self.shortCurrentTF]){
       //短路电流限制
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>exchangeCurrentLimit.floatValue){
            textField.text = exchangeCurrentLimit;
            return NO;
        }
    }else if ([textField isEqual: self.ZSZLTF]){
        //zszl
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>999999){
            textField.text = @"999999.000";
            return NO;
        }
    } else if ([textField isEqual: self.amplitudeTF]){
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>100){
            textField.text = @"100.000";
            return NO;
        }
    }else if ([textField isEqual: self.loadCurrentTF]) {
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>exchangeCurrentLimit.floatValue){
            textField.text = exchangeCurrentLimit;
            return NO;
        }

    } else if ([textField isEqual: self.loadPowerAngleTF]){
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>360.000){
            textField.text = @"360.000";
            return NO;
        }
    } else if ([textField isEqual: self.phaseAngleTF]){
        if ( [self.phaseLabel.text isEqualToString:@"Kx:"]) {
            if ([newText floatValue]<0) {
                textField.text = @"0.000";
                return NO;
            } else if (newText.floatValue>100){
                textField.text = @"100.000";
                return NO;
            }
        } else {
            if ([newText floatValue]<0) {
                textField.text = @"0.000";
                return NO;
            } else if (newText.floatValue>360.000){
                textField.text = @"360.000";
                return NO;
            }
        }
    } else if ([textField isEqual: self.ZPhiValue2]){
        if ([newText floatValue]<0) {
            textField.text = @"0.000";
            return NO;
        } else if (newText.floatValue>360.000){
            textField.text = @"360.000";
            return NO;
        }
    }
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self.view];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    if ([textField isEqual:_RXValue1] || [textField isEqual:_RXValue2]) {
        float R = [_RXValue1.text floatValue];
        float X = [_RXValue2.text floatValue];
        float Z = sqrtf(R*R+X*X);
        float Phi = atanf(X/R);
        
        _ZPhiValue1.text = [NSString stringWithFormat:@"%.3f",Z];
        _ZPhiValue2.text = [NSString stringWithFormat:@"%.3f",Phi];
    }
    if ([textField isEqual:_ZPhiValue1] || [textField isEqual:_ZPhiValue2]) {
        float Z = [_ZPhiValue1.text floatValue];
        float Phi = [_ZPhiValue2.text floatValue];
        float X = sinf(Phi)*Z;
        float R = cosf(Phi)*Z;
        
        _RXValue1.text = [NSString stringWithFormat:@"%.3f",R];
        _RXValue2.text = [NSString stringWithFormat:@"%.3f",X];
    }

    
}

- (IBAction)okAction:(id)sender {
    
    if (_zPhiBtn.selected && !_RXBtn.selected) {
        self.cacultationModel.ZPhiOrRx = 0;
    } else {
         self.cacultationModel.ZPhiOrRx = 1;
    }
    self.cacultationModel.ZPhi1 = _ZPhiValue1.text;
    self.cacultationModel.ZPhi2 = _ZPhiValue2.text ;
    self.cacultationModel.Rx1 = _RXValue1.text  ;
    self.cacultationModel.Rx2 = _RXValue2.text;
    self.cacultationModel.shortCurrent = _shortCurrentTF.text;
    self.cacultationModel.shortVoltage = _shortVoltageTF.text ;
    self.cacultationModel.ZSZL = _ZSZLTF.text;
    self.cacultationModel.ampletude = _amplitudeTF.text ;
    self.cacultationModel.phase = _phaseAngleTF.text;
    self.cacultationModel.loadCurrent = _loadCurrentTF.text;
    self.cacultationModel.loadPowerPhase = _loadPowerAngleTF.text;
    self.cacultationModel.selectedGroup = _selectedGroupBtn.titleLabel.text;
    self.cacultationModel.caculationModel = _caculateModelBtn.titleLabel.text;
    self.cacultationModel.faultStyle = _faultTypeBtn.titleLabel.text;
    self.cacultationModel.cacultationStyle = _caculateStyleBtn.titleLabel.text;
    
    if (self.okActionBlock) {
        self.okActionBlock();
        [self closeBinaryInView];
    }
}

- (IBAction)cancelAction:(id)sender {
    [self closeBinaryInView];
    
}


-(void)showBinaryInView{
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    if (!self.markView) {
        UIView *markView = [[UIView alloc]initWithFrame:window.view.bounds];
        markView.backgroundColor = [Black colorWithAlphaComponent:0.5];
        [markView addSubview:self.view];
        [window.view addSubview:markView];
        self.markView = markView;
    } else {
          [window.view addSubview:self.markView];
    }
    

    [self.view setFrame:CGRectMake(0, 0,SCREEN_WIDTH*0.75,SCREEN_HEIGHT*0.6)];
    self.view.center = self.markView.center;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self setViewDatas];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeBinaryInView{
    WeakSelf;
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        
        [weakself.markView removeFromSuperview];
        [weakself.view removeFromSuperview];
    }];
}

-(void)changeOutputLimitValue:(NSNotification *)noti{
    BD_HardwarkConfigModel *hardworakModel = (BD_HardwarkConfigModel *)noti.object;
    exchangeVoltageLimit = hardworakModel.exchangeVoltage;
    exchangeCurrentLimit = hardworakModel.exchangeCurrent;
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_OutPutLimitNotifi object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
