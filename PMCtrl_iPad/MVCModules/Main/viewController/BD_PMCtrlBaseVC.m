//
//  BD_PMCtrlBaseVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/9.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_PMCtrlBaseVC.h"
#import "BD_BinarySwitchView.h"
#import "BD_QuickTestCustomView.h"
#import "BD_GPSDateModel.h"
#import "BD_TestBinarySwitchSetModel.h"
#import "BD_UtcTime.h"
#import "BD_PopListViewManager.h"
#import "BD_ReportPDFMainVC.h"
#import "UIImage+Extension.h"
#import "BD_DirectCurrentSetManager.h"
#import "BD_RunLightAnimationManager.h"
//键盘管理
#import "IQKeyboardManager.h"
@interface BD_PMCtrlBaseVC ()<UIScrollViewDelegate>{
    BOOL rightResultViewShow;
}
/**wifi连接显示*/
@property(nonatomic,weak)UIButton *wifiBtn;
/**仪器gps时间*/
@property(nonatomic,weak)UILabel *deviceTimeLabel;
@end

@implementation BD_PMCtrlBaseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBgColor;
    self.navigationController.navigationBar.hidden = NO;
    [self configNavi];
    [self configureUI];
    
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
    
    [kNotificationCenter addObserver:self selector:@selector(refreshDateDeviceInfoBinarySwitch:) name:BD_ReadDeviceInfoNoti object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(refreshGPSRealTime:) name:BD_GPSRealTimeNoti object:nil];
    [kNotificationCenter addObserver:self selector:@selector(refreshRealHeartState:) name:BD_RealHeartStateNoti object:nil];
    
    //设置键盘出现后移动页面
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 60;
    
    // Do any additional setup after loading the view.
    
}

//界面布局
-(void)configureUI
{
    WeakSelf;
    
    //顶部视图按钮
    UIScrollView *topTestView = [[UIScrollView alloc]init];
    [topTestView setCorenerRadius:10 borderColor:Black borderWidth:3];
    
    [self.view addSubview:topTestView];
    [topTestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself.view.mas_centerX);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(weakself.view.width*0.6);
        make.height.mas_equalTo(50);
    }];
    self.topTestView = topTestView;
    
    UIButton *fileBtn = [[UIButton alloc]init];
    [fileBtn setImage:[UIImage imageNamed:@"fileNormal"] forState:UIControlStateNormal];
    [fileBtn setImage:[UIImage imageNamed:@"fileSelected"] forState:UIControlStateSelected];
    [fileBtn addTarget:self action:@selector(fileManagerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fileBtn];
    self.fileManagerBtn = fileBtn;
    [fileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    }];
    
    
    
    //开始view
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"startUn"] forState:UIControlStateSelected];
    startBtn.selected = NO;
    [startBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [startBtn addTarget:self action:@selector(startOrStopAction:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn = startBtn;
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.topTestView.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    
    
    //停止view
    UIButton *stopBtn = [[UIButton alloc]init];
    [stopBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [stopBtn setImage:[UIImage imageNamed:@"stopU"] forState:UIControlStateSelected];
    [stopBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [stopBtn addTarget:self action:@selector(startOrStopAction:) forControlEvents:UIControlEventTouchUpInside];
    stopBtn.selected = YES;
    stopBtn.userInteractionEnabled = NO;
    [self.view addSubview:stopBtn];
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.startBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    self.stopBtn = stopBtn;
    
    //主体页面
    _mainView = [[UIScrollView alloc]init];
    [_mainView setCorenerRadius:8 borderColor:BDThemeColor borderWidth:2.0];
    _mainView.pagingEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.delegate = self;
    _mainView.bounces = NO;
    [self.view addSubview:_mainView];
    
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(weakself.startBtn.mas_left).offset(-10);
        make.top.mas_equalTo(weakself.topTestView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-60);
    }];
    
    _rightResultView = [[UIScrollView alloc]init];
    [_rightResultView setCorenerRadius:10 borderColor:BDThemeColor borderWidth:2];
    _rightResultView.backgroundColor = BDThemeColor;
    UITapGestureRecognizer *tapGseture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRightViewChangeLayout:)];
    [_rightResultView addGestureRecognizer:tapGseture];
    rightResultViewShow = NO;
    [self.view addSubview:_rightResultView];
    [_rightResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.stopBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.bottom.mas_equalTo(-80);
    }];
    
    
   
    
}


