//
//  BD_DifferActionTimeParamView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferActionTimeParamView.h"
#import "BD_DifferentialTestItemModel.h"
#import "UITextField+Extension.h"
@interface BD_DifferActionTimeParamView()<UITextFieldDelegate>
@end

@implementation BD_DifferActionTimeParamView
-(void)awakeFromNib{
    [super awakeFromNib];
    [_testItemM setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    
    [_testItemFrequency setDefaultSetting];
    [_testItemName setDefaultSetting];
    [_testItemIr setDefaultSetting];
    [_testItemid setDefaultSetting];
    
    [[BD_Utils shared]setViewState:NO view:_testItemName];
    [[BD_Utils shared]setViewState:NO view:_testItemFrequency];
    [[BD_Utils shared]setViewState:NO view:
     _testItemM];
   
    _testItemIr.delegate = self;
    _testItemid.delegate =self;
     [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
    
    _testItemIrLabel.text = @"制动电流(A)";
    _testItemIdLabel.text = @"差动电流(A)";
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BD_DifferentialTestItemParaModel *)viewData{
    if (!_viewData) {
        _viewData = [[BD_DifferentialTestItemParaModel alloc]init];
    }
    return _viewData;
}

-(void)setDataToActionView{
    self.testItemName.text = self.viewData.itemName;
    [self.testItemM setTitle:[self testMIntToString:self.viewData.testPhasorType] forState:UIControlStateNormal];
    self.testItemFrequency.text = self.viewData.frequency;
    self.testItemid.text = self.viewData.Id;
    self.testItemIr.text = self.viewData.Ir;
}


-(NSString *)testMIntToString:(NSString *)value{
    switch ([value integerValue]) {
        case 0:
            return @"A";
            break;
        case 1:
            return @"B";
            break;
        case 2:
            return @"C";
            break;
        case 3:
            return @"ABC";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return  YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
    if ([textField isEqual:_testItemid]) {
        self.viewData.Id = textField.text;
    } else if([textField isEqual:_testItemIr]){
        self.viewData.Ir = textField.text;
    }
}

-(void)changeSettingType:(NSNotification *)noti{
    NSInteger type = [((NSNumber *)noti.object) integerValue];
    switch (type) {
        case 0:
            _testItemIrLabel.text = @"制动电流(A)";
            _testItemIdLabel.text = @"差动电流(A)";
            break;
        case 1:
            _testItemIrLabel.text = @"制动电流(In)";
            _testItemIdLabel.text = @"差动电流(In)";
            break;
        default:
            break;
    }
    
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DifferSettingType object:nil];
}

@end
