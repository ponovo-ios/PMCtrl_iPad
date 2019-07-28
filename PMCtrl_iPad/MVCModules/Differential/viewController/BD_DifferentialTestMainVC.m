//
//  BD_DifferentialTestMainVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/24.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferentialTestMainVC.h"
#import "BD_DifferentialTestItemModel.h"
#import "BD_DifferentialTestTabVC.h"
#import "BD_DifferentialGeneralSettingVC.h"
#import "BD_DifferentialSetParamSettingVC.h"
#import "BD_DifferTestItemParaVCViewController.h"
#import "BD_CharacteristicVC.h"
#import "BD_VectorDiagramVC.h"
#import "UIImage+Extension.h"
#import "BD_BinarySwitchSetVC.h"
#import "OCCenter.h"
#import "BD_PopListViewManager.h"
#import "BD_DifferBaseDataModel.h"
#import "BD_DifferSetDataModel.h"
#import "GeneralParaModel.h"
#import "SettingValueModel.h"
#import "BD_DifferGeneralSetDataModel.h"
#import "BD_DifferSetDataModel.h"
#import "BD_DifferentialTestResultModel.h"
#import "BD_TestDataParamModel.h"
#import "BD_BinarySwitchView.h"
#import "BD_TestBinarySwitchSetModel.h"
#import "BD_DifferIrCaculateManager.h"
#import "BD_DifferentialTemplateFileManager.h"

#import "BD_ReportBaseModel.h"
#import "BD_ReportPDFMainVC.h"
#import "BD_ReportMainVC.h"
#import "BD_HardwareConfigView.h"

//run灯管理
#import "BD_RunLightAnimationManager.h"
@interface BD_DifferentialTestMainVC (){
    BD_DifferentialTestResult *firstZDratio;
}

//通用参数
@property(nonatomic,strong)BD_DifferentialGeneralSettingVC *generalSettingView;
//整定值
@property(nonatomic,strong)BD_DifferentialSetParamSettingVC *settingView;

////数据页
//@property(nonatomic,strong)BD_DifferTestItemParaVCViewController *testItemParaView;
////特性曲线图
//@property(nonatomic,strong)BD_CharacteristicVC *characteristicView;
////矢量图
@property(nonatomic,strong)NSMutableArray<UIViewController *> *childVCArr;


@property (nonatomic, strong) NSMutableArray * generModelArray;   //plist
@property (nonatomic, strong) NSMutableArray * setModelArray;   //plist
@property(nonatomic,strong)BD_DifferGeneralSetDataModel *generalDataParam;
@property (nonatomic,strong)BD_DifferSetDataModel * setDataModel;
@property(nonatomic,strong)BD_DifferentialTemplateFileManager *templateManager;



@end

@implementation BD_DifferentialTestMainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self generalAndSetData];
    WeakSelf;
    self.generalSettingView.okBlock = ^{
        ((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).testItemBaseData = [weakself caculateIr];
        [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]) updateDataSource_generalData];
        [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]) setParamViewData];
    };
    self.settingView.okBlock = ^{
         //如果修改了拐点个数，测试项中的测试项要恢复默认，相当于删除N-1
        [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).testListdataSource removeAllObjects];
        [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]) createDefaultData];
        ((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).testItemBaseData = [weakself caculateIr];
        [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]) updateDataSource_setData];
        [weakself setCharacteristicData];
        //修改整定值设置后，页面恢复默认
          [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]) testListdefaultState];
    };
    
    self.binarySwitchSetView.okActionBlock = ^{
        [weakself setBinaryViewUsed];
    };
    [kNotificationCenter addObserver:self selector:@selector(refreshView:) name:BD_DifferTestResultNoti object:nil];
    self.hardWareView.moduletype = BD_TestModuleType_Diff;
  
    
    //数据页面监听误差范围发生变化
    [((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]) addObserver:self forKeyPath:@"assessmentError" options:NSKeyValueObservingOptionNew context:nil];

    //右侧显示结果的view,无用，暂时隐藏
    self.rightResultView.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUI{
    [super configureUI];
  
    //底部指示灯
    self.switchView = [[BD_BinarySwitchView alloc] initWithTitleArray:@[@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia", @"Ib", @"Ic", @"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"L1", @"L2", @"L3", @"L4", @"L5", @"L6", @"L7", @"L8"]];
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
    NSArray *btnTitle = @[@"数据",@"特性曲线图",@"矢量图"];
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
}


-(void)loadMainViewSubViews{
    WeakSelf;
    _childVCArr = [[NSMutableArray alloc]init];
    BD_DifferTestItemParaVCViewController *testItemParaView = [[BD_DifferTestItemParaVCViewController alloc]initWithNibName:NSStringFromClass([BD_DifferTestItemParaVCViewController class]) bundle:[NSBundle mainBundle]];
    testItemParaView.listDataSourceChangedBlock = ^{
        [weakself setCharacteristicData];
    };
    
    [self.mainView addSubview:testItemParaView.view];
    [_childVCArr addObject:testItemParaView];
    
    BD_CharacteristicVC *characteristicView = [[BD_CharacteristicVC alloc]init];
    
    [self.mainView addSubview:characteristicView.view];
    [_childVCArr addObject:characteristicView];
    
    BD_VectorDiagramVC *vectorVC = [[BD_VectorDiagramVC alloc]init];
    vectorVC.baseHeaderTitles = @[@[@"名称(故障态)",@"幅值",@"单位",@"相位(°)"]];
   vectorVC.vectorDataSource = [self createVectorData:vectorVC.baseHeaderTitles];
    [self.mainView addSubview:vectorVC.view];
    [_childVCArr addObject:vectorVC];
    
    
    
    
}

