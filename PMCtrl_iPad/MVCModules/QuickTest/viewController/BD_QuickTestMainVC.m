//
//  BD_QuickTestMainVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestMainVC.h"
#import "BD_QuickTestParamTBView.h"
#import "BD_QuickTestParamModel.h"
#import "YRBorderView.h"
#import "IQKeyboardManager.h"
#import "BD_QuickTestIECView.h"
#import "BD_QuickTestParamSetView.h"
#import "BD_FingerWaveView.h"
#import "BD_QuickTestVectorgraphTBView.h"
#import "BD_QuickTestActionResultView.h"
#import "BD_QuickTestOscillographTBView.h"
#import "BD_QuickTestVactorgraphModel.h"
#import "BD_QuickTestOscillographModel.h"
#import "BD_QuickTestParamModel.h"
#import "BD_QuickTestResultModel.h"
#import "UIImage+Extension.h"
#import "BD_HardwarkConfigModel.h"
#import "BD_QuickTestDataCenter.h"
#import "BD_OutputwaveShapeTBView.h"
#import "BD_QuickTestOscillographModel.h"
#import "BD_QuickTestCustomView.h"
#import "BD_QuickTestResultModel.h"
#import "BD_HardwareConfigView.h"
#import "BD_TestResultModel.h"
#import "BD_InfomationTBView.h"
#import "BD_PopListViewManager.h"
#import "BD_IECTabBarVC.h"
#import "BD_TestDataParamModel.h"
#import "BD_QuickTestPowerFormTBView.h"
#import "BD_FormTBViewBaseModel.h"
#import "BD_FormTBView.h"
#import "BD_CaculatePowerManager.h"
#import "BD_SequenceCaculateManager.h"
#import "BD_ChannelModel.h"
@interface BD_QuickTestMainVC ()<UIDocumentInteractionControllerDelegate,BD_QuickTestGetOscillographDataDelegate,UIScrollViewDelegate,BD_HardwareConfitDelegate,BD_OutputwaveShapeAutoRefreshDataDelegate,BDBinaryChangedProtocol>{
//    BD_QuickTestCustomView *iecBtnView;
//    BD_QuickTestCustomView *paramBtnView;
    NSMutableArray <BD_QuickTestCustomView *> *rightBtnArr;
    
//    BD_UtcTime  *testStartTime;
    long testStartSec;
    long testStartNoSec;
    UIView *viewInScroll;
    
  
}

@property (weak, nonatomic) IBOutlet UIScrollView *paramScrollView;

@property (weak, nonatomic) IBOutlet UIView *btnsView;
@property (weak, nonatomic) IBOutlet UIView *topViews;
@property (weak, nonatomic) IBOutlet UIButton *fileBtn;

@property (nonatomic,weak)BD_QuickTestParamTBView *voltageTV;
@property (nonatomic,weak)BD_QuickTestParamTBView *currentTV;
@property (nonatomic,weak)BD_QuickTestActionResultView *resultView;
@property (nonatomic,weak)BD_QuickTestParamSetView *paramSetV;
@property (nonatomic,weak)BD_QuickTestVectorgraphTBView *vectorgraphView;

@property (nonatomic,strong)  NSMutableArray<BD_QuickTestOscillographModel *>* oscillographDataArr;

@property (nonatomic,weak)BD_QuickTestOscillographTBView *oscillographView;//状态图
@property (nonatomic,weak)BD_OutputwaveShapeTBView *waveShapeView;//输出实时波形图
@property (nonatomic,weak)BD_InfomationTBView *infomationView; //信息图
@property(nonatomic,weak)BD_QuickTestPowerFormTBView *powerView;//功率图
@property(nonatomic,weak)BD_FormTBView *sequeView;//序分量
@property(nonatomic,weak)BD_FormTBView *lineVoltageView;//线电压
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (nonatomic,strong) NSMutableArray<UIView*> *pageViewArr;
@property (nonatomic,strong) NSArray<UIButton*> *topBtnArr;
@property (nonatomic,weak)UIView *markView;
@property (nonatomic,strong)BD_HardwarkConfigModel *hardwarkModelData;
@property (nonatomic,strong)BD_QuickTestDataCenter *dataCenter;

@property(nonatomic,strong)BD_TestResultData *testResultData;

@end

@implementation BD_QuickTestMainVC

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   _dataCenter = [[BD_QuickTestDataCenter alloc]init];
   
   
  
    [self configUI];
    [self readDataFromPlist];
    //设置键盘出现后移动页面
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 60;
    

