//
//  BD_HarmSystemsParameterView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmSystemsParameterView.h"
#import "BD_PickerButton.h"

@interface BD_HarmSystemsParameterView()<UITextFieldDelegate>
/**<#Description#>*/
@property (nonatomic, weak) UITextField *acVTF;
/**<#Description#>*/
@property (nonatomic, weak) UITextField *acCTF;
/**<#Description#>*/
@property (nonatomic, weak) UITextField *dcVTF;
/**<#Description#>*/
@property (nonatomic, weak) UITextField *dcCTF;
@end

@implementation BD_HarmSystemsParameterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

-(void)configureUI
{
    
    //测试仪类型
    UILabel *typeTitle = [[UILabel alloc] init];
    typeTitle.textColor = [UIColor whiteColor];
    typeTitle.text = @"测试仪类型:";
    [self addSubview:typeTitle];
    [typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-100);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(40);
    }];
    
    BD_PickerButton *typeBtn = [BD_PickerButton buttonWithType:UIButtonTypeCustom];
    [typeBtn setTitle:@"模拟" forState:UIControlStateNormal];
    typeBtn.layer.cornerRadius = 5;
    typeBtn.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:typeBtn];
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(100);
        make.centerY.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
    }];
    [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //通道选择
    UILabel *passagewayTitle = [[UILabel alloc] init];
    passagewayTitle.textColor = [UIColor whiteColor];
    passagewayTitle.text = @"通道选择:";
    [self addSubview:passagewayTitle];
    [passagewayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(typeTitle.mas_bottom).offset(40);
    }];
    
    BD_PickerButton *passagewayBtn = [BD_PickerButton buttonWithType:UIButtonTypeCustom];
    [passagewayBtn setTitle:@"4U3I" forState:UIControlStateNormal];
    passagewayBtn.layer.cornerRadius = 5;
    passagewayBtn.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:passagewayBtn];
    [passagewayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(100);
        make.centerY.mas_equalTo(passagewayTitle);
        make.width.mas_equalTo(100);
    }];
    [passagewayBtn addTarget:self action:@selector(passagewayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //输出限制
    UILabel *putoutTitle = [[UILabel alloc] init];
    putoutTitle.textColor = [UIColor whiteColor];
    putoutTitle.text = @"输出限制:";
    [self addSubview:putoutTitle];
    [putoutTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(passagewayTitle.mas_bottom).offset(40);
    }];
    
    UILabel *acVTitle = [[UILabel alloc] init];
    acVTitle.textColor = [UIColor whiteColor];
    acVTitle.text = @"交流电压(V):";
    [self addSubview:acVTitle];
    [acVTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(putoutTitle.mas_bottom).offset(40);
    }];
    
    UITextField *acVTF = [[UITextField alloc] init];
    acVTF.tag = 0;
    acVTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    acVTF.borderStyle = UITextBorderStyleRoundedRect;
    acVTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    acVTF.delegate = self;
    [self addSubview:acVTF];
    [acVTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(typeBtn);
        make.centerX.mas_equalTo(typeBtn);
        make.centerY.mas_equalTo(acVTitle);
    }];
    self.acVTF = acVTF;
    
    UILabel *acCTitle = [[UILabel alloc] init];
    acCTitle.textColor = [UIColor whiteColor];
    acCTitle.text = @"交流电流(A):";
    [self addSubview:acCTitle];
    [acCTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(acVTitle.mas_bottom).offset(40);
    }];
    
    UITextField *acCTF = [[UITextField alloc] init];
    acCTF.tag = 1;
    acCTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    acCTF.borderStyle = UITextBorderStyleRoundedRect;
    acCTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    acCTF.delegate = self;
    [self addSubview:acCTF];
    [acCTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(typeBtn);
        make.centerX.mas_equalTo(typeBtn);
        make.centerY.mas_equalTo(acCTitle);
    }];
    self.acCTF = acCTF;
    
    UILabel *dcVTitle = [[UILabel alloc] init];
    dcVTitle.textColor = [UIColor whiteColor];
    dcVTitle.text = @"直流电压(V):";
    [self addSubview:dcVTitle];
    [dcVTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(acCTitle.mas_bottom).offset(40);
    }];
    
    UITextField *dcVTF = [[UITextField alloc] init];
    dcVTF.tag = 2;
    dcVTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    dcVTF.borderStyle = UITextBorderStyleRoundedRect;
    dcVTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    dcVTF.delegate = self;
    [self addSubview:dcVTF];
    [dcVTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(typeBtn);
        make.centerX.mas_equalTo(typeBtn);
        make.centerY.mas_equalTo(dcVTitle);
    }];
    self.dcVTF = dcVTF;
    
    UILabel *dcCTitle = [[UILabel alloc] init];
    dcCTitle.textColor = [UIColor whiteColor];
    dcCTitle.text = @"直流电流(A):";
    [self addSubview:dcCTitle];
    [dcCTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeTitle);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(dcVTitle.mas_bottom).offset(40);
    }];
    
    UITextField *dcCTF = [[UITextField alloc] init];
    dcCTF.tag = 3;
    dcCTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    dcCTF.borderStyle = UITextBorderStyleRoundedRect;
    dcCTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    dcCTF.delegate = self;
    [self addSubview:dcCTF];
    [dcCTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(typeBtn);
        make.centerX.mas_equalTo(typeBtn);
        make.centerY.mas_equalTo(dcCTitle);
    }];
    self.dcCTF = dcCTF;
}

-(void)setParamsModel:(BD_HarmParamsSettingModel *)paramsModel
{
    _paramsModel = paramsModel;
    
    self.acVTF.text = paramsModel.acVoltage;
    self.acCTF.text = paramsModel.acCurrent;
    self.dcVTF.text = paramsModel.dcVoltage;
    self.dcCTF.text = paramsModel.dcCurrent;
}

-(void)typeBtnClick:(BD_PickerButton *)sender
{

    __weak typeof(self) weakSelf = self;
    [sender showPickerViewWithDataArray:@[@"模拟", @"数字"] completion:^(NSString *title){
        weakSelf.paramsModel.type = sender.titleLabel.text;
        [weakSelf.delegate changedType:weakSelf.paramsModel.type passageway:weakSelf.paramsModel.channelSelection];
    }];

}

-(void)passagewayBtnClick:(BD_PickerButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [sender showPickerViewWithDataArray:@[@"4U3I", @"6U6I"] completion:^(NSString *title){
        weakSelf.paramsModel.channelSelection = sender.titleLabel.text;
        [weakSelf.delegate changedType:weakSelf.paramsModel.type passageway:weakSelf.paramsModel.channelSelection];
    }];
    
}

#pragma mark UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.paramsModel.acVoltage = textField.text;
            break;
        case 1:
            self.paramsModel.acCurrent = textField.text;
            break;
        case 2:
            self.paramsModel.dcVoltage = textField.text;
            break;
        case 3:
            self.paramsModel.dcCurrent = textField.text;
            break;
            
        default:
            break;
    }
}

@end
