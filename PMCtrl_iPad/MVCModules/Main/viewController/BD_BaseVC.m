//
//  BD_BaseVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_BaseVC.h"
#import "BD_GPSDateModel.h"
@interface BD_BaseVC ()<UIGestureRecognizerDelegate>
@property(nonatomic,assign)UIButton *wifiBtn;
@property(nonatomic,assign)UILabel *deviceTimeL;
@end

@implementation BD_BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBgColor;
    self.navigationController.navigationBar.hidden = NO;
    [self configNavi];
    
//    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
//    
//    self.navigationItem.leftBarButtonItems = @[backButtonItem];
//    //指定手势代理
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
   //设置全屏滑动返回上级页面
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;//截取系统返回手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    pan.delegate = self;
//    
//    [self.view addGestureRecognizer:pan];
//    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;//设置系统返回手势不可用
    
    
    [kNotificationCenter addObserver:self selector:@selector(refreshGPSRealTime:) name:BD_GPSRealTimeNoti object:nil];
    [kNotificationCenter addObserver:self selector:@selector(refreshRealHeartState:) name:BD_RealHeartStateNoti object:nil];
    
    // Do any additional setup after loading the view.
    
}

//界面布局
-(void)configureUI
{
  
   
    
}


#pragma mark - 导航栏
-(void)configNavi{
    UIBarButtonItem *deviceConfitItem = [[UIBarButtonItem alloc]initWithTitle:@"系统配置" style:UIBarButtonItemStylePlain target:self action:
                                         @selector(showDeviceConfig)];
    
    UIButton *wifiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wifiBtn setImage:[UIImage imageNamed:@"wifi-off"] forState:UIControlStateNormal];
    [wifiBtn setImage:[UIImage imageNamed:@"wifi-on"] forState:UIControlStateSelected];
    [wifiBtn setSelected:NO];
    [wifiBtn sizeToFit];
    self.wifiBtn = wifiBtn;
    UIBarButtonItem *wifiItem = [[UIBarButtonItem alloc]initWithCustomView:wifiBtn];
    
    UILabel *deviceTimeLabel = [[UILabel alloc]init];;
    [deviceTimeLabel sizeToFit];
    deviceTimeLabel.textColor = White;
    deviceTimeLabel.font = [UIFont systemFontOfSize:13];
    deviceTimeLabel.numberOfLines = 0;
    deviceTimeLabel.text = @"1970/01/01 00:00:00.000";
    self.deviceTimeL = deviceTimeLabel;
    UIBarButtonItem *deviceTimeItem = [[UIBarButtonItem alloc]initWithCustomView:deviceTimeLabel];
    
    deviceTimeItem.width = 220;
    self.navigationItem.rightBarButtonItems = @[wifiItem,deviceTimeItem,deviceConfitItem];
}

-(void)showDeviceConfig{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)endEditing{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popToVCWithVCName:(NSString *)vcname{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:vcname];
    [self.navigationController pushViewController:vc animated:YES];
}

//当手势每次被触发的时候会询问，是否触发滑动手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;//设置no表示不需要触发滑动手势。  设置yes表示需要触发滑动手势
}


-(void)handleNavigationTransition:(UIGestureRecognizer *)gesture{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)judgeDeviceConnectionState{
    
}


/**gps时间*/
-(void)refreshGPSRealTime:(NSNotification *)noti{
    BD_GPSDateModel *gpsDate = (BD_GPSDateModel *)noti.object;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:gpsDate.nSecond+gpsDate.nNanoSec/1000000000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //传入时间格式
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss:sss";
    NSString *dateString = [formatter stringFromDate:date];
    
    self.deviceTimeL.text = dateString;
    
}
/**心跳状态*/
-(void)refreshRealHeartState:(NSNotification *)noti{
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL state = [noti.object boolValue];
        weakself.wifiBtn.selected = state;
    });
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