#pragma mark - 导航栏
-(void)configNavi{
    
    UIButton *wifiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wifiBtn setImage:[UIImage imageNamed:@"wifi-off"] forState:UIControlStateNormal];
    [wifiBtn setImage:[UIImage imageNamed:@"wifi-on"] forState:UIControlStateSelected];
    [wifiBtn setSelected:NO];
    [wifiBtn sizeToFit];
    UIBarButtonItem *wifiItem = [[UIBarButtonItem alloc]initWithCustomView:wifiBtn];
    self.wifiBtn = wifiBtn;
    
    UILabel *gpslabel = [[UILabel alloc]init];
    [gpslabel setFrame:CGRectMake(0, 0, 200, 30)];
    [gpslabel sizeToFit];
    gpslabel.textColor = White;
    gpslabel.numberOfLines = 0;
    gpslabel.font = [UIFont systemFontOfSize:13];
    gpslabel.text = @"1970/01/01 00:00:00.000";
    self.gpsTime.year = 1970;
    self.gpsTime.month = 01;
    self.gpsTime.day = 01;
    UIBarButtonItem *deviceTimeItem = [[UIBarButtonItem alloc]initWithCustomView:gpslabel];
    deviceTimeItem.width = 220;
    self.deviceTimeLabel = gpslabel;
    
    self.navigationItem.rightBarButtonItems = @[wifiItem,deviceTimeItem];
    /**--------------导航栏展示功能按钮----------------------*/
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [scrollView setFrame:CGRectMake(20,0,self.view.width*0.8, 40)];
    scrollView.backgroundColor = ClearColor;

    NSArray *btnTitles = @[@"系统配置",@"通用参数",@"整定值",@"开关量",@"开入量设置",@"直流设置",@"IEC"];
    //,@"报告视图",@"打开模版文件",@"保存模版文件",@"保存配置",@"清空模版文件" 文件相关的放到文件按钮中，下拉框显示
    CGFloat btnWidth = 100;
    NSMutableArray *btnarr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<btnTitles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        [button setFrame: CGRectMake(i*(5+btnWidth)+5, 0, btnWidth,35)];
        button.titleLabel.numberOfLines = 0;
        [button setCorenerRadius:6 borderColor:BDThemeColor borderWidth:1.0];
        [button setTitle:btnTitles[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(scrollBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        [btnarr addObject:button];
    }
    scrollView.contentSize = CGSizeMake(btnTitles.count*(btnWidth+5)+10,40);
    _naviBtnArr = [btnarr copy];
    self.navigationItem.titleView = scrollView;
    /**--------------导航栏展示功能按钮----------------------*/
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

#pragma mark - 懒加载
-(BD_BinarySwitchSetVC *)binarySwitchSetView{
    if (!_binarySwitchSetView) {
        _binarySwitchSetView = [[BD_BinarySwitchSetVC alloc]init];
    }
    return _binarySwitchSetView;
}

-(BD_BinaryInSetVC *)binaryInSetView{
    if (!_binaryInSetView) {
        _binaryInSetView = [[BD_BinaryInSetVC alloc]init];
    }
    return _binaryInSetView;
}

-(BD_UtcTime *)gpsTime{
    if (!_gpsTime) {
        _gpsTime = [[BD_UtcTime alloc]init];
    }
    return _gpsTime;
}

-(BD_ReportPDFMainVC *)reportView{
    if (!_reportView) {
        _reportView = [[BD_ReportPDFMainVC alloc]init];
    }
    return _reportView;
}

-(BD_DirectCurrentSetManager *)dcManager{
    if (!_dcManager) {
        _dcManager = [[BD_DirectCurrentSetManager alloc]initWithVC:self];
    }
    return _dcManager;
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

-(void)scrollBtnAction:(UIButton *)sender{
    [self navigationViewActionWithtag:sender.tag];
}


-(void)tapRightViewChangeLayout:(UIGestureRecognizer *)gesture{
    WeakSelf;
    if (rightResultViewShow) {
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.rightResultView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(100);
            }];
            [weakself.view layoutIfNeeded];
        }];
        
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.rightResultView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(250);
            }];
             [weakself.view layoutIfNeeded];
        }];
       
    }

    rightResultViewShow = !rightResultViewShow;
}


