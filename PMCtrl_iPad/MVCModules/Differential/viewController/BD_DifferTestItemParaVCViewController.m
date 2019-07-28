//
//  BD_DifferTestItemParaVCViewController.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferTestItemParaVCViewController.h"

#import "BD_ActionListView.h"
#import "BD_DifferTestItemListCell.h"
#import "BD_DifferTestItemHeaderView.h"
#import "BD_DifferentialTestItemModel.h"
#import "BD_TestItemParamView.h"
#import "BD_DifferTestAssessmentView.h"
#import "BD_DifferGooseSendView.h"
#import "BD_DifferBaseDataModel.h"
#import "BD_DifferIrCaculateManager.h"
#import "BD_DifferSetDataModel.h"
#import "BD_DifferTestItemParaVCViewController+BD_DifferParamActionList.h"
#import "UIImage+Extension.h"
#import "BD_DifferAddSeriesView.h"
@interface BD_DifferTestItemParaVCViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL isGOOSESendBtn;
    NSInteger addAtIndex;
}
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UITableView *testListTBView;
@property (weak, nonatomic) IBOutlet UIScrollView *testItemParaView;

@property (weak, nonatomic) IBOutlet UIButton *testParamBtn;
@property (weak, nonatomic) IBOutlet UIButton *testResultBtn;
@property (weak, nonatomic) IBOutlet UIButton *gooseSendBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *paramSegmentControl;

@property(nonatomic,strong)BD_TestItemParamView *itemParamView;
@property(nonatomic,strong)BD_DifferTestAssessmentView *assessmentView;
@property(nonatomic,strong)BD_DifferGooseSendView *gooseSendView;


@end

