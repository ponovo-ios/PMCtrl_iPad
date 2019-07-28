//
//  BD_StateTestDataParamVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestDataParamVC.h"
#import "BD_DifferGooseSendView.h"
#import "BD_ActionListView.h"
#import "StatusSequenceCell.h"
#import "BD_StatusSequenceHeaderView.h"
#import "BD_StateTestDataParamVC+BD_StateTestActionListAction.h"
#import "BD_QuickTestParamTBView.h"
#import "BD_StateTesttriggerParamVC.h"
#import "BD_StateTestItemModel.h"
#import "BD_StateTestShowtCalculationVC.h"
#import "BD_PopListViewManager.h"
#import "BDFaultCaculateManager.h"
#import "BD_FaultCaculateModel.h"
#import "UIImage+Extension.h"
#import "BD_TestDataParamModel.h"
#import "BD_StateTestParamModel.h"
@interface BD_StateTestDataParamVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *tbScrollView;
@property (nonatomic,weak) UITableView *tbView;
@property (weak, nonatomic) IBOutlet UIButton *dataBtn;
@property (weak, nonatomic) IBOutlet UIButton *triggerParaBtn;
@property (weak, nonatomic) IBOutlet UIButton *gooseBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *paramViewSegmentControl;
@property (weak, nonatomic) IBOutlet UIScrollView *paramScrollView;
@property (weak, nonatomic) IBOutlet UIView *actionListView;



@property(nonatomic,weak) UIButton *isDirectCurrent;
@property(nonatomic,weak) UITextField *itemProjectTF;
@property(nonatomic,weak) UIButton *faultCaculateBtn;
@property(nonatomic,weak) UIView *directView;
@property(nonatomic,weak) BD_DifferGooseSendView *gooseSendView;
@property(nonatomic,weak)BD_QuickTestParamTBView *dataView_V;
@property(nonatomic,weak)BD_QuickTestParamTBView *dataView_C;
@property(nonatomic,strong)BD_StateTesttriggerParamVC *triggerView;
@property(nonatomic,strong)BD_StateTestShowtCalculationVC *faultCaculatVC;
@property(nonatomic,assign)NSInteger faultCaculatGroup;

@end

@implementation BD_StateTestDataParamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromPlist];
    self.paramScrollView.scrollEnabled = NO;
    self.paramScrollView.showsHorizontalScrollIndicator = NO;
    _tbView.bounces = NO;
    
    self.view.backgroundColor = ClearColor;
    self.actionListView.backgroundColor = ClearColor;
    self.paramScrollView.backgroundColor = ClearColor;
  
    _currentTestItem = 0;
    _faultCaculatGroup = 1;
    _groupNum = 1;
    _itemProjectTF.delegate = self;
    [self.dataBtn setBackgroundImage:[UIImage imageWithColor:ClearColor width:self.dataBtn.width height:self.dataBtn.height title:@""] forState:UIControlStateNormal];
    [self.dataBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor] width:self.dataBtn.width height:self.dataBtn.height title:@""] forState:UIControlStateSelected];
    [self.triggerParaBtn setBackgroundImage:[UIImage imageWithColor:ClearColor width:self.triggerParaBtn.width height:self.triggerParaBtn.height title:@""] forState:UIControlStateNormal];
    [self.triggerParaBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor] width:self.triggerParaBtn.width height:self.triggerParaBtn.height title:@""] forState:UIControlStateSelected];
    [self.gooseBtn setBackgroundImage:[UIImage imageWithColor:ClearColor width:self.gooseBtn.width height:self.gooseBtn.height title:@""] forState:UIControlStateNormal];
    [self.gooseBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor] width:self.gooseBtn.width height:self.gooseBtn.height title:@""] forState:UIControlStateSelected];
