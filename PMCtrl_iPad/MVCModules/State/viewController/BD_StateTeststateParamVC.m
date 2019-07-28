//
//  BD_StateTeststateParamVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateTeststateParamVC.h"
#import "BD_StateTestParamModel.h"
#import "BD_QuickTestParamHeaderView.h"
#import "BD_QuickTestParamCell.h"
#import "BD_PopListViewManager.h"
#import "BD_StateTestShowtCalculationVC.h"
#import "BD_QuickTestDataCenter.h"
@interface BD_StateTeststateParamVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *shortCalculateBtn;

@property (weak, nonatomic) IBOutlet UIButton *isDirectCurrentBtn;
@property (nonatomic,strong)BD_QuickTestDataCenter *dataCenter;
@property (nonatomic,strong)BD_StateTestShowtCalculationVC *calculationVC;

@end

@implementation BD_StateTeststateParamVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.view.backgroundColor = ClearColor;
    self.tableView.backgroundColor = ClearColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestParamCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestParamCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestParamHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"BD_QuickTestParamHeaderView"];
    
    _dataCenter = [[BD_QuickTestDataCenter alloc]init];
    
    [kNotificationCenter addObserver:self selector:@selector(deviceConfigCompleteRefreshView:) name:BD_StateTestDeviceConfigFinished object:nil];
    
    [_isDirectCurrentBtn setSelected:NO];
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews{
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"结束编辑");
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _outputParam.outputDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BD_QuickTestParamHeaderView *headerview = [[NSBundle mainBundle]loadNibNamed:@"BD_QuickTestParamHeaderView" owner:nil options:nil].lastObject;
    if (section == 0) {
        headerview.amplitudeLabel.text = @"幅值(V)";
    } else {
        headerview.amplitudeLabel.text = @"幅值(A)";
    }
    headerview.phaseLabel.text = @"相位(Deg)";
    headerview.frequencyLabel.text = @"频率(Hz)";
    return headerview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _outputParam.outputDatas[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_QuickTestParamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestParamCellID" forIndexPath:indexPath];
    if (_outputParam.outputDatas) {
        cell.cellTitle.text = _outputParam.outputDatas[indexPath.section][indexPath.row].titleName;
        cell.phase.text =  _outputParam.outputDatas[indexPath.section][indexPath.row].phase;
        cell.amplitude.text = _outputParam.outputDatas[indexPath.section][indexPath.row].amplitude;
        cell.frequency.text = _outputParam.outputDatas[indexPath.section][indexPath.row].frequency;
    }
    cell.quickParamBlock = ^(BD_TestDataParamModel *cellmodel) {
        [_outputParam.outputDatas[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:cellmodel];
        
    };
    if (indexPath.row == _outputParam.outputDatas[indexPath.section].count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }

    return cell;
}


//-(void)setStateParamDataSource:(NSMutableArray<NSMutableArray<BD_QuickTestParamModel *> *> *)stateParamDataSource{
//    _outputParam.outputDatas = stateParamDataSource;
//    [self.tableView reloadData];
//}

-(void)setOutputParam:(BD_StateTestOutputParamModel *)outputParam{
    _outputParam = outputParam;
    
    [self.tableView reloadData];
}


//显示短路计算页面
- (IBAction)calculateShortShow:(id)sender {
    if(!_calculationVC){
        _calculationVC = [[BD_StateTestShowtCalculationVC alloc]initWithNibName:NSStringFromClass([BD_StateTestShowtCalculationVC class]) bundle:[NSBundle mainBundle]];
    }
    [_calculationVC.view setFrame:CGRectMake(0, 0, 300, 300)];
    _calculationVC.modalPresentationStyle = UIModalPresentationPopover;
    _calculationVC.preferredContentSize = CGSizeMake(SCREEN_WIDTH*0.5,SCREEN_HEIGHT*0.5);
    
    [_calculationVC confitSubViews];
    
    UIPopoverPresentationController *popPresenter = _calculationVC.popoverPresentationController;
    popPresenter.sourceView = _shortCalculateBtn;
    popPresenter.sourceRect = _shortCalculateBtn.bounds;
    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionDown;
    [self presentViewController:_calculationVC animated:NO completion:nil];
    
}


- (IBAction)selectetdGroup:(id)sender {

    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"第一组",@"第二组"] textField:(UIButton *)sender viewController:self direction:UIPopoverArrowDirectionDown complete:^(NSString *str) {
        [((UIButton *)sender)setTitle:str forState:UIControlStateNormal];
    }];
    
}


- (IBAction)changeDirectCurrentState:(id)sender {
    [_isDirectCurrentBtn setSelected:!_isDirectCurrentBtn.selected];
    _outputParam.isDirectCurrent = _isDirectCurrentBtn.selected;
}

-(void)deviceConfigCompleteRefreshView:(NSNotification *)noti{
    WeakSelf;
    NSDictionary *data = (NSDictionary *)noti.userInfo;
    self.outputParam.outputDatas = ((BD_StateTestOutputParamModel *)[data objectForKey:@"result"]).outputDatas;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.tableView reloadData];
        });
 
}

- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
