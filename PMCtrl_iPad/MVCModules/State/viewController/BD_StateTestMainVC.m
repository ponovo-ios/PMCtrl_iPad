//
//  BD_StateTestMainVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateTestMainVC.h"
#import "BD_QuickTestParamModel.h"
#import "BD_TestDataParamModel.h"
#import "BD_StateTestParamModel.h"


#import "BD_QuickTestCustomView.h"
#import "BD_FingerWaveView.h"
#import "YRBorderView.h"

#import "PMCtrl_iPad-Swift.h"
#import "BD_StateModel.h"
#import "BD_StateTestCommomParamSetVC.h"
#import "BD_QuickTestDataCenter.h"
#import "BD_TestResultModel.h"
#import "BD_PopListViewManager.h"
#import "BD_BinarySwitchView.h"
#import "UIImage+Extension.h"
#import "BD_StateTestDataParamVC.h"
//#import "BD_VectorDiagramVC.h"
#import "BD_VectorDiagramListVC.h"
#import "BD_StateTestStateDiagramVC.h"

#import "BD_InfomationTBView.h"
#import "BD_StateTestItemModel.h"
#import "BD_StateTemplateFileManager.h"
#import "BD_ReportPDFMainVC.h"
#import "BD_ReportMainVC.h"
#import "BD_ReportBaseModel.h"
#import "BD_HardwareConfigView.h"
#import "BD_RunLightAnimationManager.h"

@interface BD_StateTestMainVC ()<UIDocumentInteractionControllerDelegate,UIScrollViewDelegate>{
    CGFloat viewY;
   
    
    
}



@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (nonatomic, strong) NSMutableArray<UIButton *> * btnsArray_binaryIn;
@property (nonatomic, strong) NSMutableArray<UIButton *> * btnsArray_binaryOut;
@property (nonatomic, strong) NSMutableArray * indexArr; //需要记录结果的测试项

@property (nonatomic, assign) int lastTime; //初始时间(上一个时间)秒

@property (nonatomic, assign) int lastNSTime; //纳秒

@property (nonatomic, strong) NSMutableArray * timeIntervalArr; //时间差数组

@property (nonatomic, strong) NSMutableString * historicalData;

@property (nonatomic,strong)BD_QuickTestDataCenter *dataCenter;
@property (nonatomic,strong)BD_StateTestCommomParamSetVC *commonparamVC;
@property (nonatomic,strong)NSMutableArray<UIViewController *>  *childVCArr;
@property (nonatomic,weak)BD_InfomationTBView *infoView;
@property (nonatomic,weak)UIButton *triggerBtn;
@property(nonatomic,assign)NSInteger groupNum;
@property(nonatomic,strong)BD_TestResultData *testResultData;
//模版文件管理
@property(nonatomic,strong)BD_StateTemplateFileManager *templateManager;

@property(nonatomic,strong)BD_BeginTestModel *beginModel;
@end

@implementation BD_StateTestMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //初始化数据中心
    _dataCenter = [[BD_QuickTestDataCenter alloc]init];
    //状态序列中，设置整定值和开关量设置不可用
    [[BD_Utils shared]setViewState:NO view:self.naviBtnArr[2]];
     [[BD_Utils shared]setViewState:NO view:self.naviBtnArr[3]];
#pragma mark - 通知
    [kNotificationCenter addObserver:self selector:@selector(refreshView:) name:BD_StateTestFromServiceDataNoti object:nil];
    
    
     [kNotificationCenter addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self.beginModel addObserver:self forKeyPath:@"isBegin" options:NSKeyValueObservingOptionNew context:nil];
    WeakSelf;
    self.binarySwitchSetView.okActionBlock = ^{
        [weakself setBinaryViewUsed];
    };
    
    _commonparamVC = [[BD_StateTestCommomParamSetVC alloc]init];
    self.mainView.delegate = self;
    
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //计算哪儿个测试项需要记录
    _indexArr = [NSMutableArray array];
    
//    for (int i =0 ; i<_tbDataSource.count; i++) {
//
//        int trigerType = [_tbDataSource[i].triggerParam.TriggerType intValue];
//
//        int nBiValide = [_tbDataSource[i].triggerParam.nBiValide intValue];
//
//        if (trigerType == 2 && nBiValide != 0) {
//            [_indexArr addObject:@(i)];
//        }
//    }
//
}



