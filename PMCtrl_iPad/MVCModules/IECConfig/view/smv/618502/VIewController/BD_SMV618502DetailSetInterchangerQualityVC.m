//
//  BD_SMV618502DetailSetInterchangerQualityVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/14.
//  Copyright © 2017年 ponovo. All rights reserved.
//


#import "BD_SMV618502DetailSetInterchangerQualityVC.h"
#import "BD_IECParamCell3.h"

@implementation BD_SMV618502DetailSetInterchangerQualityDataModel
-(instancetype)initWithTitle:(NSString *)title value1State:(BOOL)value1State value1:(NSString *)value1 value2State:(BOOL)value2State value2:(NSString *)value2{
    if (self = [super init]) {
        self.title = title;
        self.value1State = value1State;
        self.value1 = value1;
        self.value2State = value2State;
        self.value2 = value2;
    }
    return self;
}

@end

@interface BD_SMV618502DetailSetInterchangerQualityVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BD_SMV618502DetailSetInterchangerQualityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = MainBgColor;
        [self loadTBDatas];
        [self createTBView];
    }
    return self;
}

-(NSMutableArray *)tbdatas{
    if (!_tbdatas) {
        _tbdatas = [[NSMutableArray alloc]init];
    }
    return _tbdatas;
}

-(void)createTBView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.mas_equalTo(self.view);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ClearColor;
    _tableView.bounces = NO;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_IECParamCell3 class]) bundle:nil] forCellReuseIdentifier:@"BD_IECParamCell3ID"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tbdatas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_IECParamCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_IECParamCell3ID" forIndexPath:indexPath];
    cell.cellTitle.text = _tbdatas[indexPath.row].title;
    cell.cellValue1.text = _tbdatas[indexPath.row].value1;
    cell.cellValue2.text = _tbdatas[indexPath.row].value2;
    cell.radioSelectedBlock = ^(int index) {
        //用户选择的是哪一项
        
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}



-(void)loadTBDatas{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BD_SMV618502DetailSetInterchangerQualityDataModel *model31 = [[BD_SMV618502DetailSetInterchangerQualityDataModel alloc]initWithTitle:@"Bit31" value1State:YES value1:@"0:运行" value2State:NO value2:@"1:检修"];
        [self.tbdatas addObject:model31];
           BD_SMV618502DetailSetInterchangerQualityDataModel *model30 = [[BD_SMV618502DetailSetInterchangerQualityDataModel alloc]initWithTitle:@"Bit30" value1State:YES value1:@"0:品质正常" value2State:NO value2:@"1:品质无效" ];
        [self.tbdatas addObject:model30];
        for (NSInteger i = 29; i>=24; i--) {
            BD_SMV618502DetailSetInterchangerQualityDataModel *model = [[BD_SMV618502DetailSetInterchangerQualityDataModel alloc]initWithTitle:[ NSString stringWithFormat:@"Bit%zd",i] value1State:YES value1:@"0:有效" value2State:NO value2:@"1:无效" ];
            [self.tbdatas addObject:model];
        }
        dispatch_async( dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
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
