
//
//  BD_TriggerView.m
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/6/12.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_TriggerView.h"
#import "UITextField+Extension.h"
#import "UIButton+Extension.h"

#define SubViewBGColor [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]
@interface BD_TriggerView()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIView *triggerConditionView;
@property(nonatomic,strong)UIPickerView *dataPicker;
/**递变设置详细页*/
@property(nonatomic,strong)BD_StateTestTransmutationDetailView *transmutationDV;


@end
@implementation BD_TriggerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    _nTirgerTime.delegate = self;
    _delayTimeTF.delegate = self;
    _holdTimeTF.delegate =  self;
    _nTirgerTime.keyboardType = UIKeyboardTypeDecimalPad;
    self.backgroundColor = ClearColor;
    
    [_triggerConditionView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_triggerConditionView setBackgroundColor:SubViewBGColor];
    [_triggerTimeV setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_triggerTimeV setBackgroundColor:SubViewBGColor];
    [_triggerLogicV setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_triggerLogicV setBackgroundColor:SubViewBGColor];
    [_binaryInV setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_binaryInV setBackgroundColor:SubViewBGColor];
    [_binaryOutV setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_binaryOutV setBackgroundColor:SubViewBGColor];
    [_delayTimeV setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_delayTimeV setBackgroundColor:SubViewBGColor];
    [_triggerMomentView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_triggerMomentView setBackgroundColor:SubViewBGColor];
    [_transmutationView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_transmutationView setBackgroundColor:SubViewBGColor];
    [_holdingView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_holdingView setBackgroundColor:SubViewBGColor];
    
    [_nTrigerType setTintColor:SwitchBGColor];
    [_nTrigerType setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateSelected];
    
    [_nTrigerType setTitleTextAttributes:@{NSForegroundColorAttributeName:Black,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
    
    [_nTrigerLogic setTintColor:SwitchBGColor];
    
    [_nTrigerLogic setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateSelected];
    
    [_nTrigerLogic setTitleTextAttributes:@{NSForegroundColorAttributeName:Black,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
    
    [_nTirgerTime setDefaultSetting];
    [_delayTimeTF setDefaultSetting];
    [_triggerMomentPickerBtn addTarget:self action:@selector(showDataPickerView) forControlEvents:UIControlEventTouchUpInside];
    [_holdTimeTF setDefaultSetting];
    //选择按钮设置image
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" button:_dfBtn];
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" button:_dvBtn];
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" button:_transmutationBtn];
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" button:_holdTimeBtn];
    [_dfBtn setSelected:NO];
    [_dvBtn setSelected:NO];
    [_transmutationBtn setSelected:NO];
    [_holdTimeBtn setSelected:NO];
    //选择按钮添加方法
    [_dfBtn addTarget:self action:@selector(checkChangeState:) forControlEvents:UIControlEventTouchUpInside];
     [_dvBtn addTarget:self action:@selector(checkChangeState:) forControlEvents:UIControlEventTouchUpInside];
     [_transmutationBtn addTarget:self action:@selector(checkChangeState:) forControlEvents:UIControlEventTouchUpInside];
     [_holdTimeBtn addTarget:self action:@selector(checkChangeState:) forControlEvents:UIControlEventTouchUpInside];
    //递变设置添加方法
    [_transmutationSettingDetailBtn addTarget:self action:@selector(showTransmutationDetailSettingView:) forControlEvents:UIControlEventTouchUpInside];
    
    //触发时刻 递变设置btn样式
    [_triggerMomentPickerBtn setCorenerRadius:6 borderColor:ClearColor borderWidth:1.0];
    _triggerMomentPickerBtn.backgroundColor = BDThemeColor;
    [_transmutationSettingDetailBtn setCorenerRadius:6 borderColor:ClearColor borderWidth:1.0];
    _transmutationSettingDetailBtn.backgroundColor = BDThemeColor;
    
    //设置switch选中颜色
    [_Bo01 setOnTintColor:SwitchBGColor];
    [_Bo02 setOnTintColor:SwitchBGColor];
    [_Bo03 setOnTintColor:SwitchBGColor];
    [_Bo04 setOnTintColor:SwitchBGColor];
    [_Bo05 setOnTintColor:SwitchBGColor];
    [_Bo06 setOnTintColor:SwitchBGColor];
    [_Bo07 setOnTintColor:SwitchBGColor];
    [_Bo08 setOnTintColor:SwitchBGColor];
    [_B01 setOnTintColor:SwitchBGColor];
    [_B02 setOnTintColor:SwitchBGColor];
    [_B03 setOnTintColor:SwitchBGColor];
    [_B04 setOnTintColor:SwitchBGColor];
    [_B05 setOnTintColor:SwitchBGColor];
    [_B06 setOnTintColor:SwitchBGColor];
    [_B07 setOnTintColor:SwitchBGColor];
    [_B08 setOnTintColor:SwitchBGColor];
    [_B09 setOnTintColor:SwitchBGColor];
    [_B10 setOnTintColor:SwitchBGColor];
    

    
    //初始化递变设置详细页面
    if (!_transmutationDV) {
        _transmutationDV  = [[BD_StateTestTransmutationDetailView alloc]init];
        WeakSelf;
        _transmutationDV.trandmutationEndEditBlock = ^{
             weakself.endEditViewBlock();
        };
    }
    
}

- (IBAction)selectSegmentIndex:(UISegmentedControl *)sender {
    NSLog(@"---");
    switch (sender.selectedSegmentIndex) {
        case 0:
            _triggerTimeV.userInteractionEnabled = NO;
            _triggerLogicV.userInteractionEnabled = NO;
            _binaryInV.userInteractionEnabled = NO;
            _binaryOutV.userInteractionEnabled = YES;
            _triggerMomentView.userInteractionEnabled = NO;
            _delayTimeV.userInteractionEnabled = NO;
            
            break;
        case 1:
            _triggerTimeV.userInteractionEnabled = YES;
            _triggerLogicV.userInteractionEnabled = NO;
            _binaryInV.userInteractionEnabled = NO;
            _binaryOutV.userInteractionEnabled = YES;
            _triggerMomentView.userInteractionEnabled = NO;
            _delayTimeV.userInteractionEnabled = NO;
            break;
        case 2:
            _triggerTimeV.userInteractionEnabled = NO;
            _triggerLogicV.userInteractionEnabled = YES;
            _binaryInV.userInteractionEnabled = YES;
            _binaryOutV.userInteractionEnabled = YES;
            _triggerMomentView.userInteractionEnabled = NO;
            _delayTimeV.userInteractionEnabled = YES;
            break;
        case 3:
            _triggerTimeV.userInteractionEnabled = NO;
            _triggerLogicV.userInteractionEnabled = NO;
            _binaryInV.userInteractionEnabled = NO;
            _binaryOutV.userInteractionEnabled = YES;
            _triggerMomentView.userInteractionEnabled = YES;
            _delayTimeV.userInteractionEnabled = NO;
            break;
        case 4:
            _triggerTimeV.userInteractionEnabled = YES;
            _triggerLogicV.userInteractionEnabled = YES;
            _binaryInV.userInteractionEnabled = YES;
            _binaryOutV.userInteractionEnabled = YES;
            _triggerMomentView.userInteractionEnabled = NO;
            _delayTimeV.userInteractionEnabled = YES;
            break;
          
        default:
            break;
    }
    _transmutationView.userInteractionEnabled = YES;
    _holdingView.userInteractionEnabled = YES;
    self.endEditViewBlock();
}

- (IBAction)triiggerLoginChanged:(id)sender {
    self.endEditViewBlock();
}

- (IBAction)BinaryInswitchsAction:(id)sender {
    self.endEditViewBlock();
}



- (IBAction)BinaryOutswitchsAction:(id)sender {
    self.endEditViewBlock();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"结束编辑");
    [self endEditing:YES];
}

//修改textfield的时候，设置只允许输入数字

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //如果是限制只能输入数字的文本框
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
    }
    
    return [[BD_Utils shared]validateNumber:string];
    //否则返回yes,不限制其他textfield
    return YES;
}

