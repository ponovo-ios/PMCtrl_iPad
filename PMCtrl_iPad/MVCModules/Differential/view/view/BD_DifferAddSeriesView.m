//
//  BD_DifferAddSeriesView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/20.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferAddSeriesView.h"
#import "UITextField+Extension.h"
@interface BD_DifferAddSeriesView()<UITextFieldDelegate>
{
    NSString *exchangeCurrentLimit;
}
@property(nonatomic,weak)UITextField *startTF;
@property(nonatomic,weak)UITextField *endTF;
@property(nonatomic,weak)UITextField *stepTF;
@property(nonatomic,weak)UITextField *testItemNumTF;
@property(nonatomic,weak)UILabel *startLabel;
@property(nonatomic,weak)UILabel *endLabel;
@property(nonatomic,weak)UILabel *stepLabel;
@property(nonatomic,weak)UIView *mainView;
@end

@implementation BD_DifferAddSeriesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
        exchangeCurrentLimit = @"20.000";
          [kNotificationCenter addObserver:self selector:@selector(exchangeCurLimitChanged:) name:BD_OutPutLimitNotifi object:nil];
          [kNotificationCenter addObserver:self selector:@selector(changeSettingType:) name:BD_DifferSettingType object:nil];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)loadSubViews{
    WeakSelf;
    self.backgroundColor = [Black colorWithAlphaComponent:0.5];
    UIView *mainView = [[UIView alloc]init];
    mainView.center  = self.center;
    mainView.backgroundColor = BDThemeColor;
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.centerX.mas_equalTo(weakself.mas_centerX);
        make.centerY.mas_equalTo(weakself.mas_centerY);
    }];
    self.mainView = mainView;
    
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"添加系列";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = White;
    [_mainView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(10);
    }];
    
    UILabel *title1 = [[UILabel alloc]init];
    title1.text = @"变化始值(A)";
    title1.textColor = White;
    self.startLabel = title1;
    UITextField *value1 = [[UITextField alloc]init];
    value1.textColor = White;
    [value1 setCorenerRadius:6.0 borderColor:[UIColor darkGrayColor] borderWidth:1.0];
    value1.delegate = self;
    
    UILabel *title2 = [[UILabel alloc]init];
    title2.text = @"变化终值(A)";
    title2.textColor = White;
    self.endLabel = title2;
    UITextField *value2 = [[UITextField alloc]init];
    value2.textColor = White;
    [value2 setCorenerRadius:6.0 borderColor:[UIColor darkGrayColor] borderWidth:1.0];
    value2.delegate = self;
    
    UILabel *title3 = [[UILabel alloc]init];
    title3.text = @"变化步长(A)";
    title3.textColor = White;
    self.stepLabel = title3;
    UITextField *value3 = [[UITextField alloc]init];
    value3.textColor = White;
    [value3 setCorenerRadius:6.0 borderColor:[UIColor darkGrayColor] borderWidth:1.0];
    value3.delegate = self;
    
    UILabel *title4 = [[UILabel alloc]init];
    title4.text = @"测试点:";
    title4.textColor = White;
    UITextField *value4 = [[UITextField alloc]init];
    value4.textColor = [UIColor lightGrayColor];
    [value4 setCorenerRadius:6.0 borderColor:[UIColor darkGrayColor] borderWidth:1.0];
    value4.userInteractionEnabled = NO;
    value4.delegate = self;
    
    
    [_mainView addSubview:title1];
    [_mainView addSubview:value1];
    [_mainView addSubview:title2];
    [_mainView addSubview:value2];
    [_mainView addSubview:title3];
    [_mainView addSubview:value3];
    [_mainView addSubview:title4];
    [_mainView addSubview:value4];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(title.mas_bottom).offset(10);
    }];
    [value1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title1.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(title1);
        make.top.mas_equalTo(title.mas_bottom).offset(10);
    }];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(title1.mas_bottom).offset(10);
    }];
    [value2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title2.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(title2);
        make.top.mas_equalTo(title1.mas_bottom).offset(10);
    }];
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(title2.mas_bottom).offset(10);
    }];
    [value3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title3.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(title3);
        make.top.mas_equalTo(title2.mas_bottom).offset(10);
    }];
    [title4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(title3.mas_bottom).offset(10);
    }];
    [value4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title4.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(title4);
        make.top.mas_equalTo(title3.mas_bottom).offset(10);
    }];
    
    _startTF = value1;
    _endTF = value2;
    _stepTF = value3;
    _testItemNumTF = value4;
  
    _startTF.text = @"1.000";
    _endTF.text = @"5.000";
    _stepTF.text = @"1.000";
    _testItemNumTF.text = @"5";
    
    [_startTF setDefaultSetting];
    [_endTF setDefaultSetting];
    [_stepTF setDefaultSetting];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainView addSubview:okBtn];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    cancelBtn.tag = 102;
    [cancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    
}

-(void)showAddSeriesView{
    WeakSelf;
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [weakself.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_HEIGHT*0.5);
            make.height.mas_equalTo(SCREEN_HEIGHT*0.5);
        }];
        [weakself.mainView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeAddSeriesView{
    WeakSelf;
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        
        [weakself.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        [weakself.mainView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
//        [weakself.mainView removeFromSuperview];
        [weakself removeFromSuperview];
    }];
}
-(void)buttonAction:(UIButton *)sender{
    if (sender.tag == 101) {
        //确定
        if (self.okActionBlock) {
            self.okActionBlock([self.startTF.text floatValue], [self.endTF.text floatValue], [self.stepTF.text floatValue], [self.testItemNumTF.text intValue]);
        }
        [self closeAddSeriesView];
    } else {
        //取消
        [self closeAddSeriesView];
    }
}

-(void)exchangeCurLimitChanged:(NSNotification *)noti{
    BD_HardwarkConfigModel *hardworakModel = (BD_HardwarkConfigModel *)noti.object;
    exchangeCurrentLimit = hardworakModel.exchangeCurrent;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
#pragma mark - textField delegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ( newText.floatValue>[exchangeCurrentLimit floatValue]) {
        textField.text = exchangeCurrentLimit;
        return  NO;
    } else if (newText.floatValue<0.000){
        textField.text = @"0.000";
        return  NO;
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return  YES;
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    self.testItemNumTF.text = [self caculateTestNum];
}


-(NSString *)caculateTestNum{
    double startToEnd = fabs([self.startTF.text floatValue]-[self.endTF.text floatValue]);
    float value = floor([self.stepTF.text floatValue]*1000)/1000;
    int num = floor(startToEnd/value);
    return [NSString stringWithFormat:@"%d",num+1];
}
-(void)changeSettingType:(NSNotification *)noti{
    NSInteger type = [((NSNumber *)noti.object) integerValue];
    switch (type) {
        case 0:
             self.startLabel.text = @"变化始值(A)";
             self.endLabel.text = @"变化终值(A)";
             self.stepLabel.text = @"变化步长(A)";
            
            break;
        case 1:
            self.startLabel.text = @"变化始值(In)";
            self.endLabel.text = @"变化终值(In)";
            self.stepLabel.text = @"变化步长(In)";
            break;
        default:
            break;
    }
    
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_OutPutLimitNotifi object:nil];
     [kNotificationCenter removeObserver:self name:BD_DifferSettingType object:nil];
}

@end
