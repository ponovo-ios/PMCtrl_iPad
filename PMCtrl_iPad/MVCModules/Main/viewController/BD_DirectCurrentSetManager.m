//
//  BD_DirectCurrentSetManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DirectCurrentSetManager.h"
#import "UITextField+Extension.h"
@interface BD_DirectCurrentSetManager()<UITextFieldDelegate>
@property(nonatomic,strong) UIAlertController *directAlert;
@property(nonatomic,strong) UIViewController *presentVC;
@property(nonatomic,strong)UIAlertAction *startAction;
@property(nonatomic,strong)UIAlertAction *stopAction;
@property(nonatomic,weak)UITextField *dcTextField;
@end

@implementation BD_DirectCurrentSetManager

-(instancetype)initWithVC:(UIViewController *)vc{
    if (self = [super init]) {
        _presentVC = vc;
        _dcCurrentValue = 220.000;
        _directAlert= [UIAlertController alertControllerWithTitle:@"直流设置" message:@"\n\n" preferredStyle:UIAlertControllerStyleAlert];
        UILabel *title = [[UILabel alloc]init];
        title.text = @"直流大小(V)";
        title.frame = CGRectMake(10,50, 100, 35);
        UITextField *value = [[UITextField alloc]init];
        value.frame = CGRectMake(title.right+5,50,130, 35);
        value.text = kTStrings(_dcCurrentValue);
        value.clearButtonMode = UITextFieldViewModeWhileEditing;
        [value setCorenerRadius:6.0 borderColor:[UIColor darkGrayColor] borderWidth:1.0];
        value.delegate = self;
        _dcTextField = value;
        [_directAlert.view addSubview:title];
        [_directAlert.view addSubview:value];
        WeakSelf;
        UIAlertAction *startAction = [UIAlertAction actionWithTitle:@"输出开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self startOutputWithAmplitude:[value.text floatValue]];
               weakself.dcCurrentValue = [weakself.dcTextField.text floatValue];
        }];
        self.startAction = startAction;
        self.startAction.enabled = YES;
        
        
        [_directAlert addAction:startAction];
        
        UIAlertAction *stopAction =[UIAlertAction actionWithTitle:@"输出停止" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self stopOutputWithAmplitued:[value.text floatValue]];
             weakself.dcCurrentValue = [weakself.dcTextField.text floatValue];
        }];
        self.stopAction = stopAction;
        self.stopAction.enabled = NO;
        
        [_directAlert addAction:stopAction];
        [_directAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
    return self;
}

-(void)showDirectCurrentView{
    self.dcTextField.text = kTStrings(_dcCurrentValue);
    if (self.dcTextField.text.floatValue==0) {
        self.startAction.enabled = YES;
        self.stopAction.enabled = NO;
    }
    [_presentVC presentViewController:_directAlert animated:YES completion:^{
        
    }];
    
}

//开始输出
-(void)startOutputWithAmplitude:(CGFloat)amplitude{
    
    BOOL isSuccess = [[OCCenter shareCenter] directCurrentSetActionIsStart:YES dirCurrentValue:amplitude];
    if (isSuccess) {
        self.startAction.enabled = NO;
        self.stopAction.enabled = YES;
       
        
            [MBProgressHUDUtil showMessage:@"开始辅助直流请求发送成功!" toView:_presentVC.view];
        if (amplitude!=0.000) {
            [kNotificationCenter postNotificationName:BD_DirectCurrStart object:nil];
        }
        
       
       
    } else {
       [MBProgressHUDUtil showMessage:@"开始辅助直流请求发送失败，请确认网络连接是否正确!" toView:_presentVC.view];
    }
}

//停止输出
-(void)stopOutputWithAmplitued:( CGFloat)amplitude{
   BOOL isSuccess = [[OCCenter shareCenter] directCurrentSetActionIsStart:NO dirCurrentValue:amplitude];
    if (isSuccess) {
        self.startAction.enabled = YES;
        self.stopAction.enabled = NO;
            [MBProgressHUDUtil showMessage:@"停止辅助直流请求发送成功!" toView:_presentVC.view];
            [kNotificationCenter postNotificationName:BD_DirectCurrStop object:nil];
     
        
    } else {
        [MBProgressHUDUtil showMessage:@"停止辅助直流请求发送失败，请确认网络连接是否正确!" toView:_presentVC.view];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

   
     NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ( newText.floatValue>_dcCurrentMax) {
        textField.text = kTStrings(_dcCurrentMax);
        return  NO;
    } else if (newText.floatValue<0){
        textField.text = @"0.000";
        return  NO;
    }
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:_directAlert.view];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
 
}
@end
