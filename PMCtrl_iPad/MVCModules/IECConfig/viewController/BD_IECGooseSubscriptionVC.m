//
//  BD_IECGooseSubscriptionVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECGooseSubscriptionVC.h"
#import "BD_IECGooseSubscriptionFormHeaderView.h"
#import "BD_GooseSubSCLFormCell.h"
#import "BD_GooseSubLeftFormCell.h"
#import "BD_GooseSubLeftFormHeaderView.h"
#import "BD_GooseSubRightFormHeaderView.h"
#import "BD_GooseSubRigthFormCell.h"
#import "UIButton+Extension.h"
#import "BD_PopListViewManager.h"
#define passageTypeArr  [[NSArray alloc]initWithObjects:@"单点",@"双点",@"时间",@"品质",@"浮点",@"字符串",@"结构",@"INT32",@"INT32U", nil]
@interface BD_IECGooseSubscriptionVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,BD_GooseSubLeftFormCellDelegate>{
    NSInteger selectedCellIndex;
}
@property(nonatomic,strong)UIScrollView *topscrollView;
@property(nonatomic,strong)UITableView *topTableView;
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;

@end


@implementation BD_IECGooseSubscriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self confitViews];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置默认选中第一行，必须在viewwillAppear中写
    NSIndexPath * selIndex = [NSIndexPath indexPathForRow:selectedCellIndex inSection:0];
    [_topTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
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
        make.height.mas_equalTo(weakself.view).multipliedBy(0.5);
        
    }];
    
    //顶部scrollview
    
    _topscrollView = [UIScrollView new];
    [view addSubview:_topscrollView];
    _topscrollView.backgroundColor = FormBgColor;
    _topscrollView.delegate = self;
    
    [_topscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.centerX);
        make.left.mas_equalTo(view.mas_left).offset(0);
        make.right.mas_equalTo(view.mas_right).offset(0);
        make.width.mas_equalTo(view.width);
        make.height.mas_equalTo(view).multipliedBy(0.8);
        
    }];

    _topscrollView.contentSize = CGSizeMake(2020,_topscrollView.height);
    _topscrollView.showsVerticalScrollIndicator = NO;
    _topscrollView.showsHorizontalScrollIndicator = NO;
   
    //顶部tableview,scl文件导入
    _topTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [_topscrollView addSubview:_topTableView];
    [_topTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(weakself.view.centerX);
        
        make.top.and.left.and.right.mas_equalTo(0.0);
        make.height.mas_equalTo(weakself.topscrollView);
       
        
    }];
    _topTableView.delegate = self;
    _topTableView.dataSource = self;
    _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _topTableView.backgroundColor = ClearColor;
  
    [_topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_IECGooseSubscriptionFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_IECGooseSubscriptionFormHeaderViewID"];
    [_topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubSCLFormCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_GooseSubSCLFormCellID"];

    UIButton *addBtn = [[UIButton alloc]initWithTitle:@"添加" action:@selector(addSCLListItem)];
    [view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(20);
        make.top.equalTo(weakself.topscrollView.mas_bottom).offset(20);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    
    
    UIButton *deleteBtn = [[UIButton alloc]initWithTitle:@"删除" action:@selector(deleteSCLListItem)];
    [view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addBtn.mas_right).offset(20);
        make.top.equalTo(weakself.topscrollView.mas_bottom).offset(20);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    
    UIButton *clearBtn = [[UIButton alloc]initWithTitle:@"清空" action:@selector(clearSCLList)];
    [view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deleteBtn.mas_right).offset(20);
        make.top.equalTo(weakself.topscrollView.mas_bottom).offset(20);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(30.0);
    }];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = FormBgColor;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-60);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
        make.top.mas_equalTo(view.mas_bottom).offset(10);
        
    }];
    
    UIButton *clearMapBtn = [[UIButton alloc]initWithTitle:@"清空映射" action:@selector(clearPassagewayMap)];
    
    [bottomView addSubview:clearMapBtn];
    [clearMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView.mas_right).offset(-10);
        make.top.mas_equalTo(bottomView.mas_top).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *describeLabel = [[UILabel alloc]init];
    [bottomView addSubview:describeLabel];
    describeLabel.textColor = Red;
    describeLabel.text = @"在左侧列表选中，双击右侧列表进行绑定";
    describeLabel.font = [UIFont systemFontOfSize:13];
    describeLabel.numberOfLines = 0;
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(5);
        make.left.mas_equalTo(bottomView.mas_left).offset(10);
        make.right.mas_equalTo(clearMapBtn.mas_left).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    
    //左侧tableView 通道绑定
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [bottomView addSubview:_leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(bottomView.mas_left).offset(0);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-6);
        make.width.mas_equalTo((weakself.view.width-40)/2);
        make.top.mas_equalTo(describeLabel.mas_bottom).offset(5);
        
    }];
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = ClearColor;
    
    
    [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubLeftFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_GooseSubLeftFormHeaderViewID"];
    [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubLeftFormCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_GooseSubLeftFormCellID"];
    
    //右侧tabelview 开入开出绑定
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [bottomView addSubview:_rightTableView];
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(describeLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(bottomView.mas_right).offset(0);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-5);
        make.width.mas_equalTo(_leftTableView);
     
    }];
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.backgroundColor = ClearColor;
    
    [_rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubRightFormHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BD_GooseSubRightFormHeaderViewID"];
    [_rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_GooseSubRigthFormCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_GooseSubRigthFormCellID"];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_topTableView]) {
        return self.topTBViewDataSource.count;
    } else if ([tableView isEqual:_leftTableView]){
        return self.leftTBViewDataSource.count;
    } else if ([tableView isEqual:_rightTableView]){
        return self.rightTBViewDataSource.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_topTableView]) {
        return 50;
    } else if ([tableView isEqual:_leftTableView]){
        return 35;
    } else if ([tableView isEqual:_rightTableView]){
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
    if ([tableView isEqual:_topTableView]) {
        BD_IECGooseSubscriptionFormHeaderView *topHeaderView = [[NSBundle mainBundle]loadNibNamed:@"BD_IECGooseSubscriptionFormHeaderView" owner:nil options:nil].lastObject;
        headerView = topHeaderView;
    } else if ([tableView isEqual:_leftTableView]){
        BD_GooseSubLeftFormHeaderView *leftHeaderView = [[NSBundle mainBundle]loadNibNamed:@"BD_GooseSubLeftFormHeaderView" owner:nil options:nil].lastObject;
        headerView = leftHeaderView;
    } else if ([tableView isEqual:_rightTableView]){
        BD_GooseSubRightFormHeaderView *rightHeaderView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_GooseSubRightFormHeaderView class]) owner:nil options:nil].lastObject;
        headerView = rightHeaderView;
    }
    return headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    UITableViewCell *commoncell = [[UITableViewCell alloc]init];
    if ([tableView isEqual:_topTableView]) {
        BD_GooseSubSCLFormCell *formcell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseSubSCLFormCellID" forIndexPath:indexPath];
        [formcell viewTagToLabel:1000].text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [formcell setDataToCellView:_topTBViewDataSource[indexPath.row]];
        commoncell = formcell;
    } else if([tableView isEqual:_leftTableView]){
        BD_GooseSubLeftFormCell *leftcell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseSubLeftFormCellID" forIndexPath:indexPath];
        leftcell.cellIndex = indexPath.row;
        [leftcell setCellData:_leftTBViewDataSource[indexPath.row]];
        leftcell.leftDelegate = self;
        leftcell.passageCellSelectedBlock = ^(NSInteger cellindexm,BOOL state) {
           
            [weakself.leftTBViewDataSource enumerateObjectsUsingBlock:^(BD_IECGooseTransmitPassageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isselected = NO;
            }];
            weakself.leftTBViewDataSource[indexPath.row].isselected = state;
            
            [self.leftTableView reloadData];
        };
        commoncell = leftcell;
    } else if ([tableView isEqual:_rightTableView]){
        BD_GooseSubRigthFormCell *rightcell = [tableView dequeueReusableCellWithIdentifier:@"BD_GooseSubRigthFormCellID" forIndexPath:indexPath];
        [rightcell setCellData:_rightTBViewDataSource[indexPath.row]];

        __weak typeof(rightcell) weakrightcell = rightcell;
        rightcell.BindingPassageMapBlock = ^(IECGooseSubscriptionBindingType type) {
            switch (type) {
                case IECGooseSubscriptionBindingType_Selected:
                    [_rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                    break;
                case IECGooseSubscriptionBindingType_Binding:
                    [_rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                    //TODO:重新给对应的cell赋值，显示绑定数据
                    weakrightcell.currentPassageIsBinding = YES;
                    DLog(@"绑定")
                    break;
                case IECGooseSubscriptionBindingType_Unbinding:
                    [_rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                    //TODO:重新给对应的cell赋值，解除绑定数据
                    weakrightcell.currentPassageIsBinding = NO;
                      DLog(@"解绑")
                default:
                    break;
            }
        };
        commoncell = rightcell;
    }
    return commoncell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_topTableView]) {
        selectedCellIndex = indexPath.row;
    }
    if ([tableView isEqual:_rightTableView]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - leftTableView delegate
-(void)passageMapListShow:(UIButton *)sender cellIndex:(NSInteger)cellIndex{
    WeakSelf;
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"0",_rightTBViewDataSource[0].binary,_rightTBViewDataSource[1].binary,_rightTBViewDataSource[2].binary,_rightTBViewDataSource[3].binary,_rightTBViewDataSource[4].binary,_rightTBViewDataSource[5].binary,_rightTBViewDataSource[6].binary,_rightTBViewDataSource[7].binary] textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        [sender setTitle:title forState:UIControlStateNormal];
         weakself.leftTBViewDataSource[cellIndex].passageMap = title;
        //TODO：修改leftTableView中数据源
    }];
}
-(void)passageTypeListShow:(UIButton *)sender cellIndex:(NSInteger)cellIndex{
    WeakSelf;
    [BD_PopListViewManager ShowPopViewWithlistDataSource:passageTypeArr textField:sender viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        [sender setTitle:title forState:UIControlStateNormal];
        weakself.leftTBViewDataSource[cellIndex].passageType = title;
        //TODO：修改leftTableView中数据源
    }];
}