-(void)viewWillLayoutSubviews{
    [_childVCArr[1].view setFrame:CGRectMake(self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    [_childVCArr[0].view setFrame:CGRectMake(0, 0, self.mainView.width, self.mainView.height)];
    [_childVCArr[2].view setFrame:CGRectMake(2*self.mainView.width, 0, self.mainView.width, self.mainView.height)];
    self.mainView.contentSize = CGSizeMake(self.mainView.frame.size.width*_childVCArr.count, self.mainView.frame.size.height);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBinaryViewUsed];
}


-(void)fileManagerListShow{
    [super fileManagerListShow];
    WeakSelf;
    
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"保存配置",@"保存模版文件",@"打开模版文件",@"报告视图",@"清空模版文件"] textField:self.fileManagerBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *str) {
        if ([str isEqualToString:@"保存配置"]) {
            //保存配置方法
        } else if ([str isEqualToString:@"保存模版文件"]){
            //保存模版文件方法
            [self templateFileNameEditAlert:^(NSString *fileName) {
                if ([weakself.templateManager saveTemplateFileWithGeneralParam:weakself.generalSettingView.generalDataParam setParam:weakself.settingView.setDataModel binarySwitch:weakself.binarySwitchSetView.binaryData testItem:[((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource copy] outputType:[BD_PMCtrlSingleton shared].deviceType fileName:fileName]) {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveSuc toView:weakself.view];
                } else {
                    [MBProgressHUDUtil showMessage:TemplateFileSaveFailed toView:weakself.view];
                }
            }];
            
        } else if ([str isEqualToString:@"打开模版文件"]) {
            //打开模版文件方法
            [weakself showFileListView:@"请选择要打开的模版文件" complete:^(NSString *fileName) {
                NSArray *resultArr = [weakself.templateManager readTemplateFileWithfileName:fileName];
                if (resultArr) {
                    self.generalDataParam = resultArr[0];
                    self.setDataModel = resultArr[1];
                    self.binarySwitchSetView.binaryData = resultArr[2];
                    ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource = resultArr[3];
                    
                    //更改数据源后必须刷新页面
                    [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]) reloadTBView];
                    //打开模版文件后，设置默认显示
                    [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]) testListdefaultState];
                    //整定值将data转换为数组
                    [self updateSetViewData];
                    self.settingView.setModelArray = self.setModelArray;
                    //通用参数将data转换为数组
                    [self updateGeneralViewData];
                    self.generalSettingView.generModelArray = self.generModelArray;
                    
                    self.settingView.setDataModel = self.setDataModel;
                    self.generalSettingView.generalDataParam = self.generalDataParam;
                    //更新单例中的整定值数据
                    [BD_DifferIrCaculateManager shared].setData = self.settingView.setDataModel;
                    
                    if (self.setDataModel.Axis==0) {
                        [kNotificationCenter postNotificationName:BD_DifferSettingType object:@(0)];
                    } else {
                        [kNotificationCenter postNotificationName:BD_DifferSettingType object:@(1)];
                    }
                    
                } else {
                    [MBProgressHUDUtil showMessage:@"打开文件失败" toView:self.view];
                }

                
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
    WeakSelf;
    switch (tag) {
        case 0://系统配置
            
            break;
        case 1: //通用参数
            [self.generalSettingView showGeneralParaView];
             break;
        case 2: //整定值
            [self.settingView showSetParaView];
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
              NSArray *resultArr = [weakself.templateManager readTemplateFileWithfileName:fileName];
                if (resultArr) {
                    self.generalDataParam = resultArr[0];
                    self.setDataModel = resultArr[1];
                    self.binarySwitchSetView.binaryData = resultArr[2];
                    ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource = resultArr[3];
                    
                    //更改数据源后必须刷新页面
                    [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]) reloadTBView];
                    //打开模版文件后，设置默认显示
                    [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]) testListdefaultState];
                    //整定值将data转换为数组
                    [self updateSetViewData];
                    self.settingView.setModelArray = self.setModelArray;
                    //通用参数将data转换为数组
                    [self updateGeneralViewData];
                    self.generalSettingView.generModelArray = self.generModelArray;
                    
                    self.settingView.setDataModel = self.setDataModel;
                    self.generalSettingView.generalDataParam = self.generalDataParam;
                    //更新单例中的整定值数据
                    [BD_DifferIrCaculateManager shared].setData = self.settingView.setDataModel;
                    
                } else {
                     [MBProgressHUDUtil showMessage:@"打开文件失败" toView:self.view];
                }
            }];
        }
            break;
        case 9://保存模版文件
        {
            [self templateFileNameEditAlert:^(NSString *fileName) {
                
                if ([weakself.templateManager saveTemplateFileWithGeneralParam:weakself.generalSettingView.generalDataParam setParam:weakself.settingView.setDataModel binarySwitch:weakself.binarySwitchSetView.binaryData testItem:[((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource copy] outputType:[BD_PMCtrlSingleton shared].deviceType fileName:fileName]) {
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

-(void)topViewBtnClick:(UIButton *)sender{
    NSLog(@"sendertag:%ld",sender.tag);
    [self scrollViewToCurrentViewWithIndex:sender.tag-100];
    WeakSelf;
    [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sender]) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
        if ([obj.titleLabel.text isEqualToString:@"特性曲线图"]) {
            if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_ActionTime) {
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateActionTimeChartData];
            } else if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_HarmonicRation){
                ((BD_CharacteristicVC *)weakself.childVCArr[1]).currentTestItem = ((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).currentSelItem;
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateHarmChartData];
                
            } else {
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateQDChartData];
                 [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateMarkViewWithTestItemIndex:((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).currentSelItem];
                
            }
        } else if ([obj.titleLabel.text isEqualToString:@"矢量图"]){
            [((BD_VectorDiagramVC *)_childVCArr[2]) updateSubViews];
        }
    }];
}

#pragma mark notification方法

- (void)refreshView:(NSNotification *)info{
//刷新矢量图实时数据
    unsigned int binaryOut = 0;
    NSArray *binarOutArr = @[@(!(BOOL)self.binarySwitchSetView.binaryData.iOut1),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut2),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut3),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut4),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut5),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut6),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut7),@(!(BOOL)self.binarySwitchSetView.binaryData.iOut8)];
    for (NSInteger i = 0; i < binarOutArr.count; i++) {
        if ([binarOutArr[i] intValue]==1)
        {
            binaryOut |= (1<<i);
        }
    }
    
 BD_DifferentialTestResult *result = (BD_DifferentialTestResult *)info.object;
    BD_DifferentialBasicResultItem *resultItem;
    if (result.itemType == DifferTestItemType_QDCurrent ||result.itemType == DifferTestItemType_SDCurrent ) {
        //启动电流 速断电流
        resultItem = result.oQdcurrent.basic;
        [self updateBinaryStateDatas:result.oQdcurrent.nibinstate];
        //开出量指示灯，从开关量设置页面获取开关量设置数据
        [self updatebinaryOutState:binaryOut];
        if (result.oQdcurrent.bEnd&&result.oQdcurrent.iIndex== ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource.count+1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //动作时间是最后一个，测试完成后就改变view状态
                [self endTestAndCreateReport];
                
            });
            
        }
    } else if (result.itemType == DifferTestItemType_ZDRatio){
        //比率制动系数
        resultItem = result.oZDRatio.basic;
        [self updateBinaryStateDatas:result.oZDRatio.nibinstate];
        //开出量指示灯，从开关量设置页面获取开关量设置数据
        [self updatebinaryOutState:binaryOut];
        if (result.oZDRatio.bEnd&&result.oZDRatio.iIndex== ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource.count+1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //动作时间是最后一个，测试完成后就改变view状态
                [self endTestAndCreateReport];
                
            });
            
        }
    }else if (result.itemType == DifferTestItemType_HarmonicRation){
        //谐波
        resultItem = result.oHarmnonicRatio.basic;
        [self updateBinaryStateDatas:result.oHarmnonicRatio.nibinstate];
        //开出量指示灯，从开关量设置页面获取开关量设置数据
        [self updatebinaryOutState:binaryOut];
        if (result.oHarmnonicRatio.bEnd&&result.oHarmnonicRatio.iIndex== ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource.count+1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //动作时间是最后一个，测试完成后就改变view状态
                [self endTestAndCreateReport];
                
            });
            
        }
    } else if (result.itemType == DifferTestItemType_ActionTime){
        //动作时间
        resultItem = result.oActionTime.basic;
        [self updateBinaryStateDatas:result.oActionTime.nibinstate];
        //开出量指示灯，从开关量设置页面获取开关量设置数据
        [self updatebinaryOutState:binaryOut];
        if (result.oActionTime.bEnd&&result.oActionTime.iIndex== ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource.count+1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //动作时间是最后一个，测试完成后就改变view状态
                [self endTestAndCreateReport];
                
            });
           
        }
        
        
    } else {
        resultItem = [[BD_DifferentialBasicResultItem alloc]init];
    }
    
   
    
    [self testItemListRefreshResult:result];
    [((BD_VectorDiagramVC *)_childVCArr[2]).vectorDataSource enumerateObjectsUsingBlock:^(NSMutableArray<BD_TestDataParamModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj[0].amplitude = [NSString stringWithFormat:@"%.3f", resultItem.Ia.famptitude];
        obj[0].phase = [NSString stringWithFormat:@"%.3f", resultItem.Ia.fphase];
        obj[1].amplitude = [NSString stringWithFormat:@"%.3f", resultItem.Ib.famptitude];
        obj[1].phase = [NSString stringWithFormat:@"%.3f", resultItem.Ib.fphase];
        obj[2].amplitude = [NSString stringWithFormat:@"%.3f", resultItem.Ic.famptitude];
        obj[2].phase = [NSString stringWithFormat:@"%.3f", resultItem.Ic.fphase];
        
        obj[3].amplitude = [NSString stringWithFormat:@"%.3f", resultItem.Iap.famptitude];
        obj[3].phase = [NSString stringWithFormat:@"%.3f", resultItem.Iap.fphase];
       
        obj[4].amplitude = [NSString stringWithFormat:@"%.3f", resultItem.Ibp.famptitude];
        obj[4].phase = [NSString stringWithFormat:@"%.3f", resultItem.Ibp.fphase];
        obj[5].amplitude = [NSString stringWithFormat:@"%.3f", resultItem.Icp.famptitude];
        obj[5].phase = [NSString stringWithFormat:@"%.3f", resultItem.Icp.fphase];
        
    }];
    
    [((BD_VectorDiagramVC *)_childVCArr[2]) updateSubViews];

}

