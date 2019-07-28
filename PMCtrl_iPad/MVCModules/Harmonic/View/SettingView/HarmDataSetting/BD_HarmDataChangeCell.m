//
//  BD_HarmDataChangeCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataChangeCell.h"
#import "BD_PickerButton.h"
#import "BD_HarmDataSettingModel.h"
#import "UITextField+Extension.h"
@interface BD_HarmDataChangeCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *startTF;
@property (weak, nonatomic) IBOutlet UITextField *endTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet BD_PickerButton *freButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;

@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isAutoSwitch;




@end

@implementation BD_HarmDataChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
    [self.startTF setDefaultSetting];
    [self.endTF setDefaultSetting];
    [self.timeTF setDefaultSetting];
    [self.stepLengthTF setDefaultSetting];
    
    _freButton.backgroundColor = BDThemeColor;
   
    if (!self.dataModel.isAuto) {
        [[BD_Utils shared] setViewState:NO view:self.startTF];
        [[BD_Utils shared] setViewState:NO view:self.endTF];
        [[BD_Utils shared] setViewState:NO view:self.timeTF];
    } else {
        [[BD_Utils shared] setViewState:YES view:self.startTF];
        [[BD_Utils shared] setViewState:YES view:self.endTF];
        [[BD_Utils shared] setViewState:YES view:self.timeTF];
    }
  
    _voltageMax = 120.000;
}

-(void)setDataModel:(BD_HarmDataSettingModel *)dataModel
{
    _dataModel = dataModel;
    //赋值
    self.stepLengthTF.text = dataModel.step;
    self.timeTF.text = dataModel.time;
    self.startTF.text = dataModel.start;
    self.endTF.text = dataModel.end;
    [self.freButton setTitle:dataModel.fre forState:UIControlStateNormal];
    
}

- (IBAction)frequencyBtnClick:(BD_PickerButton *)sender {
    __weak typeof(self) weakSelf = self;
    [sender showPickerViewWithDataArray:@[@"50", @"60"] completion:^(NSString *title) {
        weakSelf.dataModel.fre = title;
        //刷新波形
       [kNotificationCenter postNotificationName:BD_HarmWaveformRefresh object:nil userInfo:nil];
    }];
    
    
}

- (IBAction)autoSwitchClick:(UISwitch *)sender {
    
    self.autoBtnClick(sender.isOn);
    
    if (sender.isOn) {
        [[BD_Utils shared] setViewState:YES view:self.startTF];
        [[BD_Utils shared] setViewState:YES view:self.endTF];
        [[BD_Utils shared] setViewState:YES view:self.timeTF];
    }else{
        [[BD_Utils shared] setViewState:NO view:self.startTF];
        [[BD_Utils shared] setViewState:NO view:self.endTF];
        [[BD_Utils shared] setViewState:NO view:self.timeTF];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSArray *)limitValueArr{
    if ((!_limitValueArr)) {
        _limitValueArr = [[NSArray alloc]init];
    }
    return _limitValueArr;
}

-(void)limitValueChangedSetViewData{
    NSArray<NSNumber *> *newlimitArr = [[BD_Utils shared] buddleSort:self.limitValueArr];
        if (newlimitArr.count!=0) {
            if (self.startTF.text.floatValue>newlimitArr[0].floatValue){
                self.startTF.text = kTStrings(newlimitArr[0].floatValue);
               
            }
            if (self.endTF.text.floatValue>newlimitArr[0].floatValue){
                self.endTF.text = kTStrings(newlimitArr[0].floatValue);
                
            }
            if (self.stepLengthTF.text.floatValue>_voltageMax){
                self.stepLengthTF.text = kTStrings(_voltageMax);       
            }
        }
}
#pragma mark UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray<NSNumber *> *newlimitArr = [[BD_Utils shared] buddleSort:self.limitValueArr];
    if([textField isEqual:self.startTF]||[textField isEqual:self.endTF]){
        if ([self.dataModel.passagewayIndex isEqualToString:@"基波"]) {
            //基波的范围是0---直流最大值
                if (newText.floatValue>_voltageMax){
                    textField.text = kTStrings(_voltageMax);
                    return NO;
                } else if (newText.floatValue<0.000){
                    textField.text = @"0.000";
                    return NO;
                }
            
        } else {
            //谐波的范围是最值-基波的值-叠加直流的值
            if (newlimitArr.count!=0) {
                if (newText.floatValue>newlimitArr[0].floatValue){
                    textField.text = kTStrings(newlimitArr[0].floatValue);
                    return NO;
                } else if (newText.floatValue<0.000){
                    textField.text = @"0.000";
                    return NO;
                }
            }
        }
        
    } else if([textField isEqual:self.timeTF]) {
        if (newText.floatValue>99999){
            textField.text = @"99999.000";
            return NO;
        } else if (newText.floatValue<=0.000){
            textField.text = @"0.001";
            return NO;
        }
    } else if ([textField isEqual:self.stepLengthTF]){
        if (newText.floatValue>_voltageMax){
            textField.text = kTStrings(_voltageMax);
            return NO;
        } else if (newText.floatValue<0.000){
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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    textField.text = [NSString stringWithFormat:@"%.3f", textField.text.floatValue];
    
    switch (textField.tag) {
        case 0:
            self.dataModel.step = textField.text;
            break;
        case 1:
            self.dataModel.time = textField.text;
            break;
        case 2:
            self.dataModel.start = textField.text;
            break;
        case 3:
            self.dataModel.end = textField.text;
            break;
            
        default:
            break;
    }
    
    //向服务器发送数据改变通知
    [kNotificationCenter postNotificationName:BD_HarmSendData object:nil];
}

-(void)changePassageWay:(NSString *)passageWay{
    if ([passageWay hasPrefix:@"U"]) {
        self.stepLabel.text = @"变化步长(V)";
        self.startLabel.text = @"变化始值(V)";
        self.endLabel.text = @"变化终值(V)";
    } else {
        self.stepLabel.text = @"变化步长(A)";
        self.startLabel.text = @"变化始值(A)";
        self.endLabel.text = @"变化终值(A)";
    }
}
@end