-(void)startOrStopAction:(UIButton *)sender{
    if ([sender isEqual:self.startBtn]) {
        [self startAction];
    } else {
        [self stopAction];
    }
}
-(void)startAction{
    
}
-(void)stopAction{
    
}
-(void)navigationViewActionWithtag:(NSInteger)tag{
    
}

-(void)fileManagerAction:(UIButton *)sender{
    [self fileManagerListShow];
}
-(void)fileManagerListShow{
    
}
//刷新电流灯，过流过载指示灯
-(void)refreshDateDeviceInfoBinarySwitch:(NSNotification *)info{
    NSDictionary *dic = (NSDictionary *)info.object;
    int currentInfo = [[dic objectForKey: @"currentInfo"] intValue];
    int VolInfo = [[dic objectForKey: @"VolInfo"] intValue];
    [self updateCurrentState:currentInfo volt:VolInfo];
    
}

#pragma mark - V OH 过流过载 电流灯状态
-(void)updateCurrentState:(int)current volt:(int)volt{
  
    int c;
    int v;
    NSMutableArray *currentBinary = [[NSMutableArray alloc]init];
    NSMutableArray *voltBinary = [[NSMutableArray alloc]init];
    for(int i=0;i<32;i++)
    {
        c=current%2;  //取余,余数
        current=current/2;  //取整
        [currentBinary addObject:@(c)];
        
        v=volt%2;  //取余,余数
        volt=volt/2;  //取整
        [voltBinary addObject:@(v)];
        
    }
   
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *cbtns = [[NSMutableArray alloc]init];
        [self.switchView.switchBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.titleLabel.text hasPrefix:@"I"]) {
                [cbtns addObject:obj];
            }
        }];
        
        //设置btn亮 电流指示灯
        [cbtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([currentBinary[idx] intValue] == 0) {
                
                UIButton *btn = (UIButton *)obj;
                btn.backgroundColor = Red;
                btn.userInteractionEnabled = YES;
            }else if ([currentBinary[idx] intValue] == 1){
                
                UIButton *btn = (UIButton *)obj;
                btn.backgroundColor = White;
                btn.userInteractionEnabled = NO;
            }
        }];
        
        //U灯，表示过载
        if ( [voltBinary[6] intValue]==1|| [voltBinary[7] intValue]==1|| [voltBinary[8] intValue]==1
            || [voltBinary[9] intValue]==1|| [voltBinary[10] intValue]==1|| [voltBinary[11] intValue]==1)
        {
            UIButton *btn = self.switchView.switchBtnArr[self.switchView.switchBtnArr.count-18];
            btn.backgroundColor = Red;
            btn.userInteractionEnabled = NO;
        }
        else
        {
            UIButton *btn = self.switchView.switchBtnArr[self.switchView.switchBtnArr.count-18];
            btn.backgroundColor = White;
            btn.userInteractionEnabled = NO;
        }
        //OH灯，表示过热
        if ([currentBinary[6] intValue]==1 || [voltBinary[12] intValue] == 1)
        {
            UIButton *btn = self.switchView.switchBtnArr[self.switchView.switchBtnArr.count-19];
            btn.backgroundColor = Red;
            btn.userInteractionEnabled = NO;
        }
        else
        {
            UIButton *btn = self.switchView.switchBtnArr[self.switchView.switchBtnArr.count-19];
            btn.backgroundColor = White;
            btn.userInteractionEnabled = NO;
        }
        
    });
    
}