//
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.endEditViewBlock();
}

//设置复选框按钮图片
-(void)setBtnImage:(NSString *)NoramlimageName selectedImage:(NSString *)selectedImageName button:(UIButton *)button{
    [button setImage:[UIImage imageNamed:NoramlimageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
}
#pragma mark - 显示时间选择器
-(void)showDataPickerView{
    if (!self.dataPicker) {
        _dataPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _dataPicker.dataSource = self;
        _dataPicker.delegate = self;
      
        
    }
    WeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择时间" message:@"\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    [alert.view addSubview:self.dataPicker];
    self.dataPicker.frame = CGRectMake(10,10, 250, 200);
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself.triggerMomentPickerBtn setTitle:[NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)[_dataPicker selectedRowInComponent:0],[_dataPicker selectedRowInComponent:1],[_dataPicker selectedRowInComponent:2]] forState:UIControlStateNormal];
        weakself.endEditViewBlock();
      
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [[self GetSubordinateControllerForSelf] presentViewController:alert animated:YES completion:nil];
}

#pragma mark - picker view dataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 23;
            break;
        case 1:
            return 59;
            break;
        case 2:
            return 59;
            break;
        default:
            break;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%02d时",(int)row];
            break;
        case 1:
            return [NSString stringWithFormat:@"%02d分",(int)row];
            break;
        case 2:
            return [NSString stringWithFormat:@"%02d秒",(int)row];
            break;
        default:
            break;
    }
    return 0;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //选中某一行
    DLog(@"%ld行%ld列",row,component);
}
#pragma mark - 复选框按钮方法
-(void)checkChangeState:(UIButton *)sender{
    [sender setSelected:!sender.selected];
    if ([sender isEqual:_dvBtn]) {
        //dv/dt
        [_transmutationBtn setSelected:NO];
      
        
    } else if ([sender isEqual:_dfBtn]){
        //df/dt
        [_transmutationBtn setSelected:NO];
        
    } else if([sender isEqual:_transmutationBtn]){
        //递变设置
        [_dfBtn setSelected:NO];
        [_dvBtn setSelected:NO];
        
    }else if ([sender isEqual:_holdTimeBtn]){
        //保持时间选择
        [self setHoldTimeUserInteractionState:_holdTimeBtn.selected];
    }
    if (_dvBtn.selected == NO && _dfBtn.selected == NO && _transmutationBtn.selected == NO) {

              [self setTransmutationUserInteractionState:NO];
      
    } else {
            [self setTransmutationUserInteractionState:YES];
       
    }
    
    if (_dvBtn.selected == YES && _dfBtn.selected == NO && _transmutationBtn.selected == NO) {
        _transmutationDV.gradientType = BDGradientType_dvdt;
    } else if (_dvBtn.selected == NO && _dfBtn.selected == YES && _transmutationBtn.selected == NO){
        _transmutationDV.gradientType = BDGradientType_dfdt;
    } else if (_dvBtn.selected == YES && _dfBtn.selected == YES && _transmutationBtn.selected == NO){
        _transmutationDV.gradientType = BDGradientType_dfdvdt;
    } else if (_dvBtn.selected == NO && _dfBtn.selected == NO && _transmutationBtn.selected == YES){
        _transmutationDV.gradientType = BDGradientType_comGradient;
    } else {
        _transmutationDV.gradientType = BDGradientType_null;
    }
    self.endEditViewBlock();
}
 