#pragma mark - 通知
    [kNotificationCenter addObserver:self selector:@selector(refreshBtn:) name:BD_ManualTestFromServiceDataNoti object:nil];
   
    [kNotificationCenter addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    

    [self.paramSetV.comParam addObserver:self forKeyPath:@"isAuto" options:NSKeyValueObservingOptionNew context:nil];
    [self.beginModel addObserver:self forKeyPath:@"isBegin" options:NSKeyValueObservingOptionNew context:nil];
    [self.oscillographView addObserver:self forKeyPath:@"isOutputData" options:NSKeyValueObservingOptionNew context:nil];
   
    [self.waveShapeView addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    if (!_dataCenter.timer) {
        [_dataCenter createTimer];
        [_dataCenter startTimer];
    }
    if (!_oscillographView.timer) {
        [_oscillographView createTimer];
        [_oscillographView startTimer];
    }
    if (!_waveShapeView.waveTimer) {
        [_waveShapeView createTimer];
        [_waveShapeView startTimer];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    //view真正的大小在didAppear后才能确定
    
    if (!_resultView) {
      BD_QuickTestActionResultView *resultView = [[BD_QuickTestActionResultView alloc]initWithFrame:CGRectMake(_paramScrollView.frame.origin.x, self.view.height, _paramScrollView.width, 150)];
        [self.view addSubview:resultView];
        [self addGesture];
        self.resultView = resultView;
    }
}
-(void)viewWillLayoutSubviews{
    [_paramScrollView setDefaultCornerRadiusWithColor:Black];
    [_paramScrollView setShadowColor];
    
    for (UIView *view in _btnsView.subviews) {
        if ([view isKindOfClass:[YRBorderView class]]) {
            [view removeFromSuperview];
        }
    }
   
    YRBorderView *borderview = [[YRBorderView alloc]initWithFrame:_btnsView.bounds];
    borderview.backgroundColor = ClearColor;
    [borderview setLineColorTop:Black left:Black bottom:Black right:Black];
    [borderview setLineWidthTop:2.0 left:2.0 bottom:2.0 right:2.0];
    borderview.clipsToBoundsWithBorder = NO;
    [borderview setRadiusTopLeft:10.0 topRight:0.0 bottomLeft:10.0 bottomRight:0.0];
    [_btnsView insertSubview:borderview atIndex:0];
    
    [_btnsView setShadowColor];
    [_topViews setDefaultCornerRadiusWithColor:Black];
    
    
    [_voltageTV setFrame:CGRectMake(10,10, (self.paramScrollView.width-30)/2,self.paramScrollView.height-20)];
    
    
    [_currentTV setFrame:CGRectMake(20+_voltageTV.width,10, (self.paramScrollView.width-30)/2, self.paramScrollView.height-20)];

 
    [self loadVisiblePages];
    

}


#pragma mark - 初始化UI
-(void)configUI{
    
    [_fileBtn setImage:[UIImage imageNamed:@"fileNormal"] forState:UIControlStateNormal];
    [_fileBtn setImage:[UIImage imageNamed:@"fileSelected"] forState:UIControlStateSelected];
    self.navigationItem.title = @"手动试验";
    
        //顶部视图按钮
        UIScrollView *topTestView = [[UIScrollView alloc]init];
        [topTestView setCorenerRadius:10 borderColor:Black borderWidth:3];
        
        [_topViews addSubview:topTestView];
        [topTestView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        CGFloat btnX = 10;
        CGFloat btnW = 100;
        CGFloat btnH = 40;
        NSArray *btnTitle = @[@"数据",@"波形图",@"矢量图",@"状态图",@"信息图",@"功率图",@"序分量",@"线电压"];
        NSMutableArray *viewBtnArr = [[NSMutableArray alloc]init];
        for (int i = 0; i<btnTitle.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(10+i*(btnX+btnW),5,btnW,btnH)];
            [btn setCorenerRadius:6 borderColor:White borderWidth:2.0];
            [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:ClearColor width:btn.width height:btn.height title:btnTitle[i] ] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:BDThemeColor width:btn.width height:btn.height title:btnTitle[i] ] forState:UIControlStateSelected];
            if (i == 0) {
                [btn setSelected:YES];
            } else {
                [btn setSelected:NO];
            }
            
            
            btn.tag = i+100;
            
            
            [btn addTarget:self action:@selector(topViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [topTestView addSubview:btn];
            [viewBtnArr addObject:btn];
        }
        _topBtnArr = [viewBtnArr copy];
    topTestView.contentSize = CGSizeMake(_topBtnArr.count*(btnW+btnX),topTestView.height);
    
    
    CGFloat viewY = 25;
    CGFloat viewW = 130;
    CGFloat viewH = (SCREEN_HEIGHT-350)/6;
    NSArray *viewImage = @[@"rightBtn1",@"rightBtn2",@"lock_unused",@"rightBtn4",@"rightBtn5",@"rightBtn6"];
    rightBtnArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<6; i++) {
        BD_QuickTestCustomView *view = [[BD_QuickTestCustomView alloc]initWithFrame:CGRectMake(40,viewY+i*(viewY+viewH),viewW,viewH) imageName:viewImage[i]];
        __weak typeof(view) weakview = view;//block 中必须使用
        [view setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
        view.tag = i+10;
        if (i==3){
            _startBtnView = view;
        }
        if (i == 2)
        {
            view.btn.userInteractionEnabled = NO;//锁按钮，默认不可用，同时锁按钮，默认显示
        }
        view.clickAction = ^{
//            CGPoint center = weakview.btn.center;
            [self rightViewBtnClick:weakview];
//            [BD_FingerWaveView showInView:weakview center:center];
            
        };
        [rightBtnArr addObject:view];
        [_btnsView addSubview:view];
    }
    
    
    
    _pageViewArr = [[NSMutableArray alloc]init];
    
    //scrollView上添加view
    //数据
    [self addVolandCurView];
    
    //实时波形图

    if (!_waveShapeView) {
        BD_OutputwaveShapeTBView *waveShapeView = [[BD_OutputwaveShapeTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        waveShapeView.backgroundColor = ClearColor;
        waveShapeView.wavedelegate = self;
        waveShapeView.isBegin = _beginModel.isBegin;
        
        [_pageViewArr addObject:waveShapeView];
        _waveShapeView = waveShapeView;
    }
 
    
    //矢量图
    BD_QuickTestVectorgraphTBView *vectorgraphView = [[BD_QuickTestVectorgraphTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
 
    vectorgraphView.backgroundColor = ClearColor;
//    [_vectorgraphView transitionWithType:kCATransitionPush withSubType:kCATransitionFromBottom withDuration:0.5];
    
//    [_paramScrollView addSubview:_vectorgraphView];
    [_pageViewArr addObject:vectorgraphView];
    _vectorgraphView = vectorgraphView;
    
    //状态图
    if (!_oscillographView) {
        BD_QuickTestOscillographTBView *oscillographView = [[BD_QuickTestOscillographTBView alloc]initWithFrame:CGRectZero];
        
        oscillographView.backgroundColor = ClearColor;
        oscillographView.dataDelegate = self;
        oscillographView.isBegin = _beginModel.isBegin;
        oscillographView.isLock = _isLock;
        oscillographView.lineDataSourceArr = _oscillographDataArr;
        _dataCenter.isOutputData = oscillographView.isOutputData;
        [_dataCenter createRefreshTime];
        [_dataCenter createBinaryStateLineViewDatas];
        oscillographView.xValues = @[_dataCenter.times,_dataCenter.times];
        oscillographView.binaryStates = _dataCenter.binaryStateDatas;
        
        //        [_oscillographView transitionWithType:kCATransitionPush withSubType:kCATransitionFromBottom withDuration:0.5];
        //        [_paramScrollView addSubview:_oscillographView];
        [_pageViewArr addObject:oscillographView];
        _oscillographView = oscillographView;
    }
//    //IEC配置
//    BD_QuickTestIECView *iecV = [[NSBundle mainBundle] loadNibNamed:@"BD_QuickTestIECView" owner:self options:nil].lastObject;
//    [iecV setFrame:CGRectZero];
//    iecV.backgroundColor = ClearColor;
//    [iecV transitionWithType:kCATransitionPush withSubType:kCATransitionFromRight withDuration:0.5];
//    
//    [_pageViewArr addObject:iecV];
    
    //信息图页面
   BD_InfomationTBView *infomationView = [[BD_InfomationTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];;
    [infomationView createFalsedata];
    [infomationView reloadData];
    [_pageViewArr addObject:infomationView];
    _infomationView = infomationView;
    
    //功率图
    BD_QuickTestPowerFormTBView *power = [[BD_QuickTestPowerFormTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_pageViewArr addObject:power];
    self.powerView = power;
    
    BD_FormTBView *seque = [[BD_FormTBView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@"名称",@"幅值",@"相位"]];
    [_pageViewArr addObject:seque];
    self.sequeView = seque;
    //线电压
    BD_FormTBView *lineVoltage = [[BD_FormTBView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@"通道",@"幅值",@"相位",@"频率"]];
    [_pageViewArr addObject:lineVoltage];
    self.lineVoltageView = lineVoltage;
    
    //参数设置页面
   BD_QuickTestParamSetView *paramSetV = [[NSBundle mainBundle] loadNibNamed:@"BD_QuickTestParamSetView" owner:self options:nil].lastObject;
    [paramSetV setFrame:CGRectZero];
    paramSetV.isBegin = _beginModel.isBegin;
    paramSetV.backgroundColor = ClearColor;
    paramSetV.binaryDelegate = self;
    [paramSetV transitionWithType:kCATransitionPush withSubType:kCATransitionFromRight withDuration:0.5];
    [_pageViewArr addObject:paramSetV];
    _paramSetV = paramSetV;
    
    //配置scrollView
    self.paramScrollView.bounces = NO;
    self.paramScrollView.delegate = self;
    self.paramScrollView.pagingEnabled = YES;   //之前设置滑动没有翻页的效果，原因是没有设置该值为true
    [self.paramScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];

    self.paramScrollView.showsHorizontalScrollIndicator = NO;
  
    
 
    UIView *markView = [[UIView alloc]initWithFrame:self.view.bounds];
    markView.backgroundColor = [Black colorWithAlphaComponent:0.5];
    _markView = markView;
    _hardWareView = [[NSBundle mainBundle]loadNibNamed:@"BD_HardwareConfigView" owner:self options:nil].lastObject;
    WeakSelf;
    _hardWareView.hardwareConfigComplete = ^(BD_HardwarkConfigModel *hard) {
        weakself.paramSetV.passagewayNum.voltagePassageNum = hard.voltagePassNum;
        weakself.paramSetV.passagewayNum.currentPassageNum = hard.currentPassNum;
        
        
        [weakself.dataCenter updateTestData:hard.voltagePassNum C_passNum:hard.currentPassNum complete:^(NSMutableArray *resultArr) {
            weakself.quickTestData = resultArr;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.voltageTV.datasource  = weakself.quickTestData[0];
                weakself.currentTV.datasource  = weakself.quickTestData[1];
                [weakself.voltageTV reloadData];
                [weakself.currentTV reloadData];
                if (weakself.paramScrollView.contentOffset.x == 2*weakself.paramScrollView.width) {
                    [weakself showVectorgraphView];
                } else if (weakself.paramScrollView.contentOffset.x==weakself.paramScrollView.width){
                    [weakself showOscillographView];
                }
                [weakself loadoscillographData:^(NSMutableArray *oscillographArr) {
                    weakself.oscillographView.lineDataSourceArr = oscillographArr;
                    [weakself setOscillographDataToZero];
                }];
                weakself.waveShapeView.dataArr = [weakself.dataCenter outPutWaveShapeDataCenter:[weakself.quickTestData copy]];
            });
        }];
 
        [weakself disMissHardwareView];
    };
    _hardWareView.frame = CGRectZero;
    _hardWareView.layer.cornerRadius = 10;
    _hardWareView.layer.masksToBounds = YES;
    _hardWareView.center = _markView.center;
    _hardWareView.dissdelegate = self;
    [_markView addSubview:self.hardWareView];
    
}

#pragma mark -显示硬件配置页面
-(void)showDeviceConfig{
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.markView];
    [UIView animateWithDuration:0.3 animations:^{
        
        _hardWareView.frame = CGRectMake(0, 0, self.view.width*0.7,self.view.height*0.8);
       _hardWareView.center = _markView.center;
    } completion:^(BOOL finished) {
        
    }];
 
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


#pragma mark - plist文件读取参数默认设置

-(void)readDataFromPlist{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuickTestParam" ofType:@".plist"]];
        NSMutableArray *TVdatas = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSArray *arr in dictArr) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            for (NSDictionary *dict in arr) {
                
                BD_TestDataParamModel *peopleList = [BD_TestDataParamModel groupWithDict:dict];
                
                [arrM addObject:peopleList];
            }
            [TVdatas addObject:arrM];
        }
        
        self.quickTestData = TVdatas;
        int voltagePassNum = 0;
        int currentPassNum = 0;
        [[BD_DeviceInfoService shared] readDevicePara:^(BD_DeviceChanelDesc *resultModel,bool isSucess) {
            if (isSucess) {
                WeakSelf;
                [self.dataCenter updateTestData:voltagePassNum C_passNum:currentPassNum complete:^(NSMutableArray *resultArr) {
                    weakself.quickTestData = resultArr;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.voltageTV.datasource  = weakself.quickTestData[0];
                        weakself.currentTV.datasource  = weakself.quickTestData[1];
                        [weakself.voltageTV reloadData];
                        [weakself.currentTV reloadData];
                        
                        _waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:[_quickTestData copy]];
                        for (int i = 0; i<_waveShapeView.dataArr.count; i++) {
                            BD_OutputwaveShapeDataModel *model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                            [_waveShapeView.selecteddataArr addObject:model];
                        }
       
                            //必须在初始化的时候创建数据，必须在每个view的datasource有数据后初始化波形图页面数据
                            if (!
                                _oscillographDataArr) {
                                [self loadoscillographData:^(NSMutableArray *array) {
                                    _oscillographView.lineDataSourceArr = array;
                                    [self setOscillographDataToZero];
                                }];
                                
                            }
                            [self computationsVectorgraphViewData];
                            [_vectorgraphView reloadData];
                            [_waveShapeView reloadData];
                    });
                }];
                
            } else {
                [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
                }];
                
                _waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:[_quickTestData copy]];
                for (int i = 0; i<_waveShapeView.dataArr.count; i++) {
                    BD_OutputwaveShapeDataModel *model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                    [_waveShapeView.selecteddataArr addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _voltageTV.datasource = self.quickTestData[0];
                    _currentTV.datasource = self.quickTestData[1];
                    
                    [_voltageTV reloadData];
                    [_currentTV reloadData];
                    
                    //必须在初始化的时候创建数据，必须在每个view的datasource有数据后初始化波形图页面数据
                    if (!
                        _oscillographDataArr) {
                        [self loadoscillographData:^(NSMutableArray *array) {
                            _oscillographView.lineDataSourceArr = array;
                            [self setOscillographDataToZero];
                        }];
                        
                    }
                    [self computationsVectorgraphViewData];
                    [_vectorgraphView reloadData];
                    [_waveShapeView reloadData];
                });
                
            }
        }]; 
        
    });
    
    
}



#pragma mark - 懒加载
-(NSMutableArray *)quickTestData{
    if (!_quickTestData) {
        _quickTestData = [[NSMutableArray alloc]init];
    }
    return _quickTestData;
}

-(BD_BeginTestModel *)beginModel{
    if (!_beginModel) {
        _beginModel = [[BD_BeginTestModel alloc]initWithBegin:NO];
    }
    return _beginModel;
}

