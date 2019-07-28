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
#import "BD_ActionResultView.h"
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

#import "BD_ManualTemplateFileManager.h"
#import "BD_SysParaModel.h"
//报告相关
#import "BD_ReportBaseModel.h"
#import "BD_ReportPDFMainVC.h"
#import "BD_ReportMainVC.h"
//底部指示灯
#import "BD_BinarySwitchView.h"
#import "BD_RunLightAnimationManager.h"
//直流设置
#import "BD_DirectCurrentSetManager.h"

@interface BD_QuickTestMainVC ()<UIDocumentInteractionControllerDelegate,BD_QuickTestGetOscillographDataDelegate,UIScrollViewDelegate,BD_HardwareConfitDelegate,BD_OutputwaveShapeAutoRefreshDataDelegate,BDBinaryChangedProtocol>{
    //    BD_QuickTestCustomView *iecBtnView;
    //    BD_QuickTestCustomView *paramBtnView;
    NSMutableArray <BD_QuickTestCustomView *> *rightBtnArr;
    
    //    BD_UtcTime  *testStartTime;
    long locktestStartSec;
    long locktestStartNoSec;
    UIView *viewInScroll;
    
    long startTestSec;
    long startTestNoSec;
    NSInteger lockBinaryActionCount;
    
    NSInteger binaryInValue;//开入量的值
}

@property (weak, nonatomic) IBOutlet UIScrollView *paramScrollView;

@property (weak, nonatomic) IBOutlet UIView *btnsView;
@property (weak, nonatomic) IBOutlet UIView *topViews;
@property (weak, nonatomic) IBOutlet UIButton *fileBtn;
@property (weak, nonatomic) IBOutlet UIButton *testResultBtn;
@property(nonatomic,weak) UIScrollView *rightBtnScrollView;
@property (nonatomic,weak)BD_QuickTestParamTBView *voltageTV;
@property (nonatomic,weak)BD_QuickTestParamTBView *currentTV;
@property (nonatomic,weak)BD_QuickTestParamSetView *paramSetV;


@property (nonatomic,strong)  NSMutableArray<BD_QuickTestOscillographModel *>* oscillographDataArr;
@property (nonatomic,weak)BD_QuickTestVectorgraphTBView *vectorgraphView;//矢量图
@property (nonatomic,weak)BD_QuickTestOscillographTBView *oscillographView;//状态图
@property (nonatomic,weak)BD_OutputwaveShapeTBView *waveShapeView;//输出实时波形图
@property (nonatomic,weak)BD_InfomationTBView *infomationView; //信息图
@property(nonatomic,weak)BD_QuickTestPowerFormTBView *powerView;//功率图
@property(nonatomic,weak)BD_FormTBView *sequeView;//序分量
@property(nonatomic,weak)BD_FormTBView *lineVoltageView;//线电压
//测试结果view
@property (nonatomic,strong)BD_ActionResultView *resultView;
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (nonatomic,strong) NSMutableArray<UIView*> *pageViewArr;
@property (nonatomic,strong) NSArray<UIButton*> *topBtnArr;
@property (nonatomic,strong)UIView *markView;
@property (nonatomic,strong)BD_HardwarkConfigModel *hardwarkModelData;
@property (nonatomic,strong)BD_QuickTestDataCenter *dataCenter;
//顶部按钮滚动视图
@property (nonatomic,weak)UIScrollView *topScrolView;
//模版文件管理
@property(nonatomic,strong)BD_ManualTemplateFileManager *templateManager;
@property(nonatomic,strong)BD_TestResultData *testResultData;
//pdf reportView
@property(nonatomic,strong)BD_ReportPDFMainVC *reportView;
///**报告视图*/
//@property(nonatomic,strong)BD_ReportMainVC *reportVC;
@property(nonatomic,weak)BD_BinarySwitchView *switchView;
//直流设置管理
@property(nonatomic,strong)BD_DirectCurrentSetManager *dcManager;
//run灯动画管理
@property(nonatomic,strong)BD_RunLightAnimationManager *runMangaer;
//动作时间锁定计数
@property(nonatomic,strong)NSMutableArray *hasLockedArr;
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
    
    //    [kNotificationCenter addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(refreshDateDeviceInfoBinarySwitch:) name:BD_ReadDeviceInfoNoti object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(refreshDCStart:) name:BD_DirectCurrStart object:nil];
    [kNotificationCenter addObserver:self selector:@selector(refreshDCStop:) name:BD_DirectCurrStop object:nil];
    [kNotificationCenter addObserver:self selector:@selector(netWordDisconnectToStop:) name:BD_NewWordDisconnect object:nil];
    
    
    [self.paramSetV.comParam addObserver:self forKeyPath:@"isAuto" options:NSKeyValueObservingOptionNew context:nil];
    [self.beginModel addObserver:self forKeyPath:@"isBegin" options:NSKeyValueObservingOptionNew context:nil];
    [self.paramSetV.comParam addObserver:self forKeyPath:@"isCocurrent" options:NSKeyValueObservingOptionNew context:nil];
    [self.paramSetV.comParam addObserver:self forKeyPath:@"varlabel" options:NSKeyValueObservingOptionNew context:nil];
    //    [self.waveShapeView addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    
    [_testResultBtn setCorenerRadius:10.0 borderColor:BtnViewBorderColor borderWidth:2.0];
    [_testResultBtn addTarget:self action:@selector(resultViewShow:) forControlEvents:UIControlEventTouchUpInside];

    [_waveShapeView createTimer];
    [_waveShapeView stopTimer];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_dataCenter.timer) {
        
    if (!_waveShapeView.waveTimer) {
        
        if (self.beginModel.isBegin) {
            [_waveShapeView startTimer];
        } else {
            [_waveShapeView stopTimer];
        }
        
    }
}
}


-(void)viewDidAppear:(BOOL)animated{
    //view真正的大小在didAppear后才能确定
    [super viewWillAppear:animated];
    //    if (!_resultView) {
    //       BD_QuickTestActionResultView *resultView = [[BD_QuickTestActionResultView alloc]initWithFrame:CGRectMake(_paramScrollView.frame.origin.x, self.view.height, _paramScrollView.width, 150)];
    //        [self.view addSubview:resultView];
    //        self.resultView = resultView;
    //        [self addGesture];
    //
    //    }
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
    
    [_rightBtnScrollView setFrame:_btnsView.bounds];
    
    [_resultView setFrame:CGRectMake(self.view.width,self.testResultBtn.top-100, 0,200)];
}


