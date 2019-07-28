//
//  BD_HarmonicController.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/27.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmonicController.h"
#import "BD_HarmDataController.h"
#import "BD_HarmControlView.h"
#import "BD_HarmDataSettingTableView.h"
#import "BD_BinarySwitchView.h"
#import "IQKeyboardManager.h"
#import "BD_HarmModel.h"
#import "BD_HarmWaveformController.h"
#import "BD_TestResultModel.h"
#import "BD_PopListViewManager.h"
#import "BD_InfomationTBView.h"
#import "BD_DirectCurrentSetManager.h"
#import "BD_HarmTemplateFileManager.h"
#import "BD_ReportPDFMainVC.h"
#import "BD_ReportMainVC.h"
#import "BD_ReportBaseModel.h"
#import "BD_TestBinarySwitchSetModel.h"
#import "UIImage+Extension.h"
#import "BD_ActionResultView.h"
#import "BD_HarmSuperDCVC.h"
#import "BD_HardwareConfigView.h"
@interface BD_HarmonicController ()
{
    BOOL _settingViewShow;
    BDDeviceType _type;
    BDHarmPassageType _passageway;
    UIButton *_tempBtn;
    long locktestStartSec;
    long locktestStartNoSec;
    
    long startTestSec;
    long startTestNoSec;
     NSInteger lockBinaryActionCount;
    
}
/**设置视图*/
@property (nonatomic, weak) BD_HarmDataSettingTableView *dataTBView;
/**设置按钮*/
@property (nonatomic, weak) UIButton *settingBtn;
/**谐波模型*/
@property (nonatomic, strong) BD_HarmModel *harmModel;
/**数据控制器*/
@property (nonatomic, strong) BD_HarmDataController *dataVC;
/**波形控制器*/
@property (nonatomic, strong) BD_HarmWaveformController *waveformVC;
/**信息图*/
@property (nonatomic,weak)BD_InfomationTBView *infomationView;
//测试结果view
@property (nonatomic,strong)BD_ActionResultView *resultView;
/**叠加直流页面*/
@property(nonatomic,strong)BD_HarmSuperDCVC *superDCView;
@property(nonatomic,assign)BOOL isBegin;
@property(nonatomic,assign)BOOL isLock;
//测试结果数据
@property (nonatomic, strong)BD_TestResultData *testResultData;
//信息图数据源
@property(nonatomic,strong)NSMutableArray<BD_TestInformationModel *>  *infoDataSource;
/**头部控制器*/
@property (nonatomic, strong)BD_HarmControlView *headerControlView;
/**加按钮*/
@property(nonatomic,weak)UIButton *pluseBtn;
/**减按钮*/
@property(nonatomic,weak)UIButton *reduceBtn;

//文件管理
@property (nonatomic,strong)BD_HarmTemplateFileManager *templateFileManager;
//琐
@property (nonatomic,weak)UIButton *lockBtn;
//测试结果
@property (nonatomic,weak)UIButton *testResultBtn;
/**叠加直流按钮*/
@property (nonatomic,weak)UIButton *superDCBtn;
//动作时间锁定计数
@property(nonatomic,strong)NSMutableArray *hasLockedArr;

@end

@implementation BD_HarmonicController

-(BD_HarmModel *)harmModel
{
    if (!_harmModel) {
        _harmModel = [[BD_HarmModel alloc] init];
    }
    return _harmModel;
}