-(BD_HardwarkConfigModel *)hardwarkModelData{
    if (!_hardwarkModelData) {
        _hardwarkModelData = [[BD_HardwarkConfigModel init]init];
        _hardwarkModelData.deviceType = BDDeviceType_Imitate;
        _hardwarkModelData.currentPassNum = 3;
        _hardwarkModelData.voltagePassNum = 3;
        _hardwarkModelData.exchangeCurrent = @"0";
        _hardwarkModelData.exchangeVoltage = @"0";
        _hardwarkModelData.directVoltage = @"0";
        _hardwarkModelData.directCurrent = @"0";
    }
    return _hardwarkModelData;
}
-(BD_TestResultData *)testResultData{
    if (!_testResultData) {
        _testResultData = [[BD_TestResultData alloc]init];
    }
    return _testResultData;
}
#pragma mark - 接收通知方法，刷新页面数据
- (void)refreshBtn:(NSNotification *)info{
    
    NSLog(@"------------------");
    
    //获取文件路径,写入文件
    NSString *filePath = [kUserDefaults valueForKey:@"manualFilePath"];
    
    NSMutableArray *resultArr = (NSMutableArray *)info.object;//info.object就是通过通知传递的数据对象，可以转换为对应的类型
    
    /** 上一版本（1.0)返回结果处理
    for (BD_QuickTestResultModel *model in resultArr) {
        
        int nbinall = model.nbinall; //开入量
        //oactivetype 返回值代表的类型1 开始试验。2 结束实验。3 状态切换 4开入变位 递变
        int oactivetype = model.oactivetype;
        
        NSLog(@"开入量nbinall:%d",nbinall);
        NSLog(@"类型oactivetype:%d",oactivetype);
        
        switch (model.oactivetype) {
            case 1:
                NSLog(@"--1");
                testStartTime = model.time;
                [self refreshBtnWithBinary:nbinall];
                break;
            case 2:
                NSLog(@"--2");
                //类型返回2表示实验结束，应该将设备输出和页面显示都设置为停止状态，需要调用[OCCenter.shareCenter stop];方法才能停止设备的输出操作，否则不停止
                [self endTestWithFilepath:filePath nBinstate:nbinall];
                
                break;
            case 3:
                NSLog(@"--3");
                //刷新
                [self refreshBtnWithBinary:nbinall];
                break;
            case 4:
                NSLog(@"--4");
                [self refreshBtnWithBinary:nbinall];
                //计算动作时间
                if (_startBtnView.btn.isSelected && !self.isLock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (model.time.second == testStartTime.second) {
                            self.paramSetV.comParam.actionTime = [NSString stringWithFormat:@"%.3f",(float)(model.time.millisecond-testStartTime.millisecond)/pow(10,9)];
                        
                        }else {
                            self.paramSetV.comParam.actionTime  = [NSString stringWithFormat:@"%.3f",(float)(model.time.second-testStartTime.second)+(float)(model.time.millisecond-testStartTime.millisecond)/pow(10,9)];
                            
                        }
                    });
                    
                }
                
                break;
            case 5:
                NSLog(@"--5");
                [self refreshBtnWithBinary:nbinall];
                break;
                
            default:
                break;
        }
        
    }
    */
    
    /***************version1.1版本接口数据处理**********************************/
    for (BD_TestResultModel *model in resultArr) {
        
        int currentIndex = (int)[resultArr indexOfObject:model];
        
        //1：开始实验    2：结束实验    3：状态切换    4：开入变位 5: 递变
//        int ntype = model.nType;
        //开入量值
//        int ninput = model.nInput;
        /**
         //当type为开入变位，为变位的开入通道，bit9~bit0对应开入9~0
         //当type为状态切换时，为状态切换触发条件，
         //bit12:手动触发    bit11：时间触发    bit10：GPS触发
         //bit9~bit0:对应开关量9~0
         */
//        int nSource = model.nSource;
        /**产生结果的时间秒值*/
        int nSec = model.nSec;
        /**产生结果的时间纳秒值*/
        int nNanoSec = model.nNanoSec;
        //自动递变当前执行的步数
//        int nStep = model.nStep;

        
        switch (model.nType) {
            case 1:
                NSLog(@"--1");
               
                
                [self refreshBtnWithBinary:model.nInput];
                break;
            case 2:
                NSLog(@"--2");
                //类型返回2表示实验结束，应该将设备输出和页面显示都设置为停止状态，需要调用[OCCenter.shareCenter stop];方法才能停止设备的输出操作，否则不停止
                [self endTestWithFilepath:filePath nBinstate:model.nInput];
                
                break;
            case 3:
                NSLog(@"--3");
                //刷新
                [self refreshBtnWithBinary:model.nInput];
                if(_beginModel.isBegin && !self.isLock){//状态切换的时候记录动作时间的开始时刻
                    testStartSec = model.nSec;
                    testStartNoSec = model.nNanoSec;
                }
                break;
            case 4:
                NSLog(@"--4");
                [self refreshBtnWithBinary:model.nInput];
                
                //计算动作时间
//                if (currentIndex-1<0) {
//                    continue;
//                }
                
                if (_beginModel.isBegin && !self.isLock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //                        if (model.time.second == testStartTime.second) {
                        //                            self.paramSetV.comParam.actionTime = [NSString stringWithFormat:@"%.3f",(float)(model.time.millisecond-testStartTime.millisecond)/pow(10,9)];
                        //
                        //                        }else {
                        //                            self.paramSetV.comParam.actionTime  = [NSString stringWithFormat:@"%.3f",(float)(model.time.second-testStartTime.second)+(float)(model.time.millisecond-testStartTime.millisecond)/pow(10,9)];
                        //
                        //                        }
                        
                        // BD_TestResultModel *upresult = resultArr[currentIndex-1];//当前减去上一个状态的时间
                        float a1=nSec-testStartSec;
                        float a2=nNanoSec/pow(10,9)-testStartNoSec/pow(10,9);
                        float actionTime = a1+a2;
                        
                        BD_ReultInfo *result = [[BD_ReultInfo alloc]init];
                        result.actionTime = actionTime;
                        result.actionValue = [self caculateCurAutoValueWithStep:model.nStep];
                        result.binaryData = model.nInput;
                        
                        if (self.testResultData.isMark == YES) {
                            self.testResultData.returnValue = result.actionValue;
                            self.testResultData.returnTime = result.actionTime;
                            self.testResultData.isMark = NO;//获取到返回值的后将标记置为NO；
                        } else {
                        [self.testResultData.actionInfoArr addObject:result];
                        }
                        [_resultView setValues:kTStrings(result.actionTime) actionValue:kTStrings(result.actionValue) backTime:kTStrings(self.testResultData.returnTime) backValue:kTStrings(self.testResultData.returnValue)];
                    });
                    
                }
                break;
            case 5:
                NSLog(@"--5");
                self.testResultData.isMark = YES;
                [self refreshBtnWithBinary:model.nInput];
                break;
                
            default:
                break;
        }
        
        //获取数据后，刷新信息图中的数据
        [self infomationViewRefreshData:model];
        
    }
}

- (void)refreshBtnWithBinary:(int)nbinall{
    
    //回到主线程更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //开入量变化
        _dataCenter.binarynbinall = nbinall;
        [self DecimalToBinaryWithNumber:nbinall];
    });
}


- (void)endTestWithFilepath:(NSString *)filePath nBinstate:(int)nBinstate{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        [self applicationEnterBackground];
        
        //弹出DocumentInteractionController
        /*
        NSURL *URL = [NSURL fileURLWithPath:filePath];
        
        if (URL) {
            self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
            
            [self.documentInteractionController setDelegate:self];
            
            [self.documentInteractionController presentPreviewAnimated:YES];
        }
      */
        //开入量变化
        [self DecimalToBinaryWithNumber:nBinstate];
        
    });
}

- (void)DecimalToBinaryWithNumber:(int)n
{
    
    int d;
    
    for(int i=0;i<8;i++)
    {
        d=n%2;  //取余,余数
        n=n/2;  //取整
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置btn亮
            if (d == 0) {
                
                UIButton *btn = _resultView.btnsArray1[i];
                
                btn.backgroundColor = [UIColor greenColor];
                
            }
            else if (d == 1){
                
                UIButton *btn = _resultView.btnsArray1[i];
                
                btn.backgroundColor = RGB(234, 234, 234);
                
            }
        });
        
    }
}

#pragma mark - 自动递变计算当前输出的值
-(CGFloat)caculateCurAutoValueWithStep:(NSInteger)stepNum{
    
    if ([self.paramSetV.comParam.startValue floatValue]>[self.paramSetV.comParam.endValue floatValue]) {
        return [self.paramSetV.comParam.startValue floatValue]-stepNum*[self.paramSetV.comParam.stepValue floatValue];
    } else {
        return [self.paramSetV.comParam.startValue floatValue]+stepNum*[self.paramSetV.comParam.stepValue floatValue];
    }
}


#pragma mark - DocumentInteractionController代理方法
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}



#pragma  mark - 数据／波形图／矢量图／状态图／ 点击事件

-(void)topViewBtnClick:(UIButton *)sender{
    DLog(@"点击tag:%ld",(long)sender.tag);
    [_topBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sender]) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
    
    rightBtnArr[0].imageView.image = [UIImage imageNamed:@"rightBtn1"];
    rightBtnArr[1].imageView.image = [UIImage imageNamed:@"rightBtn2"];
    switch (sender.tag) {
        case 100://数据
            DLog(@"点击tag:%ld",(long)sender.tag);
     
           
            [self showVolandCurView];
            break;
        case 101://波形图
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self showOscillographView];
            if (_beginModel.isBegin) {
                [_waveShapeView startTimer];
            }
            
            break;
        case 102://矢量图
            DLog(@"点击tag:%ld",(long)sender.tag);
             [self showVectorgraphView];
            break;
        case 103://状态图
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self showStateView];
            if (_beginModel.isBegin) {
                [_oscillographView startTimer];
            }
            
            
            break;
        case 104://信息图
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self showInformationView];
           
            break;
        case 105://功率图
            DLog(@"点击tag:%ld",(long)sender.tag);
            
        {
            
            [self showPowerView];
            [self loadPowerViewData];
        }
            break;
        case 106://序分量
            DLog(@"点击tag:%ld",(long)sender.tag);
          
        {
            
            [self showSequencerView];
            [self loadSequenceViewData];
        }
            break;
        case 107://线电压
            DLog(@"点击tag:%ld",(long)sender.tag);
           
        {
            
            [self showLineVoltage];
            [self loadLineVoltageViewData];
        }
            break;
        default:
            break;
    }
   
}

