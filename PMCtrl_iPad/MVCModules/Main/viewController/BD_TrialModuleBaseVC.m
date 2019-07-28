//
//  BD_TrialModuleBaseVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TrialModuleBaseVC.h"
#import "BD_PopListViewManager.h"
#import "BD_IECTabBarVC.h"
#import "BD_DirectCurrentSetManager.h"
#import "BD_HardwarkConfigModel.h"
#import "BD_HardwareConfigView.h"
#import "BD_SysParaModel.h"
#import "BD_BinarySwitchView.h"
#import "BD_RunLightAnimationManager.h"
@interface BD_TrialModuleBaseVC ()<BD_HardwareConfitDelegate>
//硬件配置遮罩
@property (nonatomic,strong)UIView *markView;
/**开关量设置*/
@property(nonatomic,assign)NSInteger *hardViewShowNum;
@end

@implementation BD_TrialModuleBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _markView = [[UIView alloc]initWithFrame:self.view.bounds];
    _markView.backgroundColor = [Black colorWithAlphaComponent:0.5];
    _hardWareView = [[NSBundle mainBundle]loadNibNamed:@"BD_HardwareConfigView" owner:nil options:nil].lastObject;
    WeakSelf;
    _hardWareView.hardwareConfigComplete = ^(BD_HardwarkConfigModel *hard) {
        
        weakself.hardwarkSetData = hard;
        [weakself deviceSettingFinised:hard];
        [weakself disMissHardwareView];
    };
    _hardWareView.frame = CGRectZero;
    _hardWareView.layer.cornerRadius = 10;
    _hardWareView.layer.masksToBounds = YES;
    _hardWareView.center = _markView.center;
    _hardWareView.dissdelegate = self;
    _hardViewShowNum = 0;
    [_markView addSubview:self.hardWareView];
    [self readDeviceInfoFromService];
    
    
    [kNotificationCenter addObserver:self selector:@selector(refreshDCStart:) name:BD_DirectCurrStart object:nil];
    [kNotificationCenter addObserver:self selector:@selector(refreshDCStop:) name:BD_DirectCurrStop object:nil];
    [kNotificationCenter addObserver:self selector:@selector(netWordDisconnectToStop:) name:BD_NewWordDisconnect object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BD_HardwarkConfigModel *)hardwarkSetData{
    if (!_hardwarkSetData) {
        _hardwarkSetData = [[BD_HardwarkConfigModel init]init];
        _hardwarkSetData.deviceType = BDDeviceType_Imitate;
        _hardwarkSetData.currentPassNum = 3;
        _hardwarkSetData.voltagePassNum = 3;
        _hardwarkSetData.exchangeCurrent = @"0";
        _hardwarkSetData.exchangeVoltage = @"0";
        _hardwarkSetData.directVoltage = @"0";
        _hardwarkSetData.directCurrent = @"0";
    }
    return _hardwarkSetData;
}


-(void)showDeviceConfig{
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.markView];
    if (self.hardWareView.moduletype == BD_TestModuleType_Diff) {
        if (_hardViewShowNum==0) {
             [self.hardWareView SUSUViewConfig];
        }
        _hardViewShowNum++;
    } else if (self.hardWareView.moduletype == BD_TestModuleType_Harm){
        if (_hardViewShowNum==0) {
             [self.hardWareView SixUIViewConfig];
        }
        _hardViewShowNum++;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        _hardWareView.frame = CGRectMake(0, 0, self.view.width*0.7,self.view.height*0.9);
        _hardWareView.center = _markView.center;
    } completion:^(BOOL finished) {
        
        
    }];
    
}

-(void)navigationViewActionWithtag:(NSInteger)tag{
    if (tag==0) {
        //系统配置
        [self showDeviceConfig];
    } else if (tag == 6){
        //iEC
        [self showIECView];
    } else if (tag == 5){
        //直流设置
        self.dcManager.dcCurrentMax = [self.hardWareView.viewModel.assistCurrent floatValue];
        [self.dcManager showDirectCurrentView];
        
    } else if (tag == 3){
        [self.binarySwitchSetView showBinaryView];
     
    } else  if (tag == 4){
        [self.binaryInSetView showBinaryInView];
    } else if (tag ==11){
        [BD_PopListViewManager showAlertView:self title:@"提醒" message:@"是否删除所有的模版文件" okAction:^{
            if ([FileUtil delateAllTemplateFiles]) {
                [MBProgressHUDUtil showMessage:@"模版文件删除成功" toView:self.view];
            } else {
                [MBProgressHUDUtil showMessage:@"模版文件删除失败" toView:self.view];
            }
        }];
        
    }
    
}