-(NSMutableArray<BD_TestInformationModel *> *)infoDataSource{
    if (!_infoDataSource) {
        _infoDataSource = [[NSMutableArray alloc]init];
    }
    return _infoDataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    [[BD_Utils shared]setViewState:NO view:self.naviBtnArr[1]];
    [[BD_Utils shared]setViewState:NO view:self.naviBtnArr[2]];
    
    //设置键盘出现后移动页面
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    //添加监听
    [kNotificationCenter addObserver:self selector:@selector(sendHarmModel) name:BD_HarmSendData object:nil];
    [kNotificationCenter addObserver:self selector:@selector(refreshView:) name:BD_ManualTestFromServiceDataNoti object:nil];
    [kNotificationCenter addObserver:self selector:@selector(refreshDateDeviceInfoBinarySwitch:) name:BD_ReadDeviceInfoNoti object:nil];
    [self.harmModel.dataModel addObserver:self forKeyPath:@"isAuto" options:NSKeyValueObservingOptionNew context:nil];
    //目前不需要监听进入后台
//    [kNotificationCenter addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    _type = BDDeviceType_Imitate;
    _passageway = BDHarmPassageType_SUSI;
    
     self.hardWareView.moduletype = BD_TestModuleType_Harm;
    WeakSelf;
    self.binarySwitchSetView.okActionBlock = ^{
        [weakself setBinaryViewUsed];
    };
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataVC loadSubViewType:_type passageway:_passageway];
        self.waveformVC.harmModel = self.harmModel;
    });
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.dataVC.view setFrame:CGRectMake(0, 0, self.mainView.width, self.mainView.height)];
    [self.waveformVC.view setFrame:CGRectMake(2*self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    [self.infomationView setFrame:CGRectMake(self.mainView.width*3, 0, self.mainView.width, self.mainView.height)];
    [self.dataTBView setFrame:CGRectMake(self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    
    self.mainView.contentSize = CGSizeMake(self.mainView.width*4, self.mainView.height);
    [self.resultView setFrame:CGRectMake(self.view.width,self.self.view.height-250, 0,200)];
    
}
-(void)configureUI
{
    [super configureUI];
    //    [self.mainView removeFromSuperview];
    //    [self.startBtn removeFromSuperview];
    //    [self.stopBtn removeFromSuperview];
    //    [self.rightResultView removeFromSuperview];
    
    WeakSelf;
    //头部控制器
    //    BD_HarmControlView *headerView = [[BD_HarmControlView alloc] init];
    //    headerView.delegate = self;
    //    [self.view addSubview:headerView];
    //    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.and.right.mas_equalTo(0);
    //        make.height.mas_equalTo(50);
    //    }];
    //    self.headerControlView = headerView;
    
    CGFloat btnX = 10;
    CGFloat btnW = 100;
    CGFloat btnH = 40;
    NSArray *btnTitle = @[@"数据",@"参数设置",@"波形图",@"信息图"];
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
        [self.topTestView addSubview:btn];
        [viewBtnArr addObject:btn];
    }
    self.viewsBtnArr = [viewBtnArr copy];
    self.topTestView.contentSize = CGSizeMake(btnTitle.count*(btnW+btnX)+15, 50);
    if (self.topTestView.contentSize.width<self.view.width*0.6) {
        [self.topTestView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakself.topTestView.contentSize.width);
        }];
        [self.topTestView layoutIfNeeded];
    }
    
    UIButton *lockBtn = [[UIButton alloc]init];
    [lockBtn setImage:[UIImage imageNamed:@"lockOpen"] forState:UIControlStateNormal];
    //    [UIImage imageNamed:@"lock_unused"]
    [lockBtn setImage:[UIImage imageNamed:@"lock_unused"] forState:UIControlStateSelected];
    
    lockBtn.selected = YES;
    [lockBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [lockBtn addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lockBtn];
    [lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.stopBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    self.lockBtn = lockBtn;
    self.rightResultView.hidden = YES;
    [self setLockBtnIsUsed:NO];
    
  
    
    UIButton *pluseBtn = [[UIButton alloc]init];
    [pluseBtn setImage:[UIImage imageNamed:@"rightBtn5"] forState:UIControlStateNormal];
    [pluseBtn setImage:[UIImage imageNamed:@"pluse_unused"] forState:UIControlStateSelected];
    pluseBtn.selected = NO;
    [pluseBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [pluseBtn addTarget:self action:@selector(pluseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pluseBtn];
    self.pluseBtn = pluseBtn;
    [pluseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(lockBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *reduceBtn = [[UIButton alloc]init];
    [reduceBtn setImage:[UIImage imageNamed:@"rightBtn6"] forState:UIControlStateNormal];
    [reduceBtn setImage:[UIImage imageNamed:@"reduce_unused"] forState:UIControlStateSelected];
    reduceBtn.selected = NO;
    [reduceBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [reduceBtn addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reduceBtn];
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.pluseBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    self.reduceBtn = reduceBtn;
    
    
    UIButton *dcBtn = [[UIButton alloc]init];
    [dcBtn setTitle:@"叠加直流" forState:UIControlStateNormal];
    [dcBtn setTitleColor:White forState:UIControlStateNormal];
    [dcBtn setTitleColor:BDThemeColor forState:UIControlStateSelected];
    dcBtn.selected = NO;
    [dcBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [dcBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [dcBtn addTarget:self action:@selector(showSuperDCView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dcBtn];
    
    if (self.hardWareView.viewModel.deviceType==BDDeviceType_Digit) {
        [[BD_Utils shared] setViewState:NO view:dcBtn];
    }
    self.superDCBtn = dcBtn;
    [dcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.reduceBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    
    
    UIButton *resultBtn = [[UIButton alloc]init];
    
    [resultBtn setTitle:@"结果数据" forState:UIControlStateNormal];
    [resultBtn setTitleColor:White forState:UIControlStateNormal];
    [resultBtn setTitleColor:BDThemeColor forState:UIControlStateSelected];
    resultBtn.selected = NO;
    [resultBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [resultBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [resultBtn addTarget:self action:@selector(showResultView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resultBtn];
    [resultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(dcBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    self.testResultBtn = resultBtn;
    
    
    
    
    //数据展示
    BD_HarmDataController *dataVC = [[BD_HarmDataController alloc] init];
    [self.mainView addSubview:dataVC.view];
    self.dataVC = dataVC;
    
    //    [self.view layoutIfNeeded];
    self.dataVC.harmModel = self.harmModel;
    
    //数据设置页面
    BD_HarmDataSettingTableView *dataTBView = [[BD_HarmDataSettingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.mainView addSubview:dataTBView];
    self.dataTBView = dataTBView;
    self.dataTBView.harmModel = self.harmModel;
    
    //波形显示
    BD_HarmWaveformController *waveformVC = [[BD_HarmWaveformController alloc] init];
    waveformVC.harmModel = self.harmModel;
    [self.mainView addSubview:waveformVC.view];
    self.waveformVC = waveformVC;
    //信息图
    BD_InfomationTBView *infomationView =  [[BD_InfomationTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@"序号",@"时间",@"动作类型",@"开入量",@"动作时间"]];
    [self.mainView addSubview:infomationView];
    
    [infomationView createFalsedata];
    [infomationView reloadData];
    self.infomationView = infomationView;
    
    
    
    
    //底部指示灯
    self.switchView = [[BD_BinarySwitchView alloc] initWithTitleArray:@[@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia1", @"Ib1", @"Ic1",@"Ia2", @"Ib2", @"Ic2", @"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"L1", @"L2", @"L3", @"L4", @"L5", @"L6", @"L7", @"L8"]];
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-Marge);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    
    //测试结果view
    BD_ActionResultView *actionView = [[BD_ActionResultView alloc]initWithFrame:CGRectZero];
    self.resultView = actionView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resultViewTapGesture:)];
    [self.resultView addGestureRecognizer:tap];
    
}


#pragma mark - 懒加载
-(BD_TestResultData *)testResultData{
    if (!_testResultData) {
        _testResultData = [[BD_TestResultData alloc]init];
    }
    return _testResultData;
}

-(BD_HarmSuperDCVC *)superDCView{
    if (!_superDCView) {
        _superDCView  = [[BD_HarmSuperDCVC alloc]init];
    }
    return _superDCView;
}

-(NSMutableArray *)hasLockedArr{
    if (!_hasLockedArr) {
        _hasLockedArr = [[NSMutableArray alloc]init];
    }
    return _hasLockedArr;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.dataVC.view endEditing:YES];
}

-(BD_HarmTemplateFileManager *)templateFileManager{
    if (!_templateFileManager) {
        _templateFileManager = [[BD_HarmTemplateFileManager alloc]init];
    }
    return _templateFileManager;
}


#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
        [self.dataVC.view endEditing:YES];
        NSInteger index =  scrollView.contentOffset.x/scrollView.width;
        [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (index == idx) {
                obj.selected = YES;
            } else {
                obj.selected = NO;
            }
        }];
        
        switch (index) {
            case 0:
                //数据
                [self.dataVC loadSubViewType:_type passageway:_passageway];
                break;
            case 1:
              //参数设置页
                break;
            case 2:
                //波形图
                //  self.waveformVC.harmModel = self.harmModel;
                break;
            case 3:
                //信息图
                self.infomationView.infoDataSource = self.infoDataSource;
                break;
            default:
                break;
        }
    
    
}

//向服务器发送数据改变
-(void)sendHarmModel
{
    self.harmModel.isLock = _isLock;
    BOOL isChange = [[OCCenter shareCenter] harmTestChange:self.harmModel];
    DLog(@"%@", isChange ? @"成功" : @"失败");
}

-(void)getDeviceInfoToChangeViewData{
   //因为是block中的方法，使用弱引用
    [super getDeviceInfoToChangeViewData];
    [kNotificationCenter postNotificationName:BD_OutPutLimitNotifi object:self.hardWareView.viewModel];
    
}

#pragma mark - 接收到测试仪数据通知

- (void)refreshView:(NSNotification *)info{
    
    NSMutableArray *resultArr = (NSMutableArray *)info.object;//info.object就是通过通知传递的数据对象，可以转换为对应的类型
    
    for (BD_TestResultModel *model in resultArr) {
        
        int currentIndex = (int)[resultArr indexOfObject:model];
  
        int nSec = model.nSec;
        int nNanoSec = model.nNanoSec;

        unsigned int binaryOut = 0;
        NSArray *binarOutArr = @[@((BOOL)self.binarySwitchSetView.binaryData.iOut1),@((BOOL)self.binarySwitchSetView.binaryData.iOut2),@((BOOL)self.binarySwitchSetView.binaryData.iOut3),@((BOOL)self.binarySwitchSetView.binaryData.iOut4),@((BOOL)self.binarySwitchSetView.binaryData.iOut5),@((BOOL)self.binarySwitchSetView.binaryData.iOut6),@((BOOL)self.binarySwitchSetView.binaryData.iOut7),@((BOOL)self.binarySwitchSetView.binaryData.iOut8)];
        for (NSInteger i = 0; i < binarOutArr.count; i++) {
            if ([binarOutArr[i] intValue]==1)
            {
                binaryOut |= (1<<i);
            }
        }
        
        switch (model.nType) {
            case 1:
                NSLog(@"--1");
                //刷新开入开出指示灯状态
                startTestSec = model.nSec;
                startTestNoSec = model.nNanoSec;
                
                [self refreshBtnWithBinary:model.nInput];
                
                //刷新开出量指示灯状态xx
                /**注意：目前是通过客户端自己控制的，之后接口会返回开出量的数据*/
                [self updatebinaryOutState:binaryOut];
                //记录试验开始时间
                
                
                break;
            case 2:
                NSLog(@"--2");
                //类型返回2表示实验结束，应该将设备输出和页面显示都设置为停止状态，需要调用[OCCenter.shareCenter stop];方法才能停止设备的输出操作，否则不停止
                //测试类型为停止试验的时候，不刷新指示灯，指示将指示灯恢复默认
                [self endTestWithBinaryIn:model.nInput];
                //试验停止显示测试结果数据
                [self resultViewShowAnimation];
                break;
            case 3:
                NSLog(@"--3");
                //刷新
                
                if(_isBegin && !self.isLock){//状态切换的时候记录动作时间的开始时刻
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
                [self updatebinaryOutState:binaryOut];
                break;
            case 4:
                NSLog(@"--4");
                
                
                //计算动作时间
                //                if (currentIndex-1<0) {
                //                    continue;
                //                }
                
                if (_isBegin) {
                    
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
                [self updatebinaryOutState:binaryOut];
                break;
            case 5:
                NSLog(@"--5");
                self.testResultData.isMark = YES;
                //刷新开入开出指示灯状态
                [self refreshBtnWithBinary:model.nInput];
                //刷新开出量指示灯状态xx
                /**注意：目前是通过客户端自己控制的，之后接口会返回开出量的数据*/
                [self updatebinaryOutState:binaryOut];
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
        [self updateBinaryStateDatas:nbinall];
        
    });
}

#pragma mark - 试验结束，创建报告
- (void)endTestWithBinaryIn:(int)nBinstate{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self applicationEnterBackground];
        
        //开入量变化  ----试验结束不需要展示指示灯状态
        //        [self updateBinaryStateDatas:nBinstate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //延时一秒跳转，保证在离开测试页的时候，测试结果页面消失
           
            //指示灯恢复默认
            [self setLightDefault];
        });
        
        
    });
}
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
                int  binaryIn = [self getBinaryInValue];
                for(int j=0;j<10;j++)
                {
                    n=binaryIn%2;  //取余,余数
                    binaryIn=binaryIn/2;  //取整
                    
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
        int  binaryIn = [self getBinaryInValue];
        for(int j=0;j<10;j++)
        {
            n=binaryIn%2;  //取余,余数
            binaryIn=binaryIn/2;  //取整
            
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
//根据开入量设置的值，获取开入量二进制数
-(int)getBinaryInValue{
    unsigned int binaryIn = 0;
    NSArray *binarInArr = @[@((BOOL)self.binarySwitchSetView.binaryData.iKA),@((BOOL)self.binarySwitchSetView.binaryData.iKB),@((BOOL)self.binarySwitchSetView.binaryData.iKC),@((BOOL)self.binarySwitchSetView.binaryData.iKD),@((BOOL)self.binarySwitchSetView.binaryData.iKE),@((BOOL)self.binarySwitchSetView.binaryData.iKF),@((BOOL)self.binarySwitchSetView.binaryData.iKG),@((BOOL)self.binarySwitchSetView.binaryData.iKH),@((BOOL)self.binarySwitchSetView.binaryData.iKI),@((BOOL)self.binarySwitchSetView.binaryData.iKJ)];
    for (NSInteger i = 0; i < binarInArr.count; i++) {
        if ([binarInArr[i] intValue]==1)
        {
            binaryIn |= (1<<i);
        }
    }
    return binaryIn;
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
      
        self.startBtn.selected = NO;
        self.isBegin = NO;
        self.navigationItem.hidesBackButton = NO;
        [self setLightDefault];
        
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


//生成报告
-(void)createReportVC{
    [super createReportVC];
    //数组中添加BD_ReportBaseModel
    BD_ReportMainVC *reportVC = [[BD_ReportMainVC alloc]init];
    reportVC.moduleType = BD_TestModuleType_Harm;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    BD_ReportBaseModel *baseModel = [[BD_ReportBaseModel alloc]init];
    reportVC.reportDatas = [arr copy];
    [reportVC loadReportViews];
    [self.navigationController pushViewController:reportVC animated:YES];
}


#pragma mark - lockAction
-(void)lockAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.isBegin == 1) {
        self.isLock = !self.isLock;
        self.harmModel.isLock = self.isLock;
        [[OCCenter shareCenter] harmTestChange:self.harmModel];
        if (self.hasLockedArr.count<2) {
            [self.hasLockedArr addObject:@(self.isLock)];
        } else {
            [self.hasLockedArr removeObjectAtIndex:0];
            [self.hasLockedArr addObject:@(self.isLock)];
        }
    }
}
//判断琐按钮是否可用
-(void)setLockBtnIsUsed:(BOOL)isUsed{
    if (isUsed) {
        [self.lockBtn setImage:[UIImage imageNamed:@"rightBtn3"] forState:UIControlStateNormal];
        self.lockBtn.userInteractionEnabled = YES;
    } else {
        [self.lockBtn setImage:[UIImage imageNamed:@"lock_unused"] forState:UIControlStateNormal];
        self.lockBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - 顶部视图切换
-(void)topViewBtnClick:(UIButton *)sender{
    [self.dataVC.view endEditing:YES];
    self.mainView.contentOffset = CGPointMake(self.mainView.width*(sender.tag-100), 0);
    [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sender]) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
    switch (sender.tag-100) {
        case 0:
            //数据
            [self.dataVC loadSubViewType:_type passageway:_passageway];
            break;
        case 1:
            //波形图
//              self.waveformVC.harmModel = self.harmModel;
            break;
        case 2:
            //信息图
            self.infomationView.infoDataSource = self.infoDataSource;
            break;
        default:
            break;
    }
    
}

#pragma mark - startAction
-(void)startAction{
    [super startAction];
    [self.view endEditing:YES];
    [self.dataVC.view endEditing:YES];
    //清空锁动作记录
    [self.hasLockedArr removeAllObjects];
        //发送修改数值
    if (!self.startBtn.selected) {
        [self confitHarmModelSwitchData];
        BOOL isChange = [[OCCenter shareCenter] harmTestChange:self.harmModel];
        DLog(@"%@", isChange ? @"成功" : @"失败");
        if (isChange) {
            //重新显示测试信息
            [_infomationView.infoDataSource removeAllObjects];
            [_infomationView reloadData];
            self.isBegin = YES;
            bool isRun = [[OCCenter shareCenter] start:1];
            DLog(@"%@", isRun ? @"启动成功" : @"启动失败");
            if (isRun) {
                [self setLockBtnIsUsed:YES];
                self.startBtn.selected = YES;
                self.startBtn.userInteractionEnabled = NO;
                self.stopBtn.selected = NO;
                self.stopBtn.userInteractionEnabled = YES;
                self.lockBtn.selected = NO;
                self.lockBtn.userInteractionEnabled = YES;
                self.navigationItem.hidesBackButton = YES;
            }
        }else{
            [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }];
        }
    }
    
   
    
}
#pragma mark - stopAction
-(void)stopAction{
    [super stopAction];
    if (!self.stopBtn.selected) {
        self.stopBtn.selected = YES;
        self.stopBtn.userInteractionEnabled = NO;
        self.startBtn.selected = NO;
        self.startBtn.userInteractionEnabled = YES;
        self.navigationItem.hidesBackButton = NO;
        [self setLockBtnIsUsed:NO];
        self.isBegin = NO;
        int result = [OCCenter.shareCenter stop];
        NSLog(@"stopResult:%d",result);
    }
    
}
#pragma mark - fileManager
-(void)fileManagerListShow{
    [super fileManagerListShow];
    WeakSelf;
    
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"保存配置",@"保存模版文件",@"打开模版文件",@"报告视图",@"清空模版文件"] textField:self.fileManagerBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
        if ([str isEqualToString:@"保存配置"]) {
            //保存配置方法
        } else if ([str isEqualToString:@"保存模版文件"]){
            //保存模版文件方法
           
            
        } else if ([str isEqualToString:@"打开模版文件"]) {
            //打开模版文件方法
            [weakself showFileListView:@"请选择要打开的模版文件" complete:^(NSString *fileName) {
                
    
            }];
        } else if([str isEqualToString:@"清空模版文件"]) {
            //清空模版文件
            if ([FileUtil delateAllTemplateFiles]) {
                [MBProgressHUDUtil showMessage:@"模版文件删除成功" toView:self.view];
            } else {
                [MBProgressHUDUtil showMessage:@"模版文件删除失败" toView:self.view];
            }
        } else {
            //报告视图
            [weakself showFileListView:@"请选择报告文件" complete:^(NSString *fileName) {
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


#pragma mark - 参数页面
-(void)showParamView:(UIButton *)sender{
     sender.selected = YES;
     self.mainView.contentOffset = CGPointMake(3*self.mainView.width, 0);
}

#pragma mark - 数据结果页面
-(void)showResultView:(UIButton *)sender{
    _testResultBtn.selected = !_testResultBtn.selected;
    if (_testResultBtn.selected) {
        [self resultViewShowAnimation];
    } else {
        [self resultViewDismissAnimation];
    }
}

#pragma mark - 叠加直流页面
-(void)showSuperDCView:(UIButton *)sender{
    //叠加直流页面赋值，并显示
    if (self.hardWareView.viewModel.currentPassNum==3&&self.hardWareView.viewModel.voltagePassNum==4) {
        [self.superDCView setViewData:self.harmModel.dcSettingModel deviceType:self.hardWareView.viewModel.deviceType passageWay:BDHarmPassageType_FUTI];
    } else if (self.hardWareView.viewModel.currentPassNum==6&&self.hardWareView.viewModel.voltagePassNum==6) {
        [self.superDCView setViewData:self.harmModel.dcSettingModel deviceType:self.hardWareView.viewModel.deviceType passageWay:BDHarmPassageType_SUSI];
    }
    
}

-(void)pluseAction:(UIButton *)sender{
  [kNotificationCenter postNotificationName:BD_HarmValueChange object:nil userInfo:@{@"name" : @(1), @"param1" :self.harmModel.dataModel.channelPort, @"param2" : self.harmModel.dataModel.passagewayIndex, @"length" : self.harmModel.dataModel.step}];
}

-(void)reduceAction:(UIButton *)sender{
     [kNotificationCenter postNotificationName:BD_HarmValueChange object:nil userInfo:@{@"name" : @(2), @"param1" :self.harmModel.dataModel.channelPort, @"param2" : self.harmModel.dataModel.passagewayIndex, @"length" : self.harmModel.dataModel.step}];
}

-(void)resultViewShowAnimation{
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.resultView];
    [UIView animateWithDuration:0.3 animations:^{
        [self.resultView setFrame:CGRectMake(self.view.width-self.view.width/2,self.view.height-250, self.view.width/2, 200)];
    } completion:^(BOOL finished) {
        
        
    }];
}
-(void)resultViewDismissAnimation{
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.resultView];
    [UIView animateWithDuration:0.3 animations:^{
        [_resultView setFrame:CGRectMake(self.view.width,self.view.height-250, 0,200)];
    } completion:^(BOOL finished) {
        
        
    }];
}


//测试仪数据上传到移动端，刷新信息图
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
    for(int i=0;i<8;i++)
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

#pragma mark BD_HarmSettingViewDelegate
//侧边设置按钮点击
-(void)settingButtonClick:(UIButton *)button
{
    DLog(@"%@ -- %ld", button.titleLabel.text, button.tag);
    
    if (self.settingBtn != button) {//不同按钮点击

        if (self.settingBtn == nil) {
//            [self showSettingView:YES];
        }
        
        button.selected = YES;
        self.settingBtn.selected = NO;
        self.settingBtn = button;
    }else{//相同按钮点击收起视图
        
//        [self showSettingView:NO];
        button.selected = NO;
        self.settingBtn = nil;
    }
    
}

#pragma mark - 自动递变计算当前输出的值
-(CGFloat)caculateCurAutoValueWithStep:(NSInteger)stepNum{
    return 0;
}


-(void)navigationViewActionWithtag:(NSInteger)tag{
    [super navigationViewActionWithtag:tag];
    WeakSelf;
    switch (tag) {
        case 0://系统参数
            
            break;
        case 1: //通用参数
            break;
        case 2: //整定值
            break;
        case 3: //开关量
            break;
        case 4://开入量设置
            break;
        case 5://直流设置
            break;
        case 6://IEC
            break;
        case 7://报告视图
        {
            NSArray *files  = [FileUtil getDirectoryFileNames:@""];
            [BD_PopListViewManager ShowPopViewWithlistDataSource:files textField:(UIButton *)self.naviBtnArr[7] viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *fileName) {
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
            break;
        case 8://打开模版文件
        {
            [self showTemplateFileListView:(UIButton *)self.naviBtnArr[8] complete:^(NSString *fileName) {
              BD_HarmModel *result = [weakself.templateFileManager readTemplateFileWithfileName:fileName];
                if (result) {
                    weakself.harmModel = result;
                    [weakself.dataVC updateDataView];
                } else {
                    [MBProgressHUDUtil showMessage:@"打开文件失败" toView:self.view];
                }
            }];
        }
            break;
        case 9://保存模版文件
        {
            [self confitHarmModelSwitchData];
            [self templateFileNameEditAlert:^(NSString *fileName) {
                if ([weakself.templateFileManager saveTemplateFile:weakself.harmModel fileName:fileName]) {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveSuc toView:weakself.view];
                } else {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveFailed toView:weakself.view];
                }
            }];
           
        }
            break;
        case 10://保存配置
            break;
        case 11://清空模版文件
            break;
        default:
            break;
    }
}

#pragma mark - 测试结果点击手势
-(void)resultViewTapGesture:(UITapGestureRecognizer *)gesture{
    [self resultViewDismissAnimation];
    self.testResultBtn.selected = NO;
}

#pragma mark - 程序进入后台，修改页面显示
-(void)applicationEnterBackground{
    dispatch_async(dispatch_get_main_queue(), ^{
        //结束实验需要进行的动作
        self.headerControlView.startBtn.selected = NO;
        [self.headerControlView setLockBtnIsUsed:NO];
        self.navigationItem.hidesBackButton = NO;
        self.view.userInteractionEnabled = YES;
          [OCCenter.shareCenter stop];
    });
    
}
#pragma mark 硬件配置完成，刷新UI
-(void)deviceSettingFinised:(BD_HardwarkConfigModel *)hardData{

    [super deviceSettingFinised:hardData];
    
    int voltageNum = hardData.voltagePassNum;
    int currentNum = hardData.currentPassNum;
    DLog(@"电压通道数:%d,电流通道数:%d",voltageNum,currentNum);
    NSInteger currNum_V=0;
    NSInteger currNum_C=0;
    _type = self.hardWareView.viewModel.deviceType;
    if (self.hardWareView.viewModel.currentPassNum==3&&self.hardWareView.viewModel.voltagePassNum==4) {
        _passageway = BDHarmPassageType_FUTI;
    } else if (self.hardWareView.viewModel.currentPassNum==6&&self.hardWareView.viewModel.voltagePassNum==6){
        _passageway = BDHarmPassageType_SUSI;
    }
    //切换模型数据
    [self.harmModel changedType:_type passageway:_passageway];
    //切换模型视图
    [self.dataVC loadSubViewType:_type passageway:_passageway];
    //数据设置页面
    [self.dataTBView changedType:_type passageway:_passageway];
    //重汇波形
    [self.waveformVC drawWaveformLine:self.harmModel];
    if (self.hardWareView.viewModel.deviceType==BDDeviceType_Digit) {
        [[BD_Utils shared] setViewState:NO view:self.superDCBtn];
    } else if (self.hardWareView.viewModel.deviceType == BDDeviceType_Imitate){
           [[BD_Utils shared] setViewState:YES view:self.superDCBtn];
        self.superDCBtn.layer.borderColor = BtnViewBorderColor.CGColor;
    }
    [self.switchView addCurrentLightWithGroup:currentNum/3];
 
}

//根据开关量参数设置模型开关量数据
-(void)confitHarmModelSwitchData{
    self.harmModel.isLock = _isLock;
    self.harmModel.switchModel.switchLogic = self.binarySwitchSetView.binaryData.iLogic;
    self.harmModel.switchModel.switchInArray[0] = @(self.binarySwitchSetView.binaryData.iKA);
    self.harmModel.switchModel.switchInArray[1] = @(self.binarySwitchSetView.binaryData.iKB);
    self.harmModel.switchModel.switchInArray[2] = @(self.binarySwitchSetView.binaryData.iKC);
    self.harmModel.switchModel.switchInArray[3] = @(self.binarySwitchSetView.binaryData.iKD);
    self.harmModel.switchModel.switchInArray[4] = @(self.binarySwitchSetView.binaryData.iKE);
    self.harmModel.switchModel.switchInArray[5] = @(self.binarySwitchSetView.binaryData.iKF);
    self.harmModel.switchModel.switchInArray[6] = @(self.binarySwitchSetView.binaryData.iKG);
    self.harmModel.switchModel.switchInArray[7] = @(self.binarySwitchSetView.binaryData.iKH);
    self.harmModel.switchModel.switchInArray[8] = @(self.binarySwitchSetView.binaryData.iKI);
    self.harmModel.switchModel.switchInArray[9] = @(self.binarySwitchSetView.binaryData.iKJ);
    
    self.harmModel.switchModel.switchOutArray[0] = @(self.binarySwitchSetView.binaryData.iOut1);
    self.harmModel.switchModel.switchOutArray[1] = @(self.binarySwitchSetView.binaryData.iOut2);
    self.harmModel.switchModel.switchOutArray[2] = @(self.binarySwitchSetView.binaryData.iOut3);
    self.harmModel.switchModel.switchOutArray[3] = @(self.binarySwitchSetView.binaryData.iOut4);
    self.harmModel.switchModel.switchOutArray[4] = @(self.binarySwitchSetView.binaryData.iOut5);
    self.harmModel.switchModel.switchOutArray[5] = @(self.binarySwitchSetView.binaryData.iOut6);
    self.harmModel.switchModel.switchOutArray[6] = @(self.binarySwitchSetView.binaryData.iOut7);
    self.harmModel.switchModel.switchOutArray[7] = @(self.binarySwitchSetView.binaryData.iOut8);
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isAuto"]) {
        [self.pluseBtn setSelected:self.harmModel.dataModel.isAuto];
        [self.reduceBtn setSelected:self.harmModel.dataModel.isAuto];
        self.pluseBtn.userInteractionEnabled =!self.harmModel.dataModel.isAuto;
        self.reduceBtn.userInteractionEnabled =!self.harmModel.dataModel.isAuto;
    }
}

#pragma mark Dealloc
-(void)dealloc
{
    [kNotificationCenter removeObserver:self name:BD_HarmSendData object:nil];
    [kNotificationCenter removeObserver:self name:BD_ManualTestFromServiceDataNoti object:nil];
    [kNotificationCenter removeObserver:self name:BD_ReadDeviceInfoNoti object:nil];
    [kNotificationCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [self.harmModel.dataModel removeObserver:self forKeyPath:@"isAuto" context:nil];
}

@end