//显示递变设置详细页面
-(void)showTransmutationDetailSettingView:(UIButton *)sender{
    self.transmutationDV.transmutationDataModel = self.gradientModel;
    _transmutationDV.paraTypeArr = [self createGradientVarsDataWithGradientType:_transmutationDV.gradientType];
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    _transmutationDV.frame = window.view.bounds;
    _transmutationDV.center = window.view.center;
    _transmutationDV.tableView.center = _transmutationDV.center;
    [window.view addSubview:self.transmutationDV];
    [_transmutationDV showView];
    
}

//设置保持时间是否可用
-(void)setHoldTimeUserInteractionState:(BOOL)state{
    if (state) {
        _holdTimeTF.layer.borderColor = White.CGColor;
        _holdTimeTF.userInteractionEnabled = YES;
        _holdTimeLabel.textColor = White;
    } else {
        _holdTimeTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _holdTimeTF.userInteractionEnabled = NO;
        _holdTimeLabel.textColor = [UIColor lightGrayColor];
    }
}

//设置递变设置详细按钮是否可用
-(void)setTransmutationUserInteractionState:(BOOL)state{
    if (state) {
        _transmutationSettingDetailBtn.userInteractionEnabled = YES;
        [_transmutationSettingDetailBtn setTitleColor:White forState:UIControlStateNormal];
    } else {
        _transmutationSettingDetailBtn.userInteractionEnabled = NO;
        [_transmutationSettingDetailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}
//目前递变参数只有两组
-(NSArray *)createGradientVarsDataWithGradientType:(BDGradientType)gradientType{
    NSArray<NSString *> *data1 = self.paramTypeArr[0];
    NSArray<NSString *> *data2 = self.paramTypeArr[1];
    NSMutableArray *paraDatas = [[NSMutableArray alloc]init];
    
    if (gradientType == BDGradientType_comGradient) {
        if (data1.count==4) {
            [paraDatas addObject:data1[0]];
            [paraDatas addObject:data1[1]];
            [paraDatas addObject:data1[2]];
            [paraDatas addObject:data1[3]];
            [paraDatas addObject:[data1[0] stringByAppendingFormat:@",%@,%@,%@",data1[1],data1[2],data1[3]]];
        } else {
            for (int group = 0 ; group<data1.count/3; group++) {
                for (int index = 0 ; index<3; index++) {
                    [paraDatas addObject:data1[3*group+index]];
                }
                [paraDatas addObject:[data1[3*group+0] stringByAppendingFormat:@",%@,%@",data1[3*group+1],data1[3*group+2]]];
            }
        }
        
        for (int group = 0 ; group<data2.count/3; group++) {
            for (int index = 0 ; index<3; index++) {
                [paraDatas addObject:data2[3*group+index]];
            }
            [paraDatas addObject:[data2[3*group+0] stringByAppendingFormat:@",%@,%@",data2[3*group+1],data2[3*group+2]]];
        }
    } else {
        if (data1.count==4) {
            [paraDatas addObject:[data1[0] stringByAppendingFormat:@",%@,%@,%@",data1[1],data1[2],data1[3]]];
        } else if(data1.count == 3) {
            [paraDatas addObject:[data1[0] stringByAppendingFormat:@",%@,%@",data1[1],data1[2]]];
        } else if (data1.count == 6){
            [paraDatas addObject:[data1[0] stringByAppendingFormat:@",%@,%@",data1[1],data1[2]]];
            [paraDatas addObject:[data1[3] stringByAppendingFormat:@",%@,%@",data1[4],data1[5]]];
            [paraDatas addObject:[data1[0] stringByAppendingFormat:@",%@,%@,%@,%@,%@",data1[1],data1[2],data1[3],data1[4],data1[5]]];
        }
        
        if(data2.count == 3) {
            [paraDatas addObject:[data2[0] stringByAppendingFormat:@",%@,%@",data2[1],data2[2]]];
        } else if (data2.count == 6){
            [paraDatas addObject:[data2[0] stringByAppendingFormat:@",%@,%@",data2[1],data2[2]]];
            [paraDatas addObject:[data2[3] stringByAppendingFormat:@",%@,%@",data2[4],data2[5]]];
            [paraDatas addObject:[data2[0] stringByAppendingFormat:@",%@,%@,%@,%@,%@",data2[1],data2[2],data2[3],data2[4],data2[5]]];
        }
    }
    
    return  [paraDatas copy];
}

#pragma mark - 懒加载
-(BD_StateTestTransmutationDetailModel *)gradientModel{
    if (!_gradientModel) {
        _gradientModel = [[BD_StateTestTransmutationDetailModel alloc]init];
    }
    return _gradientModel;
}

@end