#pragma mark - 初始化UI
-(void)configUI{
    BD_BinarySwitchView *switchView = [[BD_BinarySwitchView alloc] initWithTitleArray:@[@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia1", @"Ib1", @"Ic1",@"Ia2", @"Ib2", @"Ic2", @"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"L1", @"L2", @"L3", @"L4", @"L5", @"L6", @"L7", @"L8"]];
    self.switchView = switchView;
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-Marge);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    [_fileBtn setImage:[UIImage imageNamed:@"fileNormal"] forState:UIControlStateNormal];
    [_fileBtn setImage:[UIImage imageNamed:@"fileSelected"] forState:UIControlStateSelected];
    self.navigationItem.title = @"通用试验";
    
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
    NSArray *btnTitle = @[@"数据",@"波形图",@"矢量图",@"状态图",@"功率图",@"序分量",@"线电压",@"信息图"];
    NSMutableArray *viewBtnArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<btnTitle.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(10+i*(btnX+btnW),5,btnW,btnH)];
        [btn setCorenerRadius:6 borderColor:White borderWidth:2.0];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:ClearColor width:btn.width height:btn.height title:btnTitle[i] ] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:BDThemeColor width:btn.width height:btn.height title:btnTitle[i] ] forState:UIControlStateSelected];
        [btn setSelected:YES];
        btn.tag = i+100;
        
        
        [btn addTarget:self action:@selector(topViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topTestView addSubview:btn];
        [viewBtnArr addObject:btn];
    }
    _topBtnArr = [viewBtnArr copy];
    topTestView.contentSize = CGSizeMake(_topBtnArr.count*(btnW+btnX),topTestView.height);
    self.topScrolView = topTestView;
    
    //右侧按钮scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounces = NO;
    [_btnsView addSubview:scrollView];
    self.rightBtnScrollView = scrollView;
    
    CGFloat viewY = 15;
    CGFloat viewW = 130;
    CGFloat viewH = (SCREEN_HEIGHT-370)/7;
    NSArray *viewImage = @[@"rightBtn1",@"rightBtn2",@"lock_unused",@"rightBtn4",@"rightBtn5",@"rightBtn6"];
    rightBtnArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<viewImage.count; i++) {
        BD_QuickTestCustomView *view=[[BD_QuickTestCustomView alloc]initWithFrame:CGRectMake(40,viewY+i*(viewY+viewH),viewW,viewH) imageName:viewImage[i]];
        
        
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
        [scrollView addSubview:view];
    }
    UIButton *assDCBtn = [[UIButton alloc]init];
    [assDCBtn setTitle:@"辅助直流" forState:UIControlStateNormal];
    [assDCBtn setTitleColor:White forState:UIControlStateNormal];
     [assDCBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [assDCBtn setFrame:CGRectMake(40,viewY+6*(viewY+viewH),viewW,viewH)];
    [assDCBtn addTarget:self action:@selector(dcViewShow:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:assDCBtn];
    
    [self makeTopBtnDidNotSelected];
    
    _rightBtnScrollView.contentSize = CGSizeMake(_rightBtnScrollView.width, (SCREEN_HEIGHT-330)/7*rightBtnArr.count);
    
    _pageViewArr = [[NSMutableArray alloc]init];
    
    //scrollView上添加view
    //数据
    [self addVolandCurView];
    
    //实时波形图
    
    if (!_waveShapeView) {
        BD_OutputwaveShapeTBView *waveShapeView = [[BD_OutputwaveShapeTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        waveShapeView.backgroundColor = ClearColor;
        waveShapeView.wavedelegate = self;
        
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
        
        [_dataCenter createRefreshTime];
        [_dataCenter createBinaryStateLineViewDatas];
        oscillographView.xValues = @[_dataCenter.times,_dataCenter.times];
        
        
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
    
    
    //功率图
    BD_QuickTestPowerFormTBView *power = [[BD_QuickTestPowerFormTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_pageViewArr addObject:power];
    self.powerView = power;
    //序分量
    BD_FormTBView *seque = [[BD_FormTBView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@[@"名称",@"幅值(V)",@"相位(°)"]]];
    [_pageViewArr addObject:seque];
    self.sequeView = seque;
    //线电压
    BD_FormTBView *lineVoltage = [[BD_FormTBView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@[@"通道",@"幅值(V)",@"相位(°)",@"频率(Hz)"]]];
    [_pageViewArr addObject:lineVoltage];
    self.lineVoltageView = lineVoltage;
    //信息图页面
    BD_InfomationTBView *infomationView =  [[BD_InfomationTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@"序号",@"时间",@"动作类型",@"开入量",@"动作时间"]];
    [infomationView createFalsedata];
    [infomationView reloadData];
    [_pageViewArr addObject:infomationView];
    _infomationView = infomationView;
    
    
    //参数设置页面
    BD_QuickTestParamSetView *paramSetV = [[NSBundle mainBundle] loadNibNamed:@"BD_QuickTestParamSetView" owner:nil options:nil].lastObject;
    [paramSetV setFrame:CGRectZero];
    paramSetV.isBegin = _beginModel.isBegin;
    paramSetV.backgroundColor = ClearColor;
    paramSetV.binaryDelegate = self;
    [paramSetV transitionWithType:kCATransitionPush withSubType:kCATransitionFromRight withDuration:0.5];
    __weak typeof(self) weself = self;
    paramSetV.reportVCShowBlock = ^(UIView *btn) {
        [weself showReportVC:btn];
    };
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
    self.markView = markView;
    _hardWareView= [[NSBundle mainBundle]loadNibNamed:@"BD_HardwareConfigView" owner:self options:nil].lastObject;
    WeakSelf;
    _hardWareView.hardwareConfigComplete = ^(BD_HardwarkConfigModel *hard) {
        weakself.paramSetV.passagewayNum.voltagePassageNum = hard.voltagePassNum;
        weakself.paramSetV.passagewayNum.currentPassageNum = hard.currentPassNum;
        
        if (!(hard.voltagePassNum==weakself.voltageTV.datasource.count && hard.currentPassNum ==weakself.currentTV.datasource.count)) {
            [weakself.dataCenter updateTestData:hard.voltagePassNum C_passNum:hard.currentPassNum complete:^(NSMutableArray *resultArr) {
                weakself.quickTestData = resultArr;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.voltageTV.datasource  = weakself.quickTestData[0];
                    weakself.currentTV.datasource  = weakself.quickTestData[1];
                    [weakself.voltageTV reloadData];
                    [weakself.currentTV reloadData];
                    //重新配置通道后，移除矢量图中的选择数据
                    [weakself.vectorgraphView.selectedDataArr removeAllObjects];
                    if (weakself.paramScrollView.contentOffset.x == 2*weakself.paramScrollView.width) {
                        
                        [weakself showVectorgraphView];
                    } else if (weakself.paramScrollView.contentOffset.x==weakself.paramScrollView.width){
                        [weakself shoWaveShapeView];
                    }  else if (weakself.paramScrollView.contentOffset.x==weakself.paramScrollView.width*4){
                        [weakself showPowerView];
                        [weakself loadPowerViewData];
                        
                    } else if (weakself.paramScrollView.contentOffset.x==weakself.paramScrollView.width*5){
                        
                        [weakself showSequencerView];
                        [weakself loadSequenceViewData];
                        
                    } else if (weakself.paramScrollView.contentOffset.x==weakself.paramScrollView.width*6){
                        [weakself showLineVoltage];
                        [weakself loadLineVoltageViewData];
                    }
                    [weakself loadoscillographData:^(NSMutableArray *oscillographArr) {
                        weakself.oscillographView.lineDataSourceArr = oscillographArr;
                    }];
                    weakself.waveShapeView.dataArr = [weakself.dataCenter outPutWaveShapeDataCenter:[weakself.quickTestData copy]];
                    [weakself.waveShapeView.selecteddataArr removeAllObjects];
                    for (int i = 0; i<weakself.waveShapeView.dataArr.count; i++) {
                        BD_OutputwaveShapeDataModel *model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                        [weakself.waveShapeView.selecteddataArr addObject:model];
                    }
                    weakself.waveShapeView.hasShowWaveImage = NO;
                    [weakself.waveShapeView reloadData];
                    [weakself.switchView addCurrentLightWithGroup:hard.currentPassNum/3];
                });
            }];
        }
        
        [weakself disMissHardwareView];
    };
    _hardWareView.frame = CGRectZero;
    _hardWareView.layer.cornerRadius = 10;
    _hardWareView.layer.masksToBounds = YES;
    _hardWareView.center = _markView.center;
    _hardWareView.dissdelegate = self;
    [_markView addSubview:self.hardWareView];
    
    
    //测试结果view
    BD_ActionResultView *actionView = [[BD_ActionResultView alloc]initWithFrame:CGRectZero];
    self.resultView = actionView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resultViewTapGesture:)];
    [self.resultView addGestureRecognizer:tap];
    
    //默认选中第一项
    [self changeTopBtnState:0];
}

#pragma mark -显示硬件配置页面
-(void)showDeviceConfig{
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.markView];
    [UIView animateWithDuration:0.3 animations:^{
        
        _hardWareView.frame = CGRectMake(0, 0, self.view.width*0.7,self.view.height*0.9);
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
        [[BD_DeviceInfoService shared] readDevicePara:^(BD_DeviceChanelDesc *resultModel,bool isSucess) {
            WeakSelf;
            if (isSucess) {
                
                [weakself.dataCenter updateTestData:resultModel.analogVoltMaxChanel C_passNum:resultModel.analogCurrentMaxChanel complete:^(NSMutableArray *resultArr) {
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
                            [weakself loadoscillographData:^(NSMutableArray *array) {
                                _oscillographView.lineDataSourceArr = array;
                                [weakself setOscillographDataToZero];
                            }];
                            
                        }
                        [weakself.vectorgraphView.selectedDataArr removeAllObjects];
                        [weakself computationsVectorgraphViewData];
                        [weakself.vectorgraphView reloadData];
                        [weakself.waveShapeView reloadData];
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
                        weakself.paramSetV.passagewayNum.voltagePassageNum = resultModel.analogVoltMaxChanel;
                        weakself.paramSetV.passagewayNum.currentPassageNum = resultModel.analogCurrentMaxChanel;
                        
                        weakself.paramSetV.ratedVoltageMax = sqrt(3)*resultModel.voltageMax;
                        weakself.paramSetV.ratedCurrentMax = resultModel.currentMax;
                        
                        
                    });
                }];
                
            } else {
                
                
                weakself.waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:[_quickTestData copy]];
                for (int i = 0; i<weakself.waveShapeView.dataArr.count; i++) {
                    BD_OutputwaveShapeDataModel *model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                    [weakself.waveShapeView.selecteddataArr addObject:model];
                    
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUDUtil showMessage:@"通道数据读取失败,请检查网络设置" toView:self.view];
                    weakself.voltageTV.datasource = weakself.quickTestData[0];
                    weakself.currentTV.datasource = weakself.quickTestData[1];
                    
                    [weakself.voltageTV reloadData];
                    [weakself.currentTV reloadData];
                    
                    //必须在初始化的时候创建数据，必须在每个view的datasource有数据后初始化波形图页面数据
                    if (!
                        weakself.oscillographDataArr) {
                        [weakself loadoscillographData:^(NSMutableArray *array) {
                            weakself.oscillographView.lineDataSourceArr = array;
                            [weakself setOscillographDataToZero];
                        }];
                        
                    }
                    [weakself.vectorgraphView.selectedDataArr removeAllObjects];
                    [weakself computationsVectorgraphViewData];
                    [weakself.vectorgraphView reloadData];
                    [weakself.waveShapeView reloadData];
                    
                    weakself.paramSetV.ratedVoltageMax = sqrt(3)* [weakself.hardWareView.viewModel.exchangeVoltage floatValue];
                    weakself.paramSetV.ratedCurrentMax = [weakself.hardWareView.viewModel.exchangeCurrent floatValue];
                    
                    [self loadPowerViewData];//计算功率图数据
                    [self loadSequenceViewData];//计算序分量数据
                    [self loadLineVoltageViewData];//计算线电压数据
                    
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
-(BD_ManualTemplateFileManager *)templateManager{
    if (!_templateManager) {
        _templateManager = [[BD_ManualTemplateFileManager alloc]init];
    }
    return _templateManager;
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

-(NSMutableArray *)hasLockedArr{
    if (!_hasLockedArr) {
        _hasLockedArr = [[NSMutableArray alloc]init];
    }
    return _hasLockedArr;
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
                //刷新开入开出指示灯状态
                startTestSec = model.nSec;
                startTestNoSec = model.nNanoSec;
                
                [self refreshBtnWithBinary:model.nInput];
                
                //刷新开出量指示灯状态xx
                /**注意：目前是通过客户端自己控制的，之后接口会返回开出量的数据*/
                [self changeBinaryoutState:[self.paramSetV.comParam.binaryOut intValue]];
                //记录试验开始时间
                
                
                break;
            case 2:
                NSLog(@"--2");
                //类型返回2表示实验结束，应该将设备输出和页面显示都设置为停止状态，需要调用[OCCenter.shareCenter stop];方法才能停止设备的输出操作，否则不停止
                //测试类型为停止试验的时候，不刷新指示灯，指示将指示灯恢复默认
                [self endTestWithFilepath:filePath nBinstate:model.nInput];
                //试验停止显示测试结果数据
                [self resultViewShowAnimation];
                break;
            case 3:
                NSLog(@"--3");
                //刷新
                
                if(_beginModel.isBegin && !self.isLock){//状态切换的时候记录动作时间的开始时刻
                    //表示计时起点
                    locktestStartSec = model.nSec;
                    locktestStartNoSec = model.nNanoSec;
                    startTestSec = model.nSec;
                    startTestNoSec = model.nNanoSec;
                    
                }
                //刷新开入开出指示灯状态
                [self refreshBtnWithBinary:model.nInput];
                //刷新开出量指示灯状态xx
                /**注意：目前是通过客户端自己控制的，之后接口会返回开出量的数据*/
                [self changeBinaryoutState:[self.paramSetV.comParam.binaryOut intValue]];
                break;
            case 4:
                NSLog(@"--4");
                
                
                //计算动作时间
                //                if (currentIndex-1<0) {
                //                    continue;
                //                }
                
                if (_beginModel.isBegin) {
                    
                        if (self.hasLockedArr.count==2 && [self.hasLockedArr[0] boolValue] && ![self.hasLockedArr[1] boolValue] ) {
                            float a1=nSec-locktestStartSec;
                            float a2=nNanoSec/pow(10,9)-locktestStartNoSec/pow(10,9);
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
                            if (lockBinaryActionCount==0) {
                                [_resultView setValues:kTStrings(result.actionTime) actionValue:kTStrings(result.actionValue) backTime:kTStrings(self.testResultData.returnTime) backValue:kTStrings(self.testResultData.returnValue)];
                                
                                self.testResultBtn.selected = YES;
                                lockBinaryActionCount++;
                            }
                            
                            
                            
                        } else {
                            float a1=nSec-startTestSec;
                            float a2=nNanoSec/pow(10,9)-startTestNoSec/pow(10,9);
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
                            
                            
                        }
   
                }
               
                
                //刷新开入开出指示灯状态
                [self refreshBtnWithBinary:model.nInput];
                //刷新开出量指示灯状态xx
                /**注意：目前是通过客户端自己控制的，之后接口会返回开出量的数据*/
                [self changeBinaryoutState:[self.paramSetV.comParam.binaryOut intValue]];
                break;
            case 5:
                NSLog(@"--5");
                self.testResultData.isMark = YES;
                //刷新开入开出指示灯状态
                [self refreshBtnWithBinary:model.nInput];
                //刷新开出量指示灯状态xx
                /**注意：目前是通过客户端自己控制的，之后接口会返回开出量的数据*/
                [self changeBinaryoutState:[self.paramSetV.comParam.binaryOut intValue]];
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
        _dataCenter.binarynbinall_out = [self.paramSetV.comParam.binaryOut intValue];
        binaryInValue = nbinall;
        [self updateBinaryStateDatas:nbinall];
        
    });
}
#pragma mark - 开入开出状态图数据
-(void)setOscillographBinaryArr{
    
    if (_oscillographView.binaryStates[0].count>=600) {
         _oscillographView.xvalueMax += 600;
        [_oscillographView.binaryStates enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeAllObjects];
        }];

    }
    int binaryIn = (int)binaryInValue;
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryIn&0x80000000)==0?1:0;
        binaryIn = binaryIn<<1;
    }
    
    int binaryOut = [self.paramSetV.comParam.binaryOut intValue];
    int chout[32];
    for (int i = 0; i<32; i++) {
        chout[i] = -1;
    }
    for (int i =31; i>=0; i--) {
        chout[i] = (binaryOut&0x80000000)==0?1:0;
        binaryOut = binaryOut<<1;
    }
    for (int i = 0; i<8; i++) {
        
        [_oscillographView.binaryStates[i] addObject:@(chout[7-i])];
    }
    for (int n = 8; n<18; n++) {
        [_oscillographView.binaryStates[n] addObject:@(ch[17-n])];
    }
    
}
#pragma mark - 试验结束，创建报告
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
        //开入量变化  ----试验结束不需要展示指示灯状态
        //        [self updateBinaryStateDatas:nBinstate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //延时一秒跳转，保证在离开测试页的时候，测试结果页面消失
            [self createReportWithBinaryIn:nBinstate binaryOut:[self.paramSetV.comParam.binaryOut intValue] actionTime:![self.resultView getactionTime]?0.000:[self.resultView getactionTime].floatValue];
            //指示灯恢复默认
            [self setLightDefault];
        });
       
        
    });
}
//创建试验报告
-(void)createReportWithBinaryIn:(int)binaryIn binaryOut:(int)binaryOut actionTime:(CGFloat)actionTime{
    //数组中添加BD_ReportBaseModel 类型
    BD_ReportMainVC *reportVC = [[BD_ReportMainVC alloc]init];
    reportVC.moduleType = BD_TestModuleType_Manual;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    BD_ReportBaseModel * baseModel = [[BD_ReportBaseModel alloc]init];
    baseModel.subTitle = [NSString stringWithFormat:@"测试对象:%dU%dI",_paramSetV.passagewayNum.voltagePassageNum,_paramSetV.passagewayNum.currentPassageNum];
    
    baseModel.testResult = [NSString stringWithFormat:@"触发后保持时间:%@s   开出量选择:%@   动作时间:%@s   开入量选择:%@", _paramSetV.comParam.delayTime,[BD_Utils reportSwitchStatusByBinaryOut:binaryOut],kTStrings(actionTime),[BD_Utils reportSwitchStatusByBinaryIn:binaryIn]];
    
    NSMutableArray *formDatas = [[NSMutableArray alloc]init];
    [_voltageTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [formDatas addObject:@[@{@"通道":obj.titleName},@{@"幅值(V)":obj.amplitude},@{@"相位(°)":obj.phase},@{@"频率(Hz)":obj.frequency}]];
    }];
    [_currentTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [formDatas addObject:@[@{@"通道":obj.titleName},@{@"幅值(V)":obj.amplitude},@{@"相位(°)":obj.phase},@{@"频率(Hz)":obj.frequency}]];
    }];
    baseModel.formDataSource = [formDatas copy];
    [arr addObject:baseModel];
    reportVC.moduleTestName = @"试验名称--通用试验";
    reportVC.reportDatas = [arr copy];
    [reportVC loadReportViews];
    [self.navigationController pushViewController:reportVC animated:YES];
}