#pragma mark 停止实验后，生成报告
-(void)endTestAndCreateReport{
    [super endTestAndCreateReport];
    //停止后，导航栏按钮改为可用
    [self.naviBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[BD_Utils shared]setViewState:YES view:obj];
        
    }];
    [self.runMangaer stopflashView];
   
}
-(void)createReportVC{
    [super createReportVC];
    BD_ReportMainVC *reportVC = [[BD_ReportMainVC alloc]init];
    reportVC.moduleType = BD_TestModuleType_Diff;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      
        BD_ReportBaseModel * baseModel = [[BD_ReportBaseModel alloc]init];
        baseModel.subTitle = obj.itemName;
        baseModel.assessmentResult = @"评估:合格";
        switch (obj.testItemParam.itemType) {
            case DifferTestItemType_QDCurrent:
            {
                baseModel.testResult = [NSString stringWithFormat:@"允许误差值：5.000%@,测试精度:%@,测试项:%@",@"%",  obj.testItemParam.testAccuracy,obj.testItemParam.testPhasorType];
                baseModel.isShowImage = NO;
                baseModel.formDataSource = @[@[@{@"制动电流":@"23"},@{obj.itemName:@"213"},@{@"IH":@"233"},@{@"IL":@"234"},@{@"试验结果":@"234"}]];
                
            }
                break;
            case DifferTestItemType_ZDRatio:
            {
                baseModel.testResult = [NSString stringWithFormat:@"允许误差值：5.000%@,测试精度:%@,测试项:%@",@"%",  obj.testItemParam.testAccuracy,obj.testItemParam.testPhasorType];
                baseModel.isShowImage = NO;
                baseModel.formDataSource = @[@[@{@"制动电流":@"23"},@{obj.itemName:@"213"},@{@"IH":@"233"},@{@"IL":@"234"},@{@"试验结果":@"234"}]];
            }
                break;
            case DifferTestItemType_SDCurrent:
            {
                baseModel.testResult = [NSString stringWithFormat:@"允许误差值：5.000%@,测试精度:%@,测试项:%@",@"%",  obj.testItemParam.testAccuracy,obj.testItemParam.testPhasorType];
                baseModel.isShowImage = YES;
                if (((BD_CharacteristicVC *)_childVCArr[1]).characterImages.count !=0) {
                    baseModel.image = ((BD_CharacteristicVC *)_childVCArr[1]).characterImages[0];
                }
                baseModel.formDataSource = @[@[@{@"制动电流":@"23"},@{obj.itemName:@"213"},@{@"IH":@"233"},@{@"IL":@"234"},@{@"试验结果":@"234"}]];
            }
                break;
            case DifferTestItemType_HarmonicRation:
            {
                baseModel.testResult = [NSString stringWithFormat:@"允许误差值：5.000%@,测试精度:%@,测试项:%@",@"%",  obj.testItemParam.testAccuracy,obj.testItemParam.testPhasorType];
                baseModel.isShowImage = YES;
                baseModel.formDataSource = @[@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"谐波次数":@"233"},@{@"整定值":@"234"},@{@"测量值":@"234"},@{@"评估":@"合格"}]];
                if (((BD_CharacteristicVC *)_childVCArr[1]).characterImages.count>=4) {
                    if ([obj.testItemParam.nHarm isEqualToString:@"2"]) {
                        baseModel.image = ((BD_CharacteristicVC *)_childVCArr[1]).characterImages[1];
                    } else if ([obj.testItemParam.nHarm isEqualToString:@"5"]){
                        baseModel.image = ((BD_CharacteristicVC *)_childVCArr[1]).characterImages[2];
                    }
                }
                
            }
                break;
            case DifferTestItemType_ActionTime:
            {
                baseModel.testResult = [NSString stringWithFormat:@"允许误差值：5.000%@,测试精度:%@,测试项:%@",@"%",  obj.testItemParam.testAccuracy,obj.testItemParam.testPhasorType];
                baseModel.isShowImage = YES;
                baseModel.formDataSource = @[@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"高压侧电流":@"233"},@{@"低压侧电流":@"234"},@{@"动作时间":@"234"},@{@"评估":@"合格"}],@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"高压侧电流":@"233"},@{@"低压侧电流":@"234"},@{@"动作时间":@"234"},@{@"评估":@"合格"}],@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"高压侧电流":@"233"},@{@"低压侧电流":@"234"},@{@"动作时间":@"234"},@{@"评估":@"合格"}]];
                if (((BD_CharacteristicVC *)_childVCArr[1]).characterImages.count>=4) {
                    baseModel.image = ((BD_CharacteristicVC *)_childVCArr[1]).characterImages[3];
                }
              
            }
            case DifferTestItemType_Characteristic:
            {
                baseModel.testResult = [NSString stringWithFormat:@"允许误差值：5.000%@,测试精度:%@,测试项:%@",@"%",  obj.testItemParam.testAccuracy,obj.testItemParam.testPhasorType];
                baseModel.isShowImage = YES;
                baseModel.formDataSource = @[@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"高压侧电流":@"233"},@{@"低压侧电流":@"234"},@{@"动作时间":@"234"},@{@"评估":@"合格"}],@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"高压侧电流":@"233"},@{@"低压侧电流":@"234"},@{@"动作时间":@"234"},@{@"评估":@"合格"}],@[@{@"制动电流":@"23"},@{@"差动电流":@"213"},@{@"高压侧电流":@"233"},@{@"低压侧电流":@"234"},@{@"动作时间":@"234"},@{@"评估":@"合格"}]];
                if (((BD_CharacteristicVC *)_childVCArr[1]).characterImages.count>=4) {
                    baseModel.image = ((BD_CharacteristicVC *)_childVCArr[1]).characterImages[3];
                }
                
            }
                break;
            case DifferTestItemType_Other:
            {
                
            }
                break;
            default:
                break;
        }
        [arr addObject:baseModel];
    
    }];
    reportVC.moduleTestName = @"试验名称--差动试验";
    reportVC.reportDatas = [arr copy];
    [reportVC loadReportViews];
    [self.navigationController pushViewController:reportVC animated:YES];
    
}
#pragma mark - 刷新测试列表，显示各个测试项测试结果
-(void)testItemListRefreshResult:(BD_DifferentialTestResult *)result{
    BD_DifferTestItemParaVCViewController *dataView = (BD_DifferTestItemParaVCViewController *)_childVCArr[0];
    NSString *resultStr = @"";
    switch (result.itemType) {
        case DifferTestItemType_QDCurrent:
        {
            
            resultStr = [NSString stringWithFormat:@"制动电流=%@A,启动电流=%@A",dataView.testListdataSource[result.oQdcurrent.iIndex-1].testItemParam.Ir,kTStrings(self.settingView.setDataModel.Icdqd)];
            
            dataView.testListdataSource[result.oQdcurrent.iIndex-1].itemResult = resultStr;
            [dataView reloadTBVIewWithCellIndex:result.oQdcurrent.iIndex-1];
        }
            break;
        case DifferTestItemType_ZDRatio:
        {
            
            if(result.itemType==DifferTestItemType_ZDRatio) {
                if (dataView.testListdataSource[result.oZDRatio.iIndex-1].testItemParam.iTypeIndex==dataView.testListdataSource[result.oZDRatio.iIndex].testItemParam.iTypeIndex) {
                        firstZDratio = result;
                    
                }
                
            }else
                
            if (result.oZDRatio.bEnd) {
                
           if (dataView.testListdataSource[result.oZDRatio.iIndex-2].itemSelect==YES) {
                    if(dataView.testListdataSource[result.oZDRatio.iIndex-1].testItemParam.itemType==DifferTestItemType_ZDRatio&&dataView.testListdataSource[result.oZDRatio.iIndex-2].testItemParam.itemType==DifferTestItemType_ZDRatio) {
                        CGFloat y2 = result.oZDRatio.Id;
                        CGFloat y1 =firstZDratio.oZDRatio.Id;
                        CGFloat x2 = dataView.testListdataSource[result.oZDRatio.iIndex-1].testItemParam.Ir.floatValue;
                        CGFloat x1 = dataView.testListdataSource[result.oZDRatio.iIndex-2].testItemParam.Ir.floatValue;
                        
                        CGFloat rate = (y2-y1)/(x2-x1);
                        DLog(@"斜率%.f",rate)
                        //当前测试测试项结果
                        resultStr = [NSString stringWithFormat:@"制动电流=%@A,差动电流=%.3fA 比率制动系数=%.3f",dataView.testListdataSource[result.oZDRatio.iIndex-1].testItemParam.Ir,result.oZDRatio.Id,rate];
                        dataView.testListdataSource[result.oZDRatio.iIndex-1].itemResult = resultStr;
                        [dataView reloadTBVIewWithCellIndex:result.oZDRatio.iIndex-1];
                        //上一个测试项的结果
                        NSString  *resultStr2 = [NSString stringWithFormat:@"制动电流=%@A,差动电流=%.3fA 比率制动系数=%.3f",dataView.testListdataSource[result.oZDRatio.iIndex-2].testItemParam.Ir,firstZDratio.oZDRatio.Id,rate];
                        dataView.testListdataSource[result.oZDRatio.iIndex-2].itemResult = resultStr2;
                        [dataView reloadTBVIewWithCellIndex:result.oZDRatio.iIndex-2];
                        
                    }
                }
                
            } else {
                resultStr = [NSString stringWithFormat:@"制动电流=%@A,差动电流=%.3fA",dataView.testListdataSource[result.oZDRatio.iIndex-1].testItemParam.Ir,result.oZDRatio.Id];
                dataView.testListdataSource[result.oZDRatio.iIndex-1].itemResult = resultStr;
                [dataView reloadTBVIewWithCellIndex:result.oZDRatio.iIndex-1];
            }
            
        }
            break;
        case DifferTestItemType_SDCurrent:
        {
            resultStr = [NSString stringWithFormat:@"制动电流=%@A,速断电流=%.3fA",dataView.testListdataSource[result.oQdcurrent.iIndex-1].testItemParam.Ir,self.settingView.setDataModel.Isd];
            
            dataView.testListdataSource[result.oQdcurrent.iIndex-1].itemResult = resultStr;
            [dataView reloadTBVIewWithCellIndex:result.oQdcurrent.iIndex-1];
        }
            break;
        case DifferTestItemType_HarmonicRation:
        {
            resultStr = [NSString stringWithFormat:@"差动电流=%@A,Kr=%.3fA",dataView.testListdataSource[result.oHarmnonicRatio.iIndex-1].testItemParam.Id,result.oHarmnonicRatio.K];
            dataView.testListdataSource[result.oHarmnonicRatio.iIndex-1].itemResult = resultStr;
            [dataView reloadTBVIewWithCellIndex:result.oHarmnonicRatio.iIndex-1];
        }
            break;
        case DifferTestItemType_ActionTime:
        {
            resultStr = [NSString stringWithFormat:@"制动电流=%@A,差动电流=%.3fA,动作时间=%.3f",dataView.testListdataSource[result.oActionTime.iIndex-1].testItemParam.Ir,result.oActionTime.fId,result.oActionTime.fTime];
            
            dataView.testListdataSource[result.oActionTime.iIndex-1].itemResult = resultStr;
            [dataView reloadTBVIewWithCellIndex:result.oActionTime.iIndex-1];
        }
            break;
        case DifferTestItemType_Other:
        {
            
        }
            break;
        default:
            break;
    }
}
//构建矢量图数据
-(NSMutableArray *)createVectorData:(NSArray *)headerArr{
    NSMutableArray<NSMutableArray<BD_TestDataParamModel *> *> *vectorDataSource = [[NSMutableArray alloc]init];
    
        for (int i = 0; i<headerArr.count; i++) {
            NSMutableArray *result = [[NSMutableArray alloc]init];
            NSArray *titles = @[@"Ia",@"Ib",@"Ic",@"Ia2",@"Ib2",@"Ic2",@"Vz",@"Ir",@"Id"];
            for (NSString *title in titles) {
                BD_TestDataParamModel *re = [[BD_TestDataParamModel alloc]init];
                re.titleName = title;
                if ([title hasPrefix:@"I"]) {
                    if ([title hasSuffix:@"r"]||[title hasSuffix:@"d"]) {
                        re.unit = @"In";
                    } else {
                        re.unit = @"A";
                    }
                    
                } else if ([title hasPrefix:@"V"]){
                    re.unit = @"V";
                }
                re.amplitude = @"0.000";
                re.phase = @"0.000";
                re.frequency = @"0.000";
                [result addObject:re];
            }
            [vectorDataSource addObject:result];
        }
    return vectorDataSource;
}


