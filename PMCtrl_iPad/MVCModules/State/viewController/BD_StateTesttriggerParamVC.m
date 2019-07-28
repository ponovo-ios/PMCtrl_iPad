//
//  BD_StateTesttriggerParamVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateTesttriggerParamVC.h"
#import "BD_StateTriggerView.h"
#import "BD_StateTestParamModel.h"
@interface BD_StateTesttriggerParamVC ()
{
    UIScrollView *myScrollView;
}
@end

@implementation BD_StateTesttriggerParamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ClearColor;
    //加载xib视图
    
       _gradientModel = [[BD_StateTestTransmutationDetailModel alloc]init];
    [self setupView];
    [kNotificationCenter addObserver:self selector:@selector(testItemIsDirectCurrent:) name:BD_IsCocurrentNoti object:nil];
}

- (void)setupView{
    //加载xib
    BD_StateTriggerView *parametersV = [[[NSBundle mainBundle] loadNibNamed:@"BD_StateTriggerView" owner:nil options:nil] lastObject];

    //xib设置
    
    [parametersV.nTrigerTypeBtn setTitle:@"时间触发" forState:UIControlStateNormal];

    parametersV.nTrigerLogic.selectedSegmentIndex = [self.dataModel.TriggerLogic intValue];

    int time = [self.dataModel.TriggerTime intValue];

    parametersV.nTirgerTime.text = [NSString stringWithFormat:@"%d",time];

    parametersV.BA.on = [self.dataModel.BArr[0] intValue];
    parametersV.BB.on = [self.dataModel.BArr[1]intValue];
    parametersV.BC.on = [self.dataModel.BArr[2] intValue];
    parametersV.BD.on = [self.dataModel.BArr[3] intValue];
    parametersV.BE.on = [self.dataModel.BArr[4] intValue];
    parametersV.BF.on = [self.dataModel.BArr[5] intValue];
    parametersV.BG.on = [self.dataModel.BArr[6] intValue];
    parametersV.BH.on = [self.dataModel.BArr[7] intValue];
    parametersV.BI.on = [self.dataModel.BArr[8] intValue];
    parametersV.BJ.on = [self.dataModel.BArr[9] intValue];

    parametersV.Bo01.on = ![self.dataModel.BoArr[0] intValue];
    parametersV.Bo02.on = ![self.dataModel.BoArr[1] intValue];
    parametersV.Bo03.on = ![self.dataModel.BoArr[2] intValue];
    parametersV.Bo04.on = ![self.dataModel.BoArr[3] intValue];
    parametersV.Bo05.on = ![self.dataModel.BoArr[4] intValue];
    parametersV.Bo06.on = ![self.dataModel.BoArr[5] intValue];
    parametersV.Bo07.on = ![self.dataModel.BoArr[6] intValue];
    parametersV.Bo08.on = ![self.dataModel.BoArr[7] intValue];

   // 0: 手动触发 1:时间触发单位ms 2:开入变位触发 3:GPS触发 4:开关量或时间触发 5:低电压触发
    int selectedSegment =  [self.dataModel.TriggerType intValue];
    NSLog(@"selectedSegment:%d",selectedSegment);
    switch (selectedSegment) {
        case 0:
            [[BD_Utils shared]setViewState:NO view:parametersV.nTirgerTime];
//            parametersV.nTrigerLogic.userInteractionEnabled = NO;
//            parametersV.binaryInV.userInteractionEnabled = NO;
//            parametersV.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:NO control:parametersV.nTrigerLogic];
            [[BD_Utils shared]setViewState:NO view:parametersV.binaryInV];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:parametersV.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:NO view:parametersV.delayTimeTF];
            break;
        case 1:
            [[BD_Utils shared]setViewState:YES view:parametersV.nTirgerTime];
//            parametersV.nTrigerLogic.userInteractionEnabled = NO;
//            parametersV.binaryInV.userInteractionEnabled = NO;
//            parametersV.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:NO control:parametersV.nTrigerLogic];
            [[BD_Utils shared]setViewState:NO view:parametersV.binaryInV];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:parametersV.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:NO view:parametersV.delayTimeTF];
            break;
        case 2:
            [[BD_Utils shared]setViewState:NO view:parametersV.nTirgerTime];