#pragma mark - IEC/参数设置／锁／开始／+／-点击事件
-(void)rightViewBtnClick:(BD_QuickTestCustomView *)sender{
  
    [self makeTopBtnDidNotSelected];
    switch (sender.tag) {
        case 10:
            DLog(@"点击tag:%ld",(long)sender.tag);
            
//            rightBtnArr[0].imageView.image = [UIImage imageNamed:@"rightBtn1Selected"];
            rightBtnArr[1].imageView.image = [UIImage imageNamed:@"rightBtn2"];
            [self showIECView];
          
            break;
        case 11:
            DLog(@"点击tag:%ld",(long)sender.tag);
            rightBtnArr[0].imageView.image = [UIImage imageNamed:@"rightBtn1"];
            rightBtnArr[1].imageView.image = [UIImage imageNamed:@"rightBtn2Selected"];
            [self showCommonParamsConfigView];
     
            break;
        case 12:
            DLog(@"点击tag:%ld",(long)sender.tag);
                if (sender.btn.selected) {
                    sender.imageView.image = [UIImage imageNamed:@"rightBtn3"];
                } else {
                    sender.imageView.image = [UIImage imageNamed:@"lockOpen"];
                }
                
            
            [self LockAction:sender.btn];
            break;
        case 13:
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self StartAction:sender.btn];
            
            if (!sender.btn.selected) {
                sender.imageView.image = [UIImage imageNamed:@"rightBtn4"];
            } else {
                sender.imageView.image = [UIImage imageNamed:@"rightBtnStop"];
            }
           
            
            break;
        case 14:
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self plusAction];
            break;
        case 15:
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self reduceAction];
            break;
        default:
            break;
    }
    [sender setNeedsDisplay];
    
}

#pragma mark - 显示测试文件结果
- (IBAction)showFileAction:(id)sender {
    
//    _fileBtn.selected = !_fileBtn.selected;
    NSString *filePath = [kUserDefaults valueForKey:@"manualFilePath"];
    
    NSLog(@"filePath-->%@",filePath);
    
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    
    if (URL) {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Preview PDF
        [self.documentInteractionController presentPreviewAnimated:YES];
    }
}



#pragma mark - 减值
- (void)reduceAction{
   
    NSArray *row = self.paramSetV.pickerModel.row;
//    int column = self.paramSetV.pickerModel.column;
    
    if ([self.paramSetV.pickerModel.title isEqualToString:@"Ua"]) {
        [self reduceAndPlusParamWithTBView:_voltageTV type:OperationTypeReduce];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                [self changeLineDataWithrow:index dataArr:_voltageTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].VAmplitudeArr];
            }
        }
    } else if ([self.paramSetV.pickerModel.title isEqualToString:@"Ia"]){
        [self reduceAndPlusParamWithTBView:_currentTV type:OperationTypeReduce];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                  [self changeLineDataWithrow:index dataArr:_currentTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].CAmplitudeArr];
                
            }
        }
     
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            
            [[OCCenter shareCenter] ManualTest:_quickTestData];
            
        }
    });
    
}

#pragma mark - 加值
- (void)plusAction{
    NSArray *row = self.paramSetV.pickerModel.row;
//    int column = self.paramSetV.pickerModel.column;
    if ([self.paramSetV.pickerModel.title isEqualToString:@"Ua"]) {
        [self reduceAndPlusParamWithTBView:_voltageTV type:OperationTypePluse];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                  [self changeLineDataWithrow:index dataArr:_voltageTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].VAmplitudeArr];
            }
        }
        
    }else if ([self.paramSetV.pickerModel.title isEqualToString:@"Ia"]){
        [self reduceAndPlusParamWithTBView:_currentTV type:OperationTypePluse];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                 [self changeLineDataWithrow:index dataArr:_currentTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].CAmplitudeArr];
            }
        }
        
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            [[OCCenter shareCenter] ManualTest:_quickTestData];
        }
    });
    
}


//+ - 通用方法   tbview:数据页面6u6itableView type : 运算类型
-(void)reduceAndPlusParamWithTBView:(BD_QuickTestParamTBView *)tbView type:(OperationType)type{
    NSArray *row = self.paramSetV.pickerModel.row; //包含的选择的行
    int column = self.paramSetV.pickerModel.column;
    
    
    for (NSNumber *i in row) {
        //根据参数设置，计算要改变的行的数据
        int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
        switch (column) {
            case 1:
                if (type == OperationTypePluse) {
                    
                    tbView.datasource[index].amplitude = [NSString stringWithFormat:@"%.3f",tbView.datasource[index].amplitude.floatValue+_paramSetV.comParam.stepValue.floatValue];
                } else {
                    tbView.datasource[index].amplitude = [NSString stringWithFormat:@"%.3f",tbView.datasource[index].amplitude.floatValue-_paramSetV.comParam.stepValue.floatValue];
                }
                if ([tbView isEqual:_voltageTV]) {
                    [self VolandCurDataLimit:tbView.datasource[index].amplitude type:BD_CellTypeVoltage column:column block:^(NSString *newText) {
                        tbView.datasource[index].amplitude = newText;
                        [self changeOutputWaveDataL:tbView index:index changeType:QuickTestParamModelChangeItemType_Amplitude changeData:newText changeModel:nil];
                    }];
                } else if([tbView isEqual:_currentTV]){
                    [self VolandCurDataLimit:tbView.datasource[index].amplitude type:BD_CellTypeCurrent column:column block:^(NSString *newText) {
                        tbView.datasource[index].amplitude = newText;
                          [self changeOutputWaveDataL:tbView index:index changeType:QuickTestParamModelChangeItemType_Amplitude changeData:newText changeModel:nil];
                    }];
                }
                break;
            case 2:
                if (type == OperationTypePluse) {
                    tbView.datasource[index].phase = [NSString stringWithFormat:@"%.3f",tbView.datasource[index].phase.floatValue+_paramSetV.comParam.stepValue.floatValue];
                } else {
                    tbView.datasource[index].phase = [NSString stringWithFormat:@"%.3f",tbView.datasource[index].phase.floatValue-_paramSetV.comParam.stepValue.floatValue];
                }
                if ([tbView isEqual:_voltageTV]) {
                    [self VolandCurDataLimit:tbView.datasource[index].phase type:BD_CellTypeVoltage column:column block:^(NSString *newText) {
                        tbView.datasource[index].phase = newText;
                        [self changeOutputWaveDataL:tbView index:index changeType:QuickTestParamModelChangeItemType_Phase changeData:newText changeModel:nil];
                    }];
                } else if([tbView isEqual:_currentTV]){
                    [self VolandCurDataLimit:tbView.datasource[index].phase type:BD_CellTypeCurrent column:column block:^(NSString *newText) {
                        tbView.datasource[index].phase = newText;
                        [self changeOutputWaveDataL:tbView index:index changeType:QuickTestParamModelChangeItemType_Phase changeData:newText changeModel:nil];
                    }];
                }
                break;
            case 3:
                if (type == OperationTypePluse) {
                    tbView.datasource[index].frequency = [NSString stringWithFormat:@"%.3f",tbView.datasource[index].frequency.floatValue+_paramSetV.comParam.stepValue.floatValue];
                } else {
                    tbView.datasource[index].frequency = [NSString stringWithFormat:@"%.3f",tbView.datasource[index].frequency.floatValue-_paramSetV.comParam.stepValue.floatValue];
                }
                if ([tbView isEqual:_voltageTV]) {
                    [self VolandCurDataLimit:tbView.datasource[index].frequency type:BD_CellTypeVoltage column:column block:^(NSString *newText) {
                        tbView.datasource[index].frequency = newText;
                        [self changeOutputWaveDataL:tbView index:index changeType:QuickTestParamModelChangeItemType_Frequency changeData:newText changeModel:nil];
                    }];
                } else if([tbView isEqual:_currentTV]){
                    [self VolandCurDataLimit:tbView.datasource[index].frequency type:BD_CellTypeCurrent column:column block:^(NSString *newText) {
                        tbView.datasource[index].frequency = newText;
                        [self changeOutputWaveDataL:tbView index:index changeType:QuickTestParamModelChangeItemType_Frequency changeData:newText changeModel:nil ];
                    }];
                }
                break;
            default:
                break;
        }
        
       
    
    }
    [tbView reloadData];
}

-(BOOL)VolandCurDataLimit:(NSString *)newText type:(BD_CellType)type column:(int)column block:(void(^)(NSString *))block{
    NSString *eCur = _hardWareView.viewModel.exchangeCurrent;
    NSString *eVol = _hardWareView.viewModel.exchangeVoltage;
    NSString *dCur = _hardWareView.viewModel.directCurrent;
    NSString *dVol = _hardWareView.viewModel.directVoltage;
    
    if (![BD_PMCtrlSingleton shared].quickTestisCocurrent) {
        //交流范围限制
            if ((column == 1 && (int)type == (int)BD_CellTypeVoltage && ABS(newText.floatValue)>[eVol floatValue])) {
                
                newText =  eVol;//120
                block(newText);
                return NO;
            }else if(column == 1 && (int)type == (int)BD_CellTypeCurrent && ABS(newText.floatValue)>[eCur floatValue]) {
                
                newText = eCur;//20
                block(newText);
                return NO;
            }
            
            return NO;
      
    } else {
        //直流范围限制
        //交流范围限制
        if ((column == 1 && (int)type == (int)BD_CellTypeVoltage && ABS(newText.floatValue)>[dVol floatValue])) {
            
            newText = dVol;//300.000
            block(newText);
            return NO;
        }else if(column == 1 && (int)type == (int)BD_CellTypeCurrent && ABS(newText.floatValue)>[dCur floatValue]) {
            
            newText = dCur;
            block(newText);
            return NO;
        }
    }

    if (column == 2 &&ABS(newText.floatValue)>180){
        newText =   @"180.000";
        block(newText);
        return NO;
    }
    else if (column == 3 && ABS(newText.floatValue)>1000){
        newText =   @"1000.000";
        block(newText);
        return NO;
       
    } else if (newText.floatValue<0 && column != 2){
        newText =   @"0.000";
        block(newText);
        return NO;
    } else {
        block(newText);
        return YES;
    }
    
    return YES;
}


