//
//  BD_QuickTestParamCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestParamCell.h"
#import "UITextField+Extension.h"
#import "BD_HardwarkConfigModel.h"
#import "BD_TestDataParamModel.h"
@interface BD_QuickTestParamCell()<UITextFieldDelegate>{
    NSString *exchangeVoltageLimit;
    NSString *exchangeCurrentLimit;
    NSString *directVoltageLimit;
    NSString *directCurrentLimit;
}

@end

@implementation BD_QuickTestParamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = ClearColor;
    self.backgroundColor = ClearColor;
    [_bgView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_bgView setBackgroundColor:FormBgColor];
    
    _phase.delegate = self;
    _amplitude.delegate = self;
    _frequency.delegate = self;
    
    _cellTitle.textColor = White;
 
    

    
    [_phase setDefaultSetting];
    [_amplitude setDefaultSetting];
    [_frequency setDefaultSetting];
    
    
    
    [kNotificationCenter addObserver:self selector:@selector(changeOutputLimitValue:) name:BD_OutPutLimitNotifi object:nil];
    //设置直流电压 交流电压 直流电流 交流电流
    exchangeVoltageLimit = @"120.000";
    exchangeCurrentLimit = @"20.000";
    directVoltageLimit = @"169.706";
    directCurrentLimit = @"10.000";
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getTFValue:(UITextField *)tfV{
   
        if (tfV.isEditing && tfV.text.length == 0) {
            tfV.text = @"0.000";
        }
    
    return tfV.text;
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return  YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    //判断值

    if (!_isDirectCurr) {
        if ([textField isEqual: self.amplitude] && (int)_cellType == (int)BD_CellTypeVoltage  && (ABS(newText.floatValue)>[exchangeVoltageLimit floatValue])) {
            
            textField.text = exchangeVoltageLimit;//120
            
            return NO;
        }else if([textField isEqual: self.amplitude] &&(int)_cellType == (int)BD_CellTypeCurrent && (ABS(newText.floatValue)>[exchangeCurrentLimit floatValue])) {
            
            textField.text = exchangeCurrentLimit;//20
            return NO;
        }
    } else {
        //直流范围限制
        if ([textField isEqual: self.amplitude] && (int)_cellType == (int)BD_CellTypeVoltage) {
            if ((newText.floatValue)>[directVoltageLimit floatValue]) {
               textField.text = directVoltageLimit;//300
                 return NO;
            } else if ((newText.floatValue)<-[directVoltageLimit floatValue]) {
                textField.text = [@"-" stringByAppendingString:directVoltageLimit];
                return NO;
            }
            
            
           
        }else if([textField isEqual: self.amplitude] &&(int)_cellType == (int)BD_CellTypeCurrent) {
            if ((newText.floatValue)>[directCurrentLimit floatValue]) {
                textField.text = directCurrentLimit;//12
                 return NO;
            } else if (newText.floatValue<-[directCurrentLimit floatValue]) {
                textField.text = [@"-" stringByAppendingString: directCurrentLimit];
                return NO;
            }

        }
    }
    
    
    if ([textField isEqual: self.phase] && newText.floatValue>180){
        textField.text = @"180.000";
        return NO;
    } else if ([textField isEqual: self.phase] && newText.floatValue<-180){
        textField.text = @"-180.000";
        return NO;
    }
    else if ([textField isEqual: self.frequency]){
        if (newText.floatValue>3000) {
            textField.text = @"3000.000";
            return NO;
        } else if(newText.floatValue<0.000) {
            textField.text = @"0.001";
            return NO;
        }
        
    } else if (newText.floatValue<0 && [textField isEqual: self.amplitude]){
        if (!_isDirectCurr) {
            textField.text = @"0.000";
            return NO;
        }
      
    }
    
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}

-(void)changeOutputLimitValue:(NSNotification *)noti{
    BD_HardwarkConfigModel *hardworakModel = (BD_HardwarkConfigModel *)noti.object;
    exchangeVoltageLimit = hardworakModel.exchangeVoltage;
    exchangeCurrentLimit = hardworakModel.exchangeCurrent;
    directCurrentLimit = hardworakModel.directCurrent;
    directVoltageLimit = hardworakModel.directVoltage;
}

-(void)setVolCurrDefaultLimitWithExVol:(NSString *)exVol exCurr:(NSString *)exCurr DV:(NSString *)DV DC:(NSString *)DC{
    exchangeVoltageLimit = exVol;
    exchangeCurrentLimit = exCurr;
    directVoltageLimit = DV;
    directCurrentLimit = DC;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
   
    NSLog(@"isLock-->%d",self.isLock);
    NSLog(@"isBegin-->%d",self.isBegin);
    if ([textField isEqual: self.frequency]&&textField.text.floatValue==0.00){
        textField.text = @"0.001";
        }
    //判断是否已经开始测试,如果已经开始，则改变数值继续进行数据发送
//    if (self.isBegin == 1 && self.isLock == 0) {
        [self excute];//当前版本，在cell中只是完成数据的修改，将数据回传到vc页面，然后添加判断条件，是否进行参数下发，给测试仪传递数据。 iphone版是在cell中完成修改参数后，下发参数
//    }
    
    NSLog(@"-------------------------");
    
}

- (void)excute{
    BD_TestDataParamModel *model = [[BD_TestDataParamModel alloc]initWithtitleName:self.cellTitle.text frequency:[self getTFValue:self.frequency] phase:[self getTFValue:self.phase] amplitude:[self getTFValue:self.amplitude]unit:@""];
    if (!_isDirectCurr) {
        if (model.frequency.floatValue==0.000) {
            model.frequency = @"0.001";
        }
    }
    self.quickParamBlock(model);
}



-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_OutPutLimitNotifi object:nil];
}


@end