//- (void)DecimalToBinaryWithNumber:(int)n
//{
//
//    int d;
//
//    for(int i=0;i<10;i++)
//    {
//        d=n%2;  //取余,余数
//        n=n/2;  //取整
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //设置btn亮
//            if (d == 0) {
//
//                UIButton *btn = _resultView.btnsArray1[i];
//
//                btn.backgroundColor = [UIColor greenColor];
//
//            }
//            else if (d == 1){
//
//                UIButton *btn = _resultView.btnsArray1[i];
//
//                btn.backgroundColor = RGB(234, 234, 234);
//
//            }
//        });
//
//    }
//}


#pragma mark - 开入量指示灯状态
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
                btn.backgroundColor = White;
                int n;
                int binaryOut = [self.paramSetV.comParam.binaryIn intValue];
                for(int j=0;j<10;j++)
                {
                    n=binaryOut%2;  //取余,余数
                    binaryOut=binaryOut/2;  //取整
                    
                    //设置btn亮
                    if (n == 0){
                        
                        UIButton *btn = self.switchView.switchBtnArr[j+2];
                        [btn setBackgroundImage:[UIImage imageNamed:@"lightUnUsed"] forState:UIControlStateNormal];
                        btn.userInteractionEnabled = NO;
                        btn.backgroundColor = White;
                    }
                }
                
            }
            else if (d == 0){
                
                UIButton *btn = self.switchView.switchBtnArr[i+2];
                [btn setBackgroundImage:[UIImage imageWithColor: Green width:btn.width height:btn.height title:@""] forState:UIControlStateNormal];
                btn.backgroundColor = Green;
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
            //设置btn亮
            if (d == 0) {
                
                UIButton *btn = self.switchView.switchBtnArr[allCount-16+i];
                btn.backgroundColor = White;
                btn.userInteractionEnabled = YES;
            }
            else if (d == 1){
                
                UIButton *btn = self.switchView.switchBtnArr[allCount-16+i];
                btn.backgroundColor = Green;
                btn.userInteractionEnabled = NO;
            }
        });
    }
}
#pragma mark - 试验结束，指示灯恢复默认
-(void)setLightDefault{
    
    for (NSInteger i=0; i<self.switchView.switchBtnArr.count; i++) {
        UIButton *btn = self.switchView.switchBtnArr[i];
        btn.userInteractionEnabled = YES;
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        btn.backgroundColor = White;
        int n;
        int binaryOut = [self.paramSetV.comParam.binaryIn intValue];
        for(int j=0;j<10;j++)
        {
            n=binaryOut%2;  //取余,余数
            binaryOut=binaryOut/2;  //取整
            
            //设置btn亮
            if (n == 0){
                
                UIButton *btn = self.switchView.switchBtnArr[j+2];
                [btn setBackgroundImage:[UIImage imageNamed:@"lightUnUsed"] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            } else {
                UIButton *btn = self.switchView.switchBtnArr[j+2];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                btn.backgroundColor = White;
                btn.userInteractionEnabled = YES;
            }
        }
    }
    
    
    
    
}
//刷新电流灯，过流过载指示灯
-(void)refreshDateDeviceInfoBinarySwitch:(NSNotification *)info{
    NSDictionary *dic = (NSDictionary *)info.object;
    int currentInfo = [[dic objectForKey: @"currentInfo"] intValue];
    int VolInfo = [[dic objectForKey: @"VolInfo"] intValue];
    [self updateCurrentState:currentInfo volt:VolInfo];
    
}

#pragma mark - 网络断开，非老化，页面和仪器都停止 老化，页面停止，仪器不停止,辅助直流输出灯关闭
-(void)netWordDisconnectToStop:(NSNotification *)nofi{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.switchView.switchBtnArr.count!=0) {
            self.switchView.switchBtnArr[1].backgroundColor = White;
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _startBtnView.btn.selected = NO;
        _startBtnView.imageView.image = [UIImage imageNamed:@"rightBtn4"];
        self.beginModel.isBegin = NO;
        self.navigationItem.hidesBackButton = NO;
        [self setLightDefault];
        //        if (!self.paramSetV.comParam.isAgingTest) {
        //            [OCCenter.shareCenter stop];
        //        }
        
        self.view.userInteractionEnabled = YES;
        
    });
    
    
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

#pragma mark - V OH 过流过载 电流灯状态 U表示过载 OH表示过热
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
    [_vectorgraphView endEditing:YES];
    [self.paramSetV endEditing:YES];
    [_voltageTV endEditing:YES];
    [_currentTV endEditing:YES];
    
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
            [self shoWaveShapeView];
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
            //            if (_beginModel.isBegin) {
            //                [_oscillographView startTimer];
            //            }
            
            
            break;
            
        case 104://功率图
            DLog(@"点击tag:%ld",(long)sender.tag);
            
        {
            
            [self showPowerView];
            [self loadPowerViewData];
        }
            break;
        case 105://序分量
            DLog(@"点击tag:%ld",(long)sender.tag);
            
        {
            
            [self showSequencerView];
            [self loadSequenceViewData];
        }
            break;
        case 106://线电压
            DLog(@"点击tag:%ld",(long)sender.tag);
            
        {
            
            [self showLineVoltage];
            [self loadLineVoltageViewData];
        }
            break;
        case 107://信息图
            DLog(@"点击tag:%ld",(long)sender.tag);
            [self showInformationView];
            
            break;
        default:
            break;
    }
    
}

