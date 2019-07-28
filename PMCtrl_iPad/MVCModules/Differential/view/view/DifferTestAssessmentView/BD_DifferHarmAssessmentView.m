//
//  BD_DifferHarmAssessmentView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferHarmAssessmentView.h"
#import "BD_DifferAssessmentModel.h"
#import "UITextField+Extension.h"
@interface BD_DifferHarmAssessmentView()<UITextFieldDelegate>
@end

@implementation BD_DifferHarmAssessmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [_absoluteError setDefaultSetting];
    [_relativeError setDefaultSetting];
    [_expression setDefaultSetting];
    [_IdResult setDefaultSetting];
    [_IrResult setDefaultSetting];
    [_rate setDefaultSetting];
    
    [_relativeErrorBtn addTarget:self action:@selector(relativeErrorAction:) forControlEvents:UIControlEventTouchUpInside];
    [_absoluteErrorBtn addTarget:self action:@selector(absoluteErrorAction:) forControlEvents:UIControlEventTouchUpInside];
    _relativeErrorBtn.selected = NO;
    _absoluteErrorBtn.selected = NO;
    [[BD_Utils shared] setViewState:NO view:_relativeError];
    [[BD_Utils shared] setViewState:NO view:_absoluteError];
    [[BD_Utils shared] setViewState:NO view:_expression];
    [[BD_Utils shared] setViewState:NO view:_IdResult];
    [[BD_Utils shared] setViewState:NO view:_IrResult];
    [[BD_Utils shared] setViewState:NO view:_rate];
    _IdResultLabel.text = @"差动电流(A)";
    _IrResultLabel.text = @"制动电流(A)";
    [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
    
    _relativeError.delegate = self;
    _absoluteError.delegate = self;
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)relativeErrorAction:(UIButton *)sender{
    _relativeErrorBtn.selected = !_relativeErrorBtn.selected;
    [[BD_Utils shared] setViewState:_relativeErrorBtn.selected view:_relativeError];
    _viewData.expression = [self getExpresionValue];
    _expression.text = _viewData.expression;
    _viewData.isRelativeErrorSelect = _relativeErrorBtn.selected;
}

-(void)absoluteErrorAction:(UIButton *)sender{
    _absoluteErrorBtn.selected = !_absoluteErrorBtn.selected;
    [[BD_Utils shared] setViewState:_absoluteErrorBtn.selected  view:_absoluteError];
    _viewData.expression = [self getExpresionValue];
    _expression.text = _viewData.expression;
    _viewData.isAbsoluteErrorSelect = _absoluteErrorBtn.selected;
}

-(NSString *)getExpresionValue{
    NSString *str = @"";
    if (_relativeErrorBtn.selected && _absoluteErrorBtn.selected) {
        str = [NSString stringWithFormat:@"((ABS(KXB-Kxb2)/Kxb2*100)<%@)|(ABS(KXB-Kxb2)<%@)",_relativeError.text,_absoluteError.text];
    } else if (_relativeErrorBtn.selected && !_absoluteErrorBtn.selected){
        str = [NSString stringWithFormat:@"((ABS(KXB-Kxb2)/Kxb2*100)<%@)",_relativeError.text];
    } else if (!_relativeErrorBtn.selected && _absoluteErrorBtn.selected){
           str = [NSString stringWithFormat:@"(ABS(KXB-Kxb2)<%@)",_absoluteError.text];
    } else {
        str = @"";
    }
    return str;
}
-(void)setViewData{
    _relativeErrorBtn.selected = _viewData.isRelativeErrorSelect;
    _absoluteErrorBtn.selected = _viewData.isAbsoluteErrorSelect;
    [[BD_Utils shared] setViewState:_relativeErrorBtn.selected view:_relativeError];
    [[BD_Utils shared] setViewState:_absoluteErrorBtn.selected view:_absoluteError];
    
    _relativeError.text = kTStrings(_viewData.relativeErrorValue);
    _absoluteError.text = kTStrings(_viewData.absoluteErrorValue);
    _expression.text = _viewData.expression;
    _IdResult.text = kTStrings(_viewData.IdValue);
    _IrResult.text = kTStrings(_viewData.IrValue);
    _rate.text = kTStrings(_viewData.rateValue);
}

-(void)changeSettingType:(NSNotification *)noti{
    NSInteger type = [((NSNumber *)noti.object) integerValue];
    switch (type) {
        case 0:
            _IdResultLabel.text = @"差动电流(A)";
            _IrResultLabel.text = @"制动电流(A)";
            break;
        case 1:
            _IdResultLabel.text = @"差动电流(In)";
            _IrResultLabel.text = @"制动电流(In)";
            break;
        default:
            break;
    }
    
}

#pragma mark - 懒加载
-(BD_DifferAssessmentModel *)viewData{
    if (!_viewData) {
        _viewData = [[BD_DifferAssessmentModel alloc]init];
    }
    return _viewData;
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
    _viewData.relativeErrorValue = [_relativeError.text floatValue];
    _viewData.absoluteErrorValue = [_absoluteError.text floatValue];
    _viewData.expression = [self getExpresionValue];
    _expression.text = _viewData.expression;
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DifferSettingType object:nil];
}

@end