#pragma mark - 开入量指示灯状态 ,开入量灯为10个
-(void)updateBinaryStateDatas:(int)binaryAll{
 
        int d;
        for(int i=0;i<10;i++)
        {
            d=binaryAll%2;  //取余,余数
            binaryAll=binaryAll/2;  //取整
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置btn亮
                if (d == 1) {
                    
                    UIButton *btn = self.switchView.switchBtnArr[i+2];
                    [btn setBackgroundImage:[UIImage imageWithColor: White width:btn.width height:btn.height title:@""] forState:UIControlStateNormal];
                    btn.userInteractionEnabled = YES;
                    int n;
                    
                    unsigned int binIn = 0;
                    NSArray *binarInArr = @[@(self.binarySwitchSetView.binaryData.iKA),@(self.binarySwitchSetView.binaryData.iKB),@(self.binarySwitchSetView.binaryData.iKC),@(self.binarySwitchSetView.binaryData.iKD),@(self.binarySwitchSetView.binaryData.iKE),@(self.binarySwitchSetView.binaryData.iKF),@(self.binarySwitchSetView.binaryData.iKG),@(self.binarySwitchSetView.binaryData.iKH),@(self.binarySwitchSetView.binaryData.iKI),@(self.binarySwitchSetView.binaryData.iKJ)];
                    for (NSInteger i = 0; i < binarInArr.count; i++) {
                        if ([binarInArr[i] intValue]==1)
                        {
                            binIn |= (1<<i);
                        }
                    }
                    for(int j=0;j<10;j++)
                    {
                        n=binIn%2;  //取余,余数
                        binIn=binIn/2;  //取整
                        
                        //设置btn亮
                        if (n == 0){
                            
                            UIButton *btn = self.switchView.switchBtnArr[j+2];
                            [btn setBackgroundImage:[UIImage imageNamed:@"lightUnUsed"] forState:UIControlStateNormal];
                            btn.userInteractionEnabled = NO;
                        }
                    }
                    
                }
                else if (d == 0){
                    
                    UIButton *btn = self.switchView.switchBtnArr[i+2];
                    [btn setBackgroundImage:[UIImage imageWithColor: Green width:btn.width height:btn.height title:@""] forState:UIControlStateNormal];
                    btn.userInteractionEnabled = NO;
                }
            });
        }
    
}
#pragma mark - 开出量指示灯状态
-(void)updatebinaryOutState:(int)binaryValue{
    int d;
    for(int i=0;i<8;i++)
    {
        d=binaryValue%2;  //取余,余数
        binaryValue=binaryValue/2;  //取整
        NSInteger allCount = self.switchView.switchBtnArr.count;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (d == 0) {
                //0闭合动作
                UIButton *btn = self.switchView.switchBtnArr[allCount-16+i];
                btn.backgroundColor = Green;
                btn.userInteractionEnabled = NO;
                
            }
            else if (d == 1){
                //1 断开不动作
                UIButton *btn = self.switchView.switchBtnArr[allCount-16+i];
                btn.backgroundColor = White;
                btn.userInteractionEnabled = YES;
                
            }
        });
    }
}


-(void)setLightDefault{
  
    for (NSInteger i=0; i<self.switchView.switchBtnArr.count; i++) {
        UIButton *btn = self.switchView.switchBtnArr[i];
        btn.userInteractionEnabled = YES;
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        btn.backgroundColor = White;
    }
}


-(void)setBinaryViewUsed{
    [self.switchView.switchBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.titleLabel.text isEqualToString:@"A"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKA    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"B"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKB    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"C"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKC    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"D"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKD    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"E"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKE    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"F"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKF    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"G"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKG    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"H"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKH    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"I"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKI    btn:obj];
        }
        if ([obj.titleLabel.text isEqualToString:@"J"]) {
            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iKJ    btn:obj];
        }
        
        //        if ([obj.titleLabel.text isEqualToString:@"1"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut1    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"2"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut2    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"3"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut3    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"4"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut4    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"5"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut5    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"6"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut6    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"7"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut7    btn:obj];
        //        }
        //        if ([obj.titleLabel.text isEqualToString:@"8"]) {
        //            [self setBinaryBtnIsUserd:(BOOL)self.binarySwitchSetView.binaryData.iOut8    btn:obj];
        //        }
        //
    }];
}