#pragma mark - Lockli
//点击lock，不能继续进行数据发送
- (void)LockAction:(UIButton *)sender {
    
    //切换按钮当前状态
    if (_beginModel.isBegin == 1) {  //在测试为开始状态下，锁按钮不好使
        sender.selected = !sender.selected;
        self.isLock = !self.isLock;
        self.paramSetV.comParam.isLock = self.isLock;
        [self configTBViewLockandBeginState];
//        if (!self.isLock) {
            //下发数组参数
            [[OCCenter shareCenter] ManualTest:_quickTestData];
            
//        }
    }
    
}


#pragma mark - 开始测试
- (void)StartAction:(UIButton *)sender {
    
    //开发测试阶段使用

//    [self actionBeginShowDeviceTestResultView];
    
    _paramSetV.comParam.isLock = _isLock;
    if (_quickTestData.count == 3) {
        [_quickTestData removeLastObject];
    }
    [_quickTestData addObject:[[NSMutableArray alloc]initWithArray:@[_paramSetV.comParam]]];
    
    //点击start
    if (!sender.selected) {
        //下发测试参数
        bool isSuc = [[OCCenter shareCenter] ManualTest:_quickTestData];
                
        //如果成功，发送start命令开始测试
        if (isSuc) {
            
            sender.selected = !sender.selected;
            //如果链接实验设备成功 显示指示灯view
           
            [self actionBeginShowDeviceTestResultView];
            
            
            _beginModel.isBegin = !_beginModel.isBegin;
            [self configTBViewLockandBeginState];
//            self.myParaV.BinChangedStop.userInteractionEnabled = NO;
            //隐藏返回按钮
            self.navigationItem.hidesBackButton = YES;
            
            int result = [OCCenter.shareCenter start:1];
            NSLog(@"startResult:%d",result);
        }
        //不成功，弹出提示框
        else{
            [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }];
            
            return;
        }
        
    }
    else{
        
        //stop
        //隐藏返回按钮
        sender.selected = !sender.selected;
        self.navigationItem.hidesBackButton = NO;
//        self.myParaV.BinChangedStop.userInteractionEnabled = YES;
        int result = [OCCenter.shareCenter stop];
        
//        [self closeLights];
        NSLog(@"%d",result);
        
        _beginModel.isBegin = !_beginModel.isBegin;
        [self configTBViewLockandBeginState];
    }
   
}

#pragma mark - IECView
-(void)showIECView{
    BD_IECTabBarVC *iecTabVC = [[UIStoryboard storyboardWithName:@"IECConfig" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"BD_IECTabBarVCID"];
    [self.navigationController pushViewController:iecTabVC animated:YES];
}
#pragma mark - 参数设置页面
-(void)showCommonParamsConfigView{
   _paramScrollView.contentOffset = CGPointMake(8*_paramScrollView.width,0);
}


#pragma mark - 矢量图页面
-(void)showVectorgraphView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self computationsVectorgraphViewData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_vectorgraphView reloadData];
            self.paramScrollView.contentOffset = CGPointMake(2*self.paramScrollView.width, 0);
        });
    });

    
}

#pragma mark - 计算矢量图数据算法

-(void)computationsVectorgraphViewData{
    NSMutableArray *vecArr = [[NSMutableArray alloc]init];
    NSInteger totalNum = _voltageTV.datasource.count<_currentTV.datasource.count?_voltageTV.datasource.count/3:_currentTV.datasource.count/3;
    for (int i = 0; i<totalNum; i++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (_voltageTV.datasource.count == 4) {
            for(int j = 0;j<4;j++){
                BD_QuickTestVactorgraphModel_Base *base_U = [[BD_QuickTestVactorgraphModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName Amplitude:_voltageTV.datasource[j].amplitude Phase:_voltageTV.datasource[j].phase Frequency:_voltageTV.datasource[j].frequency];
                if (j<3) {
                     BD_QuickTestVactorgraphModel_Base *base_C = [[BD_QuickTestVactorgraphModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName Amplitude:_currentTV.datasource[j].amplitude Phase:_currentTV.datasource[j].phase Frequency:_currentTV.datasource[j].frequency];
                    [CArr addObject:base_C];
                }
               
                [UArr addObject:base_U];
                
            }
        } else {
            for (int j = 3*i; j<(i+1)*3;j++) {
                BD_QuickTestVactorgraphModel_Base *base_U = [[BD_QuickTestVactorgraphModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName Amplitude:_voltageTV.datasource[j].amplitude Phase:_voltageTV.datasource[j].phase Frequency:_voltageTV.datasource[j].frequency];
                BD_QuickTestVactorgraphModel_Base *base_C = [[BD_QuickTestVactorgraphModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName Amplitude:_currentTV.datasource[j].amplitude Phase:_currentTV.datasource[j].phase Frequency:_currentTV.datasource[j].frequency];
                [UArr addObject:base_U];
                [CArr addObject:base_C];
            }
        }
        
        BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
        [vecArr addObject:model];
    }
    
    NSInteger otherNum =  abs((int)(_voltageTV.datasource.count-_currentTV.datasource.count))/3;
    
    for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (_voltageTV.datasource.count>_currentTV.datasource.count) {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_QuickTestVactorgraphModel_Base *base_U = [[BD_QuickTestVactorgraphModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName Amplitude:_voltageTV.datasource[j].amplitude Phase:_voltageTV.datasource[j].phase Frequency:_voltageTV.datasource[j].frequency];
               [UArr addObject:base_U];
               
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        } else {
            for (int j = 3*n; j<(n+1)*3;j++) {
                 BD_QuickTestVactorgraphModel_Base *base_C = [[BD_QuickTestVactorgraphModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName Amplitude:_currentTV.datasource[j].amplitude Phase:_currentTV.datasource[j].phase Frequency:_currentTV.datasource[j].frequency];
                [CArr addObject:base_C];
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        }
        
        
    }
    
    _vectorgraphView.drawViewDataSource = vecArr;
    [_vectorgraphView createCellSelectedArr];
}

#pragma mark - 实时波形图页面
-(void)showOscillographView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:[_quickTestData copy]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_waveShapeView reloadData];
            self.paramScrollView.contentOffset = CGPointMake(self.paramScrollView.width, 0);
        });
    });
  
}
#pragma mark - 状态图页面
-(void)showStateView{
    
   self.paramScrollView.contentOffset = CGPointMake(3*self.paramScrollView.width, 0);
   
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        NSMutableArray *plistArr = [[NSMutableArray alloc]init];
    //        NSMutableArray *Ua = [[NSMutableArray alloc]init];
    //        NSMutableArray *Ub = [[NSMutableArray alloc]init];
    //        NSMutableArray *Uc = [[NSMutableArray alloc]init];
    //        NSMutableArray *Ia = [[NSMutableArray alloc]init];
    //        NSMutableArray *Ib = [[NSMutableArray alloc]init];
    //        NSMutableArray *Ic = [[NSMutableArray alloc]init];
    //
    //        [Ua removeAllObjects];
    //        [Ub removeAllObjects];
    //        [Uc removeAllObjects];
    //        [Ia removeAllObjects];
    //        [Ib removeAllObjects];
    //        [Ic removeAllObjects];
    //
    //        for (int i = 0; i<11; i++) {
    //
    //            [Ua  addObject:_voltage1TV.datasource[0].amplitude];
    //            [Ub addObject:_voltage1TV.datasource[1].amplitude];
    //            [Uc addObject:_voltage1TV.datasource[2].amplitude];
    //            [Ia addObject:_current1TV.datasource[0].amplitude];
    //            [Ib  addObject:_current1TV.datasource[1].amplitude];
    //            [Ic addObject:_current1TV.datasource[2].amplitude];
    //
    //        }
    //
    //        NSDictionary *dic1 = @{@"dic1":@[Ua,Ub,Uc,Ia,Ib,Ic]};
    //
    //        [Ua removeAllObjects];
    //        [Ub removeAllObjects];
    //        [Uc removeAllObjects];
    //        [Ia removeAllObjects];
    //        [Ib removeAllObjects];
    //        [Ic removeAllObjects];
    //        for (int i = 0; i<11; i++) {
    //
    //            [Ua   addObject:_voltage2TV.datasource[0].amplitude];
    //            [Ub addObject:_voltage2TV.datasource[1].amplitude];
    //            [Uc addObject:_voltage2TV.datasource[2].amplitude];
    //            [Ia  addObject:_current2TV.datasource[0].amplitude];
    //            [Ib addObject:_current2TV.datasource[1].amplitude];
    //            [Ic addObject:_current2TV.datasource[2].amplitude];
    //
    //        }
    //        NSDictionary *dic2 = @{@"dic2":@[Ua,Ub,Uc,Ia,Ib,Ic]};
    //        [plistArr addObject:dic1];
    //        [plistArr addObject:dic2];
    //        [FileUtil saveInfoToPlist:@"oscillograph.plist" dic:@{@"root":plistArr}];
    //    });
    //
    
    
    
}

#pragma mark - 信息图页面
-(void)showInformationView{
    
     self.paramScrollView.contentOffset = CGPointMake(4*self.paramScrollView.width, 0);
}

#pragma mark - 功率页面
-(void)showPowerView{
    
    self.paramScrollView.contentOffset = CGPointMake(5*self.paramScrollView.width, 0);
}
#pragma mark - 序分量页面
-(void)showSequencerView{
    
    self.paramScrollView.contentOffset = CGPointMake(6*self.paramScrollView.width, 0);
}
#pragma mark - 功率页面
-(void)showLineVoltage{
    
    self.paramScrollView.contentOffset = CGPointMake(7*self.paramScrollView.width, 0);
}
//测试仪数据上传到移动端，刷新信息图
-(void)infomationViewRefreshData:(BD_TestResultModel *)result{
    _infomationView.isScrollTBView = NO;
    BD_TestInformationModel *model = [[BD_TestInformationModel alloc]init];
    model.infoindex = (int) _infomationView.infoDataSource.count+1;
    model.currentTime = [BD_Utils getCurrentDate];
    model.actionType = (BDActionType)result.nType;
    model.binaryIn = [self binaryInToString:result.nInput];
    if (result.nType == 4) {
        if (self.testResultData.actionInfoArr.count!=0) {
            model.actionTime = [NSString stringWithFormat:@"%.6f",[self.testResultData.actionInfoArr lastObject].actionTime];//信息图中显示6位小数
        }
       
    }
    [_infomationView.infoDataSource addObject:model];
    [_infomationView reloadData];
}

