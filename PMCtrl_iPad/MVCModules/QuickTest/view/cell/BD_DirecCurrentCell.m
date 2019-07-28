//
//  BD_DirecCurrentCell.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/2/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DirecCurrentCell.h"
#import "UITextField+Extension.h"
@interface  BD_DirecCurrentCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *contenterView;


@end

@implementation BD_DirecCurrentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = MainBgColor;
    self.contentView.backgroundColor = ClearColor;
    

    
    [_contenterView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_contenterView setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    [_DCStartOutBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    
    [_DCStopOutBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    _DCTitle.text = @"直流大小(V):";
    _DCTextField.text = @"220.000";
    [_DCTextField setDefaultSetting];
    _DCTextField.delegate = self;
    [[BD_Utils shared]setViewState:YES view:_DCStartOutBtn];
    [[BD_Utils shared]setViewState:NO view:_DCStopOutBtn];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)startOut:(id)sender {
    
   //开始输出
    BOOL isSuccess = [[OCCenter shareCenter] directCurrentSetActionIsStart:YES dirCurrentValue:[_DCTextField.text floatValue]];
    if (isSuccess) {
        [[BD_Utils shared]setViewState:NO view:_DCStartOutBtn];
        [[BD_Utils shared]setViewState:YES view:_DCStartOutBtn];
        [MBProgressHUDUtil showMessage:@"开始辅助直流请求发送成功!" toView:self];
    } else {
        [MBProgressHUDUtil showMessage:@"开始辅助直流请求发送失败，请确认网络连接是否正确!" toView:self];
    }
}

- (IBAction)stopOut:(id)sender {
    
    //停止输出
    BOOL isSuccess = [[OCCenter shareCenter] directCurrentSetActionIsStart:NO dirCurrentValue:[_DCTextField.text floatValue]];
    if (isSuccess) {
        [[BD_Utils shared]setViewState:YES view:_DCStartOutBtn];
        [[BD_Utils shared]setViewState:NO view:_DCStopOutBtn];
        [MBProgressHUDUtil showMessage:@"停止辅助直流请求发送成功!" toView:self];
    } else {
        [MBProgressHUDUtil showMessage:@"停止辅助直流请求发送失败，请确认网络连接是否正确!" toView:self];
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
//        return [[BD_Utils shared]validateNumber:string];
        return YES;
    }
    
}
@end