-(void)scrollViewToCurrentViewWithIndex:(NSInteger)index{
    self.mainView.contentOffset = CGPointMake(self.mainView.width*index, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    WeakSelf;
    NSInteger index =  scrollView.contentOffset.x/scrollView.width;
    [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
        if ([obj.titleLabel.text isEqualToString:@"特性曲线图"]) {
            if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_ActionTime) {
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateActionTimeChartData];
            } else if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_HarmonicRation){
                ((BD_CharacteristicVC *)weakself.childVCArr[1]).currentTestItem = ((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).currentSelItem;
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateHarmChartData];
                
            } else {
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateQDChartData];
                [((BD_CharacteristicVC *)weakself.childVCArr[1]) updateMarkViewWithTestItemIndex:((BD_DifferTestItemParaVCViewController *)weakself.childVCArr[0]).currentSelItem];
                
            }
        } else if ([obj.titleLabel.text isEqualToString:@"矢量图"]){
            [((BD_VectorDiagramVC *)_childVCArr[2]) updateSubViews];
        }
    }];
}

-(void)startAction{
    //点击start
    /*------------测试生成报告------------------*/
//    [((BD_CharacteristicVC *)self.childVCArr[1]).characterImages addObject:[((BD_CharacteristicVC *)self.childVCArr[1]).view saveToImage]];
//    [((BD_CharacteristicVC *)self.childVCArr[1]).characterImages addObject:[((BD_CharacteristicVC *)self.childVCArr[1]).view saveToImage]];
//    [((BD_CharacteristicVC *)self.childVCArr[1]).characterImages addObject:[((BD_CharacteristicVC *)self.childVCArr[1]).view saveToImage]];
//    [((BD_CharacteristicVC *)self.childVCArr[1]).characterImages addObject:[((BD_CharacteristicVC *)self.childVCArr[1]).view saveToImage]];
//    [self createReportVC];
    /*--------------------------------------*/
    
    [((BD_CharacteristicVC *)self.childVCArr[1]).characterImages removeAllObjects];
    if (!self.startBtn.selected) {

        //获取数据
        //发数据，是否成功
        bool isSuc = [[OCCenter shareCenter]DifferentialTestWithGeneralParam:self.generalSettingView.generalDataParam setParam:self.settingView.setDataModel binarySwitch:self.binarySwitchSetView.binaryData testItem:[((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource copy] outputType:[BD_PMCtrlSingleton shared].deviceType];

        //如果成功，发送start命令开始测试
        if (isSuc) {
            
            self.runMangaer = [[BD_RunLightAnimationManager alloc]initWithView:self.switchView.switchBtnArr[0]];
            
            [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.itemResult = @"";
            }];
            [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]) reloadTBView];
            self.startBtn.selected = YES;
            self.startBtn.userInteractionEnabled = NO;
            self.stopBtn.selected = NO;
            self.stopBtn.userInteractionEnabled = YES;
            [self.naviBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx!=6) {
                    [[BD_Utils shared]setViewState:NO view:obj];
                }
            }];
            self.navigationItem.hidesBackButton = YES;

            int result = [OCCenter.shareCenter start:1];

            NSLog(@"startResult:%d",result);
        }
        //不成功，弹出提示框
        else if (!isSuc){
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
        [self setLightDefault];
        self.stopBtn.selected = YES;
        self.stopBtn.userInteractionEnabled = NO;
        self.startBtn.selected = NO;
        self.startBtn.userInteractionEnabled = YES;
        self.navigationItem.hidesBackButton = NO;
        //停止后，导航栏按钮改为可用
        [self.naviBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[BD_Utils shared]setViewState:YES view:obj];
            
        }];
        int result = [OCCenter.shareCenter stop];
        NSLog(@"stopResult:%d",result);
    }
}