#pragma mark - IEC/参数设置／锁／开始／+／-点击事件
-(void)rightViewBtnClick:(BD_QuickTestCustomView *)sender{
    [_vectorgraphView endEditing:YES];
    [self.paramSetV endEditing:YES];
    [_voltageTV endEditing:YES];
    [_currentTV endEditing:YES];
    
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
        case 16:
            DLog(@"点击tag:%ld",(long)sender.tag);
        {
            
        }
            
            break;
        default:
            break;
    }
    [sender setNeedsDisplay];
    
}

-(void)dcViewShow:(UIButton *)sender{
    self.dcManager.dcCurrentMax = [self.hardWareView.viewModel.assistCurrent floatValue];
    [self.dcManager showDirectCurrentView];
}
#pragma mark - 显示测试文件结果
- (IBAction)showFileAction:(id)sender {
    
    ////    _fileBtn.selected = !_fileBtn.selected;
    //    NSString *filePath = [kUserDefaults valueForKey:@"manualFilePath"];
    //
    //    NSLog(@"filePath-->%@",filePath);
    //
    //    NSURL *URL = [NSURL fileURLWithPath:filePath];
    //
    //    if (URL) {
    //        // Initialize Document Interaction Controller
    //        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    //
    //        // Configure Document Interaction Controller
    //        [self.documentInteractionController setDelegate:self];
    //
    //        // Preview PDF
    //        [self.documentInteractionController presentPreviewAnimated:YES];
    //    }
    
    [_vectorgraphView endEditing:YES];
    [self.paramSetV endEditing:YES];
    [_voltageTV endEditing:YES];
    [_currentTV endEditing:YES];
    
    WeakSelf;
    
    _paramSetV.comParam.isLock = _isLock;
    if (_quickTestData.count == 3) {
        [_quickTestData removeLastObject];
    }
    [_quickTestData addObject:[[NSMutableArray alloc]initWithArray:@[_paramSetV.comParam]]];
    
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"保存配置",@"保存模版文件",@"打开模版文件",@"报告视图",@"清空模版文件"] textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
        if ([str isEqualToString:@"保存配置"]) {
            //保存配置方法
        } else if ([str isEqualToString:@"保存模版文件"]){
            //保存模版文件方法
            [weakself templateFileNameEditAlert:^(NSString *fileName) {
                if ([weakself.templateManager saveTemplateFile:[_quickTestData copy] fileName:fileName]) {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveSuc toView:self.view];
                } else {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveFailed toView:self.view];
                }
            }];
            
        } else if ([str isEqualToString:@"打开模版文件"]) {
            //打开模版文件方法
            [weakself showTemplateFileListView:@"请选择要打开的模版文件" complete:^(NSString *fileName) {
                NSArray *resultArr =  [weakself.templateManager readTemplateFileWithfileName:fileName];
                if (resultArr) {
                    //TODO：展示在页面上
                    weakself.voltageTV.datasource = resultArr[0];
                    weakself.currentTV.datasource = resultArr[1];
                    weakself.paramSetV.comParam = (BD_QuickTestComSetModel *)resultArr[2][0];
                    
                } else {
                    [MBProgressHUDUtil showMessage:@"打开文件失败" toView:self.view];
                }
                [weakself.voltageTV reloadData];
                [weakself.currentTV reloadData];
                [weakself.paramSetV.tableView reloadData];
            }];
        } else if([str isEqualToString:@"清空模版文件"]) {
            //清空模版文件
            if ([FileUtil delateAllTemplateFiles]) {
                [MBProgressHUDUtil showMessage:@"模版文件删除成功" toView:self.view];
            } else {
                [MBProgressHUDUtil showMessage:@"模版文件删除失败" toView:self.view];
            }
        } else {
            
            [weakself showTemplateFileListView:@"请选择报告文件" complete:^(NSString *fileName) {
                if ([fileName hasSuffix:@".pdf"]) {
                    
                    if (!weakself.reportView) {
                        weakself.reportView = [[BD_ReportPDFMainVC alloc]init];
                    }
                    weakself.reportView.fileName = fileName;
                    [weakself.reportView refreshView];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakself presentViewController:weakself.reportView animated:YES completion:nil];
                    });
                    
                } else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [BD_PopListViewManager showRemindAlertView:weakself title:@"提醒" message:@"请选择正确的报告打开"];
                    });
                    
                }
            }];
            
        }
    }];
    
}
//保存模版文件，文件名称编辑框
-(void)templateFileNameEditAlert:(void(^)(NSString *))complete{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入文件名称" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if (![userNameTextField.text isEqualToString:@""]) {
            complete(userNameTextField.text);
        } else {
            [MBProgressHUDUtil showMessage:@"请输入模版文件名称" toView:self.view];
        }
        
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入文件名称";
        
        textField.secureTextEntry = NO;
        
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}
//打开模版文件，显示模版文件列表
-(void)showTemplateFileListView:(NSString *)message complete:(void(^)(NSString *))complete{
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

#pragma mark - 减值
- (void)reduceAction{
    NSArray *row = self.paramSetV.pickerModel.row;
    //    int column = self.paramSetV.pickerModel.column;
    
    if ([self.paramSetV.pickerModel.title isEqualToString:@"Ua"]) {
        [self reduceAndPlusParamWithTBView:_voltageTV type:OperationTypeReduce];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                //                [self changeLineDataWithrow:index dataArr:_voltageTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].VAmplitudeArr];
            }
        }
    } else if ([self.paramSetV.pickerModel.title isEqualToString:@"Ia"]){
        [self reduceAndPlusParamWithTBView:_currentTV type:OperationTypeReduce];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                //                  [self changeLineDataWithrow:index dataArr:_currentTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].CAmplitudeArr];
                
            }
        }
        
        
    }
    if (self.paramScrollView.contentOffset.x == self.paramScrollView.width) {
        
        [_waveShapeView reloadData];
    } else if (self.paramScrollView.contentOffset.x==2*self.paramScrollView.width){
        [_vectorgraphView reloadData];
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
                //                  [self changeLineDataWithrow:index dataArr:_voltageTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].VAmplitudeArr];
            }
        }
        
    }else if ([self.paramSetV.pickerModel.title isEqualToString:@"Ia"]){
        [self reduceAndPlusParamWithTBView:_currentTV type:OperationTypePluse];
        if (_beginModel.isBegin == 1 && self.isLock == 0) {
            for (NSNumber *i in row) {
                int index = 3*self.paramSetV.pickerModel.group+([i intValue]-10);
                //                 [self changeLineDataWithrow:index dataArr:_currentTV.datasource lineData:self.oscillographDataArr[self.paramSetV.pickerModel.group].CAmplitudeArr];
            }
        }
        
    }
    if (self.paramScrollView.contentOffset.x == self.paramScrollView.width) {
        
        [_waveShapeView reloadData];
    } else if (self.paramScrollView.contentOffset.x==2*self.paramScrollView.width){
        [_vectorgraphView reloadData];
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
    
    if (!_paramSetV.comParam.isCocurrent) {
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
        
        if (column == 2 &&newText.floatValue>180){
            newText =   @"180.000";
            block(newText);
            return NO;
        } else if(column == 2 &&newText.floatValue<-180){
            newText =   @"-180.000";
            block(newText);
            return NO;
        }
        else if (column == 3 && ABS(newText.floatValue)>3000){
            newText =   @"3000.000";
            block(newText);
            return NO;
            
        } else if (newText.floatValue<=0 && column != 2){
            newText =   @"0.001";
            block(newText);
            return NO;
        } else {
            block(newText);
            return YES;
        }
        
        
        return NO;
        
    } else {
        //直流范围限制
        if ((column == 1 && (int)type == (int)BD_CellTypeVoltage )) {
            if (newText.floatValue>[dVol floatValue]) {
                newText = dVol;
                block(newText);
                return NO;
            } else if (newText.floatValue<-[dVol floatValue]){
                newText = [@"-" stringByAppendingString:dVol];
                block(newText);
                return NO;
            } else {
                block(newText);
                return YES;
            }
            
        }else if(column == 1 && (int)type == (int)BD_CellTypeCurrent) {
            if (newText.floatValue>[dCur floatValue]) {
                newText = dCur;
                block(newText);
                return NO;
            } else if (newText.floatValue<-[dCur floatValue]) {
                newText = [@"-" stringByAppendingString:dCur];
                block(newText);
                return NO;
            } else {
                block(newText);
                return YES;
            }
            
        }
    }
    
    
    return YES;
}


#pragma mark - Lock
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
        if (self.hasLockedArr.count<2) {
             [self.hasLockedArr addObject:@(self.isLock)];
        } else {
            [self.hasLockedArr removeObjectAtIndex:0];
            [self.hasLockedArr addObject:@(self.isLock)];
        }
        
       
    }
    
}


#pragma mark - 开始测试
- (void)StartAction:(UIButton *)sender {
    
    if (!sender.selected) {
        //重新开始试验的时候，测试结果清空
        [_resultView setValues:kTStrings(0.000) actionValue:kTStrings(0.000) backTime:kTStrings(0.000) backValue:kTStrings(0.000)];
        [self.testResultData.actionInfoArr removeAllObjects];
        //清空锁动作记录
        [self.hasLockedArr removeAllObjects];//
        
        lockBinaryActionCount =0;
        //重新开始后指示灯状态清空数据
        [self.switchView.switchBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor = White;
        }];
        //清空状态图数据
        
        [_dataCenter setBinaryDataDefault];
        [self setOscillographDataDefaut];
        //清空波形图
        _waveShapeView.hasShowWaveImage = NO;
        [_waveShapeView reloadData];
    }
    
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
            [_infomationView.infoDataSource removeAllObjects];
            [_infomationView reloadData];
            sender.selected = !sender.selected;
            //如果链接实验设备成功 显示指示灯view
            
            //            [self actionBeginShowDeviceTestResultView];
            
            
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
                BD_TestDataParamModel *base_U = _voltageTV.datasource[j];
                if (j<3) {
                    BD_TestDataParamModel *base_C = _currentTV.datasource[j];
                    [CArr addObject:base_C];
                }
                
                [UArr addObject:base_U];
                
            }
        } else {
            for (int j = 3*i; j<(i+1)*3;j++) {
                BD_TestDataParamModel *base_U = _voltageTV.datasource[j];
                BD_TestDataParamModel *base_C = _currentTV.datasource[j];
                [UArr addObject:base_U];
                [CArr addObject:base_C];
            }
        }
        
        BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
        [vecArr addObject:model];
    }
    
    
    NSInteger otherNum=0;
    if (_voltageTV.datasource.count!=4) {
        otherNum =  abs((int)(_voltageTV.datasource.count-_currentTV.datasource.count))/3;
    } else {
        otherNum =  abs((int)(3-_currentTV.datasource.count))/3;
    }
    for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (_voltageTV.datasource.count>_currentTV.datasource.count) {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_TestDataParamModel *base_U = _voltageTV.datasource[j];
                [UArr addObject:base_U];
                
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        } else {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_TestDataParamModel *base_C = _currentTV.datasource[j];
                [CArr addObject:base_C];
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        }
        
        
    }
    
    _vectorgraphView.drawViewDataSource = vecArr;
    if (_vectorgraphView.selectedDataArr.count==0) {
        [_vectorgraphView createCellSelectedArr];
    }
    
}