-(void)setBinaryBtnIsUserd:(BOOL)state btn:(UIButton *)btn{
    if (state) {
        
        [btn setBackgroundImage:[UIImage imageWithColor: RGB(234, 234, 234) width:btn.width height:btn.height title:@""] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"lightUnUsed"] forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
    }
}




//程序进入后台，修改页面显示
-(void)applicationEnterBackground{
    dispatch_async(dispatch_get_main_queue(), ^{
        //结束实验需要进行的动作
//        self.startBtn.selected = NO;
//        self.stopBtn.selected = YES;
//        self.navigationItem.hidesBackButton = NO;
//        [OCCenter.shareCenter stop];
//        self.view.userInteractionEnabled = YES;
    });
    
}

/**gps时间*/
-(void)refreshGPSRealTime:(NSNotification *)noti{
    dispatch_async(dispatch_get_main_queue(), ^{
        BD_GPSDateModel *gpsDate = (BD_GPSDateModel *)noti.object;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:gpsDate.nSecond+gpsDate.nNanoSec/pow(10, 9)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //传入时间格式
        formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss.sss";
        NSString *dateString = [formatter stringFromDate:date];
        
        self.deviceTimeLabel.text = dateString;
        formatter.dateFormat = @"yyyy";
        self.gpsTime.year = [[formatter stringFromDate:date] intValue];
        formatter.dateFormat = @"MM";
        self.gpsTime.month = [[formatter stringFromDate:date] intValue];
        formatter.dateFormat = @"dd";
        self.gpsTime.day = [[formatter stringFromDate:date] intValue];
    });
    
}
/**心跳状态*/
-(void)refreshRealHeartState:(NSNotification *)noti{
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL state = [noti.object boolValue];
        weakself.wifiBtn.selected = state;
    });
}
-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_ReadDeviceInfoNoti object:nil];
    [kNotificationCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [kNotificationCenter removeObserver:self name:BD_GPSRealTimeNoti object:nil];
}

-(void)templateFileNameEditAlert:(void(^)(NSString *))complete{
    
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入文件名称" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加取消按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    
    
    //增加确定按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if (![userNameTextField.text isEqualToString:@""]) {
            complete(userNameTextField.text);
        } else {
            [MBProgressHUDUtil showMessage:@"请输入模版文件名称" toView:self.view];
        }
        
    }]];
 
    //定义第一个输入框；
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入文件名称";
        
        textField.secureTextEntry = NO;
        
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}
-(void)showTemplateFileListView:(UIView *)sourceView complete:(void(^)(NSString *))complete{
    NSArray *files  = [FileUtil getDirectoryFileNames:@""];
    [BD_PopListViewManager ShowPopViewWithlistDataSource:files textField:sourceView viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *fileName) {
        complete(fileName);
    }];
}
-(void)showFileListView:(NSString *)message complete:(void(^)(NSString *))complete{
    NSArray *files  = [FileUtil getDirectoryFileNames:@""];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [files enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alert addAction:[UIAlertAction actionWithTitle:(NSString *)files[idx] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            complete((NSString *)files[idx]);
        }]];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
}


#pragma mark 停止实验后，生成报告
-(void)endTestAndCreateReport{
    self.stopBtn.selected = YES;
    self.stopBtn.userInteractionEnabled = NO;
    self.startBtn.selected = NO;
    self.startBtn.userInteractionEnabled = YES;
    self.navigationItem.hidesBackButton = NO;
    [self setLightDefault];
    //生成报告文件
    [self createReportVC];

}
-(void)createReportVC{
   
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