//            parametersV.nTrigerLogic.userInteractionEnabled = YES;
//            parametersV.binaryInV.userInteractionEnabled = YES;
//            parametersV.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:YES control:parametersV.nTrigerLogic];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryInV];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:parametersV.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:YES view:parametersV.delayTimeTF];
            break;
        case 3:
            [[BD_Utils shared]setViewState:NO view:parametersV.nTirgerTime];
//            parametersV.nTrigerLogic.userInteractionEnabled = NO;
//            parametersV.binaryInV.userInteractionEnabled = NO;
//            parametersV.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:NO control:parametersV.nTrigerLogic];
            [[BD_Utils shared]setViewState:NO view:parametersV.binaryInV];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryOutV];
            [[BD_Utils shared]setViewState:YES view:parametersV.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:NO view:parametersV.delayTimeTF];
            break;
        case 4:
            [[BD_Utils shared]setViewState:YES view:parametersV.nTirgerTime];
//            parametersV.nTrigerLogic.userInteractionEnabled = YES;
//            parametersV.binaryInV.userInteractionEnabled = YES;
//            parametersV.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:YES control:parametersV.nTrigerLogic];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryInV];
            [[BD_Utils shared]setViewState:YES view:parametersV.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:parametersV.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:YES view:parametersV.delayTimeTF];
            break;
        default:
            break;
    }
    parametersV.transmutationView.userInteractionEnabled = YES;

    self.trigView = parametersV;

    WeakSelf;
    self.trigView.endEditViewBlock = ^{
        [weakself blockBackParamData];
    };
    //设置scrollView
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    myScrollView.backgroundColor = ClearColor;
    myScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    myScrollView.bounces = NO;
    //设置xib大小
    self.trigView.frame = CGRectMake(0,0, myScrollView.width, myScrollView.contentSize.height);
    
   

    [self.view addSubview:myScrollView];
    [myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        [make centerXWithinMargins];
    }];
    //加载
        [myScrollView addSubview:self.trigView];
    
}

-(void)setTirggerViewData{

    [self.trigView.nTrigerTypeBtn setTitle:[StateTriggerTypeStrs objectAtIndex:[self.dataModel.TriggerType intValue]] forState:UIControlStateNormal];

    self.trigView.nTrigerLogic.selectedSegmentIndex = [self.dataModel.TriggerLogic intValue];

    int time = [self.dataModel.TriggerTime intValue];

    self.trigView.nTirgerTime.text = [NSString stringWithFormat:@"%d",time];

    self.trigView.BA.on = [self.dataModel.BArr[0] intValue];
    self.trigView.BB.on = [self.dataModel.BArr[1]intValue];
    self.trigView.BC.on = [self.dataModel.BArr[2] intValue];
    self.trigView.BD.on = [self.dataModel.BArr[3] intValue];
    self.trigView.BE.on = [self.dataModel.BArr[4] intValue];
    self.trigView.BF.on = [self.dataModel.BArr[5] intValue];
    self.trigView.BG.on = [self.dataModel.BArr[6] intValue];
    self.trigView.BH.on = [self.dataModel.BArr[7] intValue];
    self.trigView.BI.on = [self.dataModel.BArr[8] intValue];
    self.trigView.BJ.on = [self.dataModel.BArr[9] intValue];

    self.trigView.Bo01.on = ![self.dataModel.BoArr[0] intValue];
    self.trigView.Bo02.on = ![self.dataModel.BoArr[1] intValue];
    self.trigView.Bo03.on = ![self.dataModel.BoArr[2] intValue];
    self.trigView.Bo04.on = ![self.dataModel.BoArr[3] intValue];
    self.trigView.Bo05.on = ![self.dataModel.BoArr[4] intValue];
    self.trigView.Bo06.on = ![self.dataModel.BoArr[5] intValue];
    self.trigView.Bo07.on = ![self.dataModel.BoArr[6] intValue];
    self.trigView.Bo08.on = ![self.dataModel.BoArr[7] intValue];

    self.trigView.triggerMomentPickerBtn.titleLabel.text = self.dataModel.Gpstime;
    self.trigView.delayTimeTF.text = kTStrings([self.dataModel.trigerHoldTime floatValue]);
    self.trigView.dfBtn.selected = self.dataModel.isdfdt;//是否df/dt
    self.trigView.dvBtn.selected = self.dataModel.isdvdt ;//是否dv/dt
    self.trigView.transmutationBtn.selected = self.dataModel.isComGradient ;//普通递变
    self.trigView.holdTimeBtn.selected = self.dataModel.isBinaryOutStateInvert;//是否开出状态反转
    self.trigView.holdTimeTF.text =  kTStrings([self.dataModel.binaryOutStateInvertHoldTime floatValue]);
    
    //态递变设置是否可用
    if (self.dataModel.isdfdt || self.dataModel.isdvdt || self.dataModel.isComGradient) {
        [self.trigView setTransmutationUserInteractionState:YES];
    } else {
        [self.trigView setTransmutationUserInteractionState:NO];
    }
    
    //初始状态保持时间是否可用
    if (self.dataModel.isBinaryOutStateInvert) {
          [self.trigView setHoldTimeUserInteractionState:YES];
    } else {
          [self.trigView setHoldTimeUserInteractionState:NO];
    }
  
    
    int selectedSegment =  [self.dataModel.TriggerType intValue];

    NSLog(@"selectedSegment:%d",selectedSegment);
    switch (selectedSegment) {
        case 0:
            [[BD_Utils shared]setViewState:NO view:self.trigView.nTirgerTime];
//            self.trigView.nTrigerLogic.userInteractionEnabled = NO;
//            self.trigView.binaryInV.userInteractionEnabled = NO;
//            self.trigView.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:NO control:self.trigView.nTrigerLogic];
            [[BD_Utils shared]setViewState:NO view:self.trigView.binaryInV];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:self.trigView.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:NO view:self.trigView.delayTimeTF];
            break;
        case 1:
            [[BD_Utils shared]setViewState:YES view:self.trigView.nTirgerTime];
//            self.trigView.nTrigerLogic.userInteractionEnabled = NO;
//            self.trigView.binaryInV.userInteractionEnabled = NO;
//            self.trigView.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:NO control:self.trigView.nTrigerLogic];
            [[BD_Utils shared]setViewState:NO view:self.trigView.binaryInV];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:self.trigView.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:NO view:self.trigView.delayTimeTF];
            break;
        case 2:
            [[BD_Utils shared]setViewState:NO view:self.trigView.nTirgerTime];
