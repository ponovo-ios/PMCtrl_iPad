//
//  BD_SMV61850-9-2VC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV61850-9-2VC.h"
#import "BD_IECSMVSCLFormHeaderView.h"
#import "BD_SMV618502Cell.h"
#import "BD_GooseTransmitLeftFormHeaderView.h"
#import "BD_GooseTransmitLeftFormCell.h"
#import "UIButton+Extension.h"
#import "BD_PopListViewManager.h"
#import "UITextField+Extension.h"
#import "BD_SMVDetailSettingMarkPopViewManager.h"
#import "BD_SMV618502DetailSettingView.h"
#import "BD_SMV618502QualityView.h"
@interface BD_SMV61850_9_2VC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)BD_SMVDetailSettingMarkPopViewManager *markManager;
@end

@implementation BD_SMV61850_9_2VC

#pragma mark - 懒加载
-(BD_SMVDetailSettingMarkPopViewManager *)markManager{
    if (!_markManager) {
        _markManager = [[BD_SMVDetailSettingMarkPopViewManager alloc]init];
    }
    return _markManager;
}
-(NSMutableArray<BD_IECGooseSMVModel_618502Model *> *)topTBViewDataSource{
    if (!_topTBViewDataSource) {
        _topTBViewDataSource = [[NSMutableArray alloc]initWithObjects:[[BD_IECGooseSMVModel_618502Model alloc]initWithTransmit:YES targeMACAddress:@"" sourceMACAddress:@"" APPID:@"" samplingDelayTime:@"" Vlan_priority:@"" Vlan_id:@"" outputPort:@"" describe:@"" passageNum:@"" synchronousStyle:@"" svId:@"" datSet:@""],nil];
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
    t1TimeValue.text = @"80";
    [t1TimeValue setDefaultSetting];
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
    
    NSArray *paramTitles = @[@"DateSet",@"Security",@"SmpRate",@"RefrTm"];
    for (int i=0; i<paramTitles.count; i++) {
        UIButton *selectBt = [[UIButton alloc]init];
//        harmSelBtn_sel  harmSelBtn
        [selectBt setImage:[UIImage imageNamed:@"harmSelBtn"] forState:UIControlStateNormal];
        [selectBt setImage:[UIImage imageNamed:@"harmSelBtn_sel"] forState:UIControlStateSelected];
        [selectBt addTarget:self action:@selector(selectedParamChanged:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:selectBt];
        [selectBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(arrowdown2.mas_right).offset(10+i*140);
            make.centerY.mas_equalTo(arrowdown2);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.textColor = White;
        label.text = paramTitles[i];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selectBt.mas_right).offset(0);
            make.centerY.mas_equalTo(selectBt);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
    }
    
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
    

    [self.topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_SMV618502Cell class]) bundle:nil] forCellReuseIdentifier:@"BD_SMV618502CellID"];
    
    
    
    
    
    
    
    //下方view
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = FormBgColor;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-5);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
        make.top.mas_equalTo(view.mas_bottom).offset(10);
        
    }];

    
    //电压映射 电流映射
    
    UILabel *voltageMapLabel = [[UILabel alloc]init];
    voltageMapLabel.text = @"电压映射到:";
    voltageMapLabel.textColor = White;
    voltageMapLabel.textAlignment = NSTextAlignmentCenter;
    voltageMapLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:voltageMapLabel];
    [voltageMapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(10);
        make.top.mas_equalTo(bottomView.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    UIButton *voltageMapValue = [[UIButton alloc]init];
    [voltageMapValue setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [voltageMapValue.titleLabel setFont:[UIFont systemFontOfSize:13]];
    voltageMapValue.tag = 100;
    [voltageMapValue setTitle:@"Ua1,Ub1,Uc1,3U01,Uz" forState:UIControlStateNormal];
    voltageMapValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    voltageMapValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [voltageMapValue addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:voltageMapValue];
    [voltageMapValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(voltageMapLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(voltageMapLabel);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *voltageArrowdown = [[UILabel alloc]init];
    voltageArrowdown.textColor = White;
    voltageArrowdown.textAlignment = NSTextAlignmentCenter;
    voltageArrowdown.font = [UIFont systemFontOfSize:15];
    voltageArrowdown.text = @"▼";
    [bottomView addSubview:voltageArrowdown];
    [voltageArrowdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(voltageMapValue.mas_right).offset(0);
        make.centerY.mas_equalTo(voltageMapValue);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    
    UILabel *currentMapLabel = [[UILabel alloc]init];
    currentMapLabel.text = @"电流映射到:";
    currentMapLabel.textColor = White;
    currentMapLabel.textAlignment = NSTextAlignmentCenter;
    currentMapLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:currentMapLabel];
    [currentMapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(voltageMapValue.mas_right).offset(20);
        make.centerY.mas_equalTo(voltageMapValue);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(voltageMapLabel);
    }];
    
    UIButton *currentMapValue = [[UIButton alloc]init];
    [currentMapValue setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [currentMapValue.titleLabel setFont:[UIFont systemFontOfSize:13]];
    currentMapValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    currentMapValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    currentMapValue.tag = 110;
    [currentMapValue setTitle:@"Ia1,Ib1,Ic1,3I01" forState:UIControlStateNormal];
    [currentMapValue addTarget:self action:@selector(changeParams:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:currentMapValue];
    [currentMapValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(currentMapLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(currentMapLabel);
        make.width.and.height.mas_equalTo(voltageMapValue);
    }];
    
    UILabel *currentMapArrowdown = [[UILabel alloc]init];
    currentMapArrowdown.textColor = White;
    currentMapArrowdown.textAlignment = NSTextAlignmentCenter;
    currentMapArrowdown.font = [UIFont systemFontOfSize:15];
    currentMapArrowdown.text = @"▼";
    [bottomView addSubview:currentMapArrowdown];
    [currentMapArrowdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(currentMapValue.mas_right).offset(0);
        make.centerY.mas_equalTo(currentMapValue);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    
    
    
    //下方tableView 通道绑定
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [bottomView addSubview:_leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(bottomView.mas_left).offset(10);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-10);
        make.right.mas_equalTo(bottomView.mas_right).offset(-10);
        make.top.mas_equalTo(currentMapValue.mas_bottom).offset(5);
    }];
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = ClearColor;
    
    
    [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseTransmitLeftFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_GooseTransmitLeftFormHeaderViewID"];

    [_leftTableView registerClass:[BD_GooseTransmitLeftFormCell class] forCellReuseIdentifier:@"BD_GooseTransmitLeftFormCellID"];
    
    
    
    
    
    
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
        BD_IECSMVSCLFormHeaderView *topHeaderView = [[BD_IECSMVSCLFormHeaderView alloc]initWithTitls:@[@"是否发布",@"目标MAC地址",@"源MAC地址",@"APPID",@"采样延时(us）",@"VLAN_Priority",@"VLAN_ID",@"输出口选择",@"描述",@"通道数",@"版本号",@"同步方式",@"svID",@"datSet"] viewWidth:self.topscrollView.contentSize.width];
        
        headerView = topHeaderView;
    } else if ([tableView isEqual:_leftTableView]){
        BD_GooseTransmitLeftFormHeaderView * leftHeaderView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_GooseTransmitLeftFormHeaderView class]) owner:nil options:nil].lastObject;
        leftHeaderView.title1.text = @"描述";
        leftHeaderView.title2.text = @"通道类型";
        leftHeaderView.title3.text = @"通道映射";
        leftHeaderView.title4.text = @"品质";
        headerView = leftHeaderView;
    }
    return headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell = [[UITableViewCell alloc]init];
    if ([tableView isEqual:self.topTableView]) {
        BD_SMV618502Cell *sclCell = [tableView dequeueReusableCellWithIdentifier:@"BD_SMV618502CellID" forIndexPath:indexPath];
        [sclCell setDataToCellView:_topTBViewDataSource[indexPath.row]];
        [sclCell viewTagToLabel:1000].text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        
        commoncell = sclCell;
    } else if([tableView isEqual:_leftTableView]){
        BD_GooseTransmitLeftFormCell *leftcell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseTransmitLeftFormCellID" forIndexPath:indexPath];
        leftcell.TransmitLeftFormCellBtnClickBlock = ^(NSInteger columnIndex) {
            NSLog(@"当前选择的是第%ld",(long)columnIndex);
            switch (columnIndex) {
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                case 4:
                    [self leftTBViewColum_QualityAction];
                    break;
                default:
                    break;
            }
        } ;
        commoncell = leftcell;
    }
    return commoncell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCellIndex = indexPath.row;
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
        [_topTBViewDataSource addObject:[[BD_IECGooseSMVModel_618502Model alloc]initWithTransmit:YES targeMACAddress:@"" sourceMACAddress:@"" APPID:@"" samplingDelayTime:@"" Vlan_priority:@"" Vlan_id:@"" outputPort:@"" describe:@"" passageNum:@"" synchronousStyle:@"" svId:@"" datSet:@""]];
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
            [self.topTableView  selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
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

//顶部参数点击事件

-(void)changeParams:(UIButton *)sender{
    
   if (sender.tag ==10){
        //ASDU
        [BD_PopListViewManager ShowPopViewWithlistDataSource:IEC60044ParamArrs_ASDUNUM textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    } else  if(sender.tag == 40){
        //详细设置
        [self showDetailSettingView];
    } else if (sender.tag == 100){
      //电压映射到
        [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"Ua1,Ub1,Uc1,3U01,Uz",@"Ua2,Ub2,Uc2,3U02",@"Ua3,Ub3,Uc3,3U03",@"Ua4,Ub4,Uc4,3U04"] textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    } else if (sender.tag == 110){
     //电流映射到
        [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"Ia1,Ib1,Ic1,3I01",@"Ia2,Ib2,Ic2,3I02",@"Ia3,Ib3,Ic3,3I03",@"Ia4,Ib4,Ic4,3I04"] textField:sender viewController:self  direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedTitle) {
            [sender setTitle:selectedTitle forState:UIControlStateNormal];
        }];
    }
}

//顶部参数选择框点击
-(void)selectedParamChanged:(UIButton *)sender{
    [sender setSelected:!sender.selected];
}


#pragma mark - 显示详细设置页面
-(void)showDetailSettingView{
    WeakSelf;
    BD_SMV618502DetailSettingView *detailSetView = [[BD_SMV618502DetailSettingView alloc]init];
    
    detailSetView.okBlock = ^{
        [weakself.markManager disMissDetailView];
    };
    detailSetView.cancelBlock = ^{
        [self.markManager disMissDetailView];
    };
    self.markManager.detailView = detailSetView;
    [self.markManager instenceViews];
    [self.markManager showDetailViewWithRate:0.7 height:0.7];
    [detailSetView createViews];
}

#pragma mark - 下方列表 第四列 品质点击显示view事件
-(void)leftTBViewColum_QualityAction{
    [self showQualitySetView];
}

//显示品质设置view --下方列表 第四列 quality点击事件
-(void)showQualitySetView{
    WeakSelf;
    
    BD_SMV618502QualityView *qualityView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_SMV618502QualityView class]) owner:nil options:nil].lastObject;
    
    qualityView.okBlock = ^{
        [weakself.markManager disMissDetailView];
    };
    qualityView.cancelBlock = ^{
        [self.markManager disMissDetailView];
    };
    self.markManager.detailView = qualityView;
    [self.markManager instenceViews];
    [self.markManager showDetailViewWithRate:0.45 height:0.7];
   
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