#pragma mark - 懒加载
- (void)generalAndSetData{
    
    // 1.读取plist文件
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_generModelArray == nil) {
            NSDictionary *dic = [FileUtil readInfoFromPlist:@"generalValue.plist"];
            if (dic != nil) {
                NSArray *dictArr = [dic objectForKey:@"generalValue"];
                // 2.创建可变数据用来存放所有组的模型
                _generModelArray = [NSMutableArray arrayWithCapacity:dictArr.count];
                
                for (NSArray *arr in dictArr) {
                    
                    NSMutableArray *arrM = [NSMutableArray array];
                    
                    for (NSDictionary *dict in arr) {
                        
                        GeneralParaModel *peopleList = [GeneralParaModel groupWithDict:dict];
                        
                        [arrM addObject:peopleList];
                    }
                    [_generModelArray addObject:arrM];
                }
            } else {
                NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GeneralValue" ofType:@".plist"]];
                // 2.创建可变数据用来存放所有组的模型
                _generModelArray = [NSMutableArray arrayWithCapacity:dictArr.count];
                
                for (NSArray *arr in dictArr) {
                    
                    NSMutableArray *arrM = [NSMutableArray array];
                    
                    for (NSDictionary *dict in arr) {
                        
                        GeneralParaModel *peopleList = [GeneralParaModel groupWithDict:dict];
                        
                        [arrM addObject:peopleList];
                    }
                    [_generModelArray addObject:arrM];
                }
            }
            [self configGeneralData];
            self.generalSettingView.generModelArray = self.generModelArray;
        }
        
        if (_setModelArray == nil) {
            // 1.读取plist文件
            NSDictionary *dic = [FileUtil readInfoFromPlist:@"settingValue.plist"];
            if (dic != nil) {
                NSArray *dictArr = [dic objectForKey:@"settingValue"];
                // 2.创建可变数据用来存放所有组的模型
                _setModelArray = [NSMutableArray arrayWithCapacity:dictArr.count];
                
                for (NSDictionary *dict in dictArr) {
                    
                    SettingValueModel *peopleList = [SettingValueModel groupWithDict:dict];
                    [_setModelArray addObject:peopleList];
                }
            } else {
                NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SettingValue" ofType:@".plist"]];
                // 2.创建可变数据用来存放所有组的模型
                _setModelArray = [NSMutableArray arrayWithCapacity:dictArr.count];
                
                for (NSDictionary *dict in dictArr) {
                    
                    SettingValueModel *peopleList = [SettingValueModel groupWithDict:dict];
                    [_setModelArray addObject:peopleList];
                }
            }
            
            
            [self configSetData];
            self.settingView.setModelArray = self.setModelArray;
            
        }
       
        
        ((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testItemBaseData = [self caculateIr];
        [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]) createDefaultData];
        
       
        [self setCharacteristicData];
    });
    
}


-(BD_DifferentialGeneralSettingVC *)generalSettingView{
    if (!_generalSettingView) {
        _generalSettingView = [[BD_DifferentialGeneralSettingVC alloc]init];
    }
    return _generalSettingView;
}

-(BD_DifferentialSetParamSettingVC *)settingView{
    if (!_settingView) {
        _settingView = [[BD_DifferentialSetParamSettingVC alloc]init];
    }
    return _settingView;
}

-(BD_DifferentialTemplateFileManager *)templateManager{
    if (!_templateManager) {
        _templateManager = [[BD_DifferentialTemplateFileManager alloc]init];
    }
    return _templateManager;
}



//初始化特性曲线数据
-(void)setCharacteristicData{
    ((BD_CharacteristicVC *)_childVCArr[1]).setData = self.settingView.setDataModel;
    NSMutableArray *testParams = [[NSMutableArray alloc]init];
    [((BD_DifferTestItemParaVCViewController *)_childVCArr[0]).testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [testParams addObject:obj.testItemParam];
    }];
    ((BD_CharacteristicVC *)_childVCArr[1]).testItemArr = [testParams copy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [((BD_CharacteristicVC *)_childVCArr[1]) configLineChart];
    });
}

