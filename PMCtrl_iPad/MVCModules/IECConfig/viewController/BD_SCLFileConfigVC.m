//
//  BD_SCLFileConfigVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SCLFileConfigVC.h"
#import "BD_IEDInfoModel.h"
#import "BD_IEDInfoView.h"
#import "BD_SCLConfigHeaderView.h"
#import "BD_SCLConfigCell.h"
#import "BD_IEDSelectedModel.h"
#import "BD_PopListViewManager.h"
@interface BD_SCLFileConfigVC ()<UITableViewDelegate,UITableViewDataSource>{
  
    
}
@property(nonatomic,strong)UITableView *iedTreeTBView;
@property(nonatomic,strong)BD_IEDInfoView *iedInfoView;
@property(nonatomic,strong)UITableView *iedSelTBView;
@property(nonatomic,strong)UITableView *pubListTBView;
@property(nonatomic,strong)NSMutableArray *publishDatas;
@property(nonatomic,assign)NSInteger IEDTreeSelectedIndex;
@property(nonatomic,strong)NSMutableArray<BD_IEDSelectedModel *> *selectedIedArr;
@property(nonatomic,strong)UIScrollView *selScrollView;
@end

@implementation BD_SCLFileConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithDataSource:(NSMutableArray *)datasource
{
    self = [super init];
    if (self) {
        self.sclDataSource = datasource;
        [self loadViews];
        self.publishDatas = ((BD_IEDInfoModel *)datasource[0]).GSEList[0].pubList;
    }
    return self;
}
-(void)viewWillLayoutSubviews{
     _selScrollView.contentSize = CGSizeMake(1000,_selScrollView.height);
    _iedSelTBView.frame = CGRectMake(0, 0, _selScrollView.contentSize.width, _selScrollView.contentSize.height);
}
-(void)loadViews{
    WeakSelf;
    self.view.backgroundColor = MainBgColor;
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.view.mas_top).offset(20);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-20);
        make.width.mas_equalTo(30.0);
        make.height.mas_equalTo(30.0);
    }];
    _iedTreeTBView = [[UITableView alloc]init];
    _iedTreeTBView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _iedTreeTBView.dataSource = self;
    _iedTreeTBView.delegate = self;
    _iedTreeTBView.backgroundColor = ClearColor;
    [_iedTreeTBView  selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [_iedTreeTBView setCorenerRadius:6 borderColor:BDThemeColor borderWidth:2.0];
    [self.view addSubview:_iedTreeTBView];
    [_iedTreeTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(closeBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.width.mas_equalTo(250.0);
        make.height.mas_equalTo(weakself.view.mas_height).multipliedBy(0.5);
    }];
    
    _iedInfoView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_IEDInfoView class]) owner:nil options:nil].lastObject;
    _iedInfoView.backgroundColor = ClearColor;
    [_iedInfoView setCorenerRadius:6 borderColor:BDThemeColor borderWidth:2.0];
    if (_sclDataSource.count!=0) {
        _iedInfoView.infoModel = _sclDataSource[0];
    }
    [_iedInfoView reloadViewData];
    _iedInfoView.iedInfoSelectedBlock = ^(NSInteger index, BD_IEDInfoType iedViewType){
        [weakself.publishDatas removeAllObjects];
        if (iedViewType == BD_IEDInfoType_GOSend) {
            weakself.publishDatas = weakself.sclDataSource[weakself.IEDTreeSelectedIndex].GSEList[index].pubList;
        } else if (iedViewType == BD_IEDInfoType_SMVSend){
             weakself.publishDatas = weakself.sclDataSource[weakself.IEDTreeSelectedIndex].SMVList[index].pubList;
        }
        [weakself.pubListTBView reloadData];
    };
    _iedInfoView.iedInfoCheckBlock = ^(BD_IEDSelectedModel *checkItem,BOOL state) {
        if (state) {
            checkItem.IedName = weakself.sclDataSource[weakself.IEDTreeSelectedIndex].IEDname;
            [weakself.selectedIedArr addObject:checkItem];
        } else {
            [weakself.selectedIedArr removeObject:checkItem];
        }
        [weakself.iedSelTBView reloadData];
    };
    [self.view addSubview:_iedInfoView];
//    [_iedInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(closeBtn.mas_bottom).offset(10);
//        make.left.mas_equalTo(_iedInfoView.mas_right).offset(10);
//        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
//        make.height.mas_equalTo(weakself.view.mas_height).multipliedBy(0.5);
//    }];
    _iedInfoView.frame = CGRectMake(270,60,self.view.width-280, self.view.height*0.5);

    _selScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, _iedInfoView.bottom+10,250,self.view.height-_iedInfoView.bottom-20)];
    _selScrollView.backgroundColor = ClearColor;
    [self.view addSubview:_selScrollView];
    
    [_selScrollView setCorenerRadius:6 borderColor:BDThemeColor borderWidth:2.0];
   
    _iedSelTBView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _iedSelTBView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _iedSelTBView.backgroundColor = ClearColor;
    _iedSelTBView.dataSource = self;
    _iedSelTBView.delegate = self;
   
    [_selScrollView addSubview:_iedSelTBView];


    _pubListTBView = [[UITableView alloc]init];
    _pubListTBView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pubListTBView.dataSource = self;
    _pubListTBView.delegate = self;
    _pubListTBView.backgroundColor = ClearColor;
    [_pubListTBView setCorenerRadius:6 borderColor:BDThemeColor borderWidth:2.0];
    [self.view addSubview:_pubListTBView];
    [_pubListTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iedInfoView.mas_bottom).offset(10);
        make.left.mas_equalTo(weakself.selScrollView.mas_right).offset(10);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-10);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
    }];

    
}
#pragma mark - 懒加载
-(NSMutableArray<BD_IEDInfoModel *> *)sclDataSource{
    if (!_sclDataSource) {
        _sclDataSource = [[NSMutableArray alloc]init];
    }
    return _sclDataSource;
}