@implementation BD_DifferTestItemParaVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testItemParaView.scrollEnabled = NO;
    self.testItemParaView.showsHorizontalScrollIndicator = NO;
    
    [self loadSubViews];
    self.view.backgroundColor = ClearColor;
  
    [self.testParamBtn setBackgroundImage:[UIImage imageWithColor:ClearColor width:self.testParamBtn.width height:self.testParamBtn.height title:@""] forState:UIControlStateNormal];
    [self.testParamBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor] width:self.testParamBtn.width height:self.testParamBtn.height title:@""] forState:UIControlStateSelected];
    [self.testResultBtn setBackgroundImage:[UIImage imageWithColor:ClearColor width:self.testResultBtn.width height:self.testResultBtn.height title:@""] forState:UIControlStateNormal];
    [self.testResultBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor] width:self.testResultBtn.width height:self.testResultBtn.height title:@""] forState:UIControlStateSelected];
    [self.gooseSendBtn setBackgroundImage:[UIImage imageWithColor:ClearColor width:self.gooseSendBtn.width height:self.gooseSendBtn.height title:@""] forState:UIControlStateNormal];
    [self.gooseSendBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor] width:self.gooseSendBtn.width height:self.gooseSendBtn.height title:@""] forState:UIControlStateSelected];
    [self.testParamBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    [self.testResultBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    [self.gooseSendBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    
    _assessmentError = @"5.000";
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillLayoutSubviews{
    _itemParamView.frame = CGRectMake(0, 0, self.testItemParaView.width, self.testItemParaView.height);
    _assessmentView.frame = CGRectMake(self.testItemParaView.width, 0, self.testItemParaView.width, self.testItemParaView.height);
    _gooseSendView.frame = CGRectMake(self.testItemParaView.width*2, 0, self.testItemParaView.width, self.testItemParaView.height);
    self.testItemParaView.contentSize = CGSizeMake(3*self.testItemParaView.width, self.testItemParaView.height);
}
-(void)loadSubViews{
  
    BD_ActionListView *actionView = [[BD_ActionListView alloc]initWithTitles:@[@"清除结果",@"全部清除",@"添加",@"添加系列",@"删除",@"删除N-1"]];
    [_actionView addSubview:actionView];
    
    [actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    __weak typeof(self) wealself = self;
    actionView.actionIndexBlock = ^(NSInteger actionIndex) {
        [wealself actionTotestItemListWithActionIndex:actionIndex];
    };
    
    _testListTBView.delegate = self;
    _testListTBView.dataSource = self;
    _testListTBView.backgroundColor = ClearColor;
    _testListTBView.bounces = NO;
    [_testListTBView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_DifferTestItemListCell class]) bundle:nil] forCellReuseIdentifier:@"BD_DifferTestItemListCellID"];
    [_testListTBView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_DifferTestItemHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:@"BD_DifferTestItemHeaderViewID"];

    _itemParamView = [[BD_TestItemParamView alloc]initWithFrame:CGRectZero];
    WeakSelf;
    
    //修改谐波次数后，修改测试项名称
    _itemParamView.changeHarmNumBlock = ^{
        weakself.testListdataSource[weakself.currentSelItem].itemName = weakself.testListdataSource[weakself.currentSelItem].testItemParam.itemName;
        [weakself.testListTBView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakself.currentSelItem inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [weakself.testListTBView selectRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.currentSelItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    };
    [self.testItemParaView addSubview:_itemParamView];
    
    _assessmentView = [[BD_DifferTestAssessmentView alloc]initWithFrame:CGRectZero];
    _assessmentView.QDerrorValueChangedBlock = ^(NSString *qderror) {
        weakself.assessmentError = qderror;
    };
    [self.testItemParaView addSubview:_assessmentView];
    _gooseSendView = [[BD_DifferGooseSendView alloc]initWithFrame:CGRectZero];
    _gooseSendView.groupNum = 2;
    [_gooseSendView loadSubViews];
    [self.testItemParaView addSubview:_gooseSendView];
    
    BD_DifferAddSeriesView *seriesView = [[BD_DifferAddSeriesView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
   
    self.addSeriesView = seriesView;
    
}

-(void)testListdefaultState{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_testListdataSource &&_testListdataSource.count!=0) {
            [_testListTBView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            
            [self.itemParamView setDataToQDCurrentView:_testListdataSource[0].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:0];
           [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[0].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_QDCurrent];
            [self.assessmentView testItemAssessmenViewWithIndex:0];
            
            _currentSelItem = 0;
        }
    });
    [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_QDCurrent;
   
}
#pragma mark - 懒加载
-(NSMutableArray<BD_DifferentialTestItemModel *> *)testListdataSource{
    if(!_testListdataSource){
        _testListdataSource = [[NSMutableArray alloc]init];
    }
    return _testListdataSource;
}

-(BD_DifferBaseDataModel *)testItemBaseData{
    if (!_testItemBaseData) {
        _testItemBaseData = [[BD_DifferBaseDataModel alloc]init];
    }
    return _testItemBaseData;
}


#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testListdataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BD_DifferTestItemHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferTestItemHeaderView class]) owner:nil options:nil].lastObject;
    headerView.backgroundColor = BDThemeColor_Light;
    headerView.testItemNum.text = @"编号";
    headerView.testItemName.text = @"试验列表";
    headerView.testItemSelect.text = @"选择";
    headerView.testItemResult.text = @"试验结果";
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_DifferTestItemListCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"BD_DifferTestItemListCellID" forIndexPath:indexPath];
    itemCell.cellIndex = indexPath.row;
    itemCell.testItemNum.text = [NSString stringWithFormat:@"%ld",_testListdataSource[indexPath.row].itemNum];
    itemCell.testItemName.text = _testListdataSource[indexPath.row].itemName;
    
    itemCell.testItemResult.text = _testListdataSource[indexPath.row].itemResult;
    
   
    __weak typeof (self)weakself = self;
    if ([itemCell.testItemName.text isEqualToString: @"比率制动系数一"]) {
        if ([BD_DifferIrCaculateManager shared].setData.Kid1 == 0) {
            self.testListdataSource[indexPath.row].itemSelect = NO;
        } else {
             self.testListdataSource[indexPath.row].itemSelect = YES;
        }
    }
    itemCell.testItemIsSelect.selected = _testListdataSource[indexPath.row].itemSelect;
    [itemCell setSeleState];
    
    itemCell.isSelectedItemBlock = ^(NSInteger cellIndex, BOOL state) {
        weakself.testListdataSource[cellIndex].itemSelect = state;
    };

    return itemCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *itemName = _testListdataSource[indexPath.row].itemName;
   
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([itemName rangeOfString:@"谐波"].location!=NSNotFound) {
            [self.itemParamView setDataToHarmView:_testListdataSource[indexPath.row].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:1];
            _testListdataSource[indexPath.row].testItemAssessment.IdValue = [_testListdataSource[indexPath.row].testItemParam.Id floatValue];
            [self.assessmentView setDataToHarmAssessmentViewWithData:_testListdataSource[indexPath.row].testItemAssessment];
            [self.assessmentView testItemAssessmenViewWithIndex:1];
             [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_HarmonicRation;
        } else if ([itemName rangeOfString:@"动作时间"].location != NSNotFound){
            [self.itemParamView setDataToActionView:_testListdataSource[indexPath.row].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:2];
             _testListdataSource[indexPath.row].testItemAssessment.IdValue = [_testListdataSource[indexPath.row].testItemParam.Id floatValue];
             _testListdataSource[indexPath.row].testItemAssessment.IrValue = [_testListdataSource[indexPath.row].testItemParam.Ir floatValue];
            [self.assessmentView setDataToActionTimeAssessmentViewWithData:_testListdataSource[indexPath.row].testItemAssessment];
            [self.assessmentView testItemAssessmenViewWithIndex:2];
             [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_ActionTime;
        } else {
            [self.itemParamView setDataToQDCurrentView:_testListdataSource[indexPath.row].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:0];
            
            if (_testListdataSource[indexPath.row].testItemParam.itemType == DifferTestItemType_QDCurrent) {
               [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[indexPath.row].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_QDCurrent];
            } else if (_testListdataSource[indexPath.row].testItemParam.itemType == DifferTestItemType_SDCurrent){
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[indexPath.row].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_SDCurrent];
            } else if (_testListdataSource[indexPath.row].testItemParam.itemType == DifferTestItemType_ZDRatio) {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[indexPath.row].testItemParam.Ir Id_QD_SD:kTStrings(_testListdataSource[indexPath.row].testItemAssessment.IdValue) rate:@"0.000" rateLabel:_testListdataSource[indexPath.row].itemName itemType:DifferTestItemType_ZDRatio];
            } else {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[indexPath.row].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_Characteristic];
            }
            
            [self.assessmentView testItemAssessmenViewWithIndex:0];
             [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_QDCurrent;
        }
        _currentSelItem = indexPath.row;
       
    });
    
   
}
#pragma mark - 动作列表方法
-(void)actionTotestItemListWithActionIndex:(NSInteger)index{
   //0-清除结果 1-全部清除 2-添加  3-添加系列 4-删除 5-删除N-1
    NSLog(@"actionIndex:%ld",index);
    switch (index) {
        case 0:
            [self clearResult];
            break;
        case 1:
            [self allClear];
            break;
        case 2:
            [self addTestItem];
            break;
        case 3:
            [self addTestItemSeries];
            break;
        case 4:
            [self deleteTestItem];
            break;
        case 5:
            [self deleteNtestItem];
            if (self.listDataSourceChangedBlock) {
                self.listDataSourceChangedBlock();
            }
            break;
        default:
            break;
    }
    [self.testListTBView reloadData];
    [self.testListTBView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}


-(void)createDefaultData{
    
    BD_DifferentialTestItemParaModel *param1 =[[BD_DifferentialTestItemParaModel alloc]init];
    param1.itemName = DifferTestItemNames[0];
    param1.itemType = DifferTestItemType_QDCurrent;
    param1.iIndex=@"1";
    param1.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_QDIr];
    param1.fUp=@"0";
    param1.fDown=@"1";
    param1.testPhasorType=self.testItemBaseData.testPhasorType;
    param1.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param1.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];

    BD_DifferAssessmentModel *assment1 = [[BD_DifferAssessmentModel alloc]init];
    assment1.IrValue = [param1.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem1 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:1 itemName:DifferTestItemNames[0] itemSelect:YES itemResult:@"" testItemParam:param1 testItemAssessment:assment1];
    
    BD_DifferentialTestItemParaModel *param2 =[[BD_DifferentialTestItemParaModel alloc]init];
    param2.itemName = DifferTestItemNames[1];
    param2.itemType = DifferTestItemType_ZDRatio;
    param2.iIndex=@"2";
    param2.iTypeIndex = @"1";
    param2.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD1Ir];
    param2.fUp=@"0";
    param2.fDown=@"1";
    param2.testPhasorType=self.testItemBaseData.testPhasorType;
    param2.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param2.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    
    BD_DifferAssessmentModel *assment2 = [[BD_DifferAssessmentModel alloc]init];
    assment2.IrValue = [param2.Ir floatValue];
    BD_DifferentialTestItemModel *testItem2 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:2 itemName:DifferTestItemNames[1] itemSelect:NO itemResult:@"" testItemParam:param2 testItemAssessment:assment2];
    
    BD_DifferentialTestItemParaModel *param3 =[[BD_DifferentialTestItemParaModel alloc]init];
    param3.itemName = DifferTestItemNames[2];
    param3.itemType = DifferTestItemType_ZDRatio;
    param3.iIndex=@"3";
    param3.iTypeIndex = @"1";
    param3.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD1_2Ir];
    param3.fUp=@"0";
    param3.fDown=@"1";
    param3.testPhasorType=self.testItemBaseData.testPhasorType;
    param3.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param3.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    
    BD_DifferAssessmentModel *assment3 = [[BD_DifferAssessmentModel alloc]init];
    assment3.IrValue = [param3.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem3 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:3 itemName:DifferTestItemNames[2] itemSelect:NO itemResult:@"" testItemParam:param3 testItemAssessment:assment3];
    
    BD_DifferentialTestItemParaModel *param4 =[[BD_DifferentialTestItemParaModel alloc]init];
    param4.itemName = DifferTestItemNames[3];
    param4.itemType = DifferTestItemType_ZDRatio;
    param4.iIndex=@"4";
    param4.iTypeIndex = @"2";
    param4.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD2Ir];
    param4.fUp=@"0";
    param4.fDown=@"1";
    param4.testPhasorType=self.testItemBaseData.testPhasorType;
    param4.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param4.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    
    BD_DifferAssessmentModel *assment4 = [[BD_DifferAssessmentModel alloc]init];
    assment4.IrValue = [param4.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem4 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:4 itemName:DifferTestItemNames[3] itemSelect:YES itemResult:@"" testItemParam:param4 testItemAssessment:assment4];
    
    BD_DifferentialTestItemParaModel *param5 =[[BD_DifferentialTestItemParaModel alloc]init];
    param5.itemName = DifferTestItemNames[4];
    param5.itemType = DifferTestItemType_ZDRatio;
    param5.iIndex=@"5";
    param5.iTypeIndex = @"2";
    param5.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD2_2Ir];
    param5.fUp=@"0";
    param5.fDown=@"1";
    param5.testPhasorType=self.testItemBaseData.testPhasorType;
    param5.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param5.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    
    BD_DifferAssessmentModel *assment5 = [[BD_DifferAssessmentModel alloc]init];
    assment5.IrValue = [param5.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem5 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:5 itemName:DifferTestItemNames[4] itemSelect:YES itemResult:@"" testItemParam:param5 testItemAssessment:assment5];
    
    BD_DifferentialTestItemParaModel *param6 =[[BD_DifferentialTestItemParaModel alloc]init];
    param6.itemName = DifferTestItemNames[5];
    param6.itemType = DifferTestItemType_SDCurrent;
    param6.iIndex=@"6";
    param6.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_SDIr];
    param6.fUp=@"0";
    param6.fDown=@"1";
    param6.testPhasorType=self.testItemBaseData.testPhasorType;
    param6.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param6.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    
    BD_DifferAssessmentModel *assment6 = [[BD_DifferAssessmentModel alloc]init];
    assment6.IrValue = [param6.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem6 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:6 itemName:DifferTestItemNames[5] itemSelect:YES itemResult:@"" testItemParam:param6 testItemAssessment:assment6];
    
    BD_DifferentialTestItemParaModel *param7 =[[BD_DifferentialTestItemParaModel alloc]init];
    param7.itemName = DifferTestItemNames[6];
    param7.itemType = DifferTestItemType_HarmonicRation;
    param7.iIndex=@"7";
    param7.Id = [NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_HarmId];
    param7.nHarm = @"2";
    param7.searchStart = @"10";
    param7.searchEnd = @"80";
    param7.testPhasorType=self.testItemBaseData.testPhasorType;
    param7.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param7.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];

    BD_DifferAssessmentModel *assment7 = [[BD_DifferAssessmentModel alloc]init];
    assment7.IrValue = [param7.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem7 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:7 itemName:DifferTestItemNames[6] itemSelect:YES itemResult:@"" testItemParam:param7 testItemAssessment:assment7];
    
    BD_DifferentialTestItemParaModel *param8 =[[BD_DifferentialTestItemParaModel alloc]init];
    param8.itemName = DifferTestItemNames[7];
    param8.itemType = DifferTestItemType_HarmonicRation;
    param8.iIndex=@"8";
    param8.Id = [NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_HarmId];
    param8.nHarm = @"5";
    param8.searchStart = @"10";
    param8.searchEnd = @"80";
    param8.testPhasorType=self.testItemBaseData.testPhasorType;
    param8.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    param8.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    
    BD_DifferAssessmentModel *assment8 = [[BD_DifferAssessmentModel alloc]init];
    assment8.IrValue = [param8.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem8 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:8 itemName:DifferTestItemNames[7] itemSelect:YES itemResult:@"" testItemParam:param8 testItemAssessment:assment8];
    
    BD_DifferentialTestItemParaModel *param9 =[[BD_DifferentialTestItemParaModel alloc]init];
    param9.itemName = DifferTestItemNames[8];
    param9.itemType = DifferTestItemType_ActionTime;
    param9.iIndex=@"9";
    param9.Id = [NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ActionId];
    param9.Ir = [NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ActionIr];
    param9.testPhasorType=self.testItemBaseData.testPhasorType;
    param9.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
    
    BD_DifferAssessmentModel *assment9 = [[BD_DifferAssessmentModel alloc]init];
    assment9.IrValue = [param9.Ir floatValue];
    
    BD_DifferentialTestItemModel *testItem9 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:9 itemName:DifferTestItemNames[8] itemSelect:YES itemResult:@"" testItemParam:param9 testItemAssessment:assment9];
    [self.testListdataSource addObject:testItem1];
    [self.testListdataSource addObject:testItem2];
    [self.testListdataSource addObject:testItem3];
    [self.testListdataSource addObject:testItem4];
    [self.testListdataSource addObject:testItem5];
    [self.testListdataSource addObject:testItem6];
    [self.testListdataSource addObject:testItem7];
    [self.testListdataSource addObject:testItem8];
    [self.testListdataSource addObject:testItem9];
    
    [self updateDataSource_setData];
    
    [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[BD_DifferIrCaculateManager shared] caculateUpDownData:obj.testItemParam];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.testListTBView reloadData];
    });
    [self testListdefaultState];
}


