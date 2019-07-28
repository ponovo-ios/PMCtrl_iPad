//
//  BD_SMV61850-9-1VC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//
#import "BD_SMV61850-9-1VC.h"
#import "BD_IECSMVSCLFormHeaderView.h"
#import "BD_SMV618501Cell.h"
#import "BD_GooseSubLeftFormHeaderView.h"
#import "BD_GooseSubLeftFormCell.h"
#import "UIButton+Extension.h"
#import "BD_PopListViewManager.h"
#import "UITextField+Extension.h"
#import "BD_SMVDetailSettingMarkPopViewManager.h"
#import "BD_SMV618501DetailSettingView.h"
@interface BD_SMV61850_9_1VC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)BD_SMVDetailSettingMarkPopViewManager *markManager;
@end

@implementation BD_SMV61850_9_1VC
#pragma mark - 懒加载
-(BD_SMVDetailSettingMarkPopViewManager *)markManager{
    if (!_markManager) {
        _markManager = [[BD_SMVDetailSettingMarkPopViewManager alloc]init];
    }
    return _markManager;
}


-(NSMutableArray<BD_IECGooseSMVModel_618501Model *> *)topTBViewDataSource{
    if (!_topTBViewDataSource) {
        _topTBViewDataSource = [[NSMutableArray alloc]initWithObjects:[[BD_IECGooseSMVModel_618501Model alloc]initWithisTransmit:YES targeMACAddress:@"" sourceMACAddress:@"" APPID:@"" LDname:@"" DataSetName:@"" Vlan_priority:@"" Vlan_id:@"" outputPort:@"" stateCode1:@"0X000" stateCode2:@"0X000" ratedDelayTime:@"" version:@"" passageNum:@"" describe:@""], nil];
    }
    return _topTBViewDataSource;
}


