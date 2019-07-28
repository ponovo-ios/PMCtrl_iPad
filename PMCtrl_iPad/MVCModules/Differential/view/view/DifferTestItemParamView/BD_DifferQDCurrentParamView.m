//
//  BD_DifferQDCurrentParamView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferQDCurrentParamView.h"
#import "BD_DifferentialTestItemModel.h"
#import "BD_DifferIrCaculateManager.h"
#import "UITextField+Extension.h"
@interface BD_DifferQDCurrentParamView()<UITextFieldDelegate>

@end

@implementation BD_DifferQDCurrentParamView

-(void)awakeFromNib{
    [super awakeFromNib];
    [_testItemName setDefaultSetting];
    [_testItemFrequency setDefaultSetting];
    [_testItemPrecision setDefaultSetting];
    [_testItemIr setDefaultSetting];
    [_testItemUp setDefaultSetting];
    [_testItemDown setDefaultSetting];
    
    [_testItemM setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [_testItemType setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [[BD_Utils shared]setViewState:NO view:_testItemName];
    [[BD_Utils shared]setViewState:NO view:_testItemFrequency];
    [[BD_Utils shared]setViewState:NO view:_testItemPrecision];
   [[BD_Utils shared]setViewState:NO view:
    _testItemM];
    [[BD_Utils shared]setViewState:NO view:
     _testItemType];
    _testItemIr.delegate = self;
    _testItemUp.delegate = self;
    _testItemDown.delegate = self;
    [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
  
    _testItemPrecisionLabel.text = @"测试精度(A)";
    _testItemIrLabel.text = @"制动电流(A)";
    _testItemUpLabel.text = @"搜索上限(A)";
    _testItemDownLabel.text = @"搜索下限(A)";

   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
-(BD_DifferentialTestItemParaModel *)viewData{
    if (!_viewData) {
        _viewData = [[BD_DifferentialTestItemParaModel alloc]init];
    }
    return _viewData;
}
-(void)setDataToQDCurrentView{
    
    self.testItemName.text = self.viewData.itemName;
    [self.testItemM setTitle:[self testMIntToString:self.viewData.testPhasorType] forState:UIControlStateNormal];
    self.testItemFrequency.text = self.viewData.frequency;
    if ([self.viewData.itemName hasPrefix:@"I"]) {
         [self.testItemType setTitle:@"无" forState:UIControlStateNormal];
    }
    
    [self.testItemType setTitle:[[BD_Utils shared] diffTestTypeToStr:self.viewData.itemType] forState:UIControlStateNormal];
    self.testItemPrecision.text = self.viewData.testAccuracy;
    self.testItemIr.text = self.viewData.Ir;
    
    self.testItemUp.text = self.viewData.fUp;
    self.testItemDown.text = self.viewData.fDown;
    
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
    if ([textField isEqual:_testItemIr]) {
        self.viewData.Ir = textField.text;
        [[BD_DifferIrCaculateManager shared]caculateUpDownData:self.viewData];
        _testItemUp.text = self.viewData.fUp;
        _testItemDown.text = self.viewData.fDown;
    } else if ([textField isEqual:_testItemUp]){
        self.viewData.fUp = textField.text;
    } else if ([textField isEqual:_testItemDown]){
        self.viewData.fDown = textField.text;
    } else {
        
    }
}

-(void)changeSettingType:(NSNotification *)noti{
    NSInteger type = [((NSNumber *)noti.object) integerValue];
    switch (type) {
        case 0:
            _testItemPrecisionLabel.text = @"测试精度(A)";
            _testItemIrLabel.text = @"制动电流(A)";
            _testItemUpLabel.text = @"搜索上限(A)";
            _testItemDownLabel.text = @"搜索下限(A)";
            
            break;
        case 1:
            _testItemPrecisionLabel.text = @"测试精度(In)";
            _testItemIrLabel.text = @"制动电流(In)";
            _testItemUpLabel.text = @"搜索上限(In)";
            _testItemDownLabel.text = @"搜索下限(In)";
            break;
        default:
            break;
    }
    
}
-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DifferSettingType object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