-(void)setParamViewData{
    NSString *itemName = _testListdataSource[_currentSelItem].itemName;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([itemName rangeOfString:@"谐波"].location!=NSNotFound) {
            [self.itemParamView setDataToHarmView:_testListdataSource[_currentSelItem].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:1];
            _testListdataSource[_currentSelItem].testItemAssessment.IdValue = [_testListdataSource[_currentSelItem].testItemParam.Id floatValue];
            [self.assessmentView setDataToHarmAssessmentViewWithData:_testListdataSource[_currentSelItem].testItemAssessment];
            [self.assessmentView testItemAssessmenViewWithIndex:1];
            [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_HarmonicRation;
        } else if ([itemName rangeOfString:@"动作时间"].location != NSNotFound){
            [self.itemParamView setDataToActionView:_testListdataSource[_currentSelItem].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:2];
            _testListdataSource[_currentSelItem].testItemAssessment.IdValue = [_testListdataSource[_currentSelItem].testItemParam.Id floatValue];
            _testListdataSource[_currentSelItem].testItemAssessment.IrValue = [_testListdataSource[_currentSelItem].testItemParam.Ir floatValue];
            [self.assessmentView setDataToActionTimeAssessmentViewWithData:_testListdataSource[_currentSelItem].testItemAssessment];
            [self.assessmentView testItemAssessmenViewWithIndex:2];
            [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_ActionTime;
        } else {
            [self.itemParamView setDataToQDCurrentView:_testListdataSource[_currentSelItem].testItemParam];
            [self.itemParamView testItemParamViewWithIndex:0];
            if (_testListdataSource[_currentSelItem].testItemParam.itemType == DifferTestItemType_QDCurrent) {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_QDCurrent];
            } else if (_testListdataSource[_currentSelItem].testItemParam.itemType == DifferTestItemType_SDCurrent){
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_SDCurrent];
            } else if (_testListdataSource[_currentSelItem].testItemParam.itemType == DifferTestItemType_ZDRatio) {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:kTStrings(_testListdataSource[_currentSelItem].testItemAssessment.IdValue) rate:@"" rateLabel:_testListdataSource[_currentSelItem].itemName itemType:DifferTestItemType_ZDRatio];
            } else {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_Characteristic];
            }
            [self.assessmentView testItemAssessmenViewWithIndex:0];
            [BD_DifferIrCaculateManager shared].currentTestItemType = DifferTestItemType_QDCurrent;
        }
    });
}

