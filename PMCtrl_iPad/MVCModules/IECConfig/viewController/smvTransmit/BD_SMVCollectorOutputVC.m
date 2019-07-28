//
//  BD_SMVCollectorOutputVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVCollectorOutputVC.h"

#import "BD_IECSMVSCLFormHeaderView.h"
#import "BD_SMVCollectorOutputCell.h"

#import "BD_GooseSubLeftFormHeaderView.h"
#import "BD_GooseSubLeftFormCell.h"
#import "UIButton+Extension.h"

#import "BD_SMVCollectorOutputDetailSettingView.h"
#import "BD_SMVDetailSettingMarkPopViewManager.h"
@interface BD_SMVCollectorOutputVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)BD_SMVDetailSettingMarkPopViewManager *markManager;
@end

@implementation BD_SMVCollectorOutputVC

-(void)confitViews{
    [super confitViews];
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
    UILabel *messageType = [[UILabel alloc]init];
    messageType.text = @"报文类型";
    messageType.textColor = White;
    messageType.textAlignment = NSTextAlignmentCenter;
    messageType.font = [UIFont systemFontOfSize:15];
    [view addSubview:messageType];
    [messageType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(10);
        make.top.mas_equalTo(view.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    UIButton *messageTypeValue = [[UIButton alloc]init];
    [messageTypeValue setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [messageTypeValue.titleLabel setFont:[UIFont systemFontOfSize:13]];
    messageTypeValue.tag = 10;
    [messageTypeValue setTitle:@"国网" forState:UIControlStateNormal];
    messageTypeValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    messageTypeValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [messageTypeValue addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:messageTypeValue];
    [messageTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(messageType.mas_right).offset(0);
        make.centerY.mas_equalTo(messageType);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *arrowdown1 = [[UILabel alloc]init];
    arrowdown1.textColor = White;
    arrowdown1.textAlignment = NSTextAlignmentCenter;
    arrowdown1.font = [UIFont systemFontOfSize:15];
    arrowdown1.text = @"▼";
    [view addSubview:arrowdown1];
    [arrowdown1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(messageTypeValue.mas_right).offset(0);
        make.centerY.mas_equalTo(messageTypeValue);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    
    UILabel *t2timeLabel = [[UILabel alloc]init];
    t2timeLabel.text = @"采样率";
    t2timeLabel.textColor = White;
    t2timeLabel.textAlignment = NSTextAlignmentCenter;
    t2timeLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:t2timeLabel];
    [t2timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(messageTypeValue.mas_right).offset(30);
        make.centerY.mas_equalTo(messageTypeValue);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(messageType);
    }];
    
    UIButton *t2TimeValue = [[UIButton alloc]init];
    [t2TimeValue setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [t2TimeValue.titleLabel setFont:[UIFont systemFontOfSize:13]];
    t2TimeValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    t2TimeValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    t2TimeValue.tag = 20;
    [t2TimeValue setTitle:@"5kHz" forState:UIControlStateNormal];
    [t2TimeValue addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:t2TimeValue];
    [t2TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t2timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t2timeLabel);
        make.width.and.height.mas_equalTo(messageTypeValue);
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
    
    
    UILabel *t0timeLabel = [[UILabel alloc]init];
    t0timeLabel.text = @"波特率";
    t0timeLabel.textColor = White;
    t0timeLabel.textAlignment = NSTextAlignmentCenter;
    t0timeLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:t0timeLabel];
    [t0timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t2TimeValue.mas_right).offset(30);
        make.centerY.mas_equalTo(t2TimeValue);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(messageType);
    }];
    
    UIButton *t0TimeValue = [[UIButton alloc]init];
    [t0TimeValue setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [t0TimeValue.titleLabel setFont:[UIFont systemFontOfSize:13]];
    t0TimeValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    t0TimeValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [t0TimeValue setTitle:@"2.5Mbps" forState:UIControlStateNormal];
    t0TimeValue.tag = 30;
    [t0TimeValue addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:t0TimeValue];
    [t0TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t0timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t0timeLabel);
        make.width.and.height.mas_equalTo(messageTypeValue);
    }];
    
    UILabel *arrowdown3 = [[UILabel alloc]init];
    arrowdown3.textColor = White;
    arrowdown3.textAlignment = NSTextAlignmentCenter;
    arrowdown3.font = [UIFont systemFontOfSize:15];
    arrowdown3.text = @"▼";
    [view addSubview:arrowdown3];
    [arrowdown3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t0TimeValue.mas_right).offset(0);
        make.centerY.mas_equalTo(t0TimeValue);
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
        make.centerY.mas_equalTo(t0timeLabel);
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
        make.top.mas_equalTo(messageType.mas_bottom).offset(10);
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
    
    
    self.topscrollView.contentSize = CGSizeMake(1520,self.topscrollView.height);
    self.topscrollView.showsVerticalScrollIndicator = YES;
    self.topscrollView.showsHorizontalScrollIndicator = YES;
    
    //顶部tableview,scl文件导入
    self.topTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.topscrollView addSubview:self.topTableView ];
    [self.topTableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topscrollView.mas_top);
        make.left.mas_equalTo(self.topscrollView.mas_left);
        make.width.mas_equalTo(self.topscrollView.contentSize.width);
        make.height.mas_equalTo(self.topscrollView);
        
    }];
    
    self.topTableView .delegate = self;
    self.topTableView .dataSource = self;
    self.topTableView .separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topTableView .backgroundColor = ClearColor;
    
    
    [self.topTableView  registerNib:[UINib nibWithNibName:NSStringFromClass([BD_SMVCollectorOutputCell class]) bundle:nil] forCellReuseIdentifier:@"BD_SMVCollectorOutputCellID"];
    
    
    
    
    
    
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
    if ([tableView isEqual:self.topTableView ]) {
        return self.topTBViewDataSource.count;
    } else if ([tableView isEqual:_leftTableView]){
        return 5;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.topTableView ]) {
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
    if ([tableView isEqual:self.topTableView ]) {
        BD_IECSMVSCLFormHeaderView *view = [[BD_IECSMVSCLFormHeaderView alloc]initWithTitls:@[@"是否发布",@"互感器类型",@"描述",@"光口",@"温度(°)",@"通道个数",@"额定延时",@"状态字#1",@"状态字#2"] viewWidth:self.topscrollView.contentSize.width];
       
       headerView = view;
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
    if ([tableView isEqual:self.topTableView ]) {
        BD_SMVCollectorOutputCell *sclCell = [tableView dequeueReusableCellWithIdentifier:@"BD_SMVCollectorOutputCellID" forIndexPath:indexPath];
        [sclCell setDataToCellView:_topTBViewDataSource[indexPath.row]];
        [sclCell viewTagToLabel:1000].text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCellIndex = indexPath.row;
}


-(void)addSCLListItem{
    DLog(@"添加");
    if (_topTBViewDataSource.count!=0) {
        [_topTBViewDataSource addObject:[_topTBViewDataSource firstObject]];
    } else {
        [_topTBViewDataSource addObject:[[BD_IECGooseSMVModel_CollectorOutputModel alloc]initWithTransmit:YES transformerType:@"" describe:@"" opticalport:@"" temperature:@"" passageNum:@"" ratedDelayTime:@"" stateObject1:@"0X0000" stateObject2:@"0X0000"]];
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
   
    if (sender.tag == 10) {
        [BD_PopListViewManager ShowPopViewWithlistDataSource:IECControllorOutputParamArrs_MessType textField:sender viewController:self direction:UIPopoverArrowDirectionUp  complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    } else if (sender.tag ==20){
        [BD_PopListViewManager ShowPopViewWithlistDataSource:IECControllorOutputParamArrs_SamplingRate textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    } else if  (sender.tag == 30 ){
        [BD_PopListViewManager ShowPopViewWithlistDataSource:IECControllorOutputParamArrs_BaudRate textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    } else if(sender.tag == 40){
        //详细设置页面
        [self showDetailSettingView];
    }
}

#pragma mark - 显示详细设置页面
-(void)showDetailSettingView{
    WeakSelf;
    BD_SMVCollectorOutputDetailSettingView *detailSetView = [[BD_SMVCollectorOutputDetailSettingView alloc]init];
   
    detailSetView.okBlock = ^{
        [weakself.markManager disMissDetailView];
    };
    detailSetView.cancelBlock = ^{
        [self.markManager disMissDetailView];
    };
    self.markManager.detailView = detailSetView;
    [self.markManager instenceViews];
    [self.markManager showDetailViewWithRate:0.7 height:0.6];
    [detailSetView createViews];
}

#pragma mark - 懒加载
-(NSMutableArray<BD_IECGooseSMVModel_CollectorOutputModel *>*)topTBViewDataSource{
    if (!_topTBViewDataSource) {
        _topTBViewDataSource = [[NSMutableArray alloc]initWithObjects:[[BD_IECGooseSMVModel_CollectorOutputModel alloc]initWithTransmit:YES transformerType:@"" describe:@"" opticalport:@"" temperature:@"" passageNum:@"" ratedDelayTime:@"" stateObject1:@"0X0000" stateObject2:@"0X0000"], nil];
    }
    return _topTBViewDataSource;
}

-(BD_SMVDetailSettingMarkPopViewManager *)markManager{
    if (!_markManager) {
        _markManager = [[BD_SMVDetailSettingMarkPopViewManager alloc]init];
    }
    return _markManager;
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