#pragma mark - 通用参数 页面数组转换为模型数据
-(void)configGeneralData{
    
    NSArray<NSArray<GeneralParaModel *> *> *generaArr = self.generModelArray;
    self.generalDataParam = [[BD_DifferGeneralSetDataModel alloc]init];
    if ([generaArr[1][3].param isEqualToString:@"自动计算"]) {
        self.generalDataParam.BalanceParaCacuType = @"0";
    } else if ([generaArr[1][3].param isEqualToString:@"手动计算并输入"]){
        self.generalDataParam.BalanceParaCacuType = @"1";
    }
    
    if ([generaArr[2][0].param isEqualToString:@"Y"]) {
        self.generalDataParam.WindH = @"1";
    } else {
        self.generalDataParam.WindH = @"0";
    }
    
    if ([generaArr[2][1].param isEqualToString:@"Y"]) {
        self.generalDataParam.WindM = @"1";
    } else {
        self.generalDataParam.WindM = @"0";
    }
    if ([generaArr[2][2].param isEqualToString:@"Y"]) {
        self.generalDataParam.WindL = @"1";
    } else {
        self.generalDataParam.WindL = @"0";
    }
    
    if ([generaArr[2][3].param isEqualToString:@"无校正"]){
        self.generalDataParam.AngleMode = @"0";
    } else if ([generaArr[2][3].param isEqualToString:@"Y侧校正"]){
        self.generalDataParam.AngleMode = @"1";
    } else if ([generaArr[2][3].param isEqualToString:@"▲侧校正"]){
        self.generalDataParam.AngleMode = @"2";
    }
    
    if ([generaArr[2][4].param isEqualToString:@"高-低"]) {
        self.generalDataParam.WindSide = @"0";
    }else if ([generaArr[2][4].param isEqualToString:@"高-中"]){
        self.generalDataParam.WindSide = @"1";
    } else if ([generaArr[2][4].param isEqualToString:@"中-低"]){
        self.generalDataParam.WindSide = @"2";
    }
    
    if ([generaArr[2][5].param isEqualToString:@"1点"]) {
        self.generalDataParam.ConnMode = @"1";
    } else if ([generaArr[2][5].param isEqualToString:@"2点"]){
        self.generalDataParam.ConnMode = @"2";
    }else if ([generaArr[2][5].param isEqualToString:@"3点"]){
        self.generalDataParam.ConnMode = @"3";
    }else if ([generaArr[2][5].param isEqualToString:@"4点"]){
        self.generalDataParam.ConnMode = @"4";
    }else if ([generaArr[2][5].param isEqualToString:@"5点"]){
        self.generalDataParam.ConnMode = @"5";
    }else if ([generaArr[2][5].param isEqualToString:@"6点"]){
        self.generalDataParam.ConnMode = @"6";
    }else if ([generaArr[2][5].param isEqualToString:@"7点"]){
        self.generalDataParam.ConnMode = @"7";
    }else if ([generaArr[2][5].param isEqualToString:@"8点"]){
        self.generalDataParam.ConnMode = @"8";
    }else if ([generaArr[2][5].param isEqualToString:@"9点"]){
        self.generalDataParam.ConnMode = @"9";
    }else if ([generaArr[2][5].param isEqualToString:@"10点"]){
        self.generalDataParam.ConnMode = @"10";
    }else if ([generaArr[2][5].param isEqualToString:@"11点"]){
        self.generalDataParam.ConnMode = @"11";
    }else if ([generaArr[2][5].param isEqualToString:@"12点"]){
        self.generalDataParam.ConnMode = @"0";
    }
    
    if ([generaArr[2][6].param isEqualToString:@"不考虑绕组接线型式"]) {
        self.generalDataParam.JXFactor = @"0";
    } else if ([generaArr[2][6].param isEqualToString:@"考虑绕组接线型式"]) {
        self.generalDataParam.JXFactor = @"1";
    }
    
    if ([generaArr[2][7].param isEqualToString:@"二分法"]) {
        self.generalDataParam.SerachMode = @"0";
    } else if([generaArr[2][7].param isEqualToString:@"单步逼近"]){
        self.generalDataParam.SerachMode = @"1";
    }
    
    if ([generaArr[2][8].param isEqualToString:@"两侧指向变压器"]) {
        self.generalDataParam.IdEqu = @"0";
    } else if ([generaArr[2][8].param isEqualToString:@"一侧指向变压器"]) {
        self.generalDataParam.IdEqu = @"1";
    }
    NSArray *a = @[@"Ir=(|I1-I2|)/K1或Ir=(|I1+I2|)/K1",@"Ir=(|I1|+|I2|*K2)/K1",@"Ir=max(|I1|,|I2|)",@"Ir=(|Id-|I1|-|I2||)/K1",@"Ir=|I2|",@"Sqrt(K1*I1*I2*Cos(&))"];
    for (int i = 0; i<a.count; i++) {
        //制动方程
        if ([generaArr[2][9].param isEqualToString:a[i]]) {
            self.generalDataParam.Equation = [NSString stringWithFormat:@"%d",i];
        }
    }
    
    
    
    if ([generaArr[2][12].param isEqualToString:@"A"]) {
        self.generalDataParam.Phase_Type = @"0";
    } else if ([generaArr[2][12].param isEqualToString:@"B"]){
        self.generalDataParam.Phase_Type = @"1";
    }else if ([generaArr[2][12].param isEqualToString:@"C"]){
        self.generalDataParam.Phase_Type = @"2";
    }else if ([generaArr[2][12].param isEqualToString:@"ABC"]){
        self.generalDataParam.Phase_Type = @"3";
    }
    
    self.generalDataParam.ED_V = generaArr[0][0].param;
    self.generalDataParam.ED_I = generaArr[0][1].param;
    self.generalDataParam.ED_Hz = generaArr[0][2].param;
    
    self.generalDataParam.PreTime = generaArr[1][0].param;
    self.generalDataParam.PrefaultTime = generaArr[1][1].param;
    self.generalDataParam.FaultTime = generaArr[1][2].param;
    
    self.generalDataParam.SN = generaArr[1][4].param;
    self.generalDataParam.Uh = generaArr[1][5].param;
    self.generalDataParam.Um = generaArr[1][6].param;
    self.generalDataParam.Ul = generaArr[1][7].param;
    self.generalDataParam.CTPh = generaArr[1][8].param;
    self.generalDataParam.CTPm = generaArr[1][9].param;
    self.generalDataParam.CTPl = generaArr[1][10].param;
    self.generalDataParam.CTSh = generaArr[1][11].param;
    self.generalDataParam.CTSm = generaArr[1][12].param;
    self.generalDataParam.CTSl = generaArr[1][13].param;
    self.generalDataParam.Kph = generaArr[1][14].param;
    self.generalDataParam.Kpm = generaArr[1][15].param;
    self.generalDataParam.Kpl = generaArr[1][16].param;
    
    
    
    self.generalDataParam.K1 = generaArr[2][10].param;
    self.generalDataParam.K2 = generaArr[2][11].param;
    
    self.generalDataParam.Reso = generaArr[2][13].param;
    self.generalDataParam.Ugroup1 = generaArr[2][14].param;
    self.generalDataParam.Ugroup2 = generaArr[2][15].param;
    self.generalSettingView.generalDataParam = self.generalDataParam;
   
  
}
#pragma mark - 通用参数 模型数组转换为页面数据
-(void)updateGeneralViewData{
    NSArray<NSArray<GeneralParaModel *> *> *generaArr = self.generModelArray;
    if ([self.generalDataParam.BalanceParaCacuType isEqualToString:@"0"]) {
        generaArr[1][3].param = @"自动计算";
    } else if ([self.generalDataParam.BalanceParaCacuType isEqualToString:@"1"]){
        generaArr[1][3].param = @"手动计算并输入";
    }
    if ([self.generalDataParam.WindH isEqualToString:@"1"]) {
        generaArr[2][0].param = @"Y";
    } else {
        generaArr[2][0].param = @"▲";
    }
    if ([self.generalDataParam.WindM isEqualToString:@"1"]) {
        generaArr[2][1].param = @"Y";
    } else {
        generaArr[2][1].param = @"▲";
    }
    if ([self.generalDataParam.WindL isEqualToString:@"1"]) {
        generaArr[2][2].param = @"Y";
    } else {
        generaArr[2][2].param = @"▲";
    }
    
    if ([self.generalDataParam.AngleMode isEqualToString:@"0"]){
        generaArr[2][3].param = @"无校正";
    } else if ([self.generalDataParam.AngleMode isEqualToString:@"1"]){
        generaArr[2][3].param = @"Y侧校正";
    } else if ([self.generalDataParam.AngleMode isEqualToString:@"2"]){
        generaArr[2][3].param = @"▲侧校正";
    }
    
    if ([self.generalDataParam.WindSide isEqualToString:@"0"]) {
        generaArr[2][4].param = @"高-低";
    } else if ([self.generalDataParam.WindSide isEqualToString:@"1"]){
        generaArr[2][4].param = @"高-中";
    } else{
        generaArr[2][4].param = @"中-低";
    }
    switch ([self.generalDataParam.ConnMode intValue]) {
        case 0:
            generaArr[2][5].param = @"12点";
            break;
        case 1:
            generaArr[2][5].param = @"1点";
            break;
        case 2:
            generaArr[2][5].param = @"2点";
            break;
        case 3:
            generaArr[2][5].param = @"3点";
            break;
        case 4:
            generaArr[2][5].param = @"4点";
            break;
        case 5:
            generaArr[2][5].param = @"5点";
            break;
        case 6:
            generaArr[2][5].param = @"6点";
            break;
        case 7:
            generaArr[2][5].param = @"7点";
            break;
        case 8:
            generaArr[2][5].param = @"8点";
            break;
        case 9:
            generaArr[2][5].param = @"9点";
            break;
        case 10:
            generaArr[2][5].param = @"10点";
            break;
        case 11:
            generaArr[2][5].param = @"11点";
            break;
        default:
            break;
    }
    switch ([self.generalDataParam.JXFactor intValue]) {
        case 0:
            generaArr[2][6].param = @"不考虑绕组接线型式";
            break;
        case 1:
            generaArr[2][6].param = @"考虑绕组接线型式";
            break;
        default:
            break;
    }
    
    switch ([self.generalDataParam.SerachMode intValue]) {
        case 0:
            generaArr[2][7].param = @"二分法";
            break;
        case 1:
            generaArr[2][7].param = @"单步逼近";
            break;
        default:
            break;
    }
    
    switch ([self.generalDataParam.IdEqu intValue]) {
        case 0:
            generaArr[2][8].param = @"两侧指向变压器";
            break;
        case 1:
            generaArr[2][8].param = @"一侧指向变压器";
            break;
        default:
            break;
    }
    
    switch ([self.generalDataParam.Equation intValue]) {
        case 0:
            generaArr[2][9].param = @"Ir=(|I1-I2|)/K1或Ir=(|I1+I2|)/K1";
            break;
        case 1:
            generaArr[2][9].param = @"Ir=(|I1|+|I2|*K2)/K1";
            break;
        case 2:
            generaArr[2][9].param = @"Ir=max(|I1|,|I2|)";
            break;
        case 3:
            generaArr[2][9].param = @"Ir=(|Id-|I1|-|I2||)/K1";
            break;
        case 4:
            generaArr[2][9].param = @"Ir=|I2|";
            break;
        case 5:
            generaArr[2][9].param = @"Sqrt(K1*I1*I2*Cos(δ))";
            break;
        default:
            break;
    }
    
    
    switch ([self.generalDataParam.Phase_Type intValue]) {
        case 0:
            generaArr[2][12].param = @"A";
            break;
        case 1:
            generaArr[2][12].param = @"B";
            break;
        case 2:
            generaArr[2][12].param = @"C";
            break;
        case 3:
            generaArr[2][12].param = @"ABC";
            break;
        default:
            break;
    }
    
    generaArr[0][0].param = self.generalDataParam.ED_V;
    generaArr[0][1].param = self.generalDataParam.ED_I;
    generaArr[0][2].param = self.generalDataParam.ED_Hz;
    
    generaArr[1][0].param = self.generalDataParam.PreTime;
    generaArr[1][1].param = self.generalDataParam.PrefaultTime;
    generaArr[1][2].param = self.generalDataParam.FaultTime;
    
    generaArr[1][4].param = self.generalDataParam.SN;
    generaArr[1][5].param = self.generalDataParam.Uh;
    generaArr[1][6].param = self.generalDataParam.Um;
    generaArr[1][7].param = self.generalDataParam.Ul;
    generaArr[1][8].param = self.generalDataParam.CTPh;
    generaArr[1][9].param = self.generalDataParam.CTPm;
    generaArr[1][10].param = self.generalDataParam.CTPl;
    generaArr[1][11].param = self.generalDataParam.CTSh;
    generaArr[1][12].param = self.generalDataParam.CTSm;
    generaArr[1][13].param = self.generalDataParam.CTSl;
    generaArr[1][14].param = self.generalDataParam.Kph;
    generaArr[1][15].param = self.generalDataParam.Kpm;
    generaArr[1][16].param = self.generalDataParam.Kpl;
    
    
    
    generaArr[2][10].param = self.generalDataParam.K1;
    generaArr[2][11].param = self.generalDataParam.K2;
    
    generaArr[2][13].param = self.generalDataParam.Reso;
    generaArr[2][14].param = self.generalDataParam.Ugroup1;
    generaArr[2][15].param = self.generalDataParam.Ugroup2;
    
}

