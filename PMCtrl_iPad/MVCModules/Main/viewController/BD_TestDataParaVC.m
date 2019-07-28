//
//  BD_TestDataParaVC.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/31.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestDataParaVC.h"
#import "BD_ActionListView.h"
#import "StatusSequenceCell.h"
#import "BD_StatusSequenceHeaderView.h"
#import "BD_TestItemParamModel.h"
#import "UIImage+Extension.h"
@interface BD_TestDataParaVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIScrollView *testItemScrView;
@property(nonatomic,weak)UITableView *testItemTBView;
@property(nonatomic,weak)BD_ActionListView *actionListView;
@property(nonatomic,weak)UIView *paramMainView;
@property(nonatomic,weak)UIScrollView *paramScrView;
@property(nonatomic,strong)NSArray<UIButton *> *paramTabBtnArr;


@end
@implementation BD_TestDataParaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self confitUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    WeakSelf;
   
    [self.actionListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(weakself.testItemScrView.mas_right).offset(10);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(weakself.view.mas_width).multipliedBy(0.3);
        make.height.mas_equalTo(weakself.testItemScrView.mas_height);
    }];
    [self.testItemScrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(weakself.actionListView.mas_left).offset(-10);
        make.height.mas_equalTo(weakself.paramMainView.mas_height);
    }];
    [self.paramMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.testItemScrView.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(weakself.testItemScrView.mas_height);
        make.bottom.mas_equalTo(0);
    }];
    [self.paramScrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    self.testItemScrView.contentSize = CGSizeMake(self.testItemScrView.width*1.5, self.testItemScrView.height);
    [_testItemTBView setFrame:CGRectMake(0, 0, self.testItemScrView.contentSize.width, self.testItemScrView.contentSize.height)];
    [self.testItemScrView layoutIfNeeded];
    self.paramScrView.contentSize = CGSizeMake(self.paramScrView.width*3, self.paramScrView.height);
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
   
}
-(void)confitUI{
    UIScrollView *testItemScrView = [[UIScrollView alloc]init];
    testItemScrView.bounces = NO;
    testItemScrView.backgroundColor = ClearColor;
    self.testItemScrView = testItemScrView;
    [self.view addSubview:testItemScrView];
    
    BD_ActionListView *actionView = [[BD_ActionListView alloc]initWithTitles:@[@"添加试验",@"删除试验",@"清空",@"清除结果",@"清除所有",@"全选",@"全不选"]];
    self.actionListView = actionView;
    [self.view addSubview:actionView];
    
    __weak typeof(self) wealself = self;
    actionView.actionIndexBlock = ^(NSInteger actionIndex) {
   
    };
    UITableView *tbView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.testItemTBView = tbView;
    tbView.backgroundColor = Green;
    self.testItemTBView.delegate = self;
    self.testItemTBView.dataSource = self;
    self.testItemTBView.backgroundColor = ClearColor;
    self.testItemTBView.bounces = NO;
    [self.testItemTBView registerNib:[UINib nibWithNibName:NSStringFromClass([StatusSequenceCell class]) bundle:nil] forCellReuseIdentifier:@"statusCellID"];
    [self.testItemTBView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_StatusSequenceHeaderView class]) bundle:nil] forCellReuseIdentifier:@"BD_StatusSequenceHeaderViewID"];
    [self.testItemScrView addSubview:self.testItemTBView];
   
    UIView *paramView = [[UIView alloc]init];
    paramView.backgroundColor = [UIColor lightGrayColor];
    self.paramMainView = paramView;
    [self.view addSubview:paramView];
    
    NSArray *paramTabBtnTitles = @[@"参数",@"评估",@"goose数据发送"];
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<paramTabBtnTitles.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        if (i!=0) {
               [btn setFrame:CGRectMake(i*[paramTabBtnTitles[i-1] widthWithFont:[UIFont systemFontOfSize:15.0]]*1.5, 0, [paramTabBtnTitles[i] widthWithFont:[UIFont systemFontOfSize:15.0]]*1.5,40)];
            btn.selected = NO;
        } else {
               [btn setFrame:CGRectMake(0, 0, [paramTabBtnTitles[i] widthWithFont:[UIFont systemFontOfSize:15.0]]*1.5,40)];
            btn.selected = YES;
        }
        btn.tag = i+10;
        [btn setTitleColor:Black forState:UIControlStateNormal];
        [btn setTitle:paramTabBtnTitles[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:White width:btn.width height:btn.height title:@""] forState:UIControlStateSelected];
       [btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] width:btn.width height:btn.height title:@""] forState:UIControlStateNormal];
        [self.paramMainView addSubview:btn];
        [btn addTarget:self action:@selector(paramViewChanged:) forControlEvents:UIControlEventTouchUpInside];
        [btnArr addObject:btn];
        
    }
    self.paramTabBtnArr = [btnArr copy];
    
    UIScrollView *paramScrView = [[UIScrollView alloc]init];
    paramScrView.bounces = NO;
    paramScrView.scrollEnabled = NO;
    self.paramScrView = paramScrView;
    [self.paramMainView addSubview:paramScrView];

}

#pragma mark - 懒加载
-(NSMutableArray<BD_TestItemParamModel *> *)testListDataSource{
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
    headerView.testNum.text = @"编号";
    headerView.testProject.text = @"测试项目";
    headerView.isSelect.text = @"选择";
    headerView.testResult.text = @"试验结果";
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusSequenceCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"statusCellID" forIndexPath:indexPath];
    itemCell.cellIndex = indexPath.row;
    itemCell.testNum.text = [NSString stringWithFormat:@"%ld",self.testListDataSource[indexPath.row].itemNum];
    itemCell.testProject.text = self.testListDataSource[indexPath.row].itemProject;
    [itemCell.isSelect setSelected:self.testListDataSource[indexPath.row].itemSelect];
    itemCell.testResult.text = self.testListDataSource[indexPath.row].itemResult;
    itemCell.isSelectedItemBlock = ^(NSInteger cellIndex, BOOL state) {
       
    };
    return itemCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"点击");
}

-(void)reloadAllDatas{
    [self.testItemTBView reloadData];
}

-(void)paramViewChanged:(UIButton *)sender{
    [self.paramTabBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([sender isEqual:obj]) {
            sender.selected = YES;
        } else{
            sender.selected = NO;
        }
    }];
    self.paramScrView.contentOffset = CGPointMake((sender.tag-10)*self.paramScrView.width, 0);
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