#pragma mark -消失硬件配置页面
-(void)disMissHardwareView{
    [UIView animateWithDuration:0.3 animations:^{
        
        _hardWareView.frame = CGRectZero;
        _hardWareView.center = _markView.center;
        
    } completion:^(BOOL finished) {
        [self.markView removeFromSuperview];
    }];
    
}


#pragma mark - IECView
-(void)showIECView{
    BD_IECTabBarVC *iecTabVC = [[UIStoryboard storyboardWithName:@"IECConfig" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"BD_IECTabBarVCID"];
    [self.navigationController pushViewController:iecTabVC animated:YES];
}
-(void)deviceSettingFinised:(BD_HardwarkConfigModel *)hardData{
    
}
-(void)readDeviceInfoFromService{
    [[BD_DeviceInfoService shared] readDevicePara:^(BD_DeviceChanelDesc *resultModel,bool isSucess) {
        WeakSelf;
        if (isSucess) {
            //从测试仪读取输出限制信息
            weakself.hardWareView.viewModel.voltagePassNum = resultModel.analogVoltMaxChanel;
            weakself.hardWareView.viewModel.currentPassNum = resultModel.analogCurrentMaxChanel;
            weakself.hardWareView.viewModel.exchangeVoltage = kTStrings(resultModel.voltageMax);
            weakself.hardWareView.viewModel.exchangeCurrent = kTStrings(resultModel.currentMax);
            weakself.hardWareView.viewModel.assistCurrent = kTStrings(resultModel.UDCMax);
            weakself.hardWareView.viewModel.directVoltage = kTStrings(sqrt(2)*resultModel.voltageMax);
            weakself.hardWareView.viewModel.directCurrent = kTStrings(0.5*resultModel.currentMax);
            
            [weakself.hardWareView setViewDataFromRead];
            [weakself.switchView addCurrentLightWithGroup:resultModel.analogCurrentMaxChanel/3];
            [self getDeviceInfoToChangeViewData];
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUDUtil showMessage:@"通道数据读取失败,请检查网络设置" toView:self.view];
                
            });
            
        }
    }];
    
}

#pragma mark - 直流输出开始 灯亮
-(void)refreshDCStart:(NSNotification *)nofi{
    if (self.switchView.switchBtnArr.count!=0) {
        self.switchView.switchBtnArr[1].backgroundColor = Green;
    }
    
}
#pragma mark - 直流输出停止 灯灭
-(void)refreshDCStop:(NSNotification *)nofi{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.switchView.switchBtnArr.count!=0) {
            self.switchView.switchBtnArr[1].backgroundColor = White;
        }
    });
    
}

-(void)netWordDisconnectToStop:(NSNotification *)nofi{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.switchView.switchBtnArr.count!=0) {
            self.switchView.switchBtnArr[1].backgroundColor = White;
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.startBtn.selected = NO;
            self.stopBtn.selected = YES;
        self.startBtn.userInteractionEnabled = YES;
        self.stopBtn.userInteractionEnabled = NO;
            self.navigationItem.hidesBackButton = NO;
        [self setLightDefault];
        [self.runMangaer stopflashView];
        [self netWordDisConnect];
        self.view.userInteractionEnabled = YES;
    
    });
  
    
}
-(void)netWordDisConnect{
    
}
-(void)getDeviceInfoToChangeViewData{
    //TODO:从测试仪读取数据后，修改页面数据
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DirectCurrStart object:nil];
    [kNotificationCenter removeObserver:self name:BD_DirectCurrStop object:nil];
    [kNotificationCenter removeObserver:self name:BD_NewWordDisconnect object:nil];
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
