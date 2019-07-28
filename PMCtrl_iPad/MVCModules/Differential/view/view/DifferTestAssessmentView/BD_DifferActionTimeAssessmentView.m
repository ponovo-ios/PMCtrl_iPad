//
//  BD_DifferActionTimeAssessmentView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferActionTimeAssessmentView.h"
#import "UITextField+Extension.h"
#import "BD_PopListViewManager.h"
#import "BD_DifferAssessmentModel.h"
@interface BD_DifferActionTimeAssessmentView()<UITextFieldDelegate>


@end

@implementation BD_DifferActionTimeAssessmentView

-(void)awakeFromNib{
    [super awakeFromNib];
    [_relativeValue setDefaultSetting];
    [_absoluteValue setDefaultSetting];
    [_expressionValue setDefaultSetting];
    [_IdResult setDefaultSetting];
    [_IrResult setDefaultSetting];
    [_actionTimeValue setDefaultSetting];
    
    _relativeValue.delegate = self;
    _absoluteValue.delegate = self;
    [_errorLogicBtn setCorenerRadius:6.0 borderColor:White borderWidth:1.0];
    
    [[BD_Utils shared] setViewState:NO view:_errorLogicBtn];
    [[BD_Utils shared] setViewState:NO view:_expressionValue];
    [[BD_Utils shared] setViewState:NO view:_IdResult];
    [[BD_Utils shared] setViewState:NO view:_IrResult];
    [[BD_Utils shared] setViewState:NO view:_actionTimeValue];
    [[BD_Utils shared] setViewState:NO view:_absoluteValue];
    [[BD_Utils shared] setViewState:NO view:_relativeValue];
    
    [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
    _IdResultLabel.text = @"差动电流(A)";
    _IrResultLabel.text = @"制动电流(A)";
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


- (IBAction)relativeErrorAction:(id)sender {
    _relativeErrorBtn.selected = !_relativeErrorBtn.selected;
    [[BD_Utils shared] setViewState:_relativeErrorBtn.selected view:_relativeValue];
    _viewData.expression = [self getExpresionValue];
    _expressionValue.text = _viewData.expression;
    _viewData.isRelativeErrorSelect = _relativeErrorBtn.selected;
    if (_relativeErrorBtn.selected && _absoluteErrorBtn.selected) {
        [[BD_Utils shared] setViewState:YES view:_errorLogicBtn];
    } else {
         [[BD_Utils shared] setViewState:NO view:_errorLogicBtn];
    }
}

- (IBAction)absoluteErrorAction:(id)sender {
    _absoluteErrorBtn.selected = !_absoluteErrorBtn.selected;
    [[BD_Utils shared] setViewState:_absoluteErrorBtn.selected  view:_absoluteValue];
    _viewData.expression = [self getExpresionValue];
    _expressionValue.text = _viewData.expression;
    _viewData.isAbsoluteErrorSelect = _absoluteErrorBtn.selected;
    if (_relativeErrorBtn.selected && _absoluteErrorBtn.selected) {
        [[BD_Utils shared] setViewState:YES view:_errorLogicBtn];
    } else {
        [[BD_Utils shared] setViewState:NO view:_errorLogicBtn];
    }
}

- (IBAction)errorLogicAction:(id)sender {
    WeakSelf;
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"或",@"与"] textField:_errorLogicBtn viewController:[self GetSubordinateControllerForSelf] direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
        [weakself.errorLogicBtn setTitle:str forState:UIControlStateNormal];
        if ([str isEqualToString:@"或"]) {
            weakself.viewData.errorLogic = 0;
        } else {
            weakself.viewData.errorLogic = 1;
        }
        weakself.viewData.expression = [weakself getExpresionValue];
        weakself.expressionValue.text = weakself.viewData.expression;
    }];
}


-(NSString *)getExpresionValue{
    NSString *str = @"";
    if (_relativeErrorBtn.selected && _absoluteErrorBtn.selected) {
        str = [NSString stringWithFormat:@"(TRIPTIME<%@)%@(TRIPTIME>%@)",_relativeValue.text,_viewData.errorLogic==0?@"|":@"&",_absoluteValue.text];
    } else if (_relativeErrorBtn.selected && !_absoluteErrorBtn.selected){
        str = [NSString stringWithFormat:@"(TRIPTIME<%@)",_relativeValue.text];
    } else if (!_relativeErrorBtn.selected && _absoluteErrorBtn.selected){
        str = [NSString stringWithFormat:@"(TRIPTIME>%@)",_absoluteValue.text];
    } else {
        str = @"";
    }
    return str;
}

-(void)setViewData{
    
    
    switch (_viewData.errorLogic) {
        case 0:
            [_errorLogicBtn setTitle:@"或" forState:UIControlStateNormal];
            break;
        case 1:
            
            [_errorLogicBtn setTitle:@"与" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    _relativeErrorBtn.selected = _viewData.isRelativeErrorSelect;
    _absoluteErrorBtn.selected = _viewData.isAbsoluteErrorSelect;
    
    
    _relativeValue.text = kTStrings(_viewData.relativeErrorValue);
    _absoluteValue.text = kTStrings(_viewData.absoluteErrorValue);
    _expressionValue.text = _viewData.expression;
    _IdResult.text = kTStrings(_viewData.IdValue);
    _IrResult.text = kTStrings(_viewData.IrValue);
    _actionTimeValue.text = kTStrings(_viewData.rateValue);
    
    [[BD_Utils shared] setViewState:_absoluteErrorBtn.selected  view:_absoluteValue];
    [[BD_Utils shared] setViewState:_relativeErrorBtn.selected  view:_relativeValue];
    if (_relativeErrorBtn.selected && _absoluteErrorBtn.selected) {
        [[BD_Utils shared] setViewState:YES view:_errorLogicBtn];
    } else {
        [[BD_Utils shared] setViewState:NO view:_errorLogicBtn];
    }
    
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
    _viewData.relativeErrorValue = [_relativeValue.text floatValue];
    _viewData.absoluteErrorValue = [_absoluteValue.text floatValue];
    
    _viewData.expression = [self getExpresionValue];
    _expressionValue.text = _viewData.expression;
    
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DifferSettingType object:nil];
}
















@end