//将返回到十进制
-(NSString *)binaryInToString:(int)n{
    NSString *resultStr = @"";
        int d;
        for(int i=0;i<8;i++)
        {
            d=n%2;  //取余,余数
            n=n/2;  //取整
            [resultStr stringByAppendingString:[NSString stringWithFormat:@"%d",d]];
        }
    return resultStr;
}
#pragma mark - 添加6相电流 电压 幅值 相位 频率 数据view
-(void)addVolandCurView{
    
    WeakSelf;
    
    UIView *dataView = [[UIView alloc]init];
    if (!_voltageTV) {
        BD_QuickTestParamTBView *voltageTV = [[BD_QuickTestParamTBView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _voltageTV = voltageTV;
        _voltageTV.type = BD_CellTypeVoltage;
        _voltageTV.headerTitleArr = @[@"幅值(V)",@"相位(Deg)",@"频率(Hz)"];
        _voltageTV.quickTBParaBlack = ^(BD_TestDataParamModel *cellModel, NSInteger index) {
            
            [weakself.quickTestData[0] replaceObjectAtIndex:index withObject:cellModel];
            [weakself changeLineDataWithrow:index dataArr:weakself.quickTestData[0] lineData:weakself.oscillographDataArr[weakself.paramSetV.pickerModel.group].VAmplitudeArr];
            
            [weakself changeOutputWaveDataL:weakself.voltageTV index:index changeType:QuickTestParamModelChangeItemType_All changeData:nil changeModel:cellModel];
            
            [weakself.voltageTV reloadData];
            
            if (_beginModel.isBegin == 1 && self.isLock == 0) {
                [[OCCenter shareCenter] ManualTest:[weakself.quickTestData mutableCopy]];
            }
        };
        
        [_paramScrollView addSubview:_voltageTV];
    }
    
    
    
    
    
    if (!_currentTV) {
        BD_QuickTestParamTBView *currentTV = [[BD_QuickTestParamTBView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _currentTV = currentTV;
        _currentTV.type = BD_CellTypeCurrent;
        _currentTV.headerTitleArr = @[@"幅值(A)",@"相位(Deg)",@"频率(Hz)"];
        _currentTV.quickTBParaBlack = ^(BD_TestDataParamModel *cellModel, NSInteger index) {
            [weakself.quickTestData[1] replaceObjectAtIndex:index withObject:cellModel];
            
            [weakself changeLineDataWithrow:index dataArr:weakself.quickTestData[1] lineData:weakself.oscillographDataArr[weakself.paramSetV.pickerModel.group].CAmplitudeArr];
            [weakself changeOutputWaveDataL:weakself.currentTV index:index changeType:QuickTestParamModelChangeItemType_All changeData:nil changeModel:cellModel];
            [weakself.currentTV reloadData];
            if (_beginModel.isBegin == 1 && self.isLock == 0) {
                [[OCCenter shareCenter] ManualTest:[weakself.quickTestData mutableCopy]];
            }
        };
        [_paramScrollView addSubview:_currentTV];
    }

    
    [self configTBViewLockandBeginState];
    
  
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _voltageTV.datasource = self.quickTestData[0];
        _currentTV.datasource = self.quickTestData[1];
        [self caculateVolCurrEffectiveValue];
        
    });
    
    [dataView addSubview:_voltageTV];
    [dataView addSubview:_currentTV];
   
    [_pageViewArr addObject:dataView];

}


#pragma mark - 显示6相电流 电压 幅值 相位 频率 数据view
-(void)showVolandCurView{
    
    
    
    self.paramScrollView.contentOffset = CGPointMake(0, 0);
  
 
    
}
#pragma mark - 根据额定电压和额定电流，额定功率计算输出数据

-(void)caculateVolCurrEffectiveValue{
  
    [_voltageTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.amplitude = [NSString stringWithFormat:@"%.3f",[_paramSetV.comParam.rateVoltage floatValue]/sqrt(3)];
        obj.frequency = [NSString stringWithFormat:@"%.3f",[_paramSetV.comParam.rateFrequency floatValue]];
        
    }];
    
    [_currentTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.amplitude = [NSString stringWithFormat:@"%.3f",[_paramSetV.comParam.rateCurrent floatValue]] ;
        obj.frequency = [NSString stringWithFormat:@"%.3f",[_paramSetV.comParam.rateFrequency floatValue]] ;
        
    }];
    
//    _voltageTV.datasource = self.quickTestData[0];
//    _currentTV.datasource = self.quickTestData[1];
    
    [_voltageTV reloadData];
    [_currentTV reloadData];

}


-(void)configTBViewLockandBeginState{
    _voltageTV.isBegin = _beginModel.isBegin;
    _voltageTV.isLock = self.isLock;
   
    _currentTV.isBegin = _beginModel.isBegin;
    _currentTV.isLock = self.isLock;
   
    
    [_voltageTV reloadData];
    [_currentTV reloadData];
  
    
}

#pragma mark - 创建测试结果，指示灯view

-(void)actionBeginShowDeviceTestResultView{
    [_resultView transitionWithType:kCATransitionPush withSubType:kCATransitionFromTop withDuration:0.5];
    
    [_resultView setFrame:CGRectMake(_paramScrollView.frame.origin.x,self.view.height-150, _paramScrollView.width, 150)];
}
-(void)removeDeviceTestResultView{
    
    [_resultView setFrame:CGRectMake(_paramScrollView.frame.origin.x,self.view.height, _paramScrollView.width, 150)];
    [_resultView transitionWithType:kCATransitionPush withSubType:kCATransitionFromBottom withDuration:0.5];
    
}



#pragma mark - 测试结果页面添加手势
-(void)addGesture{

    
    
    UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.view addGestureRecognizer:swipeGestureRecognizerUp];
//    [_resultView addGestureRecognizer:swipeGestureRecognizerUp];
    swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
   
    UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    [self.view addGestureRecognizer:swipeGestureRecognizerDown];
    [_resultView addGestureRecognizer:swipeGestureRecognizerDown];
    swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
 
    
}

/**
 *  处理轻扫手势
 *
 *  @param recognizer 轻扫手势识别器对象实例
 */
- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
   
    //代码块方式封装操作方法
    //    void (^positionOperation)() = ^() {
    //        CGPoint newPoint = recognizer.view.center;
    //        newPoint.y -= 20.0;
    //        self.center = newPoint;
    //        newPoint.y += 40.0;
    //        self.center = newPoint;
    //    };
    
    //根据轻扫方向，进行不同控制
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            
            break;
        }
        case UISwipeGestureRecognizerDirectionUp: {
            [self actionBeginShowDeviceTestResultView];
            break;
        }
        case UISwipeGestureRecognizerDirectionDown: {
            [self removeDeviceTestResultView];
            break;
        }
    }
}

#pragma mark - 初始化波形图页面的数据
-(void)loadoscillographData:(void(^)(NSMutableArray *))complete{
    _oscillographDataArr = [[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger totalNum = _voltageTV.datasource.count<_currentTV.datasource.count?_voltageTV.datasource.count/3:_currentTV.datasource.count/3;
        for (int i = 0; i<totalNum;i++) {
            NSMutableArray *UArr = [[NSMutableArray alloc]init];
            NSMutableArray *CArr = [[NSMutableArray alloc]init];
            
            if (_voltageTV.datasource.count == 4) {
                for(int j = 0;j<4;j++){
                  
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];
                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                    for (int i = 0; i<11; i++) {
                        [Umodel addObject:_voltageTV.datasource[j].amplitude];
                        if (j<3) {
                             [Cmodel addObject:_currentTV.datasource[j].amplitude];
                        }
                    }
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName model:Umodel];
                    if (j<3) {
                         BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName model:Cmodel];
                        [CArr addObject:Cbase];
                    }
                    [UArr addObject:Ubase];
 
                }
            } else {
                for (int j = 3*i; j<(i+1)*3;j++) {
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];
                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                    for (int i = 0; i<11; i++) {
                        [Umodel addObject:_voltageTV.datasource[j].amplitude];
                        [Cmodel addObject:_currentTV.datasource[j].amplitude];
                    }
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName model:Umodel];
                    BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName model:Cmodel];
                    
                    [UArr addObject:Ubase];
                    [CArr addObject:Cbase];
                }
            }
            
            
            BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
            [_oscillographDataArr addObject:os];
        }
        
        NSInteger otherNum =  abs((int)(_voltageTV.datasource.count-_currentTV.datasource.count))/3;
        
        for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
            NSMutableArray *UArr = [[NSMutableArray alloc]init];
            NSMutableArray *CArr = [[NSMutableArray alloc]init];
            if (_voltageTV.datasource.count>_currentTV.datasource.count) {
                for (int j = 3*n; j<(n+1)*3;j++) {
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];
                   
                    for (int i = 0; i<11; i++) {
                        [Umodel addObject:_voltageTV.datasource[j].amplitude];
                        
                    }
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName model:Umodel];
                   
                    
                    [UArr addObject:Ubase];
                }
                
                BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
                [_oscillographDataArr addObject:os];
            } else {
                for (int j = 3*n; j<(n+1)*3;j++) {
                    
                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                    for (int i = 0; i<11; i++) {
                       [Cmodel addObject:_currentTV.datasource[j].amplitude];
                        
                    }
                   
                    BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName model:Cmodel];
                    
                   
                    [CArr addObject:Cbase];
                }
                BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
                [_oscillographDataArr addObject:os];
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(_oscillographDataArr);
            _oscillographView.lineDataSourceArr = _oscillographDataArr;
         //状态图页面刷新显示数据后，更新selectedarr中的数据
            [_oscillographView.selectedDataArr removeAllObjects];
            for (int i = 0; i<_oscillographDataArr.count; i++) {
                BD_OutputwaveShapeDataModel *model;
                if (_oscillographDataArr[i].VAmplitudeArr.count !=0 && _oscillographDataArr[i].CAmplitudeArr.count !=0 ) {
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                } else if (_oscillographDataArr[i].VAmplitudeArr.count ==0){
                      model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]init] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                } else if (_oscillographDataArr[i].CAmplitudeArr.count ==0){
                      model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]init]];
                }
                
                
                [_oscillographView.selectedDataArr addObject:model];
            }
            //状态图页面刷新后，修改titleArr中的数据
            [_oscillographView.titleArr removeAllObjects];
            for (int i = 0; i<_oscillographDataArr.count; i++) {
                    NSMutableArray *titleArr = [[NSMutableArray alloc]init];
                    for (BD_QuickTestOscillographModel_Base *base in _oscillographDataArr[i].VAmplitudeArr) {
                        [titleArr addObject:base.title];
                    }
                    for (BD_QuickTestOscillographModel_Base *base in _oscillographDataArr[i].CAmplitudeArr) {
                        [titleArr addObject:base.title];
                    }
                    [_oscillographView.titleArr addObject:titleArr];
            }
            [_oscillographView.tableView reloadData];
        });
        
        
        
    });
}