-(NSMutableArray *)selectedIedArr{
    if (!_selectedIedArr) {
        _selectedIedArr = [[NSMutableArray alloc]init];
    }
    return _selectedIedArr;
}

-(void)closeVC:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView dataSource delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_iedTreeTBView]) {
        return _sclDataSource.count;
    } else if ([tableView isEqual:_pubListTBView]){
        return _publishDatas.count;
    } else if ([tableView isEqual:_iedSelTBView]){
        return self.selectedIedArr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if ([tableView isEqual:_iedTreeTBView]) {
        headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.text = @"IED列表";
        titleLabel.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(20);
        }];
    }else if ([tableView isEqual:_iedSelTBView]){
        BD_SCLConfigHeaderView *iedSel = [[BD_SCLConfigHeaderView alloc]initWithData:@[@"编号",@"类型",@"APPID",@"数据集",@"IED名称"] viewWidth:200];
        headerView = iedSel;
    }else if ([tableView isEqual:_pubListTBView]){
        BD_SCLConfigHeaderView *publish = [[BD_SCLConfigHeaderView alloc]initWithData:@[@"",@"数据类型",@"路径",@"描述"] viewWidth:200];
        headerView = publish;
    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if ([tableView isEqual:_iedTreeTBView]) {
        UITableViewCell *treeCell;
        if (treeCell) {
           treeCell = [tableView dequeueReusableCellWithIdentifier:@"BD_IEDTreeCellID" forIndexPath:indexPath];
        } else {
            treeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BD_IEDTreeCellID"];
        }
        treeCell.contentView.backgroundColor = FormBgColor;
        treeCell.textLabel.textAlignment = NSTextAlignmentLeft;
        treeCell.textLabel.textColor = White;
        treeCell.textLabel.text = [NSString stringWithFormat:@"%ld-[%@]%@",indexPath.row+1,_sclDataSource[indexPath.row].IEDname,_sclDataSource[indexPath.row].IEDDescription];
        treeCell.textLabel.numberOfLines = 2;
        cell = treeCell;
    }else if ([tableView isEqual:_iedSelTBView]){
        WeakSelf;
        BD_SCLConfigCell *sclIedCell;
        BD_IEDSelectedModel *selInfo = self.selectedIedArr[indexPath.row];
        if (!sclIedCell) {
            sclIedCell = [[BD_SCLConfigCell alloc]initSelCellWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],selInfo.iedType,selInfo.APPID,selInfo.dataSetDesc,selInfo.IedName] reuseIdentifier:@"selectedIedCell"];
        }else {
            sclIedCell = [tableView dequeueReusableCellWithIdentifier:@"selectedIedCell" forIndexPath:indexPath];
        }
        sclIedCell.selectedBtn.hidden = YES;
        sclIedCell.cellIndex = indexPath.row;
        sclIedCell.changeIEDType = ^(NSInteger cellIndex, UIButton *iedTypeChangedBtn) {
            [BD_PopListViewManager ShowPopViewWithlistDataSource:[weakself iedTypeStrToArr:selInfo.iedType] textField:iedTypeChangedBtn viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selStr) {
                [iedTypeChangedBtn setTitle:selStr forState:UIControlStateNormal];
                selInfo.iedType = selStr;
            }];
        };
        sclIedCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = sclIedCell;
    } else if ([tableView isEqual:_pubListTBView]){
        BD_SCLConfigCell *publishCell;
        if (!publishCell) {
            BD_PublishRECInfo *publishInfo = _publishDatas[indexPath.row];
            publishCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row],publishInfo.bType,publishInfo.ref,publishInfo.desc] viewWidth:200 reuseIdentifier:@"publishCell"];
        }else {
            publishCell = [tableView dequeueReusableCellWithIdentifier:@"publishCell" forIndexPath:indexPath];
        }
        publishCell.selectedBtn.hidden = YES;
        publishCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = publishCell;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_iedTreeTBView]) {
        _iedInfoView.infoModel = _sclDataSource[indexPath.row];
        _IEDTreeSelectedIndex = indexPath.row;
        [_iedInfoView reloadViewData];
    }
    
}


-(NSArray<NSString *> *)iedTypeStrToArr:(NSString *)str{
    if ([str rangeOfString:@"GOOSE"].location == NSNotFound) {
        return @[IEDType_GooseSendStr,IEDType_GooseSubStr];
    } else {
       return @[IEDType_SMVSendStr,IEDType_SMVSubStr];
    }
    
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