#pragma mark - 实时波形图页面
-(void)shoWaveShapeView{
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
    
    self.paramScrollView.contentOffset = CGPointMake(7*self.paramScrollView.width, 0);
}

#pragma mark - 功率页面
-(void)showPowerView{
    
    self.paramScrollView.contentOffset = CGPointMake(4*self.paramScrollView.width, 0);
}
#pragma mark - 序分量页面
-(void)showSequencerView{
    
    self.paramScrollView.contentOffset = CGPointMake(5*self.paramScrollView.width, 0);
}
#pragma mark - 功率页面
-(void)showLineVoltage{
    
    self.paramScrollView.contentOffset = CGPointMake(6*self.paramScrollView.width, 0);
}
//测试仪数据上传到移动端，刷新信息图
-(void)infomationViewRefreshData:(BD_TestResultModel *)result{
    _infomationView.isScrollTBView = NO;
    BD_TestInformationModel *model = [[BD_TestInformationModel alloc]init];
    model.infoindex = (int) _infomationView.infoDataSource.count+1;
    model.currentTime = [BD_Utils getCurrentDateToms];
    model.actionType = (BDActionType)result.nType;
    model.binaryIn = [self binaryInToString:result.nInput];
    if (result.nType == 4) {
        //self.hasLockedArr.count！=0表示此次数据有动作时间
//        if (self.hasLockedArr.count!=0) {
            model.actionTime = [NSString stringWithFormat:@"%.6f",[self.testResultData.actionInfoArr lastObject].actionTime];//信息图中显示6位小数
//            //在信息图中添加了新的动作时间后，才删除动作计数数组中的内容
//            [self.hasLockedArr removeAllObjects];
//        }
        
    }
    [_infomationView.infoDataSource addObject:model];
    [_infomationView reloadData];
}

//将返回到十进制
-(NSString *)binaryInToString:(int)n{
    NSString *resultStr = @"";
    int d;
    for(int i=0;i<10;i++)
    {
        d=n%2;  //取余,余数
        n=n/2;  //取整
        if (d==0) {
            resultStr =  [resultStr stringByAppendingString:[NSString stringWithFormat:@"%d",1]];
        } else {
            resultStr =  [resultStr stringByAppendingString:[NSString stringWithFormat:@"%d",0]];
        }
        
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
        _voltageTV.headerTitleArr = @[@"幅值(V)",@"相位(°)",@"频率(Hz)"];
        _voltageTV.quickTBParaBlack = ^(BD_TestDataParamModel *cellModel, NSInteger index) {
            
            //            [weakself.quickTestData[0] replaceObjectAtIndex:index withObject:cellModel];
            ((BD_TestDataParamModel *)weakself.quickTestData[0][index]).titleName = cellModel.titleName;
            ((BD_TestDataParamModel *)weakself.quickTestData[0][index]).amplitude = cellModel.amplitude;
            ((BD_TestDataParamModel *)weakself.quickTestData[0][index]).phase = cellModel.phase;
            ((BD_TestDataParamModel *)weakself.quickTestData[0][index]).frequency = cellModel.frequency;
            ((BD_TestDataParamModel *)weakself.quickTestData[0][index]).unit = cellModel.unit;
            
            //            [weakself changeLineDataWithrow:index dataArr:weakself.quickTestData[0] lineData:weakself.oscillographDataArr[weakself.paramSetV.pickerModel.group].VAmplitudeArr];
            
            [weakself changeOutputWaveDataL:weakself.voltageTV index:index changeType:QuickTestParamModelChangeItemType_All changeData:nil changeModel:cellModel];
            
//            [weakself.voltageTV reloadData];
            
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
        _currentTV.headerTitleArr = @[@"幅值(A)",@"相位(°)",@"频率(Hz)"];
        _currentTV.quickTBParaBlack = ^(BD_TestDataParamModel *cellModel, NSInteger index) {
            //            [weakself.quickTestData[1] replaceObjectAtIndex:index withObject:cellModel];
            ((BD_TestDataParamModel *)weakself.quickTestData[1][index]).titleName = cellModel.titleName;
            ((BD_TestDataParamModel *)weakself.quickTestData[1][index]).amplitude = cellModel.amplitude;
            ((BD_TestDataParamModel *)weakself.quickTestData[1][index]).phase = cellModel.phase;
            ((BD_TestDataParamModel *)weakself.quickTestData[1][index]).frequency = cellModel.frequency;
            ((BD_TestDataParamModel *)weakself.quickTestData[1][index]).unit = cellModel.unit;
            //            [weakself changeLineDataWithrow:index dataArr:weakself.quickTestData[1] lineData:weakself.oscillographDataArr[weakself.paramSetV.pickerModel.group].CAmplitudeArr];
            [weakself changeOutputWaveDataL:weakself.currentTV index:index changeType:QuickTestParamModelChangeItemType_All changeData:nil changeModel:cellModel];
//            [weakself.currentTV reloadData];
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
#pragma mark - 根据额定电压和额定电流，额定频率计算输出数据

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
//注销原因：测试结果和指示灯view进行了样式修改
//-(void)actionBeginShowDeviceTestResultView{
//    [_resultView transitionWithType:kCATransitionPush withSubType:kCATransitionFromTop withDuration:0.5];
//
//    [_resultView setFrame:CGRectMake(_paramScrollView.frame.origin.x,self.view.height-150, _paramScrollView.width, 150)];
//}
//-(void)removeDeviceTestResultView{
//
//    [_resultView setFrame:CGRectMake(_paramScrollView.frame.origin.x,self.view.height, _paramScrollView.width, 150)];
//    [_resultView transitionWithType:kCATransitionPush withSubType:kCATransitionFromBottom withDuration:0.5];
//
//}

-(void)resultViewShow:(UIButton *)sender{
    _testResultBtn.selected = !_testResultBtn.selected;
    if (_testResultBtn.selected) {
        [self resultViewShowAnimation];
    } else {
        [self resultViewDismissAnimation];
    }
    
}


-(void)resultViewShowAnimation{
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.resultView];
    [UIView animateWithDuration:0.3 animations:^{
        [self.resultView setFrame:CGRectMake(self.view.width-self.view.width/2, self.testResultBtn.top-100, self.view.width/2, 200)];
    } completion:^(BOOL finished) {
        
        
    }];
}
-(void)resultViewDismissAnimation{
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.resultView];
    [UIView animateWithDuration:0.3 animations:^{
        [_resultView setFrame:CGRectMake(self.view.width,self.testResultBtn.top-100, 0,200)];
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark - 测试结果点击手势
-(void)resultViewTapGesture:(UITapGestureRecognizer *)gesture{
    [self resultViewDismissAnimation];
    self.testResultBtn.selected = NO;
}
#pragma mark - 测试结果页面添加手势
//-(void)addGesture{
//
//
//
//    UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    [self.view addGestureRecognizer:swipeGestureRecognizerUp];
////    [_resultView addGestureRecognizer:swipeGestureRecognizerUp];
//    swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
//
//    UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
////    [self.view addGestureRecognizer:swipeGestureRecognizerDown];
//    [self.resultView addGestureRecognizer:swipeGestureRecognizerDown];
//    swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
//
//
//}

/**
 *  处理轻扫手势
 *
 *  @param recognizer 轻扫手势识别器对象实例
 */
//- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
//
//    //代码块方式封装操作方法
//    //    void (^positionOperation)() = ^() {
//    //        CGPoint newPoint = recognizer.view.center;
//    //        newPoint.y -= 20.0;
//    //        self.center = newPoint;
//    //        newPoint.y += 40.0;
//    //        self.center = newPoint;
//    //    };
//
//    //根据轻扫方向，进行不同控制
//    switch (recognizer.direction) {
//        case UISwipeGestureRecognizerDirectionRight: {
//
//            break;
//        }
//        case UISwipeGestureRecognizerDirectionLeft: {
//
//            break;
//        }
//        case UISwipeGestureRecognizerDirectionUp: {
//            [self actionBeginShowDeviceTestResultView];
//            break;
//        }
//        case UISwipeGestureRecognizerDirectionDown: {
//            [self removeDeviceTestResultView];
//            break;
//        }
//    }
//}

#pragma mark - 初始化状态图页面的数据
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
                    
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName model:Umodel];
                    BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName model:Cmodel];
                    
                    [UArr addObject:Ubase];
                    [CArr addObject:Cbase];
                }
            }
            
            
            BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
            [_oscillographDataArr addObject:os];
        }
        
        NSInteger otherNum=0;
        if (_voltageTV.datasource.count!=4) {
            otherNum =  abs((int)(_voltageTV.datasource.count-_currentTV.datasource.count))/3;
        } else {
            otherNum =  abs((int)(3-_currentTV.datasource.count))/3;
        }
        for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
            NSMutableArray *UArr = [[NSMutableArray alloc]init];
            NSMutableArray *CArr = [[NSMutableArray alloc]init];
            if (_voltageTV.datasource.count>_currentTV.datasource.count) {
                for (int j = 3*n; j<(n+1)*3;j++) {
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];
                    
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_voltageTV.datasource[j].titleName model:Umodel];
                    
                    
                    [UArr addObject:Ubase];
                }
                
                BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
                [_oscillographDataArr addObject:os];
            } else {
                for (int j = 3*n; j<(n+1)*3;j++) {
                    
                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                    
                    
                    BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_currentTV.datasource[j].titleName model:Cmodel];
                    
                    
                    [CArr addObject:Cbase];
                }
                BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
                [_oscillographDataArr addObject:os];
            }
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _oscillographView.lineDataSourceArr = _oscillographDataArr;
            //状态图页面刷新显示数据后，更新selectedarr中的数据
            [_oscillographView.selectedDataArr removeAllObjects];
            for (int i = 0; i<_oscillographDataArr.count; i++) {
                BD_OutputwaveShapeDataModel *model;
                if (_oscillographDataArr[i].VAmplitudeArr.count !=0 && _oscillographDataArr[i].CAmplitudeArr.count !=0 ) {
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                    [_oscillographView.selectedDataArr addObject:model];
                } else if (_oscillographDataArr[i].VAmplitudeArr.count ==0){
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]init] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                    [_oscillographView.selectedDataArr addObject:model];
                } else if (_oscillographDataArr[i].CAmplitudeArr.count ==0){
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]init]];
                    [_oscillographView.selectedDataArr addObject:model];
                }
                
                
                
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
            
            complete(_oscillographDataArr);
            [_oscillographView.tableView reloadData];
            
        });
        
        
    });
}



