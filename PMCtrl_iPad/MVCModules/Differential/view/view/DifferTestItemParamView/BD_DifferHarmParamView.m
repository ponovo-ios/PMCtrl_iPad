//
//  BD_DifferHarmParamView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferHarmParamView.h"
#import "BD_PopListViewManager.h"
#import "BD_DifferentialTestItemModel.h"
#import "UITextField+Extension.h"
@interface BD_DifferHarmParamView()<UITextFieldDelegate>
@end
@implementation BD_DifferHarmParamView
-(void)awakeFromNib{
    [super awakeFromNib];
    [_testItemName setDefaultSetting];
    [_testItemFrequency setDefaultSetting];
    [_testItemPrecision setDefaultSetting];
    [_testItemId setDefaultSetting];
    [_testItemSearchStartValue setDefaultSetting];
    [_testItemSearchEndValue setDefaultSetting];
    
    [_testItemM setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [_harmNum setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    
    [_harmNum addTarget:self action:@selector(harmNumChangedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[BD_Utils shared]setViewState:NO view:_testItemName];
    [[BD_Utils shared]setViewState:NO view:_testItemFrequency];
    [[BD_Utils shared]setViewState:NO view:_testItemPrecision];
    [[BD_Utils shared]setViewState:NO view:
     _testItemM];
    
    _testItemId.delegate = self;
    _testItemSearchStartValue.delegate = self;
    _testItemSearchEndValue.delegate = self;
    [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
    
     _testItemIdLabel.text = @"差动电流(A)";
    
   
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)harmNumChangedAction:(UIButton *)sender{
    WeakSelf;
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"2",@"3",@"5"] textField:sender viewController:[self GetSubordinateControllerForSelf] direction:UIPopoverArrowDirectionDown complete:^(NSString *title) {
        [weakself.harmNum setTitle:title forState:UIControlStateNormal];
        weakself.viewData.nHarm = title;
        weakself.viewData.itemName = [title stringByAppendingString:@"次谐波制动系数"];
        weakself.testItemName.text = weakself.viewData.itemName;
        weakself.changeHarmNumBlock();
    }];
}

-(BD_DifferentialTestItemParaModel *)viewData{
    if (!_viewData) {
        _viewData = [[BD_DifferentialTestItemParaModel alloc]init];
    }
    return _viewData;
}

-(void)setDataToHarmView{
    self.testItemName.text = self.viewData.itemName;
    [self.testItemM setTitle:[self testMIntToString:self.viewData.testPhasorType] forState:UIControlStateNormal];
    self.testItemFrequency.text = self.viewData.frequency;
    [self.harmNum setTitle:self.viewData.nHarm forState:UIControlStateNormal];
    self.testItemPrecision.text = self.viewData.testAccuracy;
    self.testItemId.text = self.viewData.Id;
    self.testItemSearchStartValue.text = self.viewData.searchStart;
    self.testItemSearchEndValue.text = self.viewData.searchEnd;
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
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
  
    if ([textField isEqual:_testItemId]) {
        self.viewData.Id = textField.text;
    } else if ([textField isEqual:_testItemSearchStartValue]){
        self.viewData.searchStart = textField.text;
    } else if ([textField isEqual:_testItemSearchEndValue]){
        self.viewData.searchEnd = textField.text;
    } else {
        
    }
}


-(void)changeSettingType:(NSNotification *)noti{
    NSInteger type = [((NSNumber *)noti.object) integerValue];
    switch (type) {
        case 0:
              _testItemIdLabel.text = @"差动电流(A)";
            break;
        case 1:
            _testItemIdLabel.text = @"差动电流(In)";
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