#pragma mark - 整定值 页面数组转换为模型数组

-(void)configSetData{
    
    NSArray<SettingValueModel *> *setBackModelArr = self.setModelArray;
    self.setDataModel = [[BD_DifferSetDataModel alloc]init];
    if ([setBackModelArr[0].val isEqualToString:@"有名值"]) {
        self.setDataModel.Axis = 0;
    } else if ([setBackModelArr[0].val isEqualToString:@"标幺值"]) {
        self.setDataModel.Axis = 1;
    }
    
    if ([setBackModelArr[1].val isEqualToString:@"高侧额定二次电流"]) {
        self.setDataModel.Insel = 0;
    } else if ([setBackModelArr[1].val isEqualToString:@"其它"]) {
        self.setDataModel.Insel = 1;
    }
    
    if ([setBackModelArr[5].val isEqualToString:@"一个拐点"]) {
        self.setDataModel.KneePoint = 1;
    } else if ([setBackModelArr[5].val isEqualToString:@"两个拐点"]) {
        self.setDataModel.KneePoint = 2;
    } else if ([setBackModelArr[5].val isEqualToString:@"三个拐点"]){
        self.setDataModel.KneePoint = 3;
    }
    
    
    self.setDataModel.Inom = [setBackModelArr[2].val floatValue];
    self.setDataModel.Isd = [setBackModelArr[3].val floatValue];
    self.setDataModel.Icdqd = [setBackModelArr[4].val floatValue];
    
    self.setDataModel.Ip1 = [setBackModelArr[6].val floatValue];
    self.setDataModel.Ip2 = [setBackModelArr[7].val floatValue];
    self.setDataModel.Ip3 = [setBackModelArr[8].val floatValue];
    self.setDataModel.Kid1 = [setBackModelArr[9].val floatValue];
    self.setDataModel.Kid2 = [setBackModelArr[10].val floatValue];
    self.setDataModel.Kid3 = [setBackModelArr[11].val floatValue];
    self.setDataModel.Kid4 = [setBackModelArr[12].val floatValue];
    self.setDataModel.Kxb2 = [setBackModelArr[13].val floatValue];
    self.setDataModel.Kxb3 = [setBackModelArr[14].val floatValue];
    self.setDataModel.Kxb5 = [setBackModelArr[15].val floatValue];
    
    
    self.settingView.setDataModel = self.setDataModel;
    [BD_DifferIrCaculateManager shared].setData = self.settingView.setDataModel;
}