//数据页面数据改变后，改变oscillographDataArr(状态图)页面的数据
//-(void)changeLineDataWithrow:(NSInteger)row dataArr:(NSMutableArray *)tbArray lineData:(NSMutableArray<BD_QuickTestOscillographModel_Base *> *)lineDataArr{
//
//    WeakSelf;
//    NSInteger arrRow = row-3*self.paramSetV.pickerModel.group;
//    if (weakself.oscillographDataArr) {
//        NSString *change = ((BD_TestDataParamModel *)tbArray[row]).amplitude;
//        switch (arrRow) {
//            case 0:
//                [lineDataArr[0].model   addObject:change];
//                break;
//            case 1:
//                [lineDataArr[1].model   addObject:change];
//
//                break;
//            case 2:
//                [lineDataArr[2].model   addObject:change];
//                break;
//            default:
//                break;
//        }
//
//    }
//}



#pragma mark - 创建开入开出状态图数据源
//-(void)updateBinaryStateDatas:(int)binaryAll{
//    int d;
//    for(int i=0;i<10;i++)
//    {
//        d=binaryAll%2;  //取余,余数
//        binaryAll=binaryAll/2;  //取整
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //设置btn亮
//            if (d == 0) {
//
//                UIButton *btn = _resultView.btnsArray1[i];
//                btn.backgroundColor = [UIColor greenColor];
//                btn.userInteractionEnabled = YES;
//            }
//            else if (d == 1){
//
//                UIButton *btn = _resultView.btnsArray1[i];
//                btn.backgroundColor = [UIColor lightGrayColor];
//                btn.userInteractionEnabled = NO;
//
//            }
//        });
//    }
//}

#pragma mark - BDBinaryChangedProtocol
//开入量设置通道指示灯是否可用
-(void)changeBinaryState:(int)binaryNum{
    int d;
    for(int i=0;i<10;i++)
    {
        d=binaryNum%2;  //取余,余数
        binaryNum=binaryNum/2;  //取整
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置btn亮
            if (d == 1) {
                
                UIButton *btn = self.switchView.switchBtnArr[i+2];
                [btn setBackgroundImage:[UIImage imageWithColor: RGB(234, 234, 234) width:btn.width height:btn.height title:@""] forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            }
            else if (d == 0){
                
                UIButton *btn = self.switchView.switchBtnArr[i+2];
                [btn setBackgroundImage:[UIImage imageNamed:@"lightUnUsed"] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            }
        });
    }
    
}
#pragma  mark - 控制开出量指示灯状态，移动端自己控制的
-(void)changeBinaryoutState:(int)binaryNum{
    int d;
    for(int i=0;i<8;i++)
    {
        d=binaryNum%2;  //取余,余数
        binaryNum=binaryNum/2;  //取整
        NSInteger allCount = self.switchView.switchBtnArr.count;
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置btn亮
            if (d == 1) {
                
                UIButton *btn = self.switchView.switchBtnArr[allCount-16+i];
                btn.backgroundColor = RGB(234, 234, 234);
                btn.userInteractionEnabled = YES;
            }
            else if (d == 0){
                
                UIButton *btn = self.switchView.switchBtnArr[allCount-16+i];
                
                btn.backgroundColor = [UIColor greenColor];
                btn.userInteractionEnabled = NO;
            }
        });
    }
    
}

-(void)changeBinaryoutStateOntimer:(int)binaryNum{
    if (_beginModel.isBegin) {
        _paramSetV.comParam.isLock = _isLock;
        if (_quickTestData.count == 3) {
            [_quickTestData removeLastObject];
        }
        [_quickTestData addObject:[[NSMutableArray alloc]initWithArray:@[_paramSetV.comParam]]];
        [[OCCenter shareCenter] ManualTest:_quickTestData];
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
        @autoreleasepool{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (BD_QuickTestOscillographModel *model in _oscillographDataArr) {
                    for (int i = 0; i<model.VAmplitudeArr.count;i++) {
                        BD_QuickTestOscillographModel_Base *base = model.VAmplitudeArr[i];
                        
                        for (BD_TestDataParamModel *obj in _quickTestData[0]) {
                            if ([obj.titleName isEqualToString:base.title]) {
                                if (base.model.count>=600) {
                                    [base.model removeAllObjects];
                                }
                                [base.model addObject:@([obj.amplitude floatValue])];
                            }
                        }
                        
                        
                    }
                    
                    for (int i = 0; i<model.CAmplitudeArr.count;i++) {
                        BD_QuickTestOscillographModel_Base *base = model.CAmplitudeArr[i];
                        
                        for (BD_TestDataParamModel *obj in _quickTestData[1]) {
                            if ([obj.titleName isEqualToString:base.title]) {
                                if (base.model.count>=600) {
                                    [base.model removeAllObjects];
                                }
                                [base.model addObject:@([obj.amplitude floatValue])];
                            }
                        }
                    }
                }
                    [self setOscillographBinaryArr];
            });
           
        }

    

    
}
-(void)setOscillographDataDefaut{
    _oscillographView.xvalueMax = 600;
    for (BD_QuickTestOscillographModel *model in _oscillographDataArr) {
        for (int n = 0; n<model.VAmplitudeArr.count; n++) {
            for (int i = 0; i<model.VAmplitudeArr[n].model.count ; i++) {
                [model.VAmplitudeArr[n].model removeAllObjects];
            }
            
        }
        for (int n = 0; n<model.CAmplitudeArr.count; n++) {
            for (int i = 0; i<model.CAmplitudeArr[n].model.count ; i++) {
                [model.CAmplitudeArr[n].model removeAllObjects];
            }
            
        }
        
        
    }
    _oscillographView.lineDataSourceArr = _oscillographDataArr;
    [_oscillographView.binaryStates enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeAllObjects];
    }];
    [_oscillographView.tableView reloadData];
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
    //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    //
    //    [_oscillographView.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    [_oscillographView.tableView reloadData];
}