//数据页面数据改变后，改变oscillographDataArr(状态图)页面的数据
-(void)changeLineDataWithrow:(NSInteger)row dataArr:(NSMutableArray *)tbArray lineData:(NSMutableArray<BD_QuickTestOscillographModel_Base *> *)lineDataArr{
    
    WeakSelf;
    NSInteger arrRow = row-3*self.paramSetV.pickerModel.group;
    if (weakself.oscillographDataArr) {
        NSString *change = ((BD_TestDataParamModel *)tbArray[row]).amplitude;
        switch (arrRow) {
            case 0:
                [lineDataArr[0].model removeObjectAtIndex:0];
                [lineDataArr[0].model   addObject:change];
                break;
            case 1:
                [lineDataArr[1].model  removeObjectAtIndex:0];
                [lineDataArr[1].model   addObject:change];
              
                break;
            case 2:
                
                [lineDataArr[2].model  removeObjectAtIndex:0];
                [lineDataArr[2].model   addObject:change];
                break;
            default:
                break;
        }
        
    }
}



#pragma mark - 创建开入开出状态图数据源
-(void)updateBinaryStateDatas:(int)binaryAll{
    int d;
    for(int i=0;i<8;i++)
    {
        d=binaryAll%2;  //取余,余数
        binaryAll=binaryAll/2;  //取整
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置btn亮
            if (d == 0) {
                
                UIButton *btn = _resultView.btnsArray1[i];
                btn.backgroundColor = [UIColor greenColor];
                btn.userInteractionEnabled = YES;
            }
            else if (d == 1){
                
                UIButton *btn = _resultView.btnsArray1[i];
                btn.backgroundColor = [UIColor lightGrayColor];
                btn.userInteractionEnabled = NO;
                
            }
        });
    }
}
#pragma mark - BDBinaryChangedProtocol
//开入量设置通道指示灯是否可用
-(void)changeBinaryState:(int)binaryNum{
    int d;
    for(int i=0;i<8;i++)
    {
        d=binaryNum%2;  //取余,余数
        binaryNum=binaryNum/2;  //取整
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置btn亮
            if (d == 1) {
                
                UIButton *btn = _resultView.btnsArray1[i];
                btn.backgroundColor = RGB(234, 234, 234);
                btn.userInteractionEnabled = YES;
            }
            else if (d == 0){
                
                UIButton *btn = _resultView.btnsArray1[i];
                
                btn.backgroundColor = [UIColor lightGrayColor];
                btn.userInteractionEnabled = NO;
            }
        });
    }
}

//根据递变方式设置返回值和返回时间是否显示
-(void)changeResultViewBackViewShow:(int)autoChangeStyle{
    [_resultView setBackViewsShow:autoChangeStyle];
}
//修改了额定电压，额定电流，额定频率。   
-(void)changeRateVolCurrFre{
    [self caculateVolCurrEffectiveValue];
}
#pragma mark - BD_QuickTestGetOscillographDataDelegate 状态图页面主动获取数据delegate
-(void)refreshData{
    if (_beginModel.isBegin) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            for (BD_QuickTestOscillographModel *model in _oscillographDataArr) {
                NSLog(@"------刷新页面啦-----");
                for (int i = 0; i<model.VAmplitudeArr.count;i++) {
                    [model.VAmplitudeArr[i].model removeObjectAtIndex:0];
                    [model.VAmplitudeArr[i].model addObject:[model.VAmplitudeArr[i].model lastObject]];
                }
                
                for (int i = 0; i<model.CAmplitudeArr.count;i++) {
                    [model.CAmplitudeArr[i].model removeObjectAtIndex:0];
                    [model.CAmplitudeArr[i].model addObject:[model.CAmplitudeArr[i].model lastObject]];
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_oscillographView.tableView reloadData];
            });
        });

    } else {
        
        //在未开始状态下，置为0后，不在进行修改
        if(![_oscillographDataArr[0].VAmplitudeArr[0].model[0] isEqualToString:@"0.000"]){
            [self setOscillographDataToZero];
        }
    }
    
}

-(void)setOscillographDataToZero{
    for (BD_QuickTestOscillographModel *model in _oscillographDataArr) {
        DLog(@"---无输出----");
        for (int n = 0; n<model.VAmplitudeArr.count; n++) {
            for (int i = 0; i<model.VAmplitudeArr[n].model.count ; i++) {
                [model.VAmplitudeArr[n].model replaceObjectAtIndex:i withObject:@"0.000"];
            }
            
        }
        for (int n = 0; n<model.CAmplitudeArr.count; n++) {
            for (int i = 0; i<model.CAmplitudeArr[n].model.count ; i++) {
                [model.CAmplitudeArr[n].model replaceObjectAtIndex:i withObject:@"0.000"];
            }
            
        }
        
        
    }
    _oscillographView.lineDataSourceArr = _oscillographDataArr;
    [_oscillographView.tableView reloadData];
}

#pragma mark - BD_OutputwaveShapeAutoRefreshDataDelegate 实时波形图页面自动刷新更新数据delegate
-(void)refreshOutputwaveData{
    
    [_waveShapeView reloadData];
}


-(void)changeOutputWaveDataL:(UITableView *)tbView index:(NSInteger)cellIndex changeType:(QuickTestParamModelChangeItemType)changeType changeData:( NSString * _Nullable )changeData changeModel:(BD_TestDataParamModel * _Nullable)changeModel{
    if ([tbView isEqual:_voltageTV]) {
        NSInteger arrIndex = cellIndex/3;
        NSInteger modelIndex = cellIndex%3;
        if (_waveShapeView.dataArr[0].voltageArr.count == 4) {
            arrIndex = 0;
            modelIndex = 3;
        }
        BD_TestDataParamModel *changeItem = _waveShapeView.dataArr[arrIndex].voltageArr[modelIndex];
        switch (changeType) {
            case QuickTestParamModelChangeItemType_Amplitude:
                changeItem.amplitude = changeData;
                break;
            case QuickTestParamModelChangeItemType_Phase:
                changeItem.phase = changeData;
                break;
            case QuickTestParamModelChangeItemType_Frequency:
                changeItem.frequency = changeData;
                break;
            case QuickTestParamModelChangeItemType_All:
                changeItem.amplitude = changeModel.amplitude;
                changeItem.phase = changeModel.phase;
                changeItem.frequency = changeModel.frequency;
            default:
                break;
        }
    } else if ([tbView isEqual:_currentTV]){
        NSInteger arrIndex = cellIndex/3;
        NSInteger modelIndex = cellIndex%3;
        BD_TestDataParamModel *changeItem = _waveShapeView.dataArr[arrIndex].currentArr[modelIndex];
        switch (changeType) {
            case QuickTestParamModelChangeItemType_Amplitude:
                changeItem.amplitude = changeData;
                break;
            case QuickTestParamModelChangeItemType_Phase:
                changeItem.phase = changeData;
                break;
            case QuickTestParamModelChangeItemType_Frequency:
                changeItem.frequency = changeData;
                break;
            case QuickTestParamModelChangeItemType_All:
                changeItem.amplitude = changeModel.amplitude;
                changeItem.phase = changeModel.phase;
                changeItem.frequency = changeModel.frequency;
            default:
                break;
        }
    }
}
#pragma mark - 构建功率图数据
-(void)loadPowerViewData{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSInteger groupNum = _voltageTV.datasource.count/3;
    for (NSInteger i = 0; i<groupNum; i++) {
        NSString *a = [NSString stringWithFormat:@"%.3f",[BD_CaculatePowerManager getpowerElementWithVData:_voltageTV.datasource[3*i+0] CData:_currentTV.datasource[3*i+0]]];
        NSString *b = kTStrings([BD_CaculatePowerManager getpowerElementWithVData:_voltageTV.datasource[3*i+1] CData:_currentTV.datasource[3*i+1]]);
        NSString *c = kTStrings([BD_CaculatePowerManager getpowerElementWithVData:_voltageTV.datasource[3*i+2] CData:_currentTV.datasource[3*i+2]]);
        
        BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
        model1.modelDatas = @[@"功率因数",a,b,c,@""];
        
        float archive_a = [BD_CaculatePowerManager getActivePowerWithVData:_voltageTV.datasource[3*i+0] CData:_currentTV.datasource[3*i+0]];
        float archive_b = [BD_CaculatePowerManager getActivePowerWithVData:_voltageTV.datasource[3*i+1] CData:_currentTV.datasource[3*i+1]];
        float archive_c = [BD_CaculatePowerManager getActivePowerWithVData:_voltageTV.datasource[3*i+2] CData:_currentTV.datasource[3*i+2]];
        
        BD_FormTBViewBaseModel *model2 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
        model2.modelDatas = @[@"有功功率W", kTStrings(archive_a), kTStrings(archive_b), kTStrings(archive_c), kTStrings(archive_a+archive_b+archive_c)];
        
        float rearchive_a = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[3*i+0] CData:_currentTV.datasource[3*i+0]];
        float rearchive_b = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[3*i+1] CData:_currentTV.datasource[3*i+1]];
        float rearchive_c = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[3*i+2] CData:_currentTV.datasource[3*i+2]];
        
        BD_FormTBViewBaseModel *model3 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
        model3.modelDatas = @[@"无功功率Var",kTStrings(rearchive_a), kTStrings(rearchive_b), kTStrings(rearchive_c), kTStrings(rearchive_a+rearchive_b+rearchive_c)];
        
        float ap_a = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[3*i+0] CData:_currentTV.datasource[3*i+0]];
        float ap_b = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[3*i+1] CData:_currentTV.datasource[3*i+1]];
        float ap_c = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[3*i+2] CData:_currentTV.datasource[3*i+2]];
        
        BD_FormTBViewBaseModel *model4 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
        model4.modelDatas = @[@"现在功率VA",kTStrings(ap_a), kTStrings(ap_b), kTStrings(ap_c), kTStrings(ap_a+ap_b+ap_c)];
        NSArray *value = @[model1,model2,model3,model4];
        [arr addObject:value];
    }
    
    self.powerView.powerDatasource = [arr copy];
    [self.powerView reloadData];
}