- (IBAction)paramViewChanged:(id)sender {
    switch (self.paramSegmentControl.selectedSegmentIndex) {
        case 0:
        {
            _testParamBtn.selected = YES;
            _testResultBtn.selected = NO;
            _gooseSendBtn.selected = NO;
            self.testItemParaView.contentOffset = CGPointMake(0, 0);
            [self.testItemParaView layoutIfNeeded];
            isGOOSESendBtn = NO;
        }
            break;
        case 1:
        {
            _testParamBtn.selected = NO;
            _testResultBtn.selected = YES;
            _gooseSendBtn.selected = NO;
            self.testItemParaView.contentOffset = CGPointMake(self.testItemParaView.width, 0);
            
            if (_testListdataSource[_currentSelItem].testItemParam.itemType == DifferTestItemType_QDCurrent) {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_QDCurrent];
            } else if (_testListdataSource[_currentSelItem].testItemParam.itemType == DifferTestItemType_SDCurrent){
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_SDCurrent];
            } else if (_testListdataSource[_currentSelItem].testItemParam.itemType == DifferTestItemType_ZDRatio) {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:kTStrings(_testListdataSource[_currentSelItem].testItemAssessment.IdValue) rate:@"0.000" rateLabel:_testListdataSource[_currentSelItem].itemName itemType:DifferTestItemType_ZDRatio];
            } else {
                [self.assessmentView setDataToQDAssessmentViewWithError:_assessmentError Ir:_testListdataSource[_currentSelItem].testItemParam.Ir Id_QD_SD:@"0.000" rate:@"" rateLabel:@"" itemType:DifferTestItemType_Characteristic];
            }
            
            
            _testListdataSource[_currentSelItem].testItemAssessment.IdValue = [_testListdataSource[_currentSelItem].testItemParam.Id floatValue];
            [self.assessmentView setDataToHarmAssessmentViewWithData:_testListdataSource[_currentSelItem].testItemAssessment];
            
            _testListdataSource[_currentSelItem].testItemAssessment.IrValue = [_testListdataSource[_currentSelItem].testItemParam.Ir floatValue];
            [self.assessmentView setDataToActionTimeAssessmentViewWithData:_testListdataSource[_currentSelItem].testItemAssessment];
            
            
            [self.testItemParaView layoutIfNeeded];
            isGOOSESendBtn = NO;
        }
            break;
        case 2:
        {
            if (!isGOOSESendBtn) {
                _testParamBtn.selected = NO;
                _testResultBtn.selected = NO;
                _gooseSendBtn.selected = YES;
                self.testItemParaView.contentOffset = CGPointMake(self.testItemParaView.width*2, 0);
                [self.testItemParaView layoutIfNeeded];
                isGOOSESendBtn = YES;
            }
        }
            break;
        default:
            break;
    }
}