#pragma mark - BD_OutputwaveShapeAutoRefreshDataDelegate 实时波形图页面自动刷新更新数据delegate
-(void)refreshOutputwaveData{
    
    //重新开始试验后，先恢复波形图的数据，之后就不用构建波形图数据了
    if (!_waveShapeView.hasShowWaveImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:[_quickTestData copy]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_waveShapeView reloadData];
                
            });
        });
    }
    _waveShapeView.hasShowWaveImage = YES;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSInteger groupNum = _voltageTV.datasource.count<_currentTV.datasource.count? _voltageTV.datasource.count/3:_currentTV.datasource.count/3;
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
            model2.modelDatas = @[@"有功功率(W)", kTStrings(archive_a), kTStrings(archive_b), kTStrings(archive_c), kTStrings(archive_a+archive_b+archive_c)];
            
            float rearchive_a = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[3*i+0] CData:_currentTV.datasource[3*i+0]];
            float rearchive_b = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[3*i+1] CData:_currentTV.datasource[3*i+1]];
            float rearchive_c = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[3*i+2] CData:_currentTV.datasource[3*i+2]];
            
            BD_FormTBViewBaseModel *model3 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
            model3.modelDatas = @[@"无功功率(Var)",kTStrings(rearchive_a), kTStrings(rearchive_b), kTStrings(rearchive_c), kTStrings(rearchive_a+rearchive_b+rearchive_c)];
            
            float ap_a = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[3*i+0] CData:_currentTV.datasource[3*i+0]];
            float ap_b = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[3*i+1] CData:_currentTV.datasource[3*i+1]];
            float ap_c = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[3*i+2] CData:_currentTV.datasource[3*i+2]];
            
            BD_FormTBViewBaseModel *model4 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
            model4.modelDatas = @[@"现在功率(VA)",kTStrings(ap_a), kTStrings(ap_b), kTStrings(ap_c), kTStrings(ap_a+ap_b+ap_c)];
            NSArray *value = @[model1,model2,model3,model4];
            [arr addObject:value];
        }
        NSInteger otherNum=0;
        if (_voltageTV.datasource.count!=4) {
            otherNum =  abs((int)(_voltageTV.datasource.count-_currentTV.datasource.count))/3;
        } else {
            otherNum =  abs((int)(3-_currentTV.datasource.count))/3;
        }
        for (int n = (int)groupNum; n<otherNum+groupNum; n++) {
            
            if (_voltageTV.datasource.count>_currentTV.datasource.count) {
                NSArray *value;
                for (int j = 3*n; j<(n+1)*3;j++) {
                    
                    NSString *a = [NSString stringWithFormat:@"%.3f",[BD_CaculatePowerManager getpowerElementWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]]];
                    NSString *b = kTStrings([BD_CaculatePowerManager getpowerElementWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]]);
                    NSString *c = kTStrings([BD_CaculatePowerManager getpowerElementWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]]);
                    
                    BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model1.modelDatas = @[@"功率因数",a,b,c,@""];
                    
                    float archive_a = [BD_CaculatePowerManager getActivePowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    float archive_b = [BD_CaculatePowerManager getActivePowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    float archive_c = [BD_CaculatePowerManager getActivePowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    
                    BD_FormTBViewBaseModel *model2 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model2.modelDatas = @[@"有功功率(W)", kTStrings(archive_a), kTStrings(archive_b), kTStrings(archive_c), kTStrings(archive_a+archive_b+archive_c)];
                    
                    float rearchive_a = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    float rearchive_b = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    float rearchive_c = [BD_CaculatePowerManager getReactivePowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    
                    BD_FormTBViewBaseModel *model3 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model3.modelDatas = @[@"无功功率(Var)",kTStrings(rearchive_a), kTStrings(rearchive_b), kTStrings(rearchive_c), kTStrings(rearchive_a+rearchive_b+rearchive_c)];
                    
                    float ap_a = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    float ap_b = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    float ap_c = [BD_CaculatePowerManager getApparentPowerWithVData:_voltageTV.datasource[j] CData:[[BD_TestDataParamModel alloc]init]];
                    
                    BD_FormTBViewBaseModel *model4 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model4.modelDatas = @[@"现在功率(VA)",kTStrings(ap_a), kTStrings(ap_b), kTStrings(ap_c), kTStrings(ap_a+ap_b+ap_c)];
                    value = @[model1,model2,model3,model4];
                }
                [arr addObject:value];
                
            } else {
                NSArray *value;
                for (int j = 3*n; j<(n+1)*3;j++) {
                    NSString *a = [NSString stringWithFormat:@"%.3f",[BD_CaculatePowerManager getpowerElementWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]]];
                    NSString *b = kTStrings([BD_CaculatePowerManager getpowerElementWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]]);
                    NSString *c = kTStrings([BD_CaculatePowerManager getpowerElementWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]]);
                    
                    BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model1.modelDatas = @[@"功率因数",a,b,c,@""];
                    
                    float archive_a = [BD_CaculatePowerManager getActivePowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    float archive_b = [BD_CaculatePowerManager getActivePowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    float archive_c = [BD_CaculatePowerManager getActivePowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    
                    BD_FormTBViewBaseModel *model2 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model2.modelDatas = @[@"有功功率(W)", kTStrings(archive_a), kTStrings(archive_b), kTStrings(archive_c), kTStrings(archive_a+archive_b+archive_c)];
                    
                    float rearchive_a = [BD_CaculatePowerManager getReactivePowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    float rearchive_b = [BD_CaculatePowerManager getReactivePowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    float rearchive_c = [BD_CaculatePowerManager getReactivePowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    
                    BD_FormTBViewBaseModel *model3 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model3.modelDatas = @[@"无功功率(Var)",kTStrings(rearchive_a), kTStrings(rearchive_b), kTStrings(rearchive_c), kTStrings(rearchive_a+rearchive_b+rearchive_c)];
                    
                    float ap_a = [BD_CaculatePowerManager getApparentPowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    float ap_b = [BD_CaculatePowerManager getApparentPowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    float ap_c = [BD_CaculatePowerManager getApparentPowerWithVData:[[BD_TestDataParamModel alloc]init] CData:_currentTV.datasource[j]];
                    
                    BD_FormTBViewBaseModel *model4 = [[BD_FormTBViewBaseModel alloc]initWithNum:5];
                    model4.modelDatas = @[@"现在功率(VA)",kTStrings(ap_a), kTStrings(ap_b), kTStrings(ap_c), kTStrings(ap_a+ap_b+ap_c)];
                    value = @[model1,model2,model3,model4];
                    
                }
                [arr addObject:value];
            }
            
            
        }
        
        self.powerView.powerDatasource = [arr copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.powerView reloadData];
        });
    });
  
   
 
}

#pragma mark - 构建序分量数据
-(void)loadSequenceViewData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BD_SequenceCaculateManager *cacuManager = [[BD_SequenceCaculateManager alloc]init];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSInteger groupNum = _voltageTV.datasource.count/3;
        NSMutableArray *headerTitle = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i<groupNum; i++) {
            BD_ChannelModel *channelA = [[BD_ChannelModel alloc]init];
            channelA.amplitude = [_voltageTV.datasource[i*3+0].amplitude doubleValue];
            channelA.phase = [_voltageTV.datasource[i*3+0].phase doubleValue];
            channelA.frequency = [_voltageTV.datasource[i*3+0].frequency doubleValue];
            
            BD_ChannelModel *channelB = [[BD_ChannelModel alloc]init];
            channelB.amplitude = [_voltageTV.datasource[i*3+1].amplitude doubleValue];
            channelB.phase = [_voltageTV.datasource[i*3+1].phase doubleValue];
            channelB.frequency = [_voltageTV.datasource[i*3+1].frequency doubleValue];
            
            BD_ChannelModel *channelC = [[BD_ChannelModel alloc]init];
            channelC.amplitude = [_voltageTV.datasource[i*3+2].amplitude doubleValue];
            channelC.phase = [_voltageTV.datasource[i*3+2].phase doubleValue];
            channelC.frequency = [_voltageTV.datasource[i*3+2].frequency doubleValue];
            
            BD_ChannelStrModel *channelS_U0 = [cacuManager getZeroSeqValueFromchannel_A:channelA channel_B:channelB channel_C:channelC];
            BD_ChannelStrModel *channelS_U1 = [cacuManager getPositiveSeqValueFromchannel_A:channelA channel_B:channelB channel_C:channelC];
            BD_ChannelStrModel *channelS_U2 = [cacuManager getNegativeSeqValueFromchannel_A:channelA channel_B:channelB channel_C:channelC];
            
            BD_FormTBViewBaseModel *model0 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model0.modelDatas = @[@"U0",channelS_U0.amplitude,channelS_U0.phase];
            BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model1.modelDatas = @[@"U1",channelS_U1.amplitude,channelS_U1.phase];
            BD_FormTBViewBaseModel *model2 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model2.modelDatas = @[@"U2",channelS_U2.amplitude,channelS_U2.phase];
            
            NSArray *value = @[model1,model2,model0];
            [arr addObject:value];
            
            [headerTitle addObject:@[[NSString stringWithFormat:@"名称(%@,%@,%@)",_voltageTV.datasource[i*3+0].titleName,_voltageTV.datasource[i*3+1].titleName,_voltageTV.datasource[i*3+2].titleName],@"幅值(V)",@"相位(°)"]];
        }
        
        NSInteger groupNum_I = _currentTV.datasource.count/3;
        for (NSInteger i = 0; i<groupNum_I; i++) {
            BD_ChannelModel *channelA = [[BD_ChannelModel alloc]init];
            channelA.amplitude = [_currentTV.datasource[i*3+0].amplitude doubleValue];
            channelA.phase = [_currentTV.datasource[i*3+0].phase doubleValue];
            channelA.frequency = [_currentTV.datasource[i*3+0].frequency doubleValue];
            
            BD_ChannelModel *channelB = [[BD_ChannelModel alloc]init];
            channelB.amplitude = [_currentTV.datasource[i*3+1].amplitude doubleValue];
            channelB.phase = [_currentTV.datasource[i*3+1].phase doubleValue];
            channelB.frequency = [_currentTV.datasource[i*3+1].frequency doubleValue];
            
            BD_ChannelModel *channelC = [[BD_ChannelModel alloc]init];
            channelC.amplitude = [_currentTV.datasource[i*3+2].amplitude doubleValue];
            channelC.phase = [_currentTV.datasource[i*3+2].phase doubleValue];
            channelC.frequency = [_currentTV.datasource[i*3+2].frequency doubleValue];
            
            BD_ChannelStrModel *channelS_U0 = [cacuManager getZeroSeqValueFromchannel_A:channelA channel_B:channelB channel_C:channelC];
            BD_ChannelStrModel *channelS_U1 = [cacuManager getPositiveSeqValueFromchannel_A:channelA channel_B:channelB channel_C:channelC];
            BD_ChannelStrModel *channelS_U2 = [cacuManager getNegativeSeqValueFromchannel_A:channelA channel_B:channelB channel_C:channelC];
            
            BD_FormTBViewBaseModel *model0 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model0.modelDatas = @[@"I0",channelS_U0.amplitude,channelS_U0.phase];
            BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model1.modelDatas = @[@"I1",channelS_U1.amplitude,channelS_U1.phase];
            BD_FormTBViewBaseModel *model2 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model2.modelDatas = @[@"I2",channelS_U2.amplitude,channelS_U2.phase];
            
            NSArray *value = @[model1,model2,model0];
            
            [arr addObject:value];
            [headerTitle addObject:@[[NSString stringWithFormat:@"名称(%@,%@,%@)",_currentTV.datasource[i*3+0].titleName,_currentTV.datasource[i*3+1].titleName,_currentTV.datasource[i*3+2].titleName],@"幅值(A)",@"相位(°)"]];
        }
        
        self.sequeView.formDatasource = [arr copy];
        self.sequeView.headerTitles = [headerTitle copy];
        
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.sequeView reloadData];
       });
    });
   
   
}