//    [self.dataBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
//    [self.triggerParaBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
//    [self.gooseBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    
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
  
    [self.dataView_V setFrame:CGRectMake(0,35, self.paramScrollView.width/2,self.paramScrollView.height)];
    [self.dataView_C setFrame:CGRectMake(self.paramScrollView.width/2,35, self.paramScrollView.width/2,self.paramScrollView.height)];
    
    [self.triggerView.view setFrame:CGRectMake(self.paramScrollView.width,0, self.paramScrollView.width,self.paramScrollView.height)];
    [self.gooseSendView setFrame:CGRectMake(self.paramScrollView.width*2,0, self.paramScrollView.width,self.paramScrollView.height)];
    self.paramScrollView.contentSize = CGSizeMake(3*self.paramScrollView.width, self.paramScrollView.height);
    self.tbScrollView.contentSize = CGSizeMake(self.tbScrollView.width*1.0, self.tbScrollView.height);
    [_tbView setFrame:CGRectMake(0, 0, self.tbScrollView.contentSize.width, self.tbScrollView.contentSize.height)];
    [self.directView setFrame:CGRectMake(0,0,self.paramScrollView.width,40)];
    [self.tbScrollView layoutIfNeeded];
}
-(void)loadSubViews{
    
    BD_ActionListView *actionView = [[BD_ActionListView alloc]initWithTitles:@[@"添加试验",@"删除试验",@"删除N-1",@"清除结果",@"清除所有"]];
    [_actionListView addSubview:actionView];
    
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
    UITableView *tbView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbView = tbView;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = ClearColor;
    _tbView.bounces = NO;
    [_tbView registerNib:[UINib nibWithNibName:NSStringFromClass([StatusSequenceCell class]) bundle:nil] forCellReuseIdentifier:@"statusCellID"];
    [_tbView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_StatusSequenceHeaderView class]) bundle:nil] forCellReuseIdentifier:@"BD_StatusSequenceHeaderViewID"];
    [self.tbScrollView addSubview:self.tbView];
   
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ClearColor;
    self.directView = view;
    [self.paramScrollView addSubview:view];
    
    UILabel *itemName = [[UILabel alloc]init];
    [itemName setFrame:CGRectMake(10, 5,90, 30)];
    itemName.textColor = White;
    itemName.text = @"测试项目:";
    itemName.font = [UIFont systemFontOfSize:17.0];
    [view addSubview:itemName];
    
    UITextField *tf = [[UITextField alloc]init];
    [tf setFrame:CGRectMake(itemName.right, 5, 150, 30)];
    tf.textColor = White;
    [tf setFont:[UIFont systemFontOfSize:17.0]];
    [tf setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    self.itemProjectTF = tf;
    tf.delegate = self;
    [view addSubview:tf];
    
    UIButton *isDirec = [[UIButton alloc]init];
    [isDirec setFrame:CGRectMake(tf.right+15,10, 20,20)];
    [isDirec setBackgroundImage:[UIImage imageNamed:@"select_green"] forState:UIControlStateSelected];
    [isDirec setBackgroundImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
    [isDirec addTarget:self action:@selector(isDirectCurrentAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:isDirec];
    self.isDirectCurrent = isDirec;
    
    UILabel *isDirecLabel = [[UILabel alloc]init];
    [isDirecLabel setFrame:CGRectMake(isDirec.right+5,5,100, 30)];
    isDirecLabel.text = @"是否直流";
    isDirecLabel.textColor = White;
    isDirecLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:isDirecLabel];
    
    UIButton *fault = [[UIButton alloc]init];
    [fault setTitle:@"短路计算" forState:UIControlStateNormal];
    [fault.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [fault setFrame:CGRectMake(isDirecLabel.right, 5, 120, 30)];
    self.faultCaculateBtn = fault;
    fault.backgroundColor = BDThemeColor;
    [fault addTarget:self action:@selector(faultCaculateAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fault];
    
    
    
    BD_QuickTestParamTBView *voltageTV = [[BD_QuickTestParamTBView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    voltageTV.type = BD_CellTypeVoltage;
    voltageTV.headerTitleArr = @[@"幅值(V)",@"相位(°)",@"频率(Hz)"];
    voltageTV.quickTBParaBlack = ^(BD_TestDataParamModel *model, NSInteger cellIndex) {
     
    } ;
    [self.paramScrollView addSubview:voltageTV];
    _dataView_V = voltageTV;
    _dataView_V.backgroundColor = ClearColor;
    
    BD_QuickTestParamTBView *currentTV = [[BD_QuickTestParamTBView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    currentTV.type = BD_CellTypeCurrent;
    currentTV.headerTitleArr = @[@"幅值(A)",@"相位(°)",@"频率(Hz)"];
    currentTV.quickTBParaBlack = ^(BD_TestDataParamModel *model, NSInteger cellIndex) {
        
    } ;
    [self.paramScrollView addSubview:currentTV];
    _dataView_C = currentTV;
    _dataView_C.backgroundColor = ClearColor;
    BD_StateTesttriggerParamVC *triggerView = [[BD_StateTesttriggerParamVC alloc]init];
    [self.paramScrollView addSubview:triggerView.view];
    self.triggerView = triggerView;
    
    
   BD_DifferGooseSendView *gooseSendView = [[BD_DifferGooseSendView alloc]initWithFrame:CGRectZero];
    gooseSendView.groupNum = 2;
    [gooseSendView loadSubViews];
    [self.paramScrollView addSubview:gooseSendView];
    self.gooseSendView = gooseSendView;
    
}
#pragma mark - 懒加载
-(NSMutableArray *)testListDataSource{
    if (!_testListDataSource) {
        _testListDataSource = [[NSMutableArray alloc]init];
    }
    return _testListDataSource;
}




#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testListDataSource.count;
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
    BD_StatusSequenceHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_StatusSequenceHeaderView class]) owner:self options:nil].lastObject;
    headerView.backgroundColor = BDThemeColor_Light;
    headerView.testNum.text = @"编号";
    headerView.testName.text = @"名称";
    headerView.testProject.text = @"测试项目";
    headerView.isSelect.text = @"选择";
    headerView.testResult.text = @"试验结果";
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusSequenceCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"statusCellID" forIndexPath:indexPath];
    itemCell.cellIndex = indexPath.row;
    itemCell.testNum.text = [NSString stringWithFormat:@"%ld",self.testListDataSource[indexPath.row].itemNum];
    itemCell.testName.text = self.testListDataSource[indexPath.row].itemName;
     itemCell.testProject.text = self.testListDataSource[indexPath.row].itemProject;
     [itemCell.isSelect setSelected:self.testListDataSource[indexPath.row].itemSelect];
     itemCell.testResult.text = self.testListDataSource[indexPath.row].itemResult;
    WeakSelf;
    itemCell.isSelectedItemBlock = ^(NSInteger cellIndex, BOOL state) {
        weakself.testListDataSource[cellIndex].itemSelect = state;
    };
    return itemCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentTestItem = indexPath.row;
    [self refreshItemParamViewData];
    [self setCurrentItemDirectCurr];
    
}
//创建触发条件中递变设置中变量类型数组
-(void)createParamTypeArr{
    NSMutableArray *paramArr = [[NSMutableArray alloc]init];
    NSMutableArray *paramArr_V = [[NSMutableArray alloc]init];
    NSMutableArray *paramArr_C = [[NSMutableArray alloc]init];
    [_dataView_V.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramArr_V addObject:obj.titleName];
    }];
    [_dataView_C.datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramArr_C addObject:obj.titleName];
    }];
    [paramArr addObject:paramArr_V];
    [paramArr addObject:paramArr_C];
    _triggerView.paramTypeArr = [paramArr copy];
}