//            self.trigView.nTrigerLogic.userInteractionEnabled = YES;
//            self.trigView.binaryInV.userInteractionEnabled = YES;
//            self.trigView.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:YES control:self.trigView.nTrigerLogic];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryInV];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:self.trigView.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:YES view:self.trigView.delayTimeTF];
            break;
        case 3:
            [[BD_Utils shared]setViewState:NO view:self.trigView.nTirgerTime];
//            self.trigView.nTrigerLogic.userInteractionEnabled = NO;
//            self.trigView.binaryInV.userInteractionEnabled = NO;
//            self.trigView.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:NO control:self.trigView.nTrigerLogic];
            [[BD_Utils shared]setViewState:NO view:self.trigView.binaryInV];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryOutV];
            [[BD_Utils shared]setViewState:YES view:self.trigView.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:NO view:self.trigView.delayTimeTF];
            break;
        case 4:
            [[BD_Utils shared]setViewState:YES view:self.trigView.nTirgerTime];
//            self.trigView.nTrigerLogic.userInteractionEnabled = YES;
//            self.trigView.binaryInV.userInteractionEnabled = YES;
//            self.trigView.binaryOutV.userInteractionEnabled = YES;
            [[BD_Utils shared]setControlState:YES control:self.trigView.nTrigerLogic];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryInV];
            [[BD_Utils shared]setViewState:YES view:self.trigView.binaryOutV];
            [[BD_Utils shared]setViewState:NO view:self.trigView.triggerMomentPickerBtn];
            [[BD_Utils shared]setViewState:YES view:self.trigView.delayTimeTF];
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)viewWillLayoutSubviews{
    
    myScrollView.contentSize = CGSizeMake(self.view.width,self.view.height*1.5);
    _trigView.frame = CGRectMake(0,0, myScrollView.width, myScrollView.contentSize.height);
  
   
}
-(void)setDataModel:(BD_StateTestTriggerParamModel *)dataModel{
    _dataModel = dataModel;
    [self setTirggerViewData];


}
-(void)setGradientModel:(BD_StateTestTransmutationDetailModel *)gradientModel{
    _gradientModel = gradientModel;
    self.trigView.gradientModel = _gradientModel;
}