#pragma mark - 构建序分量数据
-(void)loadSequenceViewData{
    
    
    BD_SequenceCaculateManager *cacuManager = [[BD_SequenceCaculateManager alloc]init];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSInteger groupNum = _voltageTV.datasource.count/3;
    for (NSInteger i = 0; i<groupNum; i++) {
//        BD_ChannelModel *channelA = [[BD_ChannelModel alloc]init];
//        channelA.amplitude = [_voltageTV.datasource[i*3+0].amplitude doubleValue];
//        channelA.phase = [_voltageTV.datasource[i*3+0].amplitude doubleValue];
//        channelA.frequency = [_voltageTV.datasource[i*3+0].amplitude doubleValue];
//
//        cacuManager getZeroSeqValueFromchannel_A:<#(BD_ChannelModel *)#> channel_B:<#(BD_ChannelModel *)#> channel_C:<#(BD_ChannelModel *)#>
//        BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
//
//        model1.modelDatas = @[@"U0",@"1",@"1"];
//
//        NSArray *value = @[model1,model1,model1];
//        [arr addObject:value];
    }
   
    self.sequeView.formDatasource = [arr copy];;
    [self.sequeView reloadData];
}

#pragma mark - 构建线电压数据
-(void)loadLineVoltageViewData{
  NSMutableArray  *value = [[NSMutableArray alloc]init];
    [_voltageTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
        model1.modelDatas = @[obj.titleName,obj.amplitude,obj.phase,obj.frequency];
        [value addObject:model1];
    }];
    
    self.lineVoltageView.formDatasource = @[value];
    [self.lineVoltageView reloadData];
}

-(void)loadPage:(NSInteger)page{
    if (page < 0 || page >= _pageViewArr.count) {
        // 如果超出了页面显示的范围，什么也不需要做
        return;
    }
    
    CGRect frame = _paramScrollView.frame;
    frame.origin.x = _paramScrollView.width * page;    //此处决定了整个滑动页面的宽度，如果宽度定义不准确，不能合理的显示页面
    frame.origin.y = 0.0;
    
    _pageViewArr[page].frame = frame;
    viewInScroll = _pageViewArr[page];
    _paramScrollView.contentSize = CGSizeMake(_paramScrollView.width*_pageViewArr.count, _paramScrollView.height);
    [_paramScrollView addSubview:viewInScroll];
    
}


-(void)loadVisiblePages{
    // 首先确定当前可见的页面
    NSInteger pageWidth = _paramScrollView.width;
    NSInteger page = (int)_paramScrollView.contentOffset.x / pageWidth;
    
    // 更新segment
    //        self.segment.selectedSegmentIndex = page
    
    // 计算那些页面需要加载
    NSInteger firstPage = page;
    NSInteger lastPage = page + _pageViewArr.count;
    
    // 加载范围内（firstPage到lastPage之间）的所有页面
    for (NSInteger index = firstPage;index<=lastPage; index++) {
        [self loadPage:index];
    }
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (_paramScrollView.contentOffset.x>3*_paramScrollView.width) {
        _paramScrollView.scrollEnabled = NO;
    } else {
        _paramScrollView.scrollEnabled = YES;
        NSInteger currentindex = (int)_paramScrollView.contentOffset.x/_paramScrollView.width;
        [self changeTopBtnState:currentindex];
    }
    
    if (_paramScrollView.contentOffset.x==3*_paramScrollView.width && _beginModel.isBegin == YES) {
        [_oscillographView startTimer];
    }
    
    if(_paramScrollView.contentOffset.x == _paramScrollView.width && _beginModel.isBegin == YES){
        [_waveShapeView startTimer];
    }
    if (_paramScrollView.contentOffset.x==_paramScrollView.width) {//滑动到输出波形图，调用显示输出波形图页面
        [self showOscillographView];
    }
}


-(void)changeTopBtnState:(NSInteger)index{
    for (NSInteger i = 0; i<_topBtnArr.count; i++) {
        if (i == index) {
            _topBtnArr[i].selected = YES;
        } else {
            _topBtnArr[i].selected = NO;
            
        }
    }
}

-(void)makeTopBtnDidNotSelected{
    _topBtnArr[0].selected = NO;
    _topBtnArr[1].selected = NO;
    _topBtnArr[2].selected = NO;
    _topBtnArr[3].selected = NO;
    _topBtnArr[4].selected = NO;
    _topBtnArr[5].selected = NO;
}

//程序进入后台，修改页面显示
-(void)applicationEnterBackground{
    dispatch_async(dispatch_get_main_queue(), ^{
        //结束实验需要进行的动作
        _startBtnView.btn.selected = NO;
        _startBtnView.imageView.image = [UIImage imageNamed:@"rightBtn4"];
        self.beginModel.isBegin = NO;
        self.navigationItem.hidesBackButton = NO;
        [OCCenter.shareCenter stop];
        self.view.userInteractionEnabled = YES;
    });
   
}


#pragma mark - KVO监听方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    NSLog(@"keyPath=%@,object=%@,change=%@,context=%@",keyPath,object,change,context);
    //这里需要将NSNumber类型转换为字符串类型
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *newStr = [numberFormatter stringFromNumber:[change objectForKey:@"new"]];
    //监听到comParam后，刷新tableVIew对应的行
    if ([keyPath isEqualToString:@"isAuto"]) {
        if (self.paramSetV.comParam.isAuto) {
            rightBtnArr[4].imageView.image = [UIImage imageNamed:@"pluse_unused"];
            rightBtnArr[5].imageView.image = [UIImage imageNamed:@"reduce_unused"];
            rightBtnArr[4].btn.userInteractionEnabled = NO;
            rightBtnArr[5].btn.userInteractionEnabled = NO;
            
        } else {
            rightBtnArr[4].imageView.image = [UIImage imageNamed:@"rightBtn5"];
            rightBtnArr[5].imageView.image = [UIImage imageNamed:@"rightBtn6"];
            rightBtnArr[4].btn.userInteractionEnabled = YES;
            rightBtnArr[5].btn.userInteractionEnabled = YES;
        }
    }

    if ([keyPath isEqualToString:@"isBegin"]) {
        if (_beginModel.isBegin == 1) {
            //开始测试后，如果是自动测试，lock不可用，手动测试，lock可用
            if (self.paramSetV.comParam.isAuto) {
                rightBtnArr[2].imageView.image = [UIImage imageNamed:@"lock_unused"];
                rightBtnArr[2].btn.userInteractionEnabled = NO;
            } else {
                rightBtnArr[2].imageView.image = [UIImage imageNamed:@"rightBtn3"];
                rightBtnArr[2].btn.userInteractionEnabled = YES;
            }
            
            [_dataCenter startTimer];
            [self loadoscillographData:^(NSMutableArray *oscillographArr) {
                
            }];
            if (_paramScrollView.contentOffset.x==3*_paramScrollView.width && _beginModel.isBegin == YES) {
                [_oscillographView startTimer];
            }
            if(_paramScrollView.contentOffset.x == _paramScrollView.width && _beginModel.isBegin == YES){
                [_waveShapeView startTimer];
                //测试开始后，重新获取一波形图的数据
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    _waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:_quickTestData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_waveShapeView reloadData];
                    });
                });
                
            }
            self.navigationController.navigationBar.userInteractionEnabled = NO;
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
            self.navigationItem.leftBarButtonItem.tintColor = [UIColor lightGrayColor];
//            iec_unused
            rightBtnArr[0].imageView.image = [UIImage imageNamed:@"iec_unused"];
            rightBtnArr[0].btn.userInteractionEnabled = NO;
        } else {
            rightBtnArr[2].imageView.image = [UIImage imageNamed:@"lock_unused"];
            rightBtnArr[2].btn.userInteractionEnabled = NO;
            rightBtnArr[0].imageView.image = [UIImage imageNamed:@"rightBtn1"];
            rightBtnArr[0].btn.userInteractionEnabled = YES;
            [_dataCenter stopTimer];
            [self setOscillographDataToZero];
//            [_oscillographView stopTimer];
//            [_waveShapeView stopTimer];
            
            self.navigationController.navigationBar.userInteractionEnabled = YES;
            self.navigationItem.rightBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
               self.navigationItem.leftBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
            
        }
        _paramSetV.isBegin = self.beginModel.isBegin;
        _oscillographView.isBegin = self.beginModel.isBegin;
        _waveShapeView.isBegin = self.beginModel.isBegin;
        [_paramSetV.tableView reloadData];
        
       
    }
    if ([keyPath isEqualToString:@"isOutputData"]) {
        _dataCenter.isOutputData = _oscillographView.isOutputData;
        if (_oscillographView.isOutputData) {//如果切换到输出数据页面，关闭定时器，如果切换到开入状态页，启动定时器
//           [_dataCenter stopTimer];
            [_oscillographView startTimer];
        } else {
//           [_dataCenter startTimer];
           [_oscillographView stopTimer];
        }
    }
    
    if ([keyPath isEqualToString:@"dataArr"]) {
        [_waveShapeView.selecteddataArr removeAllObjects];
        for (int i = 0; i<_waveShapeView.dataArr.count; i++) {
            BD_OutputwaveShapeDataModel *model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
            [_waveShapeView.selecteddataArr addObject:model];
        }
    }
    
}

- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    //必须移除通知
    [kNotificationCenter removeObserver:self];
    //添加监听后，必须移除
    [self removeObserver:self forKeyPath:@"isAuto" context:nil];
    [self removeObserver:self forKeyPath:@"isBegin" context:nil];
    [self removeObserver:self forKeyPath:@"isOutputData" context:nil];
    [self removeObserver:self forKeyPath:@"dataArr" context:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [_dataCenter cancelTimer];
    [_oscillographView cancelTimer];
    [_waveShapeView cancelTimer];
    [BD_PMCtrlSingleton shared].deviceType = BDDeviceType_Imitate;
}
//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}


@end