#pragma mark - 动作列表方法
-(void)actionTotestItemListWithActionIndex:(NSInteger)index{
    //0-添加试验 1-删除试验 2-删除N-1 3-清除结果 4-清除所有 5-全选 6全不选
    [self.view endEditing:YES];
    NSLog(@"actionIndex:%ld",index);
    switch (index) {
        case 0:
            
            [self addTestItem];
            [self.tbView reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            break;
        case 1:
        {
            [self deleteTestItem];
            
            [self refreshItemParamViewData];
            
            [self.tbView reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
            
            break;
        case 2:
            [self clearAllDataAndResult];
            break;
        case 3:
            [self clearResult];
            [self.tbView reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            break;
        case 4:
            [self clearAllResult];
            [self.tbView reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            break;
        case 5:
            [self selectedAll];
            [self.tbView reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            break;
        case 6:
            [self unselectedAll];
            [self.tbView reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            break;
        default:
            break;
    }
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (IBAction)paramViewChanged:(id)sender {
    switch (self.paramViewSegmentControl.selectedSegmentIndex) {
        case 0:
        {
            _dataBtn.selected = YES;
            _triggerParaBtn.selected = NO;
            _gooseBtn.selected = NO;
            self.paramScrollView.contentOffset = CGPointMake(0, 0);
            [self.paramScrollView layoutIfNeeded];
            [self.view endEditing:YES];
        }
            break;
         case 1:
        {
            _dataBtn.selected = NO;
            _triggerParaBtn.selected = YES;
            _gooseBtn.selected = NO;
            self.paramScrollView.contentOffset = CGPointMake(self.paramScrollView.width, 0);
            
            [self.paramScrollView layoutIfNeeded];
            [self.view endEditing:YES];
        }
            break;
        case 2:
        {
            _dataBtn.selected = NO;
            _triggerParaBtn.selected = NO;
            _gooseBtn.selected = YES;
            self.paramScrollView.contentOffset = CGPointMake(self.paramScrollView.width*2, 0);
            [self.paramScrollView layoutIfNeeded];
            [self.view endEditing:YES];
        }
            break;
        default:
            break;
    }
}

-(void)isDirectCurrentAction:(UIButton *)sender{
    _isDirectCurrent.selected = !_isDirectCurrent.selected;
    self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent = _isDirectCurrent.selected;
    _dataView_V.isDirectCurrent = self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent;
    _dataView_C.isDirectCurrent = self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent;
    [_dataView_C reloadData];
    [_dataView_V reloadData];
    
    if (self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent) {
        [[BD_Utils shared]setViewState:NO view:_faultCaculateBtn];
    } else {
        [[BD_Utils shared]setViewState:YES view:_faultCaculateBtn];
    }
    
    [kNotificationCenter postNotificationName:BD_IsCocurrentNoti object:@(_isDirectCurrent.selected) userInfo:nil];
}
//是否直流影响当前测试项，选择其他测试项，刷新是否直流表示
-(void)setCurrentItemDirectCurr{
    self.isDirectCurrent.selected = self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent;
    _dataView_V.isDirectCurrent = self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent;
    _dataView_C.isDirectCurrent = self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent;
    [_dataView_C reloadData];
    [_dataView_V reloadData];
    
    if (self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent) {
        [[BD_Utils shared]setViewState:NO view:_faultCaculateBtn];
    } else {
        [[BD_Utils shared]setViewState:YES view:_faultCaculateBtn];
    }
}


-(void)faultCaculateAction:(UIButton *)sender{
    if (!_faultCaculatVC) {
        _faultCaculatVC = [[BD_StateTestShowtCalculationVC alloc]initWithNibName:NSStringFromClass([BD_StateTestShowtCalculationVC class]) bundle:nil];
        
    }
    WeakSelf;
    _faultCaculatVC.groupNum = _dataView_C.datasource.count/3<_dataView_V.datasource.count/3?_dataView_C.datasource.count/3:_dataView_V.datasource.count/3;
    
    _faultCaculatVC.okActionBlock = ^{
        [weakself faultCaculate];
    };
    [_faultCaculatVC showBinaryInView];
//        [_faultCaculatVC.view setFrame: CGRectMake(0, 0, 300, 300)];
//        _faultCaculatVC.modalPresentationStyle = UIModalPresentationPopover;
//        _faultCaculatVC.preferredContentSize = CGSizeMake(SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.5);
//    [_faultCaculatVC confitSubViews];
//    UIPopoverPresentationController *pop = _faultCaculatVC.popoverPresentationController;
//    pop.sourceView = (UIButton *)sender;
//    pop.sourceRect = ((UIButton *)sender).bounds;
//    pop.permittedArrowDirections = UIPopoverArrowDirectionUp;
//    [self presentViewController:_faultCaculatVC animated:NO completion:nil];
}

#pragma mark - plist文件读取参数默认设置
-(void)readDataFromPlist{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StateTestParam" ofType:@".plist"]];
        
        for (NSInteger i= 0; i<2; i++) {
            NSMutableArray *arrV = [NSMutableArray array];
            NSMutableArray *arrC = [NSMutableArray array];
            for (NSArray *arr in dictArr) {
                if ([dictArr indexOfObject:arr]==0) {
                    for (NSDictionary *dict in arr) {
                        BD_TestDataParamModel *peopleList = [BD_TestDataParamModel groupWithDict:dict];
                        
                        [arrV addObject:peopleList];
                    }
                } else {
                    for (NSDictionary *dict in arr) {
                        BD_TestDataParamModel *peopleList = [BD_TestDataParamModel groupWithDict:dict];
                        
                        [arrC addObject:peopleList];
                    }
                }
                
            }
            
            BD_StateTestTriggerParamModel *triggerPara = [[BD_StateTestTriggerParamModel alloc]initWithTirggerType:@1 TriggerLogic:@0 TriggerTime:@5 Gpstime:@"00:00:00"  nBiValide:@255 nbinaryout:@255 trigerHoldTime:@0 isBinaryOutStateInvert:NO binaryOutStateInvertHoldTime:@0 isdfdt:NO isdvdt:NO isComGradient:NO  BArr:[@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1] mutableCopy] BoArr:[@[@1,@1,@1,@1,@1,@1,@1,@1] mutableCopy]];//开出是正好和显示的状态是反的，开出默认都为关闭，设置状态都为1，显示的时候是!@(1),表示关闭
            
            BD_StateTestTransmutationDetailModel *transmutationPara = [[BD_StateTestTransmutationDetailModel alloc]init];
            
            BD_StateTestParamModel *model = [[BD_StateTestParamModel alloc]initWithStateParam:[[BD_StateTestOutputParamModel alloc] initWithIsDirectCurrent:NO voltageOutputDatas:arrV currentOutputDatas:arrC] triggerParam:triggerPara transmutationParam:transmutationPara result:@0];
            BD_StateTestItemModel *testItem = [[BD_StateTestItemModel alloc]init];
            testItem.itemNum = i+1;
            testItem.itemName = @"状态序列";
            if (i==0) {
                 testItem.itemProject = @"常态";
            } else {
                 testItem.itemProject = @"故障态";
            }
           
            testItem.itemSelect = YES;
            testItem.itemResult = @"";
            testItem.itemParam = model;
            [self.testListDataSource addObject:testItem];
        }
        if (self.testListDataSource.count!=0) {
            _dataView_V.datasource = self.testListDataSource[0].itemParam.stateParam.voltageOutputDatas;
            _dataView_C.datasource = self.testListDataSource[0].itemParam.stateParam.currentOutputDatas;
            [self createParamTypeArr];
        }
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView reloadData];
            [self.dataView_C reloadData];
            [self.dataView_V reloadData];
            [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            _triggerView.dataModel = self.testListDataSource[_currentTestItem].itemParam.triggerParam;
            _triggerView.gradientModel = self.testListDataSource[_currentTestItem].itemParam.transmutationParam;
          
            self.itemProjectTF.text = self.testListDataSource[_currentTestItem].itemProject;
            [self.isDirectCurrent setSelected:self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent];
            self.testListDataSourceCompleteBlock();
           
        });
        
    });
    
    
}
-(void)updateViewData{
    dispatch_async(dispatch_get_main_queue(), ^{
        _dataView_V.datasource = self.testListDataSource[_currentTestItem].itemParam.stateParam.voltageOutputDatas;
        _dataView_C.datasource = self.testListDataSource[_currentTestItem].itemParam.stateParam.currentOutputDatas;
        [self.dataView_V reloadData];
        [self.dataView_C reloadData];
        [self createParamTypeArr];
    });
    
}
#pragma mark - 试验开始后不可修改参数页面
-(void)setParamViewUnUsed{
    [[BD_Utils shared]setViewState:NO view:_tbScrollView];
    [[BD_Utils shared]setViewState:NO view:_paramScrollView];
    [[BD_Utils shared]setViewState:NO view:_actionListView];


}
#pragma mark - 试验停止后，可修改参数页面
-(void)setParamViewUsed{
    [[BD_Utils shared]setViewState:YES view:_tbScrollView];
    [[BD_Utils shared]setViewState:YES view:_paramScrollView];
    [[BD_Utils shared]setViewState:YES view:_actionListView];
}

#pragma mark - 刷新
- (void)reloadRowInTableviewWithNcur:(int)ncur{
  
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新指定行cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:ncur inSection:0];
        [self.tbView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tbView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        _currentTestItem = indexPath.row;
        _dataView_V.datasource = self.testListDataSource[_currentTestItem].itemParam.stateParam.voltageOutputDatas;
        _dataView_C.datasource = self.testListDataSource[_currentTestItem].itemParam.stateParam.currentOutputDatas;
        _triggerView.dataModel = self.testListDataSource[_currentTestItem].itemParam.triggerParam;
        _triggerView.gradientModel = self.testListDataSource[_currentTestItem].itemParam.transmutationParam;
       
        [_dataView_V reloadData];
        [_dataView_C reloadData];
        
    });
    
}

//修改当前选择测试项后，修改数据参数和触发参数
-(void)refreshItemParamViewData{
    _dataView_V.datasource = self.testListDataSource[_currentTestItem].itemParam.stateParam.voltageOutputDatas;
    _dataView_C.datasource = self.testListDataSource[_currentTestItem].itemParam.stateParam.currentOutputDatas;
    _triggerView.dataModel = self.testListDataSource[_currentTestItem].itemParam.triggerParam;
    _triggerView.gradientModel = self.testListDataSource[_currentTestItem].itemParam.transmutationParam;
     
    self.itemProjectTF.text = self.testListDataSource[_currentTestItem].itemProject;
    [self.isDirectCurrent setSelected:self.testListDataSource[_currentTestItem].itemParam.stateParam.isDirectCurrent];
    [_dataView_V reloadData];
    [_dataView_C reloadData];
}

#pragma mark - 短路计算页面数据恢复默认
-(void)setCaculatVCDefaultData{
    self.faultCaculatVC.cacultationModel = nil;
}
#pragma mark - 短路计算方法
-(void)faultCaculate{
    _faultCaculatGroup = [[self.faultCaculatVC.cacultationModel.selectedGroup substringWithRange:NSMakeRange(1, 1)] integerValue];
    BD_FaultCaculateModel *faultModel = [[BD_FaultCaculateModel alloc]init];
    /**短路阻抗角*/
    faultModel.fImpAngle = [_faultCaculatVC.cacultationModel.ZPhi2 doubleValue];
    /**转换后零序补偿系数（幅值）---通用参数*/
    faultModel.fK0s = [_faultCaculatVC.cacultationModel.ampletude doubleValue];
    /**转换后零序补偿系数（相位）---通用参数*/
    faultModel.fK0sPhi = [_faultCaculatVC.cacultationModel.phase doubleValue];
    /**!零序补偿系数计算方式  0-|K0|,,Phi(K0), 1-RERL,,XEXL, 2-|Z0/Z1|,,Phi(Z0/Z1)  默认为1*/
    faultModel.fK0CalModel = [self cacultationStyleStrToInt:_faultCaculatVC.cacultationModel.cacultationStyle];
    /**此系数只有工频变化量距离用到，其他是1*/
    faultModel.fDZFactor = 1;
    /**!故障方向，0-反方向，1-正方向，默认为1*/
    faultModel.fFaultDir = 1;
    /**CT极性正方向: 0--指向线路, 1--指向母线，默认为0*/
    //如果未修改用默认值
    faultModel.fCTPoint = 1;
    /**!计算模式，过流、零序为3，距离、阻抗边界搜索为0，工频变化量距离根据故障方向而不同，为4（正方向）或5（反方向），默认为0*/
    faultModel.fCalMode = [self caculModeStrToInt:_faultCaculatVC.cacultationModel.caculationModel];
    /**!故障类型，0-9分别为A相接地、B相接地、C相接地、AB短路、BC短路、CA短路、AB接地短路、BC接地短路、CA接地短路、三相短路*/
    faultModel.fFaultType = [self faultStyleStrToInt:_faultCaculatVC.cacultationModel.faultStyle];
    /**额定电压*/
    faultModel.fVNom = 57.740;//使用默认值，搜索阻抗中是57.735
    /**PT变比,一般情况传入1*/
    faultModel.fVFactor = 1;
    /**CT变比一般情况传入1*/
    faultModel.fIFactor = 1;
    /**短路电流*/
    faultModel.fDL_I = [_faultCaculatVC.cacultationModel.shortCurrent doubleValue];
    /**短路电压*/
    faultModel.fDL_V = [_faultCaculatVC.cacultationModel.shortVoltage doubleValue];
    /**首端阻抗值*/
    faultModel.fHeadZ = [_faultCaculatVC.cacultationModel.ZPhi1 doubleValue];
    //负荷电流
    faultModel.m_fIfh = [_faultCaculatVC.cacultationModel.loadCurrent doubleValue];
    //负荷功角
    faultModel.m_fPowerAngle = [_faultCaculatVC.cacultationModel.loadPowerPhase doubleValue];
    //ZS/ZL
    faultModel.zszl = [_faultCaculatVC.cacultationModel.ZSZL doubleValue];
   BD_FaultCacuResultModel *result = [[[BDFaultCaculateManager alloc]init] stateCaculateShortDataWithTestData:faultModel];
   
    _dataView_V.datasource[(_faultCaculatGroup-1)*3+0].amplitude = [NSString stringWithFormat:@"%.3f",result.basic3U3I.fVa];
    _dataView_V.datasource[(_faultCaculatGroup-1)*3+1].amplitude = [NSString stringWithFormat:@"%.3f",result.basic3U3I.fVb];
    _dataView_V.datasource[(_faultCaculatGroup-1)*3+2].amplitude = [NSString stringWithFormat:@"%.3f",result.basic3U3I.fVc];
    _dataView_C.datasource[(_faultCaculatGroup-1)*3+0].amplitude = [NSString stringWithFormat:@"%.3f",result.basic3U3I.fIa];
    _dataView_C.datasource[(_faultCaculatGroup-1)*3+1].amplitude = [NSString stringWithFormat:@"%.3f",result.basic3U3I.fIb];
    _dataView_C.datasource[(_faultCaculatGroup-1)*3+2].amplitude = [NSString stringWithFormat:@"%.3f",result.basic3U3I.fIc];
    
    _dataView_V.datasource[(_faultCaculatGroup-1)*3+0].phase = [NSString stringWithFormat:@"%.3f",[self angleLimitWithData:(result.basic3U3I.fAngle_Va+120.000)]];
    _dataView_V.datasource[(_faultCaculatGroup-1)*3+1].phase = [NSString stringWithFormat:@"%.3f",[self angleLimitWithData:(result.basic3U3I.fAngle_Vb+120.000)]];
    _dataView_V.datasource[(_faultCaculatGroup-1)*3+2].phase = [NSString stringWithFormat:@"%.3f",[self angleLimitWithData:(result.basic3U3I.fAngle_Vc+120.000)]];
    _dataView_C.datasource[(_faultCaculatGroup-1)*3+0].phase = [NSString stringWithFormat:@"%.3f",[self angleLimitWithData:(result.basic3U3I.fAngle_Ia+120.000)]];
    _dataView_C.datasource[(_faultCaculatGroup-1)*3+1].phase = [NSString stringWithFormat:@"%.3f",[self angleLimitWithData:(result.basic3U3I.fAngle_Ib+120.000)]];
    _dataView_C.datasource[(_faultCaculatGroup-1)*3+2].phase = [NSString stringWithFormat:@"%.3f",[self angleLimitWithData:(result.basic3U3I.fAngle_Ic+120.000)]];
    
    [_dataView_C reloadData];
    [_dataView_V reloadData];
}

//故障类型转换为int下发
-(int)faultStyleStrToInt:(NSString *)faultStyle{
    NSArray*arr = @[@"A相接地",@"B相接地",@"C相接地",@"AB短路",@"BC短路",@"CA短路",@"AB接地短路",@"BC接地短路",@"AC接地短路",@"三相短路",@"单相系统"];
    return (int)[arr indexOfObject:faultStyle];
}

-(int)cacultationStyleStrToInt:(NSString *)str{
    NSArray*arr = @[@"KL",@"Kr,Kx",@"Z0/Z1"];
    return (int)[arr indexOfObject:str];
}

-(int)caculModeStrToInt:(NSString *)str{
    NSArray*arr = @[@"电流不变",@"电压不变",@"系统阻抗不变"];
    return (int)[arr indexOfObject:str];
}
/**把角度限制在-180---180之间*/
-(float)angleLimitWithData:(float)angle{
    if (angle>180) {
        return angle-360.000;
    } else {
        return  angle;
    }
}
#pragma mark - textfieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.testListDataSource[_currentTestItem].itemProject = textField.text;
    [self.tbView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_currentTestItem inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentTestItem inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
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