-(void)addSCLListItem{
    DLog(@"添加");
    if (_topTBViewDataSource.count!=0) {
        [_topTBViewDataSource addObject:[_topTBViewDataSource firstObject]];
    } else {
        [_topTBViewDataSource addObject:[[BD_IECGooseSubscriptionSCLDataModel alloc]initWithTransmit:YES targeMACAddress:@"" APPID:@"" SubscriptionOpticalport:@"" describe:@"" passageNum:@"" version:@"" isTest:NO gocbRef:@"" datSet:@"" goId:@"" ndsCom:NO alowExistTime:@"" isAnalysis:NO]];
    }
    [_topTableView reloadData];
    selectedCellIndex = selectedCellIndex+1;
    [_topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}
-(void)deleteSCLListItem{
    DLog(@"删除");
    
    if (_topTBViewDataSource.count!=0) {
        [BD_PopListViewManager showAlertView:self title:@"警告" message:[NSString stringWithFormat:@"是否删除第【%ld】行",selectedCellIndex+1] okAction:^{
            [_topTBViewDataSource removeObjectAtIndex:selectedCellIndex];
            [_topTableView reloadData];
            selectedCellIndex = selectedCellIndex-1;
            [_topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }];
    } else {
         [MBProgressHUDUtil showMessage:kListNoData toView:self.view];
    }

    
    
}
-(void)clearSCLList{
    DLog(@"清除");
    selectedCellIndex = -1;
    [_topTBViewDataSource removeAllObjects];
    [_topTableView reloadData];
}

-(void)clearPassagewayMap{
    DLog(@"清空映射");
    [_rightTBViewDataSource enumerateObjectsUsingBlock:^(BD_IECGooseSubscriptionPassageMapModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bindingAppID = @"---";
        obj.bindingPassage = @"---";
        obj.bindingMACAddress = @"---";
    }];
    [_leftTBViewDataSource enumerateObjectsUsingBlock:^(BD_IECGooseTransmitPassageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.passageMap = @"0";
    }];
    [_leftTableView reloadData];
    [_rightTableView reloadData];
}


#pragma mark - 懒加载
-(NSMutableArray<BD_IECGooseSubscriptionSCLDataModel *> *)topTBViewDataSource{
    if (!_topTBViewDataSource) {
        _topTBViewDataSource = [[NSMutableArray alloc]initWithObjects:[[BD_IECGooseSubscriptionSCLDataModel alloc]initWithTransmit:YES targeMACAddress:@"" APPID:@"" SubscriptionOpticalport:@"" describe:@"" passageNum:@"" version:@"" isTest:NO gocbRef:@"" datSet:@"" goId:@"" ndsCom:NO alowExistTime:@"" isAnalysis:NO], nil];
    }
    return _topTBViewDataSource;
}

-(NSMutableArray<BD_IECGooseSubscriptionPassageMapModel*>*)rightTBViewDataSource{
    if (!_rightTBViewDataSource) {
        _rightTBViewDataSource = [[NSMutableArray alloc]init];
        for (NSInteger i = 0;i<8;i++) {
            [_rightTBViewDataSource addObject:[[BD_IECGooseSubscriptionPassageMapModel alloc]initWithBinary:[NSString stringWithFormat:@"开入%ld",i+1] bindingMACAddress:@"---" bindingAppID:@"---" bindingPassage:@"---"]];
        }
    }
    return _rightTBViewDataSource;
}

-(NSMutableArray<BD_IECGooseTransmitPassageModel *> *)leftTBViewDataSource{
    if (!_leftTBViewDataSource) {
        _leftTBViewDataSource = [[NSMutableArray alloc]init];
        for (NSInteger i = 0;i<8;i++) {
            [_leftTBViewDataSource addObject:[[BD_IECGooseTransmitPassageModel alloc]initWithDescribe:@"" passageType:@"" passageMap:@"" passageInitialvalue:@"" isselected:NO]];
        }
    }
    return _leftTBViewDataSource;
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