-(void)confitViews{
    WeakSelf;
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:view];
    view.backgroundColor = FormBgColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself.view.centerX);
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10.0);
        make.top.mas_equalTo(weakself.view.mas_top).offset(5);
        make.height.mas_equalTo(weakself.view).multipliedBy(0.55);
        
    }];
    
    //顶部参数
    UILabel *t1timeLabel = [[UILabel alloc]init];
    t1timeLabel.text = @"采样率";
    t1timeLabel.textColor = White;
    t1timeLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:t1timeLabel];
    [t1timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(10);
        make.top.mas_equalTo(view.mas_top).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
    UITextField *t1TimeValue = [[UITextField alloc]init];
    t1TimeValue.borderStyle = UITextBorderStyleRoundedRect;
    [t1TimeValue setDefaultSetting];
    t1TimeValue.text = @"80";
    [view addSubview:t1TimeValue];
    [t1TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t1timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t1timeLabel);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t2timeLabel = [[UILabel alloc]init];
    t2timeLabel.text = @"ASDU";
    t2timeLabel.textColor = White;
    t2timeLabel.textAlignment = NSTextAlignmentCenter;
    t2timeLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:t2timeLabel];
    [t2timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t1TimeValue.mas_right).offset(30);
        make.centerY.mas_equalTo(t1TimeValue);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(t1timeLabel);
    }];
    
    
    UIButton *t2TimeValue = [[UIButton alloc]init];
    [t2TimeValue setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [t2TimeValue.titleLabel setFont:[UIFont systemFontOfSize:13]];
    t2TimeValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    t2TimeValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    t2TimeValue.tag = 10;
    [t2TimeValue setTitle:@"1" forState:UIControlStateNormal];
    [t2TimeValue addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:t2TimeValue];
    [t2TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t2timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t2timeLabel);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *arrowdown2 = [[UILabel alloc]init];
    arrowdown2.textColor = White;
    arrowdown2.textAlignment = NSTextAlignmentCenter;
    arrowdown2.font = [UIFont systemFontOfSize:15];
    arrowdown2.text = @"▼";
    [view addSubview:arrowdown2];
    [arrowdown2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t2TimeValue.mas_right).offset(0);
        make.centerY.mas_equalTo(t2TimeValue);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *detialSet = [[UIButton alloc]init];
    [detialSet setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [detialSet.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [detialSet setTitle:@"详细设置" forState:UIControlStateNormal];
    detialSet.tag = 40;
    [detialSet addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:detialSet];
    [detialSet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
        make.centerY.mas_equalTo(t2TimeValue);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    //顶部scrollview
    
    self.topscrollView = [UIScrollView new];
    [view addSubview:self.topscrollView];
    self.topscrollView.backgroundColor = FormBgColor;
    self.topscrollView.delegate = self;
    
    [self.topscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.centerX);
        make.left.mas_equalTo(view.mas_left).offset(0);
        make.right.mas_equalTo(view.mas_right).offset(0);
        make.width.mas_equalTo(view.width);
        make.top.mas_equalTo(t1timeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(view).multipliedBy(0.7);
        
    }];
    
    self.topscrollView.contentSize = CGSizeMake(2020,self.topscrollView.height);
    self.topscrollView.showsVerticalScrollIndicator = YES;
    self.topscrollView.showsHorizontalScrollIndicator = YES;
    
    
    
    UIButton *addBtn = [[UIButton alloc]initWithTitle:@"添加" action:@selector(addSCLListItem)];
    [view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(20);
        make.top.equalTo(weakself.topscrollView.mas_bottom).offset(10);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    
    
    UIButton *deleteBtn = [[UIButton alloc]initWithTitle:@"删除" action:@selector(deleteSCLListItem)];
    [view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addBtn.mas_right).offset(20);
        make.top.equalTo(weakself.topscrollView.mas_bottom).offset(10);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    
    UIButton *clearBtn = [[UIButton alloc]initWithTitle:@"清空" action:@selector(clearSCLList)];
    [view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deleteBtn.mas_right).offset(20);
        make.top.equalTo(weakself.topscrollView.mas_bottom).offset(10);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    
    
    self.topscrollView.contentSize = CGSizeMake(2020,self.topscrollView.height);
    self.topscrollView.showsVerticalScrollIndicator = YES;
    self.topscrollView.showsHorizontalScrollIndicator = YES;
    
    //顶部tableview,scl文件导入
    self.topTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.topscrollView addSubview:self.topTableView];
    [self.topTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topscrollView.mas_top);
        make.left.mas_equalTo(self.topscrollView.mas_left);
        make.width.mas_equalTo(self.topscrollView.contentSize.width);
        make.height.mas_equalTo(self.topscrollView);
        
    }];
    
    self.topTableView.delegate = self;
    self.topTableView.dataSource = self;
    self.topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topTableView.backgroundColor = ClearColor;
    
    
    [self.topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_SMV618501Cell class]) bundle:nil] forCellReuseIdentifier:@"BD_SMV618501CellID"];
    
    
    
    
    
    
    //左侧tableView 通道绑定
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-5);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
        make.top.mas_equalTo(view.mas_bottom).offset(10);
        
    }];
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = ClearColor;
    
    
    [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubLeftFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_GooseSubLeftFormHeaderViewID"];
    
    [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubLeftFormCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_GooseSubLeftFormCellID"];
    
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.topTableView]) {
        return self.topTBViewDataSource.count;
    } else if ([tableView isEqual:_leftTableView]){
        return 5;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.topTableView]) {
        return 50;
    } else if ([tableView isEqual:_leftTableView]){
        return 35;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView;
    if ([tableView isEqual:self.topTableView]) {
        BD_IECSMVSCLFormHeaderView *topHeaderView = [[BD_IECSMVSCLFormHeaderView alloc]initWithTitls:@[@"是否发布",@"目标MAC地址",@"源MAC地址",@"APPID",@"LDName",@"DataSetName",@"VLAN_Priority",@"VLAN_ID",@"输出口选择",@"状态字#1",@"状态字#2",@"额定延时(ms)",@"配置版本号",@"通道个数",@"描述"] viewWidth:self.topscrollView.contentSize.width];
        
        headerView = topHeaderView;
    } else if ([tableView isEqual:_leftTableView]){
        BD_GooseSubLeftFormHeaderView * leftHeaderView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_GooseSubLeftFormHeaderView class]) owner:nil options:nil].lastObject;
        leftHeaderView.firstLineView.hidden = YES;
        leftHeaderView.describeLaelLeading.constant = 10;
        headerView = leftHeaderView;
    }
    return headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell = [[UITableViewCell alloc]init];
    if ([tableView isEqual:self.topTableView]) {
        BD_SMV618501Cell *sclCell = [tableView dequeueReusableCellWithIdentifier:@"BD_SMV618501CellID" forIndexPath:indexPath];
      
        [sclCell viewTagToLabel:1000].text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [sclCell setDataToCellView:_topTBViewDataSource[indexPath.row]];
        commoncell = sclCell;
        
    } else if([tableView isEqual:_leftTableView]){
        BD_GooseSubLeftFormCell *leftcell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseSubLeftFormCellID" forIndexPath:indexPath];
        leftcell.cellSelectedBtn.hidden = YES;
        leftcell.firstLineView.hidden = YES;
        leftcell.describeValueLeading.constant = 10;
        commoncell = leftcell;
    }
    return commoncell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addSCLListItem{
    DLog(@"添加");
    if (_topTBViewDataSource.count!=0) {
        [_topTBViewDataSource addObject:[_topTBViewDataSource firstObject]];
    } else {
        [_topTBViewDataSource addObject:[[BD_IECGooseSMVModel_618501Model alloc]initWithisTransmit:YES targeMACAddress:@"" sourceMACAddress:@"" APPID:@"" LDname:@"" DataSetName:@"" Vlan_priority:@"" Vlan_id:@"" outputPort:@"" stateCode1:@"0X000" stateCode2:@"0X000" ratedDelayTime:@"" version:@"" passageNum:@"" describe:@""]];
    }
    [self.topTableView  reloadData];
    self.selectedCellIndex = self.selectedCellIndex+1;
    [self.topTableView  selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}
-(void)deleteSCLListItem{
    DLog(@"删除");
    if (_topTBViewDataSource.count!=0) {
        [BD_PopListViewManager showAlertView:self title:@"警告" message:[NSString stringWithFormat:@"是否删除第【%ld】行",self.self.selectedCellIndex+1] okAction:^{
            [_topTBViewDataSource removeObjectAtIndex:self.self.selectedCellIndex];
            [self.topTableView  reloadData];
            self.self.selectedCellIndex = self.self.selectedCellIndex-1;
            [self.topTableView  selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.self.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }];
    } else {
        [MBProgressHUDUtil showMessage:kListNoData toView:self.view];
    }
    
    
    
}
-(void)clearSCLList{
    DLog(@"清除");
    self.self.selectedCellIndex = -1;
    [_topTBViewDataSource removeAllObjects];
    [self.topTableView  reloadData];
}


-(void)changeParams:(UIButton *)sender{
    
    if (sender.tag ==10){
        //ASDU
        [BD_PopListViewManager ShowPopViewWithlistDataSource:IEC60044ParamArrs_ASDUNUM textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    } else  if(sender.tag == 40){
        //详细设置
        [self showDetailSettingView];
    }
}

#pragma mark - 显示详细设置页面
-(void)showDetailSettingView{
    WeakSelf;
    BD_SMV618501DetailSettingView *detailSetView = [[BD_SMV618501DetailSettingView alloc]init];
    
    detailSetView.okBlock = ^{
        [weakself.markManager disMissDetailView];
    };
    detailSetView.cancelBlock = ^{
        [self.markManager disMissDetailView];
    };
    self.markManager.detailView = detailSetView;
    [self.markManager instenceViews];
    [self.markManager showDetailViewWithRate:0.8 height:0.6];
    [detailSetView createViews];
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