-(void)setParamTypeArr:(NSArray *)paramTypeArr{
    _paramTypeArr = paramTypeArr;
    self.trigView.paramTypeArr = _paramTypeArr;
}
#pragma mark - 返回
- (void)blockBackParamData{



    //开入量-->按位权展开  根据开入量按钮的开关的状态值与pow函数相乘
    int krl =
    self.trigView.BA.on *pow(2 ,0) +
    self.trigView.BB.on *pow(2, 1) +
    self.trigView.BC.on *pow(2, 2) +
    self.trigView.BD.on *pow(2, 3) +
    self.trigView.BE.on *pow(2, 4) +
    self.trigView.BF.on *pow(2, 5) +
    self.trigView.BG.on *pow(2, 6) +
    self.trigView.BH.on *pow(2, 7) +
    self.trigView.BI.on *pow(2, 8) +
    self.trigView.BJ.on *pow(2, 9);

    NSLog(@"开入量-->%d",krl);

    //开出量-->按位权展开
    int kcl =
    !self.trigView.Bo01.on *pow(2 ,0) +
    !self.trigView.Bo02.on *pow(2, 1) +
    !self.trigView.Bo03.on *pow(2, 2) +
    !self.trigView.Bo04.on *pow(2, 3) +
    !self.trigView.Bo05.on *pow(2, 4) +
    !self.trigView.Bo06.on *pow(2, 5) +
    !self.trigView.Bo07.on *pow(2, 6) +
    !self.trigView.Bo08.on *pow(2, 7);

   
    self.dataModel.TriggerType = @(self.trigView.triggerTypeIndex);
    self.dataModel.TriggerLogic = @(self.trigView.nTrigerLogic.selectedSegmentIndex);
    self.dataModel.TriggerTime = @([self.trigView.nTirgerTime.text floatValue]);

//    self.dataModel.sGpstime = @0;
//    self.dataModel.nsGpsTime = @0; //GPS时间 hour:minute:second.ns;
    self.dataModel.Gpstime = self.trigView.triggerMomentPickerBtn.titleLabel.text;
    self.dataModel.nBiValide = @(krl);//开入有效位
    self.dataModel.nbinaryout = @(kcl);//开出有效位
    self.dataModel.trigerHoldTime = @([self.trigView.delayTimeTF.text floatValue]);//触发后保持时间
    self.dataModel.isBinaryOutStateInvert = self.trigView.holdTimeBtn.selected;//是否开出状态反转
    self.dataModel.binaryOutStateInvertHoldTime = @([self.trigView.holdTimeTF.text floatValue]);//开出状态翻转保持时间
    self.dataModel.isdfdt = self.trigView.dfBtn.selected;//是否df/dt
    self.dataModel.isdvdt = self.trigView.dvBtn.selected;//是否dv/dt
    self.dataModel.isComGradient = self.trigView.transmutationBtn.selected;//普通递变
    
    self.dataModel.BArr = [(@[@(self.trigView.BA.on),
                              @(self.trigView.BB.on),
                              @(self.trigView.BC.on),
                              @(self.trigView.BD.on),
                              @(self.trigView.BE.on),
                              @(self.trigView.BF.on),
                              @(self.trigView.BG.on),
                              @(self.trigView.BH.on),
                              @(self.trigView.BI.on),
                              @(self.trigView.BJ.on)
                              ])mutableCopy];//开入
    self.dataModel.BoArr = [(@[@(!self.trigView.Bo01.on),
                               @(!self.trigView.Bo02.on),
                               @(!self.trigView.Bo03.on),
                               @(!self.trigView.Bo04.on),
                               @(!self.trigView.Bo05.on),
                               @(!self.trigView.Bo06.on),
                               @(!self.trigView.Bo07.on),
                               @(!self.trigView.Bo08.on)
                               ])mutableCopy];//开出
    self.gradientModel = self.trigView.gradientModel;

}

-(void)testItemIsDirectCurrent:(NSNotification *)noti{
    BOOL isDirect = [((NSNumber *)noti.object) boolValue];
    [[BD_Utils shared]setBtnWithImageState:!isDirect btn:self.trigView.dfBtn];
    if (self.trigView.dfBtn.selected && isDirect &&!self.trigView.dvBtn.selected) {
        [self.trigView setTransmutationUserInteractionState:NO];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"结束编辑");
    [self.view endEditing:YES];
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_IsCocurrentNoti object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
