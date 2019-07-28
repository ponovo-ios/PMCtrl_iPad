//
//  BD_DifferQDCurrentAssessmentView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferQDCurrentAssessmentView.h"
#import "UITextField+Extension.h"
@interface BD_DifferQDCurrentAssessmentView()<UITextFieldDelegate>
{
    NSInteger settingType;
}
@end

@implementation BD_DifferQDCurrentAssessmentView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _IrResult.delegate = self;
    _QdResult.delegate = self;
    _error.delegate = self;
    _rate.delegate = self;
    
    [_IrResult setDefaultSetting];
    [_QdResult setDefaultSetting];
    [_error setDefaultSetting];
    [_rate setDefaultSetting];
    
    if (_testType==DifferTestItemType_QDCurrent || _testType == DifferTestItemType_SDCurrent) {
        _rateLabel.hidden = YES;
        _rate.hidden = YES;
    } else {
        _rateLabel.hidden = NO;
        _rate.hidden = NO;
    }
    [[BD_Utils shared]setViewState:NO view:_IrResult];
    [[BD_Utils shared]setViewState:NO view:_QdResult];
    [[BD_Utils shared]setViewState:NO view:_rate];
    
     [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
    _IrResultLabel.text = @"制动电流(A)";
    if (_testType==DifferTestItemType_QDCurrent) {
        _QdResultLabel.text = @"启动电流(A)";
    } else if (_testType==DifferTestItemType_SDCurrent) {
        _QdResultLabel.text = @"速断电流(A)";
    } else {
        _QdResultLabel.text = @"差动电流(A)";
    }
    settingType = 0;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)setViewDataWithError:(NSString *)error Ir:(NSString *)Ir Id_QD_SD:(NSString *)Id_QD_SD rate:(NSString *)rate rateLabel:(NSString *)rateLabel {
    NSString *unit = @"";
    if (settingType ==0) {
        unit = @"(A)";
    } else {
        unit = @"(In)";
    }
    if (_testType==DifferTestItemType_QDCurrent) {
        
        _QdResultLabel.text = [@"启动电流" stringByAppendingString:unit];;
    } else if (_testType==DifferTestItemType_SDCurrent) {
        _QdResultLabel.text = [@"速断电流" stringByAppendingString:unit];
    } else {
        _QdResultLabel.text = [@"差动电流" stringByAppendingString:unit];
    }
    if (_testType!=DifferTestItemType_ZDRatio) {
        _rateLabel.hidden = YES;
        _rate.hidden = YES;
    } else {
        _rateLabel.hidden = NO;
        _rate.hidden = NO;
    }
    
    _IrResult.text = Ir;
    _QdResult.text = Id_QD_SD;
    _error.text = error;
    _rate.text = rate;
    _rateLabel.text = rateLabel;
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return  YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    if ([textField isEqual:_error]) {
        if (self.errorValueChangedBlock) {
            self.errorValueChangedBlock(_error.text);
        }
    }
    
}

-(void)changeSettingType:(NSNotification *)noti{
    NSInteger type = [((NSNumber *)noti.object) integerValue];
    settingType = type;
    switch (type) {
        case 0:
            _IrResultLabel.text = @"制动电流(A)";
            if (_testType==DifferTestItemType_QDCurrent) {
                _QdResultLabel.text = @"启动电流(A)";
            } else if (_testType==DifferTestItemType_SDCurrent) {
                _QdResultLabel.text = @"速断电流(A)";
            } else {
                _QdResultLabel.text = @"差动电流(A)";
            }
            
            break;
        case 1:
            _IrResultLabel.text = @"制动电流(In)";
            if (_testType==DifferTestItemType_QDCurrent) {
                _QdResultLabel.text = @"启动电流(In)";
            } else if (_testType==DifferTestItemType_SDCurrent) {
                _QdResultLabel.text = @"速断电流(In)";
            } else {
                _QdResultLabel.text = @"差动电流(In)";
            }
            break;
        default:
            break;
    }
    
}
-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DifferSettingType object:nil];
}
@end