#pragma mark - 整定值 模型数据转换为页面数据
-(void)updateSetViewData{
   
    switch (self.setDataModel.Axis) {
        case 0:
            ((SettingValueModel *)self.setModelArray[0]).val = @"有名值";
            break;
        case 1:
            ((SettingValueModel *)self.setModelArray[0]).val = @"标幺值";
            break;
        default:
            break;
    }
    switch (self.setDataModel.Insel) {
        case 0:
            ((SettingValueModel *)self.setModelArray[1]).val = @"高侧额定二次电流";
            break;
        case 1:
            ((SettingValueModel *)self.setModelArray[1]).val = @"其它";
            break;
        default:
            break;
    }
   
    switch (self.setDataModel.KneePoint) {
        case 1:
             ((SettingValueModel *)self.setModelArray[5]).val = @"一个拐点";
            break;
        case 2:
            ((SettingValueModel *)self.setModelArray[5]).val = @"两个拐点";
            break;
        case 3:
            ((SettingValueModel *)self.setModelArray[5]).val = @"三个拐点";
            break;
            
        default:
            break;
    }
    ((SettingValueModel *)self.setModelArray[2]).val = kTStrings(self.setDataModel.Inom);
    ((SettingValueModel *)self.setModelArray[3]).val = kTStrings(self.setDataModel.Isd);
    ((SettingValueModel *)self.setModelArray[4]).val = kTStrings(self.setDataModel.Icdqd);
    
    ((SettingValueModel *)self.setModelArray[6]).val = kTStrings(self.setDataModel.Ip1);
    ((SettingValueModel *)self.setModelArray[7]).val = kTStrings(self.setDataModel.Ip2);
    ((SettingValueModel *)self.setModelArray[8]).val = kTStrings(self.setDataModel.Ip3);
    ((SettingValueModel *)self.setModelArray[9]).val = kTStrings(self.setDataModel.Kid1);
    ((SettingValueModel *)self.setModelArray[10]).val = kTStrings(self.setDataModel.Kid2);
    ((SettingValueModel *)self.setModelArray[11]).val = kTStrings(self.setDataModel.Kid3);
    ((SettingValueModel *)self.setModelArray[12]).val = kTStrings(self.setDataModel.Kid4);
    ((SettingValueModel *)self.setModelArray[13]).val = kTStrings(self.setDataModel.Kxb2);
    ((SettingValueModel *)self.setModelArray[14]).val = kTStrings(self.setDataModel.Kxb3);
    ((SettingValueModel *)self.setModelArray[15]).val = kTStrings(self.setDataModel.Kxb5);
    
}
-(void)getDeviceInfoToChangeViewData{
    WeakSelf;//因为是block中的方法，使用弱引用
    [super getDeviceInfoToChangeViewData];
    [kNotificationCenter postNotificationName:BD_OutPutLimitNotifi object:self.hardWareView.viewModel];
   
}
//计算制动电流
-(BD_DifferBaseDataModel *)caculateIr{
    BD_DifferBaseDataModel *result = [[BD_DifferBaseDataModel alloc]init];

    BD_DifferSetDataModel *setData = self.settingView.setDataModel;
    
    result.m_QDIr = 0.5*setData.Ip1;
    if (setData.KneePoint == 1) {
        result.m_ZD1Ir = setData.Ip1*0.1;
        result.m_ZD1_2Ir = setData.Ip1*0.2;
        float fy1 = setData.Icdqd+(setData.Ip1*setData.Kid1);   //第一个拐点的Y坐标
        result.m_ZD2Ir = setData.Ip1+((setData.Isd-fy1)/setData.Kid2)*0.1;
        result.m_ZD2_2Ir = setData.Ip1+((setData.Isd-fy1)/setData.Kid2)*0.2;
        result.m_SDIr = 1.05*((setData.Isd-fy1)/setData.Kid2+setData.Ip1);
    } else if(setData.KneePoint == 2) {
        result.m_ZD1Ir = setData.Ip1*0.1;
        result.m_ZD1_2Ir = setData.Ip1*0.2;
        float fy1 = setData.Icdqd+(setData.Ip1*setData.Kid1);   //第一个拐点的Y坐标
        float fy2 = fy1+ (setData.Ip2-setData.Ip1)*setData.Kid2; //第二个拐点的Y坐标
        result.m_ZD2Ir = setData.Ip1+((fy2-fy1)/setData.Kid2)*0.1;
        result.m_ZD2_2Ir = setData.Ip1+((fy2-fy1)/setData.Kid2)*0.2;
        result.m_ZD3Ir = setData.Ip2+((setData.Isd-fy2)/setData.Kid3)*0.1;
        result.m_ZD3_2Ir = setData.Ip2+((setData.Isd-fy2)/setData.Kid3)*0.2;
        result.m_SDIr = 1.05*((setData.Isd-fy2)/setData.Kid3+setData.Ip2);
    } else if (setData.KneePoint == 3){
        result.m_ZD1Ir = setData.Ip1*0.1;
        result.m_ZD1_2Ir = setData.Ip1*0.2;
        float fy1 = setData.Icdqd+(setData.Ip1*setData.Kid1);   //第一个拐点的Y坐标
        float fy2 = fy1+ (setData.Ip2-setData.Ip1)*setData.Kid2; //第二个拐点的Y坐标
        result.m_ZD2Ir = setData.Ip1+((fy2-fy1)/setData.Kid2)*0.1;
        result.m_ZD2_2Ir = setData.Ip1+((fy2-fy1)/setData.Kid2)*0.2;
        float fy3 = fy2 + (setData.Ip3-setData.Ip2)*setData.Kid3;
        result.m_ZD3Ir = setData.Ip2+((fy3-fy2)/setData.Kid3)*0.1;
        result.m_ZD3_2Ir = setData.Ip2+((fy3-fy2)/setData.Kid3)*0.2;
        
        
        result.m_ZD4Ir = setData.Ip3+((setData.Isd-fy3)/setData.Kid4)*0.1;
        result.m_ZD4_2Ir = setData.Ip3+((setData.Isd-fy3)/setData.Kid4)*0.2;
        
        float xIsd = setData.Ip3+(setData.Isd-fy3)/setData.Kid4;
        result.m_SDIr = 1.05*xIsd;
    }
    
    result.m_HarmId = 2.0*setData.Icdqd;
    
    result.m_ActionId = 5;
    result.m_ActionIr = 1;
    result.testPhasorType = self.generalSettingView.generalDataParam.Phase_Type;
    result.frequency = [self.generalSettingView.generalDataParam.ED_Hz floatValue];
    result.testAccuracy = [self.generalSettingView.generalDataParam.Reso floatValue];
    return result;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"assessmentError"]) {
        CGFloat assessement = [((BD_DifferTestItemParaVCViewController *)self.childVCArr[0]).assessmentError floatValue]/100.00;
        [((BD_CharacteristicVC *)self.childVCArr[1]) changeErrorRate:1-assessement upRate:1+assessement];
        if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_ActionTime) {
            [((BD_CharacteristicVC *)self.childVCArr[1]) updateActionTimeChartData];
        } else if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_HarmonicRation){
            ((BD_CharacteristicVC *)self.childVCArr[1]).currentTestItem = ((BD_DifferTestItemParaVCViewController *)self.childVCArr[0]).currentSelItem;
            [((BD_CharacteristicVC *)self.childVCArr[1]) updateHarmChartData];
        } else {
            [((BD_CharacteristicVC *)self.childVCArr[1]) updateQDChartData];
            [((BD_CharacteristicVC *)self.childVCArr[1]) updateMarkViewWithTestItemIndex:((BD_DifferTestItemParaVCViewController *)self.childVCArr[0]).currentSelItem];
            
        }
        
    }
    
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_DifferTestResultNoti object:nil];
    [kNotificationCenter removeObserver:self name:BD_ReadDeviceInfoNoti object:nil];
    [((BD_DifferTestItemParaVCViewController *)self.childVCArr[0]) removeObserver:self forKeyPath:@"assessmentError" context:nil];
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
