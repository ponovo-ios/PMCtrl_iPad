//
//  BD_IECGooseTransmitVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECGooseTransmitVC.h"
#import "BD_IECGooseTransmitFormHeaderView.h"
#import "BD_GooseTransmitSCLFormCell.h"
#import "BD_GooseTransmitLeftFormHeaderView.h"
#import "BD_GooseTransmitLeftFormCell.h"
#import "UIButton+Extension.h"
#import "UITextField+Extension.h"
@interface BD_IECGooseTransmitVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
}

@property(nonatomic,strong)UITableView *leftTableView;

@end

@implementation BD_IECGooseTransmitVC

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
        
        make.height.mas_equalTo(weakself.view).multipliedBy(0.55);
        
    }];
    
    //顶部参数
    UILabel *t1timeLabel = [[UILabel alloc]init];
    t1timeLabel.text = @"T1时间(ms)";
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
    [view addSubview:t1TimeValue];
    [t1TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t1timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t1timeLabel);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
    UILabel *t2timeLabel = [[UILabel alloc]init];
    t2timeLabel.text = @"T2时间(ms)";
    t2timeLabel.textColor = White;
    t2timeLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:t2timeLabel];
    [t2timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t1TimeValue.mas_right).offset(10);
        make.centerY.mas_equalTo(t1TimeValue);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(t1timeLabel);
    }];
    
    UITextField *t2TimeValue = [[UITextField alloc]init];
    t2TimeValue.borderStyle = UITextBorderStyleRoundedRect;
    [t2TimeValue setDefaultSetting];
    [view addSubview:t2TimeValue];
    [t2TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t2timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t2timeLabel);
        make.width.and.height.mas_equalTo(t1TimeValue);
    }];
    
    
    UILabel *t0timeLabel = [[UILabel alloc]init];
    t0timeLabel.text = @"T0时间(ms)";
    t0timeLabel.textColor = White;
    t0timeLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:t0timeLabel];
    [t0timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t2TimeValue.mas_right).offset(10);
        make.centerY.mas_equalTo(t2TimeValue);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(t1timeLabel);
    }];
    
    UITextField *t0TimeValue = [[UITextField alloc]init];
    t0TimeValue.borderStyle = UITextBorderStyleRoundedRect;
    [t0TimeValue setDefaultSetting];
    [view addSubview:t0TimeValue];
    [t0TimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t0timeLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(t0timeLabel);
        make.width.and.height.mas_equalTo(t1TimeValue);
    }];

    UILabel *timeQualityLabel = [[UILabel alloc]init];
    timeQualityLabel.text = @"时间品质(A)";
    timeQualityLabel.textColor = White;
    timeQualityLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:timeQualityLabel];
    [timeQualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(t0TimeValue.mas_right).offset(10);
        make.centerY.mas_equalTo(t0TimeValue);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(t1timeLabel);
    }];
    
    UITextField *timeQualityValue = [[UITextField alloc]init];
    timeQualityValue.borderStyle = UITextBorderStyleRoundedRect;
    [timeQualityValue setDefaultSetting];
    [view addSubview:timeQualityValue];
    [timeQualityValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeQualityLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(timeQualityLabel);
        make.width.and.height.mas_equalTo(t1TimeValue);
    }];
    
    UILabel *groupDelayLabel = [[UILabel alloc]init];
    groupDelayLabel.text = @"组间延时(ms)";
    groupDelayLabel.textColor = White;
    groupDelayLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:groupDelayLabel];
    [groupDelayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeQualityValue.mas_right).offset(10);
        make.centerY.mas_equalTo(timeQualityValue);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(t1timeLabel);
    }];
    
    UITextField *groupDelayValue = [[UITextField alloc]init];
    groupDelayValue.borderStyle = UITextBorderStyleRoundedRect;
    [groupDelayValue setDefaultSetting];
    [view addSubview:groupDelayValue];
    [groupDelayValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(groupDelayLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(groupDelayLabel);
        make.width.and.height.mas_equalTo(t1TimeValue);
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
    self.topscrollView.showsVerticalScrollIndicator = NO;
    self.topscrollView.showsHorizontalScrollIndicator = NO;
    
    
    
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
    
  
    
    [self.topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_IECGooseTransmitFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_IECGooseTransmitFormHeaderViewID"];
    [self.topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseTransmitSCLFormCell class]) bundle:nil] forCellReuseIdentifier:@"BD_GooseTransmitSCLFormCellID"];
    
    
    
    
    
    
    //左侧tableView 通道绑定
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-60);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
        make.height.mas_equalTo(weakself.view).multipliedBy(0.35);
    }];
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = ClearColor;
   
    
    [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseTransmitLeftFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_GooseSubLeftFormHeaderViewID"];
    [_leftTableView registerClass:[BD_GooseTransmitLeftFormCell class] forCellReuseIdentifier:@"BD_GooseTransmitLeftFormCellID"];
    
   
    
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.topTableView]) {
        return self.topTBViewDataSource.count;
    } else if ([tableView isEqual:_leftTableView]){
        return self.bottomTBViewDataSource.count;
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
        BD_IECGooseTransmitFormHeaderView *topHeaderView = [[NSBundle mainBundle]loadNibNamed:@"BD_IECGooseTransmitFormHeaderView" owner:nil options:nil].lastObject;
        headerView = topHeaderView;
    } else if ([tableView isEqual:_leftTableView]){
        BD_GooseTransmitLeftFormHeaderView * leftHeaderView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_GooseTransmitLeftFormHeaderView class]) owner:nil options:nil].lastObject;
        headerView = leftHeaderView;
    }
    return headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell = [[UITableViewCell alloc]init];
    if ([tableView isEqual:self.topTableView]) {
        BD_GooseTransmitSCLFormCell *sclCell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseTransmitSCLFormCellID" forIndexPath:indexPath];
        [sclCell viewTagToLabel:1000].text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [sclCell setDataToCellView:_topTBViewDataSource[indexPath.row]];
        commoncell = sclCell;
    } else if([tableView isEqual:_leftTableView]){
        BD_GooseTransmitLeftFormCell *leftcell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseTransmitLeftFormCellID" forIndexPath:indexPath];
        leftcell.TransmitLeftFormCellBtnClickBlock = ^(NSInteger columnIndex) {
          
        };
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
        [_topTBViewDataSource addObject:[[BD_IECGooseTransmitSCLDataModel alloc] initWithTransmit:YES targeMACAddress:@"" souceMACAddress:@"" APPID:@""  Vlan_priority:@""  Vlan_id:@""  outputOpticalport:@"" describe:@"" passageNum:@"" version:@"" isTest:NO gocbRef:@"" datSet:@"" goId:@"" ndsCom:NO alowExistTime:@""]];
    }
     [self.topTableView reloadData];
    self.selectedCellIndex = self.selectedCellIndex+1;
    [self.topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
   
}
-(void)deleteSCLListItem{
    DLog(@"删除");
    if (_topTBViewDataSource.count != 0) {
        [BD_PopListViewManager showAlertView:self title:@"警告" message:[NSString stringWithFormat:@"是否删除第【%ld】行",self.selectedCellIndex+1] okAction:^{
            [_topTBViewDataSource removeObjectAtIndex:self.selectedCellIndex];
            [self.topTableView reloadData];
            self.selectedCellIndex = self.selectedCellIndex-1;
            [self.topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }];
    } else {
         [MBProgressHUDUtil showMessage:kListNoData toView:self.view];
    }
}
-(void)clearSCLList{
    DLog(@"清除");
    self.selectedCellIndex = -1;
    [_topTBViewDataSource removeAllObjects];
     [self.topTableView reloadData];
}



#pragma mark - 懒加载
-(NSMutableArray<BD_IECGooseTransmitSCLDataModel *> *)topTBViewDataSource{
    if (!_topTBViewDataSource) {
        _topTBViewDataSource = [[NSMutableArray alloc]initWithObjects:[[BD_IECGooseTransmitSCLDataModel alloc] initWithTransmit:YES targeMACAddress:@"" souceMACAddress:@"" APPID:@""  Vlan_priority:@""  Vlan_id:@""  outputOpticalport:@"" describe:@"" passageNum:@"" version:@"" isTest:NO gocbRef:@"" datSet:@"" goId:@"" ndsCom:NO alowExistTime:@""], nil];
    }
    return _topTBViewDataSource;
}

-(NSMutableArray<BD_IECGooseTransmitPassageModel *> *)bottomTBViewDataSource{
    if(_bottomTBViewDataSource){
        _bottomTBViewDataSource = [[NSMutableArray alloc]init];
    }
    return _bottomTBViewDataSource;
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
