//
//  BD_QuickTestComParamCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/16.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestComParamCell.h"
#import "UITextField+Extension.h"
@interface BD_QuickTestComParamCell()<UITextFieldDelegate>
{
   
}
@end

@implementation BD_QuickTestComParamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = MainBgColor;
    self.contentView.backgroundColor = MainBgColor;
    
    self.contentView.layer.borderColor = Black.CGColor;
    self.contentView.layer.borderWidth = 1.0;
    [_containerView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_containerView setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    _celltitle.textColor = White;
    _cellvalue.textColor = White;
  
    _cellvalue.layer.borderWidth = 1.0;
    _cellvalue.layer.borderColor = White.CGColor;
    _cellvalue.layer.cornerRadius = 6.0;
    _cellvalue.layer.masksToBounds = YES;
    _cellvalue.backgroundColor = ClearColor;
    
    [_cellvalue setDefaultSetting];
    _cellvalue.delegate = self;
    

    
    _exchangeVoltageLimit = @"120.000";
    _exchangeCurrentLimit = @"20.000";
    _directVoltageLimit = @"169.706";
    _directCurrentLimit = @"10.000";
   
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)showPopView:(id)sender {
    
    self.popViewBlock(_cellIndex,_cellvalue);
  
}


//修改textfield的时候，设置只允许输入数字

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //如果是限制只能输入数字的文本框
   
      NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //状态序列通用参数限制
    if ([_celltitle.text hasPrefix:@"额定"]) {
        switch (_cellIndex.row) {
            case 0:
            {
                if (!_isDirectCurr) {
                    if ( newText.floatValue>sqrt(3)* _exchangeVoltageLimit.floatValue) {
                        textField.text = kTStrings(sqrt(3)* _exchangeVoltageLimit.floatValue);
                        return  NO;
                    } else if (newText.floatValue<0.000){
                        textField.text = @"0.000";
                        return  NO;
                    }
                } else {
                    if ( newText.floatValue>sqrt(3)*_directVoltageLimit.floatValue) {
                        textField.text = kTStrings(sqrt(3)* _directVoltageLimit.floatValue);
                        return  NO;
                    } else if (newText.floatValue<0.000){
                        textField.text = @"0.000";
                        return  NO;
                    }
                }
               
            }
                break;
            case 1:
                {
                    if (!_isDirectCurr) {
                        if ( newText.floatValue>_exchangeCurrentLimit.floatValue) {
                            textField.text = _exchangeCurrentLimit;
                            return  NO;
                        } else if (newText.floatValue<0.000){
                            textField.text = @"0.000";
                            return  NO;
                        }
                    } else {
                        if ( newText.floatValue>_directCurrentLimit.floatValue) {
                            textField.text = _directCurrentLimit;
                            return  NO;
                        } else if (newText.floatValue<0.000){
                            textField.text = @"0.000";
                            return  NO;
                        }
                    }
                   
                }
                break;
            case 2:
            {
                if ( newText.floatValue>1000) {
                    textField.text = kTStrings(1000.000);
                    return  NO;
                } else if (newText.floatValue<0.000){
                    textField.text = @"0.000";
                    return  NO;
                }
            }
                break;
            
            default:
                break;
        }
    }
    
    if ([_celltitle.text isEqualToString:@"衰减时间常数"]) {
        if ( newText.floatValue>0.100) {
            textField.text = @"0.100";
            return  NO;
        } else if (newText.floatValue<0.00){
            textField.text = @"0.000";
            return  NO;
        }
    } else if ([_celltitle.text isEqualToString:@"循环次数"]){
        if ( newText.intValue>999999) {
            textField.text = @"999999";
            return  NO;
        } else if (newText.intValue<0){
            textField.text = @"1";
            return  NO;
        }
    }
    //手动试验通用参数限制
    if (_cellIndex.section==1 && _cellIndex.row==4) {
        if ( newText.floatValue>999999) {
            textField.text = @"999999";
            return  NO;
        } else if (newText.floatValue<0.000){
            textField.text = @"0.001";
            return  NO;
        }
    }
  

    
    //手动试验--整定动作值 整定动作时间
    
    if ((_cellIndex.section==0 && [_celltitle.text hasSuffix:@"整定"]) ||(_cellIndex.section==1 && _cellIndex.row==9) ) {
        if ( newText.floatValue>999999) {
            textField.text = @"999999";
            return  NO;
        } else if (newText.floatValue<0){
            textField.text = @"0.000";
            return  NO;
        }
    }
    
    //状态序列--递变设置限制
    if ([_celltitle.text isEqualToString:@"变化时间(s)"]) {
        if ( newText.floatValue>999999) {
            textField.text = @"999999.000";
            return  NO;
        } else if (newText.floatValue<0){
            textField.text = @"0.001";
            return  NO;
        }
    }
   
    if ([_celltitle.text isEqualToString: @"起始频率(Hz)"]||[_celltitle.text isEqualToString: @"终止频率(Hz)"]) {
        if ( newText.floatValue>1000) {
            textField.text = @"1000.000";
            return  NO;
        } else if (newText.floatValue<0){
            textField.text = @"0.000";
            return  NO;
        }
    }
    
    if ([_celltitle.text isEqualToString: @"起始电压(V)"]||[_celltitle.text isEqualToString: @"终止电压(V)"]) {
        if (!_isDirectCurr) {
            if ( newText.floatValue>[_exchangeVoltageLimit floatValue]) {
                textField.text = _exchangeVoltageLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.000";
                return  NO;
            }
        } else {
            if ( newText.floatValue>[_directVoltageLimit floatValue]) {
                textField.text = _directVoltageLimit;
                return  NO;
            } else if (newText.floatValue<-[_directVoltageLimit floatValue]){
                textField.text = kTStrings(-[_directVoltageLimit floatValue]);
                return  NO;
            }
        }
       
    }
    
    if ([_celltitle.text isEqualToString: @"起始电流()"]||[_celltitle.text isEqualToString: @"终止电流(A)"]) {
        if (!_isDirectCurr) {
            if ( newText.floatValue>[_exchangeCurrentLimit floatValue]) {
                textField.text = _exchangeCurrentLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.000";
                return  NO;
            }
        } else {
            if ( newText.floatValue>[_directCurrentLimit floatValue]) {
                textField.text = _directCurrentLimit;
                return  NO;
            } else if (newText.floatValue<-[_directCurrentLimit floatValue]){
                textField.text = kTStrings(-[_directCurrentLimit floatValue]);
                return  NO;
            }
        }
        
    }

    
    if ([_celltitle.text isEqualToString:@"df/dt(Hz/s)"]|| [_celltitle.text isEqualToString:@"dv/dt(V/s)"]) {
        if ( newText.floatValue>999999) {
            textField.text = @"999999.000";
            return  NO;
        } else if (newText.floatValue<0){
            textField.text = @"0.000";
            return  NO;
        }
    }
    //状态序列-递变设置 变化步长限制
    if ([_celltitle.text isEqualToString:@"变化步长(V)"]) {
        if (!_isDirectCurr) {
            //交流
            if ( newText.floatValue>[_exchangeVoltageLimit floatValue]) {
                textField.text = _exchangeVoltageLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.001";
                return  NO;
            }
        } else {
            //直流
          if ( newText.floatValue>[_directVoltageLimit floatValue]) {
                textField.text = _directVoltageLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.001";
                return  NO;
            }
        }
        
    } else if ([_celltitle.text isEqualToString:@"变化步长(A)"]){
        if (!_isDirectCurr) {
            //交流
            if ( newText.floatValue>[_exchangeCurrentLimit floatValue]) {
                textField.text = _exchangeCurrentLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.001";
                return  NO;
            }
        } else {
            //直流
            if ( newText.floatValue>[_directCurrentLimit floatValue]) {
                textField.text = _directCurrentLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.001";
                return  NO;
            }
        }
        
    }
    if ([_celltitle.text isEqualToString:@"变化步长(°)"] || [_celltitle.text isEqualToString:@"始值(°)"] ||[_celltitle.text isEqualToString:@"终值(°)"] ) {
        if ( newText.floatValue>180){
            textField.text = @"180.000";
            return NO;
        } else if (newText.floatValue<-180){
            textField.text = @"-180.000";
            return NO;
        }
    }
    if ([_celltitle.text isEqualToString:@"变化步长(Hz)"] || [_celltitle.text isEqualToString:@"始值(Hz)"] ||[_celltitle.text isEqualToString:@"终值(Hz)"]) {
        
            if (newText.floatValue>3000) {
                textField.text = @"3000.000";
                return NO;
            } else if(newText.floatValue<0.000) {
                textField.text = @"0.000";
                return NO;
            }
    }
    //状态序列-递变设置 始终值限制
    if (!_isDirectCurr) {
        //交流
        if ([_celltitle.text isEqualToString:@"变化始值(V)"]||[_celltitle.text isEqualToString:@"变化终值(V)"]||[_celltitle.text isEqualToString:@"终值(V)"]||[_celltitle.text isEqualToString:@"始值(V)"]) {
            if ( newText.floatValue>[_exchangeVoltageLimit floatValue]) {
                textField.text = _exchangeVoltageLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.000";
                return  NO;
            }
        } else if([_celltitle.text isEqualToString:@"变化始值(A)"]||[_celltitle.text isEqualToString:@"变化终值(A)"]||[_celltitle.text isEqualToString:@"始值(A)"]||[_celltitle.text isEqualToString:@"终值(A)"]){
            if ( newText.floatValue>[_exchangeCurrentLimit floatValue]) {
                textField.text = _exchangeCurrentLimit;
                return  NO;
            } else if (newText.floatValue<0){
                textField.text = @"0.000";
                return  NO;
            }
        }
    } else {
        //直流
        if ([_celltitle.text isEqualToString:@"变化始值(V)"]||[_celltitle.text isEqualToString:@"变化终值(V)"] || [_celltitle.text isEqualToString:@"始值(V)"]||[_celltitle.text isEqualToString:@"终值(V)"]) {
            if ( newText.floatValue>[_directVoltageLimit floatValue]) {
                textField.text = _directVoltageLimit;
                return  NO;
            } else if (newText.floatValue<-[_directVoltageLimit floatValue]){
                textField.text = kTStrings(-[_directVoltageLimit floatValue]);
                return  NO;
            }
        } else if([_celltitle.text isEqualToString:@"变化始值(A)"]||[_celltitle.text isEqualToString:@"变化终值(A)"]||[_celltitle.text isEqualToString:@"始值(A)"]||[_celltitle.text isEqualToString:@"终值(A)"]){
            if ( newText.floatValue>[_directCurrentLimit floatValue]) {
                textField.text = _directCurrentLimit;
                return  NO;
            } else if (newText.floatValue<-[_directCurrentLimit floatValue]){
                textField.text = kTStrings(-[_directCurrentLimit floatValue]);
                return  NO;
            }
        }
    }
    
    if (_cellvalue==textField) {
        if ([[BD_Utils shared] validateNumber:string] == NO) {
            [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        }
        
        return [[BD_Utils shared]validateNumber:newText];
        
    }
    
    //否则返回yes,不限制其他textfield
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (_cellIndex.section == 1 && _cellIndex.row == 3) {
//        textField.text = [NSString stringWithFormat:@"%d",[textField.text intValue]];
//    } else {
    if ((_cellIndex.section==1 && _cellIndex.row==4)|| [_celltitle.text isEqualToString:@"变化时间(s)"]) {
        if ([[NSString stringWithFormat:@"%.3f",[textField.text floatValue]] isEqualToString:@"0.000"]) {
           textField.text = @"0.001";
        } else {
            textField.text =  [NSString stringWithFormat:@"%.3f",[textField.text floatValue]];
        }
    } else  {
         textField.text =  [NSString stringWithFormat:@"%.3f",[textField.text floatValue]];
    }
    if ([_celltitle.text isEqualToString:@"循环次数"]) {
         textField.text =  [NSString stringWithFormat:@"%d",[textField.text intValue]];
    }
    
//    }
    self.textFieldChangedBlock(_cellIndex,textField.text);
   
    if ([_celltitle.text isEqualToString:@"始值(Hz)"]||[_celltitle.text isEqualToString:@"终值(Hz)"]) {
            if (textField.text.floatValue==0.000) {
                textField.text = @"1.000";
            }
    }
}



@end