#pragma mark - 构建线电压数据
-(void)loadLineVoltageViewData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BD_SequenceCaculateManager *cacuManager = [[BD_SequenceCaculateManager alloc]init];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSInteger groupNum = _voltageTV.datasource.count/3;
        for (NSInteger i = 0; i<groupNum; i++) {
            BD_ChannelModel *channelA = [[BD_ChannelModel alloc]init];
            channelA.amplitude = [_voltageTV.datasource[i*3+0].amplitude doubleValue];
            channelA.phase = [_voltageTV.datasource[i*3+0].phase doubleValue];
            channelA.frequency = [_voltageTV.datasource[i*3+0].frequency doubleValue];
            
            BD_ChannelModel *channelB = [[BD_ChannelModel alloc]init];
            channelB.amplitude = [_voltageTV.datasource[i*3+1].amplitude doubleValue];
            channelB.phase = [_voltageTV.datasource[i*3+1].phase doubleValue];
            channelB.frequency = [_voltageTV.datasource[i*3+1].frequency doubleValue];
            
            BD_ChannelModel *channelC = [[BD_ChannelModel alloc]init];
            channelC.amplitude = [_voltageTV.datasource[i*3+2].amplitude doubleValue];
            channelC.phase = [_voltageTV.datasource[i*3+2].phase doubleValue];
            channelC.frequency = [_voltageTV.datasource[i*3+2].frequency doubleValue];
            
            double  amplitude1 = [cacuManager getASubBAmplitude:channelA channel2:channelB];
            double  phase1 = [cacuManager getASubBAngle:channelA channel2:channelB];
            
            double  amplitude2 = [cacuManager getASubBAmplitude:channelB channel2:channelC];
            double  phase2 = [cacuManager getASubBAngle:channelB channel2:channelC];
            
            double  amplitude3 = [cacuManager getASubBAmplitude:channelC channel2:channelA];
            double  phase3 = [cacuManager getASubBAngle:channelC channel2:channelA];
            
            BD_FormTBViewBaseModel *model0 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            
            model0.modelDatas = @[[NSString stringWithFormat:@"%@%@",[_voltageTV.datasource[i*3+0].titleName substringToIndex:2],[_voltageTV.datasource[i*3+1].titleName substringFromIndex:1]],[NSString stringWithFormat:@"%.3f",amplitude1],[NSString stringWithFormat:@"%.3f",phase1],_voltageTV.datasource[i*3+0].frequency];
            
            BD_FormTBViewBaseModel *model1 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model1.modelDatas = @[[NSString stringWithFormat:@"%@%@",[_voltageTV.datasource[i*3+1].titleName substringToIndex:2],[_voltageTV.datasource[i*3+2].titleName substringFromIndex:1]],[NSString stringWithFormat:@"%.3f",amplitude2],[NSString stringWithFormat:@"%.3f",phase2],_voltageTV.datasource[i*3+1].frequency];
            BD_FormTBViewBaseModel *model2 = [[BD_FormTBViewBaseModel alloc]initWithNum:3];
            model2.modelDatas = @[[NSString stringWithFormat:@"%@%@",[_voltageTV.datasource[i*3+2].titleName substringToIndex:2],[_voltageTV.datasource[i*3+0].titleName substringFromIndex:1]],[NSString stringWithFormat:@"%.3f",amplitude3],[NSString stringWithFormat:@"%.3f",phase3],_voltageTV.datasource[i*3+2].frequency];
            
            [arr addObject:model0];
            [arr addObject:model1];
            [arr addObject:model2];
            
        }
        
        self.lineVoltageView.formDatasource = @[[arr copy]];
       dispatch_async(dispatch_get_main_queue(), ^{
           
           [self.lineVoltageView reloadData];
       });
    });
   
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //只要改变试图，就关闭矢量图页面键盘

    if (_paramScrollView.contentOffset.x>7*_paramScrollView.width) {
        _paramScrollView.scrollEnabled = NO;
    } else {
        _paramScrollView.scrollEnabled = YES;
        NSInteger currentindex = (int)_paramScrollView.contentOffset.x/_paramScrollView.width;
        [self changeTopBtnState:currentindex];
    }
    
    
    if(_paramScrollView.contentOffset.x == _paramScrollView.width && _beginModel.isBegin == YES){
        [_waveShapeView startTimer];
    }
    if (_paramScrollView.contentOffset.x==_paramScrollView.width) {//滑动到输出波形图，调用显示输出波形图页面
        [self shoWaveShapeView];
    }
    
    if ( _paramScrollView.contentOffset.x==4*_paramScrollView.width) {
        
        [self loadPowerViewData];
        
        self.paramScrollView.contentOffset = CGPointMake(4*self.paramScrollView.width, 0);
        
    }
    if ( _paramScrollView.contentOffset.x==5*_paramScrollView.width) {
        
        [self loadSequenceViewData];
        
        self.paramScrollView.contentOffset = CGPointMake(5*self.paramScrollView.width, 0);
        
    }
    if ( _paramScrollView.contentOffset.x==6*_paramScrollView.width) {
        
        [self loadLineVoltageViewData];
        
        self.paramScrollView.contentOffset = CGPointMake(6*self.paramScrollView.width, 0);
        
    }
    
    
}


-(void)changeTopBtnState:(NSInteger)index{
    for (NSInteger i = 0; i<_topBtnArr.count; i++) {
        if (i == index) {
            _topBtnArr[i].selected = YES;
        } else {
            _topBtnArr[i].selected = NO;
            
        }
        if (index>=5) {
            self.topScrolView.contentOffset = CGPointMake(_topBtnArr[i].width*3, 0);
        } else if (index<=3){
                self.topScrolView.contentOffset = CGPointMake(0, 0);
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

-(void)showReportVC:(UIView *)sourceView{
    //    BD_TestReportManagerVC *reportVC = [[BD_TestReportManagerVC alloc]init];
    //    reportVC.modalPresentationStyle = UIModalPresentationPopover;
    //     reportVC.preferredContentSize = CGSizeMake(350,SCREEN_HEIGHT*0.5);
    //    UIPopoverPresentationController *popPresenter = reportVC.popoverPresentationController;
    //    popPresenter.sourceView = sourceView;
    //    popPresenter.sourceRect = sourceView.bounds;
    //    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionDown;
    //    [self presentViewController:reportVC animated:NO completion:nil];
    WeakSelf;
    NSArray *files  = [FileUtil getDirectoryFileNames:@""];
    [BD_PopListViewManager ShowPopViewWithlistDataSource:files textField:sourceView viewController:self direction:UIPopoverArrowDirectionDown complete:^(NSString *fileName) {
        if ([fileName hasSuffix:@".pdf"]) {
            
            if (!weakself.reportView) {
                weakself.reportView = [[BD_ReportPDFMainVC alloc]init];
            }
            weakself.reportView.fileName = fileName;
            [weakself.reportView refreshView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself presentViewController:weakself.reportView animated:YES completion:nil];
            });
            
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [BD_PopListViewManager showRemindAlertView:weakself title:@"提醒" message:@"请选择正确的报告打开"];
            });
            
        }
    }];
    
}
//程序进入后台，修改页面显示
-(void)applicationEnterBackground{
    //注意： 之前的需求是程序进入后台测试仪要停止输出，页面显示开始试验前的状态，2018年6月7日这轮测试又说进入后台后，不停止试验。。。
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
    
    if ([keyPath isEqualToString:@"isCocurrent"]) {
        if (self.paramSetV.comParam.isCocurrent) {
            [_voltageTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.phase = @"0.000";
                obj.frequency = @"0.000";
            }];
            [_currentTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.phase = @"0.000";
                obj.frequency = @"0.000";
            }];
        } else {
            [_voltageTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.titleName containsString:@"a"]) {
                    obj.phase = @"0.000";
                } else if ([obj.titleName containsString:@"b"]) {
                    obj.phase = @"-120.000";
                } else if ([obj.titleName containsString:@"c"]) {
                    obj.phase = @"120.000";
                }
                obj.frequency = @"50.000";
            }];
            [_currentTV.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.titleName containsString:@"a"]) {
                    obj.phase = @"0.000";
                } else if ([obj.titleName containsString:@"b"]) {
                    obj.phase = @"-120.000";
                } else if ([obj.titleName containsString:@"c"]) {
                    obj.phase = @"120.000";
                }
                obj.frequency = @"50.000";
            }];
        }
        _voltageTV.isDirectCurrent = self.paramSetV.comParam.isCocurrent;
        _currentTV.isDirectCurrent = self.paramSetV.comParam.isCocurrent;
    }
    
    if ([keyPath isEqualToString:@"varlabel"]) {
        [self.resultView setValuesUnitWithStr:self.paramSetV.comParam.varlabel];
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
            
        
            [self loadoscillographData:^(NSMutableArray *oscillographArr) {
                
            }];
          
            
            [_waveShapeView startTimer];
            //测试开始后，重新获取一波形图的数据
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                _waveShapeView.dataArr = [_dataCenter outPutWaveShapeDataCenter:_quickTestData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_waveShapeView reloadData];
                });
            });
            
            self.navigationController.navigationBar.userInteractionEnabled = NO;
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
            self.navigationItem.leftBarButtonItem.tintColor = [UIColor lightGrayColor];
            //            iec_unused
            rightBtnArr[0].imageView.image = [UIImage imageNamed:@"iec_unused"];
            rightBtnArr[0].btn.userInteractionEnabled = NO;
            //开始run灯闪
            self.runMangaer = [[BD_RunLightAnimationManager alloc]initWithView:self.switchView.switchBtnArr[0]];
            [kNotificationCenter postNotificationName:BD_ManualTestBegin object:nil userInfo:nil];
        } else {
            rightBtnArr[2].imageView.image = [UIImage imageNamed:@"lock_unused"];
            rightBtnArr[2].btn.userInteractionEnabled = NO;
            rightBtnArr[0].imageView.image = [UIImage imageNamed:@"rightBtn1"];
            rightBtnArr[0].btn.userInteractionEnabled = YES;
            
            
            //            [_oscillographView stopTimer];
            //            [_waveShapeView stopTimer];
            
            self.navigationController.navigationBar.userInteractionEnabled = YES;
            self.navigationItem.rightBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
            self.navigationItem.leftBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
            //停止run灯灭
            [self.runMangaer stopflashView];
            
        }
        _paramSetV.isBegin = self.beginModel.isBegin;
        _oscillographView.isBegin = self.beginModel.isBegin;
        [_paramSetV.tableView reloadData];
        
        
    }
    
    
    //    if ([keyPath isEqualToString:@"dataArr"]) {
    //        [_waveShapeView.selecteddataArr removeAllObjects];
    //        for (int i = 0; i<_waveShapeView.dataArr.count; i++) {
    //            BD_OutputwaveShapeDataModel *model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
    //            [_waveShapeView.selecteddataArr addObject:model];
    //        }
    //    }
    
}

- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    //必须移除通知
    
    //    [kNotificationCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [kNotificationCenter removeObserver:self name:BD_ReadDeviceInfoNoti object:nil];
    [kNotificationCenter removeObserver:self name:BD_ManualTestFromServiceDataNoti object:nil];
    [kNotificationCenter removeObserver:self name:BD_DirectCurrStart object:nil];
    [kNotificationCenter removeObserver:self name:BD_DirectCurrStop object:nil];
    [kNotificationCenter removeObserver:self name:BD_NewWordDisconnect object:nil];
    //添加监听后，必须移除
    [self removeObserver:self forKeyPath:@"isAuto" context:nil];
    [self removeObserver:self forKeyPath:@"isBegin" context:nil];
    [self removeObserver:self forKeyPath:@"isCocurrent" context:nil];
    [self removeObserver:self forKeyPath:@"varlabel" context:nil];
    
   
    [_waveShapeView cancelTimer];
    //    [self removeObserver:self forKeyPath:@"dataArr" context:nil];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_waveShapeView stopTimer];
    [BD_PMCtrlSingleton shared].deviceType = BDDeviceType_Imitate;
    [self resultViewDismissAnimation];
    self.testResultBtn.selected = NO;
    
}
//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
//}


@end