-(void)updateDataSource_generalData{
    [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.testItemParam.testPhasorType=self.testItemBaseData.testPhasorType;
         obj.testItemParam.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
         obj.testItemParam.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
    }];
}
-(void)updateDataSource_setData{
    WeakSelf;
   

    if ([BD_DifferIrCaculateManager shared].setData.KneePoint == 1) {
        NSMutableArray *removeObj = [[NSMutableArray alloc]init];
        for (BD_DifferentialTestItemModel *obj in self.testListdataSource) {
            if ([obj.itemName isEqualToString:@"比率制动系数三"] ||[obj.itemName isEqualToString:@"比率制动系数四"] ) {
                [removeObj addObject:obj];
            }
        }
        
        [removeObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakself.testListdataSource removeObject:(BD_DifferentialTestItemModel *)obj];
        }];
        
        [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.itemNum = idx+1;
            obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
        }];
        
    } else if ([BD_DifferIrCaculateManager shared].setData.KneePoint == 2){
        NSMutableArray *removeObj = [[NSMutableArray alloc]init];
        
        [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.itemName isEqualToString:@"比率制动系数四"] ) {
                [removeObj addObject:obj];
            }
        }];
        [removeObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakself.testListdataSource removeObject:(BD_DifferentialTestItemModel *)obj];
        }];
        
        if (![self isHasTestItemWithString:@"比率制动系数三"]) {
            addAtIndex = 5;
            BD_DifferentialTestItemParaModel *param2 =[[BD_DifferentialTestItemParaModel alloc]init];
            param2.itemName = @"比率制动系数三";
            param2.itemType = DifferTestItemType_ZDRatio;
            param2.iIndex = [NSString stringWithFormat:@"%ld",addAtIndex];
            param2.iTypeIndex = @"3";
            param2.Ir=[NSString stringWithFormat:@"%.3f",weakself.testItemBaseData.m_ZD3Ir];
            param2.fUp=@"0";
            param2.fDown=@"1";
            param2.testPhasorType=weakself.testItemBaseData.testPhasorType;
            param2.frequency=[NSString stringWithFormat:@"%.3f",weakself.testItemBaseData.frequency];
            param2.testAccuracy= [NSString stringWithFormat:@"%.3f",weakself.testItemBaseData.testAccuracy];
            
            BD_DifferAssessmentModel *assment2 = [[BD_DifferAssessmentModel alloc]init];
            assment2.IrValue = [param2.Ir floatValue];
            
            BD_DifferentialTestItemModel *testItem2 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex itemName:@"比率制动系数三" itemSelect:YES itemResult:@"" testItemParam:param2 testItemAssessment:assment2];
            
            BD_DifferentialTestItemParaModel *param3 =[[BD_DifferentialTestItemParaModel alloc]init];
            param3.itemName = @"比率制动系数三";
            param3.itemType = DifferTestItemType_ZDRatio;
            param3.iIndex=[NSString stringWithFormat:@"%ld",addAtIndex+1];
            param3.iTypeIndex = @"3";
            param3.Ir=[NSString stringWithFormat:@"%.3f",weakself.testItemBaseData.m_ZD3_2Ir];
            param3.fUp=@"0";
            param3.fDown=@"1";
            param3.testPhasorType=weakself.testItemBaseData.testPhasorType;
            param3.frequency=[NSString stringWithFormat:@"%.3f",weakself.testItemBaseData.frequency];
            param3.testAccuracy= [NSString stringWithFormat:@"%.3f",weakself.testItemBaseData.testAccuracy];
            
            BD_DifferAssessmentModel *assment3 = [[BD_DifferAssessmentModel alloc]init];
            assment3.IrValue = [param3.Ir floatValue];
            
            BD_DifferentialTestItemModel *testItem3 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex+1 itemName:@"比率制动系数三" itemSelect:YES itemResult:@"" testItemParam:param3 testItemAssessment:assment3 ];
            
            [weakself.testListdataSource insertObject:testItem2 atIndex:addAtIndex];
            [weakself.testListdataSource insertObject:testItem3 atIndex:addAtIndex];
            
        }
        
        [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.itemNum = idx+1;
            obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
        }];
    } else {
        
        if ([self isHasTestItemWithString:@"比率制动系数三"]) {
            if (![self isHasTestItemWithString:@"比率制动系数四"]) {
                addAtIndex = 5;
                BD_DifferentialTestItemParaModel *param4 =[[BD_DifferentialTestItemParaModel alloc]init];
                param4.itemName = @"比率制动系数四";
                param4.itemType = DifferTestItemType_ZDRatio;
                param4.iIndex = [NSString stringWithFormat:@"%ld",addAtIndex+2];
                param4.iTypeIndex = @"4";
                param4.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD4Ir];
                param4.fUp=@"0";
                param4.fDown=@"1";
                param4.testPhasorType=self.testItemBaseData.testPhasorType;
                param4.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
                param4.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
                
                BD_DifferAssessmentModel *assment4 = [[BD_DifferAssessmentModel alloc]init];
                assment4.IrValue = [param4.Ir floatValue];
                
                BD_DifferentialTestItemModel *testItem4 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex+2 itemName:@"比率制动系数四" itemSelect:YES itemResult:@"" testItemParam:param4 testItemAssessment:assment4];
                
                BD_DifferentialTestItemParaModel *param5 =[[BD_DifferentialTestItemParaModel alloc]init];
                param5.itemName = @"比率制动系数四";
                param5.itemType = DifferTestItemType_ZDRatio;
                param5.iIndex=[NSString stringWithFormat:@"%ld",addAtIndex+3];
                param5.iTypeIndex = @"4";
                param5.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD4_2Ir];
                param5.fUp=@"0";
                param5.fDown=@"1";
                param5.testPhasorType=self.testItemBaseData.testPhasorType;
                param5.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
                param5.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
                
                BD_DifferAssessmentModel *assment5 = [[BD_DifferAssessmentModel alloc]init];
                assment5.IrValue = [param5.Ir floatValue];
                
                BD_DifferentialTestItemModel *testItem5 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex+3 itemName:@"比率制动系数四" itemSelect:YES itemResult:@"" testItemParam:param5 testItemAssessment:assment5];
                [self.testListdataSource insertObject:testItem4 atIndex:addAtIndex+2];
                [self.testListdataSource insertObject:testItem5 atIndex:addAtIndex+3];
            }

        } else {
            addAtIndex = 5;
            BD_DifferentialTestItemParaModel *param2 =[[BD_DifferentialTestItemParaModel alloc]init];
            param2.itemName = @"比率制动系数三";
            param2.itemType = DifferTestItemType_ZDRatio;
            param2.iIndex = [NSString stringWithFormat:@"%ld",addAtIndex];
            param2.iTypeIndex = @"3";
            param2.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD3Ir];
            param2.fUp=@"0";
            param2.fDown=@"1";
            param2.testPhasorType=self.testItemBaseData.testPhasorType;
            param2.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
            param2.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
            
            BD_DifferAssessmentModel *assment2 = [[BD_DifferAssessmentModel alloc]init];
            assment2.IrValue = [param2.Ir floatValue];
            
            BD_DifferentialTestItemModel *testItem2 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex itemName:@"比率制动系数三" itemSelect:YES itemResult:@"" testItemParam:param2 testItemAssessment:assment2];
            
            BD_DifferentialTestItemParaModel *param3 =[[BD_DifferentialTestItemParaModel alloc]init];
            param3.itemName = @"比率制动系数三";
            param3.itemType = DifferTestItemType_ZDRatio;
            param3.iIndex=[NSString stringWithFormat:@"%ld",addAtIndex+1];
            param3.iTypeIndex = @"3";
            param3.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD3_2Ir];
            param3.fUp=@"0";
            param3.fDown=@"1";
            param3.testPhasorType=self.testItemBaseData.testPhasorType;
            param3.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
            param3.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
            
            BD_DifferAssessmentModel *assment3 = [[BD_DifferAssessmentModel alloc]init];
            assment3.IrValue = [param3.Ir floatValue];
            
            BD_DifferentialTestItemModel *testItem3 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex+1 itemName:@"比率制动系数三" itemSelect:YES itemResult:@"" testItemParam:param3 testItemAssessment:assment3];
            [self.testListdataSource insertObject:testItem2 atIndex:addAtIndex];
            [self.testListdataSource insertObject:testItem3 atIndex:addAtIndex+1];
            
            BD_DifferentialTestItemParaModel *param4 =[[BD_DifferentialTestItemParaModel alloc]init];
            param4.itemName = @"比率制动系数四";
            param4.itemType = DifferTestItemType_ZDRatio;
            param4.iIndex = [NSString stringWithFormat:@"%ld",addAtIndex+2];
            param4.iTypeIndex = @"4";
            param4.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD4Ir];
            param4.fUp=@"0";
            param4.fDown=@"1";
            param4.testPhasorType=self.testItemBaseData.testPhasorType;
            param4.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
            param4.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
            
            BD_DifferAssessmentModel *assment4 = [[BD_DifferAssessmentModel alloc]init];
            assment4.IrValue = [param4.Ir floatValue];
            
            BD_DifferentialTestItemModel *testItem4 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex+2 itemName:@"比率制动系数四" itemSelect:YES itemResult:@"" testItemParam:param4 testItemAssessment:assment4];
            
            BD_DifferentialTestItemParaModel *param5 =[[BD_DifferentialTestItemParaModel alloc]init];
            param5.itemName = @"比率制动系数四";
            param5.itemType = DifferTestItemType_ZDRatio;
            param5.iIndex=[NSString stringWithFormat:@"%ld",addAtIndex+3];
            param5.iTypeIndex = @"4";
            param5.Ir=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.m_ZD4_2Ir];
            param5.fUp=@"0";
            param5.fDown=@"1";
            param5.testPhasorType=self.testItemBaseData.testPhasorType;
            param5.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
            param5.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
            
            BD_DifferAssessmentModel *assment5 = [[BD_DifferAssessmentModel alloc]init];
            assment5.IrValue = [param5.Ir floatValue];
            
            BD_DifferentialTestItemModel *testItem5 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:addAtIndex+3 itemName:@"比率制动系数四" itemSelect:YES itemResult:@"" testItemParam:param5 testItemAssessment:assment5];
            [self.testListdataSource insertObject:testItem4 atIndex:addAtIndex+2];
            [self.testListdataSource insertObject:testItem5 atIndex:addAtIndex+3];
        }
 
        [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.itemNum = idx+1;
            obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
        }];
    }
    
    [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[BD_DifferIrCaculateManager shared] caculateUpDownData:obj.testItemParam];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.testListTBView reloadData];
        [self.testListTBView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    });
   
    
}

-(BOOL)isHasTestItemWithString:(NSString *)testItemName{
    for (BD_DifferentialTestItemModel *model in self.testListdataSource) {
        if ([model.itemName isEqualToString:testItemName]) {
            return YES;
            break;
        }
    }
    return NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isGOOSESendBtn = NO;
}

-(void)reloadTBView{
    
    [self.testListTBView reloadData];
    [self.testListTBView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    if (self.listDataSourceChangedBlock) {
        self.listDataSourceChangedBlock();
    }
}
-(void)reloadTBVIewWithCellIndex:(int)cellIndex{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.testListTBView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cellIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.testListTBView selectRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
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