#pragma mark - 搭建UI
-(void)configureUI{
    [super configureUI];
    //底部指示灯
    self.switchView = [[BD_BinarySwitchView alloc] initWithTitleArray:@[@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia1", @"Ib1", @"Ic1",@"Ia2", @"Ib2", @"Ic2", @"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"L1", @"L2", @"L3", @"L4", @"L5", @"L6", @"L7", @"L8"]];
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-Marge);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    
    CGFloat btnX = 10;
    CGFloat btnW = 100;
    CGFloat btnH = 40;
    NSArray *btnTitle = @[@"数据",@"状态图",@"矢量图",@"信息图"];
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
    WeakSelf;
    self.topTestView.contentSize = CGSizeMake(btnTitle.count*(btnW+btnX)+15, 50);
    if (self.topTestView.contentSize.width<self.view.width*0.6) {
        [self.topTestView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakself.topTestView.contentSize.width);
        }];
        [self.topTestView layoutIfNeeded];
    }
    [self loadMainViewSubViews];
    
   UIButton *triggerBtn = [[UIButton alloc]init];
    [triggerBtn setImage:[UIImage imageNamed:@"triggerImage"] forState:UIControlStateNormal];
    [triggerBtn setImage:[UIImage imageNamed:@"triggerImageUn"] forState:UIControlStateSelected];
    triggerBtn.selected = YES;
    triggerBtn.userInteractionEnabled = NO;
    [triggerBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:2.0];
    [triggerBtn addTarget:self action:@selector(triggerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:triggerBtn];
    [triggerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(weakself.stopBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];
    self.triggerBtn = triggerBtn;
    self.rightResultView.hidden = YES;
    
    
}


-(void)loadMainViewSubViews{
    _groupNum = 2;
    _childVCArr = [[NSMutableArray alloc]init];
    //数据
    BD_StateTestDataParamVC *dataVC = [[BD_StateTestDataParamVC alloc]initWithNibName:NSStringFromClass([BD_StateTestDataParamVC class]) bundle:nil];
    WeakSelf;
    __weak typeof(dataVC) weakdataVC = dataVC;
    dataVC.testListDataSourceCompleteBlock = ^{
        NSMutableArray<BD_StateTestItemModel *> *data = weakdataVC.testListDataSource;
        
        if (data.count!=0) {
            ((BD_StateTestStateDiagramVC *)weakself.childVCArr[1]).vcDatas =[[NSMutableArray alloc]initWithObjects:data[weakdataVC.currentTestItem].itemParam.stateParam.voltageOutputDatas,data[weakdataVC.currentTestItem].itemParam.stateParam.currentOutputDatas, nil];
        }
        [((BD_StateTestStateDiagramVC *)weakself.childVCArr[1]) reloadTBView];
    };
    [self.mainView addSubview:dataVC.view];
    [_childVCArr addObject:dataVC];
  
//    //状态图
   BD_StateTestStateDiagramVC *stateVC = [[BD_StateTestStateDiagramVC alloc]init];
    [self.mainView addSubview:stateVC.view];
    [_childVCArr addObject:stateVC];
//    //矢量图
    BD_VectorDiagramListVC *vectorVC = [[BD_VectorDiagramListVC alloc]init];
    [self.mainView addSubview:vectorVC.view];
    [_childVCArr addObject:vectorVC];
    //信息图
    //信息图页面

    BD_InfomationTBView *infomationView = [[BD_InfomationTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[@"序号",@"时间",@"动作类型",@"开入量",@"动作时间",@"当前状态号"]];;
    [infomationView createFalsedata];
    [infomationView reloadData];
    [self.mainView addSubview:infomationView];
    self.infoView = infomationView;
    
}

-(void)viewWillLayoutSubviews{
    
    [_childVCArr[0].view setFrame:CGRectMake(0, 0, self.mainView.width, self.mainView.height)];
    [_childVCArr[1].view setFrame:CGRectMake(self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    [_childVCArr[2].view setFrame:CGRectMake(2*self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    [self.infoView setFrame:CGRectMake(3*self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    self.mainView.contentSize = CGSizeMake(self.mainView.frame.size.width*(_childVCArr.count+1), self.mainView.frame.size.height);
}



#pragma mark - 执行通知
- (void)refreshView:(NSNotification *)info{
    
    //获取文件路径,写入文件
    NSString *filePath = [kUserDefaults valueForKey:@"stateFilePath"];
    
    NSMutableArray *modelArr = (NSMutableArray *)info.object;
    /***********version1.0版本接口数据处理****************************/
    /**
    for (BD_StateModel *model in modelArr) {
        
        int ncur = model.ncurrentstateIndex;  //当前状态序列号  当前开始的测试项 从0开始
        int otype = model.oactivetype; //当前状态类型
        int nindex = model.nindex;
        int secondtime = model.secondtime; //时间
        int nstime = model.nstime;       //时间
        int nBinstate = model.nBinstate; //开入量
        
        
        
        NSLog(@"nindex:%d",nindex);
        NSLog(@"secondtime:%d",secondtime);
        NSLog(@"nstime:%d",nstime);
        NSLog(@"nBinstate:%d",nBinstate);
        NSLog(@"当前状态序列号:ncur-->%d",ncur);
        NSLog(@"当前状态类型:otype-->%d",otype);
        
        if (otype == 2) {
            //将最后时间差存入数组
            float timeInterval = secondtime - _lastTime;
            //        float nstimeInterval = nstime - _lastNSTime;
            
            [self.timeIntervalArr addObject:@(timeInterval)];
            
            NSLog(@"_timeIntervalArr:%@",_timeIntervalArr);
            
            //遍历出要用的时间段
            for (int i = 0; i<_indexArr.count; i++) {
                
                int indexNum =  [_indexArr[i] intValue];
                
                if (indexNum <= _timeIntervalArr.count-1) {
                    
                    float time =  [_timeIntervalArr[indexNum] floatValue];
                    
                    NSLog(@"_timeIntervalArr[indexNum]:%@",_timeIntervalArr[indexNum]);
                    NSLog(@"time:%f",time);
                    
                    //拼接字符串
                    [_historicalData appendString:[NSString stringWithFormat:@"\nstatus%d:%f\n",indexNum+1,time]];
                }
                
            }
            
            //写入文件
            [_historicalData writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            //移除原来数据
            [_timeIntervalArr removeAllObjects];
        }
        
        
        switch (otype) {
            case 1:
                NSLog(@"--1");
                
                //记录初始时间
                self.lastTime = secondtime;
                //            self.lastNSTime = nstime;
                
                NSLog(@"lastTime:%d",self.lastTime);
                
                //拼接开始时间
                [self appendBeginTimeWith:secondtime];
                //刷新tableView显示
                
                // [self reloadRowInTableviewWithNcur:ncur nBinstate:nBinstate];
                //开入量变化
                [self DecimalToBinaryWithNumber:nBinstate];
                
                break;
            case 2:
                NSLog(@"--2");
                //刷新
                [self reloadRowInTableviewWithNcur:ncur nBinstate:nBinstate];
                //开入量变化
                //                [self DecimalToBinaryWithNumber:nBinstate];
                [self endTestWithFilepath:filePath nBinstate:nBinstate];
                break;
            case 3:
                NSLog(@"--3");
                //计算时间差，并存入数组
                int
                timeInterval = secondtime - _lastTime;
                //            float nstimeInterval = nstime - _lastNSTime;
                
                NSLog(@"timeInterval:%d",timeInterval);
                
                [self.timeIntervalArr addObject:@(timeInterval)];
                _lastTime = secondtime;
                _lastNSTime = nstime;
                //开入量变化
                //[self DecimalToBinaryWithNumber:nBinstate];
                //刷新tableView 状态切换，说明上一个测试项完成，刷新上一个cell，如果是最后一个测试项，是从正在测试到结束测试状态进行切换，但是ncur不会切换到最后一项+1 ，所以需要结束测试的时候，重新刷新一个tableVIew；
                currentTestItem = ncur;
                [self reloadRowInTableviewWithNcur:ncur nBinstate:nBinstate];
                NSLog(@"ncur:%d",ncur);
                break;
            case 4:
                NSLog(@"--4");
                //开入量变化只刷新开入量，不需要刷新tableView
                //                [self reloadRowInTableviewWithNcur:ncur nBinstate:nBinstate];
                [self DecimalToBinaryWithNumber:nBinstate];
                break;
            case 5:
                NSLog(@"--5");
                break;
                
            default:
                break;
        }
        
    }
    */
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for (BD_TestResultModel *model in modelArr) {
            int nType = model.nType;//结果类型1：开始实验    2：实验结束    3：状态切换    4：开入变位 5: 递变
            
            /**
             //当type为开入变位，为变位的开入通道，bit9~bit0对应开入9~0
             //当type为状态切换时，为状态切换触发条件，
             //bit12:手动触发    bit11：时间触发    bit10：GPS触发
             //bit9~bit0:对应开关量9~0
             */
            //        int nSource = model.nSource;
            /**产生结果的时间秒值*/
            //        int nSec = model.nSec;
            /**产生结果的时间纳秒值*/
            //        int nNanoSec = model.nNanoSec;
            /**产生结果时开入量的值*/
            //        int nInput = model.nInput;
            /**当前状态索引号*/
            //        int currentIndex = model.currentIndex;
            /**要跳转的状态索引号*/
            //        int nObjective = model.nObjective;
            /**自动递变已经执行的步数*/
            //        int nStep = model.nStep;
            if ([((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[model.currentIndex].itemParam.triggerParam.TriggerType intValue]==0) {
                self.triggerBtn.selected = NO;
                self.triggerBtn.userInteractionEnabled = YES;
            } else {
                self.triggerBtn.selected = YES;
                self.triggerBtn.userInteractionEnabled = NO;
            }

            if (nType == 2) {
                //将最后时间差存入数组
                float timeInterval = model.nSec - _lastTime;
                float nstimeInterval = model.nNanoSec - _lastNSTime;
                
                [self.timeIntervalArr addObject:@(timeInterval+nstimeInterval/pow(10, 9))];
                
                NSLog(@"_timeIntervalArr:%@",_timeIntervalArr);
                //遍历出要用的时间段
                for (int i = 0; i<_indexArr.count; i++) {
                    
                    int indexNum =  [_indexArr[i] intValue];
                    
                    if (indexNum <= _timeIntervalArr.count-1) {
                        
                        float time =  [_timeIntervalArr[indexNum] floatValue];
                        
                        NSLog(@"_timeIntervalArr[indexNum]:%@",_timeIntervalArr[indexNum]);
                        NSLog(@"time:%f",time);
                        
                        //拼接字符串
                        [_historicalData appendString:[NSString stringWithFormat:@"\nstatus%d:%f\n",indexNum+1,time]];
                    }
                    
                }
                
                //写入文件
                [_historicalData writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                //移除原来数据
                [_timeIntervalArr removeAllObjects];
            }
            
            
            switch (nType) {
                case 1:
                    NSLog(@"--1");
                    
                    //记录初始时间
                    self.lastTime = model.nSec;
                    self.lastNSTime = model.nNanoSec;
                    
                    NSLog(@"lastTime:%d",self.lastTime);
                    
                    //拼接开始时间
                    [self appendBeginTimeWith:model.nSec+model.nNanoSec/pow(10, 9)];
                    //刷新tableView显示
                    [((BD_StateTestDataParamVC *)_childVCArr[0]) reloadRowInTableviewWithNcur:model.currentIndex];
                    
                    [self updateBinaryStateDatas:model.nInput];
                    [self updatebinaryOutState:[((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[model.currentIndex].itemParam.triggerParam.nbinaryout intValue]];
                    
                    break;
                case 2:
                    NSLog(@"--2");
                    //刷新
                    [((BD_StateTestDataParamVC *)_childVCArr[0]) reloadRowInTableviewWithNcur:model.currentIndex];
                    //开入量变化
                    //                [self DecimalToBinaryWithNumber:nBinstate];
                    [self endTestAndCreateReport];
                     //停止试验后停止run灯
                     [self.runMangaer stopflashView];
                    [self setLightDefault];
                    break;
                case 3:
                    NSLog(@"--3");
                    //计算时间差，并存入数组
                    int timeInterval = model.nSec - _lastTime;
                    float nstimeInterval =  - _lastNSTime;
                    
                    NSLog(@"timeInterval:%d",timeInterval);
                    NSLog(@"nstimeInterval:%f",nstimeInterval);
                    [self.timeIntervalArr addObject:@(timeInterval+nstimeInterval/pow(10, 9))];
                    _lastTime = model.nSec;
                    _lastNSTime = model.nNanoSec;
                    
                    //开入量变化
                    //[self DecimalToBinaryWithNumber:nBinstate];
                    //刷新tableView 状态切换，说明上一个测试项完成，刷新上一个cell，如果是最后一个测试项，是从正在测试到结束测试状态进行切换，但是ncur不会切换到最后一项+1 ，所以需要结束测试的时候，重新刷新一个tableVIew；
                    //                currentTestItem = currentIndex;
                    [((BD_StateTestDataParamVC *)_childVCArr[0]) reloadRowInTableviewWithNcur:model.currentIndex];
                    NSLog(@"ncur:%d",model.currentIndex);
                    [self updateBinaryStateDatas:model.nInput];
                    [self updatebinaryOutState:[((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[model.currentIndex].itemParam.triggerParam.nbinaryout intValue]];
                    break;
                case 4:
                    NSLog(@"--4");
                    //开入量变化只刷新开入量，不需要刷新tableView
                    //                [self updateBinaryStateDatas:model.nInput];
                {
                    
                        float a1=model.nSec-_lastTime;
                        float a2=model.nNanoSec/pow(10,9)-_lastNSTime/pow(10,9);
                        float actionTime = a1+a2;
                        
                        BD_ReultInfo *result = [[BD_ReultInfo alloc]init];
                        result.actionTime = actionTime;
                        //                        result.actionValue = [self caculateCurAutoValueWithStep:model.nStep];
                        result.binaryData = model.nInput;
                        
                        if (self.testResultData.isMark == YES) {
                            self.testResultData.returnValue = result.actionValue;
                            self.testResultData.returnTime = result.actionTime;
                            self.testResultData.isMark = NO;//获取到返回值的后将标记置为NO；
                        } else {
                            [self.testResultData.actionInfoArr addObject:result];
                        }
                        
                    //当开关量动作的时候，在测试列表行显示动作通道和动作时间
                    [self testItemListRefreshData:model];
                    
                }
                    [self updateBinaryStateDatas:model.nInput];
                    [self updatebinaryOutState:[((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[model.currentIndex].itemParam.triggerParam.nbinaryout intValue]];
                    break;
                case 5:
                    NSLog(@"--5");
                    //递变
                    self.testResultData.isMark = YES;
                    [((BD_StateTestDataParamVC *)_childVCArr[0]) reloadRowInTableviewWithNcur:model.currentIndex];
                    [self updateBinaryStateDatas:model.nInput];
                    [self updatebinaryOutState:[((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[model.currentIndex].itemParam.triggerParam.nbinaryout intValue]];
                    break;
                    
                default:
                    break;
            }
           
            
            
            ((BD_StateTestStateDiagramVC *)_childVCArr[1]).binaryInValue = model.nInput;
            ((BD_StateTestStateDiagramVC *)_childVCArr[1]).binaryOutValue = [((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[model.currentIndex].itemParam.triggerParam.nbinaryout intValue];
         
            //刷新信息图数据
            [self infomationViewRefreshData:model];
            //------返回数据后，也应该根据当前测试项输出值修改状态图和矢量图的数据-----//
            //刷新矢量图数据
            NSMutableArray<BD_StateTestItemModel *> *data = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource;
            ((BD_VectorDiagramListVC *)_childVCArr[2]).voltageDataArr = data[model.currentIndex].itemParam.stateParam.voltageOutputDatas;
            ((BD_VectorDiagramListVC *)_childVCArr[2]).currentDataArr = data[model.currentIndex].itemParam.stateParam.currentOutputDatas;
            [((BD_VectorDiagramListVC *)_childVCArr[2]) refreshViewData];
            //刷新状态图数据
            NSMutableArray<BD_StateTestItemModel *> *Statedata = ((BD_StateTestDataParamVC *)self.childVCArr[0]).testListDataSource;
            if (data.count!=0) {//只修改数据源，不刷新页面，保证数据依旧
                ((BD_StateTestStateDiagramVC *)self.childVCArr[1]).vcDatas =[[NSMutableArray alloc]initWithObjects:Statedata[model.currentIndex].itemParam.stateParam.voltageOutputDatas,Statedata[model.currentIndex].itemParam.stateParam.currentOutputDatas, nil];
            }
            
        }
    });
    
    
}

#pragma mark - 拼接开始时间
- (void)appendBeginTimeWith:(int)secondtime{
    //初始时间转化
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondtime];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentDateString = [format stringFromDate: date];
    
    //拼接字符串
    [self.historicalData appendString:[NSString stringWithFormat:@"\r\n%@\n",currentDateString]];
}

#pragma mark - 停止测试，生成报告
-(void)endTestAndCreateReport{
    [super endTestAndCreateReport];
    [self.naviBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx!=2 && idx!=3) {
            [[BD_Utils shared]setViewState:YES view:obj];
        }
    }];
    [((BD_StateTestDataParamVC *)_childVCArr[0]) setParamViewUsed];
    self.beginModel.isBegin = NO;
    self.triggerBtn.selected = YES;
    self.triggerBtn.userInteractionEnabled = NO;
 
    //弹出DocumentInteractionController
//    NSURL *URL = [NSURL fileURLWithPath:filePath];
//
//    if (URL) {
//        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
//
//        [self.documentInteractionController setDelegate:self];
//
//        [self.documentInteractionController presentPreviewAnimated:YES];
//    }
}
//生成报告
-(void)createReportVC{
    [super createReportVC];
    WeakSelf;
    //数组中添加BD_ReportBaseModel
    BD_StateTestDataParamVC *dataVC = (BD_StateTestDataParamVC *)_childVCArr[0];
    BD_ReportMainVC *reportVC = [[BD_ReportMainVC alloc]init];
    reportVC.moduleType = BD_TestModuleType_Status;
    reportVC.moduleTestName = @"试验名称--状态序列";
    
    reportVC.objectMessageNum = [NSString stringWithFormat:@"测试对象-%ldU%ldI",dataVC.testListDataSource[0].itemParam.stateParam.voltageOutputDatas.count,dataVC.testListDataSource[0].itemParam.stateParam.voltageOutputDatas.count];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    [dataVC.testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BD_ReportBaseModel * baseModel = [[BD_ReportBaseModel alloc]init];
        baseModel.subTitle = obj.itemProject;
       
        BD_StateTestTriggerParamModel *triggerM = obj.itemParam.triggerParam;
        switch ([triggerM.TriggerType intValue]) {
            case 0:
                //手动触发
            {
                baseModel.testResult = [NSString stringWithFormat:@"触发条件:%@    频率:%@    开出量选择:%@",[self triggerTypeToString:[triggerM.TriggerType intValue]],weakself.commonparamVC.paramDataModel.ratedPower,[self reportSwitchStatusByBinaryOut:[triggerM.nbinaryout intValue]]];
                
            }
                break;
            case 1:
                //时间触发
            {
                  baseModel.testResult = [NSString stringWithFormat:@"触发条件:%@    输出时间:%.3f    频率:%@    开出量选择:%@",[self triggerTypeToString:[triggerM.TriggerType intValue]],[triggerM.TriggerTime floatValue],weakself.commonparamVC.paramDataModel.ratedPower,[self reportSwitchStatusByBinaryOut:[triggerM.nbinaryout intValue]]];
            }
                break;
            case 2:
                //开入量触发
            {
                NSString *triggerLogic = [triggerM.TriggerLogic intValue]==0?@"逻辑或":@"逻辑与";
                 baseModel.testResult = [NSString stringWithFormat:@"触发条件:%@    触发后保持时间:%.3f    频率:%@    开入量选择:%@    开入逻辑：%@    开出量选择：%@",[self triggerTypeToString:[triggerM.TriggerType intValue]],[triggerM.trigerHoldTime floatValue],weakself.commonparamVC.paramDataModel.ratedPower,[self reportSwitchStatusByBinaryIn:[triggerM.nBiValide intValue]],triggerLogic,[self reportSwitchStatusByBinaryOut:[triggerM.nbinaryout intValue]]];
                
            }
                break;
            case 3:
                //GPS触发
            {
              baseModel.testResult = [NSString stringWithFormat:@"触发条件:%@    GPS触发时间:%@    频率:%@    开出量选择：%@",[self triggerTypeToString:[triggerM.TriggerType intValue]],triggerM.Gpstime,weakself.commonparamVC.paramDataModel.ratedPower,[self reportSwitchStatusByBinaryOut:[triggerM.nbinaryout intValue]]];
                
            }
                break;
            case 4:
                //时间+开入量触发
            {
                NSString *triggerLogic = [triggerM.TriggerLogic intValue]==0?@"逻辑或":@"逻辑与";
                baseModel.testResult = [NSString stringWithFormat:@"触发条件:%@    触发后保持时间:%.3f    输出时间:%.3f    频率:%@    开入量选择:%@    开入逻辑：%@    开出量选择：%@",[self triggerTypeToString:[triggerM.TriggerType intValue]],[triggerM.trigerHoldTime floatValue],[triggerM.TriggerTime floatValue],weakself.commonparamVC.paramDataModel.ratedPower,[self reportSwitchStatusByBinaryIn:[triggerM.nBiValide intValue]],triggerLogic,[self reportSwitchStatusByBinaryOut:[triggerM.nbinaryout intValue]]];
            }
                break;
            default:
                break;
        }
       
        
        NSMutableArray *formDatas = [[NSMutableArray alloc]init];
        [obj.itemParam.stateParam.voltageOutputDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formDatas addObject:@[@{@"通道":obj.titleName},@{@"幅值(V)":obj.amplitude},@{@"相位(°)":obj.phase},@{@"频率(Hz)":obj.frequency}]];
        }];
        [obj.itemParam.stateParam.currentOutputDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formDatas addObject:@[@{@"通道":obj.titleName},@{@"幅值(V)":obj.amplitude},@{@"相位(°)":obj.phase},@{@"频率(Hz)":obj.frequency}]];
        }];
        baseModel.formDataSource = [formDatas copy];
        [arr addObject:baseModel];
    }];
    
    
    reportVC.reportDatas = [arr copy];
    [reportVC loadReportViews];
    [self.navigationController pushViewController:reportVC animated:YES];
}

-(NSString *)triggerTypeToString:(int)intType{
    switch (intType) {
        case 0:
            return @"手动触发";
            break;
        case 1:
            return  @"时间触发";
             break;
        case 2:
            return @"开入量";
             break;
        case 3:
            return @"GPS触发";
             break;
        case 4:
            return @"时间+开入量";
            break;
        default:
            break;
    }
    return @"";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)endEditing{
    [self.view endEditing:YES];
}

#pragma  mark - 懒加载


- (NSMutableArray *)btnsArray_binaryIn{
    if (!_btnsArray_binaryIn) {
        _btnsArray_binaryIn = [NSMutableArray array];
    }
    return _btnsArray_binaryIn;
}
- (NSMutableArray *)btnsArray_binaryOut{
    if (!_btnsArray_binaryOut) {
        _btnsArray_binaryOut = [NSMutableArray array];
    }
    return _btnsArray_binaryOut;
}

- (NSMutableString *)historicalData{
    
    if (_historicalData == nil) {
        _historicalData = [NSMutableString string];
    }
    return _historicalData;
}

- (NSMutableArray *)timeIntervalArr{
    
    if (_timeIntervalArr ==nil) {
        _timeIntervalArr = [NSMutableArray array];
    }
    
    return _timeIntervalArr;
}

-(BD_TestResultData *)testResultData{
    if (!_testResultData) {
        _testResultData = [[BD_TestResultData alloc]init];
    }
    return _testResultData;
}
-(BD_StateTemplateFileManager *)templateManager{
    if (!_templateManager) {
        _templateManager = [[BD_StateTemplateFileManager alloc]init];
    }
    return _templateManager;
}

-(BD_BeginTestModel *)beginModel{
    if (!_beginModel) {
        _beginModel = [[BD_BeginTestModel alloc]init];
    }
    return _beginModel;
}

#pragma mark - 点击开始\结束
//- (void)startButtonClick:(UIButton *)sender{
//
////    //点击start
////    if (!sender.selected) {
////
////        //发数据，是否成功
////        bool isSuc = [[OCCenter shareCenter] statesTest:_tbDataSource commonPara:_paramVC.paramDataModel];
////
////        //如果成功，发送start命令开始测试
////        if (isSuc) {
////            sender.selected = !sender.selected;
////
////            self.navigationItem.hidesBackButton = YES;
////
////            //如果测试成功，服务器返回result,将对应cell的result数据改为0，刷新tableview,，显示完成状态按钮
////            int result = [OCCenter.shareCenter start:1];
////            //改变单利中状态序列测试状态
////            [BD_PMCtrlSingleton shared].StatebeginModel.isBegin = ![BD_PMCtrlSingleton shared].StatebeginModel.isBegin;
////
////            for (int i=0; i <_tbDataSource.count; i ++) {
////                _tbDataSource[i].result = @0;
////            }
////
////
////            NSLog(@"startResult:%d",result);
////        }
////        //不成功，弹出提示框
////        else if (!isSuc){
////            [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
////                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
////            }];
////
////            return;
////
////        }
////    }
////    //点击stop
////    else{
////
////        //stop
////        sender.selected = !sender.selected;
////        self.navigationItem.hidesBackButton = NO;
////
////        int result = [OCCenter.shareCenter stop];
////
////        [BD_PMCtrlSingleton shared].StatebeginModel.isBegin = ![BD_PMCtrlSingleton shared].StatebeginModel.isBegin;
////        NSLog(@"stopResult:%d",result);
////
////    }
//}
-(void)startAction{

//    [self createReportVC];

        if (!self.startBtn.selected) {
            
            //获取数据
            //发数据，是否成功
            bool isSuc = [[OCCenter shareCenter] statesTest:[((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource copy] commonPara:_commonparamVC.paramDataModel deviceGPSTime:self.gpsTime];
            
            //如果成功，发送start命令开始测试
            if (isSuc) {
                self.runMangaer = [[BD_RunLightAnimationManager alloc]initWithView:self.switchView.switchBtnArr[0]];
                
                [((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.itemResult = @"";
                }];
                [((BD_StateTestDataParamVC *)_childVCArr[0]) updateViewData];
                
                [_infoView.infoDataSource removeAllObjects];
                [_infoView reloadData];
                
                self.startBtn.selected = YES;
                self.startBtn.userInteractionEnabled = NO;
                self.stopBtn.selected = NO;
                self.stopBtn.userInteractionEnabled = YES;
                
                self.navigationItem.hidesBackButton = YES;
                [self.naviBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx!=6) {
                        [[BD_Utils shared]setViewState:NO view:obj];
                    }
                }];
                self.beginModel.isBegin = YES;
                [((BD_StateTestDataParamVC *)_childVCArr[0]) setParamViewUnUsed];
                int result = [OCCenter.shareCenter start:1];
                NSLog(@"startResult:%d",result);
            }
            //不成功，弹出提示框
            if (!isSuc){
                [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
                }];
                
                return;
            }
        }
    
}

-(void)stopAction{
   
    if (!self.stopBtn.selected) {
        //stop
        //
        [self.runMangaer stopflashView];
        self.stopBtn.selected = YES;
        self.stopBtn.userInteractionEnabled = NO;
        self.startBtn.selected = NO;
        self.startBtn.userInteractionEnabled = YES;
        self.navigationItem.hidesBackButton = NO;
        [self.naviBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx!=2 && idx!=3) {
                [[BD_Utils shared]setViewState:YES view:obj];
            }
        }];
        [((BD_StateTestDataParamVC *)_childVCArr[0]) setParamViewUsed];
        self.beginModel.isBegin = NO;
        self.triggerBtn.selected = YES;
        self.triggerBtn.userInteractionEnabled = NO;
        int result = [OCCenter.shareCenter stop];
        NSLog(@"stopResult:%d",result);
    }
}

#pragma mark - 手动触发
- (void)triggerBtnClick:(UIButton *)sender{
   
    BD_StateTestDataParamVC *dataVC = ((BD_StateTestDataParamVC *)_childVCArr[0]);
    int a = [dataVC.testListDataSource[dataVC.currentTestItem].itemParam.triggerParam.TriggerType intValue];
    
    if (a == 0) {
        if (self.startBtn.selected) {
            int result = [OCCenter.shareCenter start:3];
            NSLog(@"%d",result);
        }
    }
    
    
}


-(void)fileManagerListShow{
    [super fileManagerListShow];
    [((BD_VectorDiagramListVC *)_childVCArr[2]).view endEditing:YES];
    [((BD_StateTestDataParamVC *)_childVCArr[0]).view endEditing:YES];
    
    WeakSelf;
    
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"保存配置",@"保存模版文件",@"打开模版文件",@"报告视图",@"清空模版文件"] textField:self.fileManagerBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
        if ([str isEqualToString:@"保存配置"]) {
            //保存配置方法
        } else if ([str isEqualToString:@"保存模版文件"]){
            //保存模版文件方法
            [self templateFileNameEditAlert:^(NSString *fileName) {
                if ([weakself.templateManager saveTemplateFile: [((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource copy] commonPara:_commonparamVC.paramDataModel deviceGPSTime:weakself.gpsTime fileName:fileName]) {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveSuc toView:weakself.view];
                } else {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveFailed toView:weakself.view];
                }
            }];
            
        } else if ([str isEqualToString:@"打开模版文件"]) {
            //打开模版文件方法
            [weakself showFileListView:@"请选择要打开的模版文件" complete:^(NSString *fileName) {
                NSArray *resultArr = [weakself.templateManager readTemplateFileWithfileName:fileName];
                BD_StateTestDataParamVC *dataVC= ((BD_StateTestDataParamVC *)_childVCArr[0]);
                if (resultArr) {
                    dataVC.testListDataSource = resultArr[0];
                    weakself.commonparamVC.paramDataModel = resultArr[1];
                    
                } else {
                    [MBProgressHUDUtil showMessage:@"打开文件失败" toView:self.view];
                }
                [dataVC updateViewData];
                [dataVC reloadRowInTableviewWithNcur:0];
                
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
-(void)navigationViewActionWithtag:(NSInteger)tag{
    [super navigationViewActionWithtag:tag];
    
    [((BD_VectorDiagramListVC *)_childVCArr[2]).view endEditing:YES];
    [((BD_StateTestDataParamVC *)_childVCArr[0]).view endEditing:YES];
    
    WeakSelf;
    switch (tag) {
        case 0://系统配置
            
            break;
        case 1: //通用参数
            self.commonparamVC.ratedCurrentMax = [self.hardWareView.viewModel.exchangeCurrent floatValue];
            self.commonparamVC.ratedVoltageMax = [self.hardWareView.viewModel.exchangeVoltage floatValue]*sqrt(3);
            [self.commonparamVC showCommomParaView];
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
           
        }
            break;
        case 9://保存模版文件
        {
            
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

#pragma  mark - 数据／状态图／矢量图／信息图点击按钮方法
-(void)topViewBtnClick:(UIButton *)sender{
    NSLog(@"sendertag:%ld",sender.tag);
    [self scrollViewToCurrentViewWithIndex:sender.tag-100];
    [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sender]) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
    
    if (sender.tag == 101) {
//        NSMutableArray<BD_StateTestItemModel *> *data = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource;
//        
//        if (data.count!=0) {
//            ((BD_StateTestStateDiagramVC *)_childVCArr[1]).vcDatas =[[NSMutableArray alloc]initWithObjects:data[((BD_StateTestDataParamVC *)_childVCArr[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem]).currentTestItem].itemParam.stateParam.voltageOutputDatas,data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas, nil];
//        }
//        [((BD_StateTestStateDiagramVC *)_childVCArr[1]) reloadTBView];
    }  else if (sender.tag==102){
     
//        NSMutableArray<BD_StateTestItemModel *> *data = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource;
//        [((BD_VectorDiagramVC *)_childVCArr[2]).vectorDataSource removeAllObjects];
//        if (data.count!=0) {
//
//            NSInteger count_V = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas.count;
//            NSInteger count_C = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas.count;
//
//            if (count_V == 4) {
//                NSMutableArray *datas = [[NSMutableArray alloc]init];
//
//                [data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    [datas addObject:obj];
//                }];
//                [data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    [datas addObject:obj];
//                }];
//                [((BD_VectorDiagramVC *)_childVCArr[2]).vectorDataSource addObject:datas];
//
//            } else {
//                NSInteger group = count_V/3>count_C/3?count_C/3:count_V/3;
//                for (NSInteger i = 0; i<group; i++) {
//                    NSMutableArray *pageDatas = [[NSMutableArray alloc]init];
//                    BD_TestDataParamModel *data1 = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas[i*3+0];
//                    data1.unit = @"V";
//                    BD_TestDataParamModel *data2 = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas[i*3+1];
//                    data2.unit = @"V";
//                    BD_TestDataParamModel *data3 = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas[i*3+2];
//                    data3.unit = @"V";
//                    [pageDatas addObject:data1];
//                    [pageDatas addObject:data2];
//                    [pageDatas addObject:data3];
//
//                    BD_TestDataParamModel *data4=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas[i*3+0];
//                    data4.unit = @"A";
//                    BD_TestDataParamModel *data5=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas[i*3+1];
//                    data5.unit = @"A";
//                    BD_TestDataParamModel *data6=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas[i*3+2];
//                    data6.unit = @"A";
//
//                    [pageDatas addObject:data4];
//                    [pageDatas addObject:data5];
//                    [pageDatas addObject:data6];
//
//                    [((BD_VectorDiagramVC *)_childVCArr[2]).vectorDataSource addObject:pageDatas];
//                }
//
//                for (NSInteger i = 0; i<count_V/3-group; i++) {
//                    NSMutableArray *pageDatas = [[NSMutableArray alloc]init];
//                    BD_TestDataParamModel *data1=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas[i*3+0+group*3];
//                    data1.unit = @"V";
//                    BD_TestDataParamModel *data2=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas[i*3+1+group*3];
//                    data2.unit = @"V";
//                    BD_TestDataParamModel *data3=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas[i*3+2+group*3];
//                    data3.unit = @"V";
//                    [pageDatas addObject:data1];
//                    [pageDatas addObject:data2];
//                    [pageDatas addObject:data3];
//
//                    [((BD_VectorDiagramVC *)_childVCArr[2]).vectorDataSource addObject:pageDatas];
//                }
//                for (NSInteger i = 0; i<count_C/3-group; i++) {
//                    NSMutableArray *pageDatas = [[NSMutableArray alloc]init];
//
//                    BD_TestDataParamModel *data4=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas[i*3+0+group*3];
//                    data4.unit = @"A";
//                    BD_TestDataParamModel *data5=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas[i*3+1+group*3];
//                    data5.unit = @"A";
//                    BD_TestDataParamModel *data6=   data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas[i*3+2+group*3];
//                    data6.unit = @"A";
//
//                    [pageDatas addObject:data4];
//                    [pageDatas addObject:data5];
//                    [pageDatas addObject:data6];
//
//                    [((BD_VectorDiagramVC *)_childVCArr[2]).vectorDataSource addObject:pageDatas];
//                }
//
//
//            }
//
//            [((BD_VectorDiagramVC *)_childVCArr[2]) updateSubViews];
        }
    
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    WeakSelf;
    NSInteger index =  scrollView.contentOffset.x/scrollView.width;
    [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:weakself.viewsBtnArr[index]]) {
            obj.selected = YES;
       
        } else {
            obj.selected = NO;
       
        }
    }];
    switch (index) {
            case 0:
        {
            [((BD_VectorDiagramListVC *)_childVCArr[2]).view endEditing:YES];
        }
            break;
        case 1:
            {
                [((BD_VectorDiagramListVC *)_childVCArr[2]).view endEditing:YES];
                [((BD_StateTestDataParamVC *)_childVCArr[0]).view endEditing:YES];
            }
            break;
        case 2:
        {
            NSMutableArray<BD_StateTestItemModel *> *data = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource;
            ((BD_VectorDiagramListVC *)_childVCArr[2]).voltageDataArr = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.voltageOutputDatas;
            ((BD_VectorDiagramListVC *)_childVCArr[2]).currentDataArr = data[((BD_StateTestDataParamVC *)_childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas;
            [((BD_VectorDiagramListVC *)_childVCArr[2]) refreshViewData];
          
            [((BD_StateTestDataParamVC *)_childVCArr[0]).view endEditing:YES];
        }
            break;
        case 3:
            [((BD_VectorDiagramListVC *)_childVCArr[2]).view endEditing:YES];
            [((BD_StateTestDataParamVC *)_childVCArr[0]).view endEditing:YES];
            break;
        default:
            break;
    }
    
}
//测试仪数据上传到移动端，刷新信息图
-(void)infomationViewRefreshData:(BD_TestResultModel *)result{
    _infoView.isScrollTBView = NO;
    BD_TestInformationModel *model = [[BD_TestInformationModel alloc]init];
    model.infoindex = (int) _infoView.infoDataSource.count+1;
    model.currentTime = [BD_Utils getCurrentDateToms];
    model.actionType = (BDActionType)result.nType;
    model.binaryIn = [self binaryInToString:result.nInput];
    if (result.nType == 4) {
        if (self.testResultData.actionInfoArr.count!=0) {
            model.actionTime = [NSString stringWithFormat:@"%.6f",[self.testResultData.actionInfoArr lastObject].actionTime];//信息图中显示6位小数
        }
        
    }
    //返回到当前状态号从0开始，需要+1进行显示
    model.stateIndex = result.currentIndex+1;
    [_infoView.infoDataSource addObject:model];
    dispatch_async(dispatch_get_main_queue(), ^{
      [_infoView reloadData];
    }) ;
    
}

-(void)testItemListRefreshData:(BD_TestResultModel *)result{
    int triggerType =[((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[result.currentIndex].itemParam.triggerParam.TriggerType intValue];
    
    if (triggerType ==2 || triggerType == 4) {
        BD_StateTestItemModel *itemData = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[result.currentIndex];
        
        WeakSelf;
        NSString *testResultStr  = @"";
        for (BD_ReultInfo *info in self.testResultData.actionInfoArr) {
            if (info.actionTime>0) {
                NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"];
                for (NSInteger i = 0; i<itemData.itemParam.triggerParam.BArr.count; i++) {
                    if ([[weakself compareSwitchStatusByBinaryIn:(int)result.nSource] hasSuffix:arr[i]] && [itemData.itemParam.triggerParam.BArr[i] intValue]==1) {
                        testResultStr = [NSString stringWithFormat:@"%@:%@s ",[weakself compareSwitchStatusByBinaryIn:(int)result.nSource],[NSString stringWithFormat:@"%.4f",info.actionTime]];
                    }
                }
               
                
            }
            
        }
        if (self.testResultData.returnTime>0) {
            testResultStr = [testResultStr stringByAppendingString:[NSString stringWithFormat:@"返回时间:%.3fs",self.self.testResultData.returnTime]];
        }
        
        ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[result.currentIndex].itemResult = [((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[result.currentIndex].itemResult stringByAppendingString:testResultStr];
        [((BD_StateTestDataParamVC *)_childVCArr[0]) reloadRowInTableviewWithNcur:result.currentIndex];
    }
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

-(void)scrollViewToCurrentViewWithIndex:(NSInteger)index{
    self.mainView.contentOffset = CGPointMake(self.mainView.width*index, 0);
}



#pragma  mark - 添加状态序列测试项
-(void)pluseAction{
    //设置最多可用添加9个状态，最初可以，后来提bug,固将个数限制取消
//    if (self.tbDataSource.count>8) {
//        return;
//    }
    
//    [self.tbDataSource addObject:[[BD_StateTestParamModel alloc]initWithStateParam:[[self.tbDataSource lastObject].stateParam mutableCopy] triggerParam:[[self.tbDataSource lastObject].triggerParam copy] transmutationParam:[[self.tbDataSource lastObject].transmutationParam copy] result:@0]];
//
}
#pragma mark - 减少测试状态测试项
-(void)reduseAction{
//    if (self.tbDataSource.count==1) {
//        return;
//    }
//    if (selectedTestItem != -1) {
//        [self.tbDataSource removeObjectAtIndex:selectedTestItem];
//        selectedTestItem = -1;
//    }
 
}


#pragma mark 硬件配置完成，刷新UI
-(void)deviceSettingFinised:(BD_HardwarkConfigModel *)hardData{
    WeakSelf;
    [super deviceSettingFinised:hardData];
    
    int voltageNum = hardData.voltagePassNum;
    int currentNum = hardData.currentPassNum;
    DLog(@"电压通道数:%d,电流通道数:%d",voltageNum,currentNum);
    NSInteger currNum_V=0;
    NSInteger currNum_C=0;
    if (((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource.count!=0) {
        currNum_V = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[0].itemParam.stateParam.voltageOutputDatas.count;
        currNum_C = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[0].itemParam.stateParam.currentOutputDatas.count;
    }
    
    if (!((int)currNum_V==voltageNum && (int)currNum_C == currentNum)){
        
        [weakself.dataCenter updateTestData:voltageNum C_passNum:currentNum complete:^(NSMutableArray *resultArr) {
            //        [_tbDataSource enumerateObjectsUsingBlock:^(BD_StateTestParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //            obj.stateParam = [resultArr copy];
            //            [kNotificationCenter postNotificationName:BD_StateTestDeviceConfigFinished object:nil userInfo:@{@"result":resultArr}];
            //        }];
            //        for (BD_StateTestParamModel *obj in _tbDataSource) {
            //
            //
            //            [kNotificationCenter postNotificationName:BD_StateTestDeviceConfigFinished object:nil userInfo:@{@"result":obj.stateParam}];
            //        }
            
            
            if (resultArr && resultArr.count==2) {
                [((BD_StateTestDataParamVC *)weakself.childVCArr[0]).testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.itemParam.stateParam.voltageOutputDatas = [resultArr[0] mutableCopy];
                    obj.itemParam.stateParam.currentOutputDatas = [resultArr[1] mutableCopy];
                }];
                [((BD_StateTestDataParamVC *)weakself.childVCArr[0]) updateViewData];
                
                [((BD_VectorDiagramListVC *)weakself.childVCArr[2]) cleanVectorgraphSelectedArr];
                ((BD_VectorDiagramListVC *)weakself.childVCArr[2]).voltageDataArr = [resultArr[0] mutableCopy];
                ((BD_VectorDiagramListVC *)weakself.childVCArr[2]).currentDataArr = [resultArr[1] mutableCopy];
                  [((BD_VectorDiagramListVC *)weakself.childVCArr[2]) refreshViewData];
                
                
                NSMutableArray<BD_StateTestItemModel *> *data = ((BD_StateTestDataParamVC *)weakself.childVCArr[0]).testListDataSource;
                if (data.count!=0) {
                    ((BD_StateTestStateDiagramVC *)weakself.childVCArr[1]).vcDatas =[[NSMutableArray alloc]initWithObjects:data[((BD_StateTestDataParamVC *)weakself.childVCArr[((BD_StateTestDataParamVC *)weakself.childVCArr[0]).currentTestItem]).currentTestItem].itemParam.stateParam.voltageOutputDatas,data[((BD_StateTestDataParamVC *)weakself.childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas, nil];
                }
                [((BD_StateTestStateDiagramVC *)weakself.childVCArr[1]) reloadTBView];
                
            }
            
        }];

        _groupNum = voltageNum/3>currentNum/3?voltageNum/3:currentNum/3;
        ((BD_StateTestDataParamVC *)_childVCArr[0]).groupNum = _groupNum;
        [((BD_StateTestDataParamVC *)_childVCArr[0]) setCaculatVCDefaultData];
        
//        NSMutableArray *headerTitles = [[NSMutableArray alloc]init];
//        for (NSInteger i = 0; i<_groupNum; i++) {
//            [headerTitles addObject:@[@"通道名称",@"幅值",@"单位",@"相位(°)",@"频率(Hz)"]];
//        }
//        ((BD_VectorDiagramVC *)_childVCArr[2]).baseHeaderTitles = [headerTitles copy];
        
        [self.switchView addCurrentLightWithGroup:currentNum/3];
    }
    
    
    
}

#pragma mark - 从测试仪读取通道信息和输出限制信息后，刷新页面显示
-(void)getDeviceInfoToChangeViewData{
    WeakSelf;//因为是block中的方法，使用弱引用
    [super getDeviceInfoToChangeViewData];
    int voltageNum = self.hardWareView.viewModel.voltagePassNum;
    int currentNum = self.hardWareView.viewModel.currentPassNum;
    DLog(@"电压通道数:%d,电流通道数:%d",voltageNum,currentNum);
    NSInteger currNum_V=0;
    NSInteger currNum_C=0;
    if (((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource.count!=0) {
        currNum_V = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[0].itemParam.stateParam.voltageOutputDatas.count;
        currNum_C = ((BD_StateTestDataParamVC *)_childVCArr[0]).testListDataSource[0].itemParam.stateParam.currentOutputDatas.count;
    }
    
    if (!((int)currNum_V==voltageNum && (int)currNum_C == currentNum)){
        
        [weakself.dataCenter updateTestData:voltageNum C_passNum:currentNum complete:^(NSMutableArray *resultArr) {
            
            if (resultArr && resultArr.count==2) {
                [((BD_StateTestDataParamVC *)weakself.childVCArr[0]).testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.itemParam.stateParam.voltageOutputDatas = [resultArr[0] mutableCopy];
                    obj.itemParam.stateParam.currentOutputDatas = [resultArr[1] mutableCopy];
                }];
                [((BD_StateTestDataParamVC *)weakself.childVCArr[0]) updateViewData];
                
                [((BD_VectorDiagramListVC *)weakself.childVCArr[2]) cleanVectorgraphSelectedArr];
                ((BD_VectorDiagramListVC *)weakself.childVCArr[2]).voltageDataArr = [resultArr[0] mutableCopy];
                ((BD_VectorDiagramListVC *)weakself.childVCArr[2]).currentDataArr = [resultArr[1] mutableCopy];
                [((BD_VectorDiagramListVC *)weakself.childVCArr[2]) refreshViewData];
                
                
                NSMutableArray<BD_StateTestItemModel *> *data = ((BD_StateTestDataParamVC *)weakself.childVCArr[0]).testListDataSource;
                if (data.count!=0) {
                    ((BD_StateTestStateDiagramVC *)weakself.childVCArr[1]).vcDatas =[[NSMutableArray alloc]initWithObjects:data[((BD_StateTestDataParamVC *)weakself.childVCArr[((BD_StateTestDataParamVC *)weakself.childVCArr[0]).currentTestItem]).currentTestItem].itemParam.stateParam.voltageOutputDatas,data[((BD_StateTestDataParamVC *)weakself.childVCArr[0]).currentTestItem].itemParam.stateParam.currentOutputDatas, nil];
                }
                [((BD_StateTestStateDiagramVC *)weakself.childVCArr[1]) reloadTBView];
                
            }
            
        }];
        
        _groupNum = voltageNum/3>currentNum/3?voltageNum/3:currentNum/3;
        ((BD_StateTestDataParamVC *)_childVCArr[0]).groupNum = _groupNum;
    }
}
//程序进入后台，修改页面显示
-(void)applicationEnterBackground{
        //结束实验需要进行的动作
   
//    [OCCenter.shareCenter stop];
//    self.view.userInteractionEnabled = YES;

}

//网络连接断开
-(void)netWordDisConnect{
    [super netWordDisConnect];
    ((BD_StateTestStateDiagramVC *)_childVCArr[1]).beginModel = self.beginModel;
    [((BD_StateTestStateDiagramVC *)_childVCArr[1]) setBeginState];
}
//kvo监听变化是否开始测试属性
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isBegin"]) {
        
        
        if ( self.beginModel.isBegin) {
            
            self.navigationController.navigationBar.userInteractionEnabled = NO;
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
            self.navigationItem.backBarButtonItem.tintColor = [UIColor lightGrayColor];
            self.navigationItem.leftBarButtonItem.tintColor = [UIColor lightGrayColor];
        } else {
            self.navigationController.navigationBar.userInteractionEnabled = YES;
            self.navigationItem.rightBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
            self.navigationItem.backBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
            self.navigationItem.leftBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
        }
        ((BD_StateTestStateDiagramVC *)_childVCArr[1]).beginModel = self.beginModel;
        [((BD_StateTestStateDiagramVC *)_childVCArr[1]) setBeginState];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [BD_PMCtrlSingleton shared].deviceType = BDDeviceType_Imitate;
}
- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.beginModel removeObserver:self forKeyPath:@"isBegin" context:nil];
}

#pragma mark - 测试列表中测试结果，开关量动作
-(NSString *)compareSwitchStatusByBinaryIn:(int)binaryIn {
    NSString *str = @"";
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryIn&0x80000000)==0?0:1;
        binaryIn = binaryIn<<1;
    }
    if (ch[0] == 1)
    {
        str = @"跳A";
        return str;
    }
    
    if (ch[1] == 1)
    {
        str = @"跳B";
        return str;
    }
    
    if (ch[2] == 1)
    {
        str = @"跳C";
        return str;
    }
    
    if (ch[3] == 1)
    {
        str = @"跳D";
        return str;
    }
    
    if (ch[4] == 1)
    {
        str = @"跳E";
        return str;
    }
    
    if (ch[5] == 1)
    {
        str = @"跳F";
        return str;
    }
    
    if (ch[6] == 1)
    {
        str = @"跳G";
        return str;
    }
    
    if (ch[7] == 1)
    {
        str = @"跳H";
        return str;
    }
    
    if (ch[8] == 1)
    {
        str = @"跳I";
        return str;
    }
    
    if (ch[9] == 1)
    {
        str = @"跳J";
        return str;
    }
    
    return @"";
}

#pragma mark - 报告中开入量int转通道
-(NSString *)reportSwitchStatusByBinaryIn:(int)binaryIn {
    NSString *str = @"";
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryIn&0x80000000)==0?0:1;
        binaryIn = binaryIn<<1;
    }
    if (ch[0] == 1)
    {
        str = [str stringByAppendingString:@"A,"];
    }
    
    if (ch[1] == 1)
    {
        str = [str stringByAppendingString:@"B,"];
    }
    
    if (ch[2] == 1)
    {
         str = [str stringByAppendingString:@"C,"];
    }
    
    if (ch[3] == 1)
    {
         str = [str stringByAppendingString:@"D,"];

    }
    
    if (ch[4] == 1)
    {
         str = [str stringByAppendingString:@"E,"];
    }
    
    if (ch[5] == 1)
    {
         str = [str stringByAppendingString:@"F,"];
    }
    
    if (ch[6] == 1)
    {
        str = [str stringByAppendingString:@"G,"];
    }
    
    if (ch[7] == 1)
    {
        str = [str stringByAppendingString:@"H,"];
    }
    
    if (ch[8] == 1)
    {
        str = [str stringByAppendingString:@"I,"];
    }
    
    if (ch[9] == 1)
    {
        str = [str stringByAppendingString:@"J,"];
    }
    
    return str;
}
#pragma mark - 报告中开出量int转通道
-(NSString *)reportSwitchStatusByBinaryOut:(int)binaryOut {
    NSString *str = @"";
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryOut&0x80000000)==0?0:1;
        binaryOut = binaryOut<<1;
    }
    if (ch[0] == 1)
    {
        str = [str stringByAppendingString:@"1,"];
    }
    
    if (ch[1] == 1)
    {
        str = [str stringByAppendingString:@"2,"];
    }
    
    if (ch[2] == 1)
    {
        str = [str stringByAppendingString:@"3,"];
    }
    
    if (ch[3] == 1)
    {
        str = [str stringByAppendingString:@"4,"];
        
    }
    
    if (ch[4] == 1)
    {
        str = [str stringByAppendingString:@"5,"];
    }
    
    if (ch[5] == 1)
    {
        str = [str stringByAppendingString:@"6,"];
    }
    
    if (ch[6] == 1)
    {
        str = [str stringByAppendingString:@"7,"];
    }
    
    if (ch[7] == 1)
    {
        str = [str stringByAppendingString:@"8,"];
    }
    
    return str;
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
